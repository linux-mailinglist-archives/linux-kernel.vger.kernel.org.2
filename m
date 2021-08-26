Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884973F86B1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 13:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242277AbhHZLti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 07:49:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233829AbhHZLtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 07:49:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C833761002;
        Thu, 26 Aug 2021 11:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629978529;
        bh=5eIeVxoctzWgFmx2RW/0E9lnkFB8VE2eB8wk0K2Y9mM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jFxIa3zS3qh98lGeqCaFuH1g32dMabFj/VPYPSX7ZMC7pPo1sMc/ybgpe1g9RId+f
         ImlJk3XhS9T5oBGSdvM7TKwt0T18ZWeSOYUUmY8F2WimkZnYuCK12RYC74M2Tl81g0
         m4x5XPjPamJdnZxOZE2M9EDxoLIh+pjFEdlzcGjE=
Date:   Thu, 26 Aug 2021 13:48:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: Raise vdm_sm_running flag only when
 VDM SM is running
Message-ID: <YSd/nTbuO8QggB9J@kroah.com>
References: <20210816075449.2236547-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816075449.2236547-1-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 03:54:49PM +0800, Kyle Tso wrote:
> If the port is going to send Discover_Identity Message, vdm_sm_running
> flag was intentionally set before entering Ready States in order to
> avoid the conflict because the port and the port partner might start
> AMS at almost the same time after entering Ready States.
> 
> However, the original design has a problem. When the port is doing
> DR_SWAP from Device to Host, it raises the flag. Later in the
> tcpm_send_discover_work, the flag blocks the procedure of sending the
> Discover_Identity and it might never be cleared until disconnection.
> 
> Since there exists another flag send_discover representing that the port
> is going to send Discover_Identity or not, it is enough to use that flag
> to prevent the conflict. Also change the timing of the set/clear of
> vdm_sm_running to indicate whether the VDM SM is actually running or
> not.
> 
> Fixes: c34e85fa69b9 ("usb: typec: tcpm: Send DISCOVER_IDENTITY from dedicated work")
> Cc: Badhri Jagan Sridharan <badhri@google.com>
> Signed-off-by: Kyle Tso <kyletso@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 81 ++++++++++++++++-------------------
>  1 file changed, 38 insertions(+), 43 deletions(-)

This does not apply to my usb-linus branch :(

Please rebase and resend, collecting the acks that others have done.

thanks,

greg k-h
