Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAB2338A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 11:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbhCLKxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 05:53:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:37172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233641AbhCLKxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 05:53:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B6D56501B;
        Fri, 12 Mar 2021 10:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615545895;
        bh=UfOV09KQcKMeWL12uT+LRLZWIw6CpoAZkllye4DuvZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cFRuOfo4hYjQH16EHW8ytC693/8mGqx8Eksw99CvF2BmY6ymqNr62HU+ozvYwth6v
         FJgF2wabUH1Jxh0cOymAk70aFfT8hM3wNrqHzEOyzwRBPWHeqHpqt+7qnPzZnIcazq
         ZqaS475OlHk6KfmkJoOnV1Kr4v6WBXb7Rdswd3ReyBRhnVx4Eyve6AzthZszMBQMgX
         S6h7BpBUQDhtolWE6sDoHNCNCnkM0ocM684GenOxqAWa3ktEK6eikvK4FIdUp1B1W2
         +71qIij1IjFFIbhtU2UaIAoR/QvrVjt9yuEKUHc84t5wbvjO9M19J0abZ9Ji2IDBd7
         6P53bZiDVySWw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lKfI0-0007H0-7k; Fri, 12 Mar 2021 11:45:04 +0100
Date:   Fri, 12 Mar 2021 11:45:04 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+a93fba6d384346a761e3@syzkaller.appspotmail.com
Subject: Re: [PATCH] usbip: fix vhci races in connection tear down
Message-ID: <YEtGMMjOg3pHTSma@hovoldconsulting.com>
References: <20210312022737.44122-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312022737.44122-1-skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 07:27:37PM -0700, Shuah Khan wrote:
> vhci_shutdown_connection() references connection state (tcp_socket,
> tcp_rx, tcp_tx, sockfd) saved in usbpip_device without holding the
> lock.
> 
> Current connection tear down sequence:
> Step 1: shutdown the socket
> Step 2: stop rx thread and reset tcp_rx pointer
> Step 3: stop tx thread and reset tcp_tx pointer
> Step 4: Reset tcp_socket and sockfd
> 
> There are several race windows between these steps. In addition, device
> reset routine (vhci_device_reset) resets tcp_socket and sockfd holding
> the lock.
> 
> Fix these races:
> - Introduce in_disconnect flag to ensure vhci_shutdown_connection() runs
>   only once.
> - Change attach_store() to initialize in_disconnect to false while
>   initializing connection status (tcp_socket, tcp_rx, tcp_tx, sockfd)
> - Change vhci_shutdown_connection() to check in_disconnect and bail
>   out if disconnect is in progress.
> - Change vhci_shutdown_connection() to
>   -- hold lock to save connection state pointers and unlock.
>   -- Shutdown the socket and stop threads.
>   -- Hold lock to clear connection status and in_disconnect flag.
> - Change vhci_device_reset() to reset tcp_socket and sockfd.
>   if !in_disconnect
> 
> Tested syzbot and the reproducer did not trigger any issue.
> 
> Reported-and-tested-by: syzbot+a93fba6d384346a761e3@syzkaller.appspotmail.com
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  drivers/usb/usbip/usbip_common.h |  1 +
>  drivers/usb/usbip/vhci_hcd.c     | 55 +++++++++++++++++++++++---------
>  drivers/usb/usbip/vhci_sysfs.c   |  4 +++
>  3 files changed, 45 insertions(+), 15 deletions(-)

> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index 3209b5ddd30c..c1917efe5737 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -1007,31 +1007,54 @@ static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
>  static void vhci_shutdown_connection(struct usbip_device *ud)
>  {
>  	struct vhci_device *vdev = container_of(ud, struct vhci_device, ud);
> +	unsigned long flags;
> +	struct socket *socket;
> +	struct task_struct *tcp_rx = NULL;
> +	struct task_struct *tcp_tx = NULL;
> +	int sockfd = 0;
> +
> +	spin_lock_irqsave(&ud->lock, flags);
> +	if (vdev->ud.in_disconnect) {
> +		pr_info("%s: Disconnect in progress for sockfd %d\n",
> +			__func__, ud->sockfd);

Looks like you forgot to remove all you debug printks like this one
before submitting.

> +		spin_unlock_irqrestore(&ud->lock, flags);
> +		return;
> +	}

Johan
