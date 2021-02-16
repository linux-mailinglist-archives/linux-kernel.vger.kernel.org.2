Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18DBD31CD6D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhBPQBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 11:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhBPQBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:01:13 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1CAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 08:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=zD9+E+ZI4r3/IBpj+enzwdFwXkNHRFx6629chcrO5Jo=; b=Oq2osaDx94R7D/gXckdRgZY3EW
        cox0JwwMGIN6w+fM0S1vOf3NpfkLg5pRxu06MvfhBwb3n6MwSPgkkBEZuehydylfbqzne4ENz+0Hk
        U5i8EN86I/c3J/GG4FIAh/mrLBu/UMTcuLz236NCC1lc98wt0SmsoFg3xBeVh6aXwKWed3dkd8ToV
        Il5iPUOp9wjZRn5qQ67Mpm9+19G9gkqWc8FsaUkgZ9zxBfowOu7YC/widj60xKG08dS+kzqPsTjqm
        sy8DtAsNydq7IRDBMVYhHBcbr09NkAs4znIYHMIC8k7sxhSmxcSatowBqRnEkXJXU8ItStj6RWNWf
        wNELq1hQ==;
Received: from [54.239.6.185] (helo=freeip.amazon.com)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lC2m4-0008Lk-8i; Tue, 16 Feb 2021 16:00:28 +0000
Message-ID: <425a47ad4de9f0f7bd00daf446566e59a9081c7e.camel@infradead.org>
Subject: Re: [PATCH] virtio_console: remove pointless check for
 debugfs_create_dir()
From:   Amit Shah <amit@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        virtualization@lists.linux-foundation.org
Cc:     Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Date:   Tue, 16 Feb 2021 17:00:26 +0100
In-Reply-To: <20210216150410.3844635-1-gregkh@linuxfoundation.org>
References: <20210216150410.3844635-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-02-16 at 16:04 +0100, Greg Kroah-Hartman wrote:
> It is impossible for debugfs_create_dir() to return NULL, so checking
> for it gives people a false sense that they actually are doing something
> if an error occurs.  As there is no need to ever change kernel logic if
> debugfs is working "properly" or not, there is no need to check the
> return value of debugfs calls, so remove the checks here as they will
> never be triggered and are wrong.
> 
> Cc: Amit Shah <amit@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: virtualization@lists.linux-foundation.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/char/virtio_console.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 1836cc56e357..59dfd9c421a1 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1456,18 +1456,15 @@ static int add_port(struct ports_device *portdev, u32 id)
>  	 */
>  	send_control_msg(port, VIRTIO_CONSOLE_PORT_READY, 1);
>  
> -	if (pdrvdata.debugfs_dir) {
> -		/*
> -		 * Finally, create the debugfs file that we can use to
> -		 * inspect a port's state at any time
> -		 */
> -		snprintf(debugfs_name, sizeof(debugfs_name), "vport%up%u",
> -			 port->portdev->vdev->index, id);
> -		port->debugfs_file = debugfs_create_file(debugfs_name, 0444,
> -							 pdrvdata.debugfs_dir,
> -							 port,
> -							 &port_debugfs_fops);
> -	}
> +	/*
> +	 * Finally, create the debugfs file that we can use to
> +	 * inspect a port's state at any time
> +	 */
> +	snprintf(debugfs_name, sizeof(debugfs_name), "vport%up%u",
> +		 port->portdev->vdev->index, id);
> +	port->debugfs_file = debugfs_create_file(debugfs_name, 0444,
> +						 pdrvdata.debugfs_dir,
> +						 port, &port_debugfs_fops);
>  	return 0;
>  
>  free_inbufs:
> @@ -2244,8 +2241,6 @@ static int __init init(void)
>  	}
>  
>  	pdrvdata.debugfs_dir = debugfs_create_dir("virtio-ports", NULL);
> -	if (!pdrvdata.debugfs_dir)
> -		pr_warn("Error creating debugfs dir for virtio-ports\n");
>  	INIT_LIST_HEAD(&pdrvdata.consoles);
>  	INIT_LIST_HEAD(&pdrvdata.portdevs);
> 

Reviewed-by: Amit Shah <amit@kernel.org>

