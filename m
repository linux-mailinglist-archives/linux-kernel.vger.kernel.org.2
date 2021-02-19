Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E12E31F5B8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 09:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhBSIOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 03:14:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:57398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhBSIOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 03:14:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA81464EBD;
        Fri, 19 Feb 2021 08:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613722424;
        bh=0vt+ZRs9Rwe2i5MnPG83TOwiw+V1EdFAt+vD6kMqqyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XQwbj6iiqSgDhGhwXCc5VMOTiPUvm0+mqRkDxCGzbDTo863PmS0p9nImHFPVga7zD
         wmsRCAHosIIMfo1SwdTwEnnS5pyQjB0Qsj1q3lCiQoRZKCYVQJXU/I2ruE3oF1s+64
         LahreQ+/xdD5q231wXDvJz3b31spLRXf542ru1cc=
Date:   Fri, 19 Feb 2021 09:13:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prakash Dubey <prakashdubey1999@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fwserial: Fix alignment of function parameters
Message-ID: <YC9zNVWX7R9kD0Rq@kroah.com>
References: <20210218102851.GA20810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218102851.GA20810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 03:58:51PM +0530, Prakash Dubey wrote:
> This patch fixes the following checkpatch.pl check:
> 
> CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Prakash Dubey <prakashdubey1999@gmail.com>
> ---
>  drivers/staging/fwserial/fwserial.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
> index c368082aae1a..a92741b8b6c6 100644
> --- a/drivers/staging/fwserial/fwserial.c
> +++ b/drivers/staging/fwserial/fwserial.c
> @@ -1318,8 +1318,8 @@ static int fwtty_break_ctl(struct tty_struct *tty, int state)
>  	if (state == -1) {
>  		set_bit(STOP_TX, &port->flags);
>  		ret = wait_event_interruptible_timeout(port->wait_tx,
> -					       !test_bit(IN_TX, &port->flags),
> -					       10);
> +							!test_bit(IN_TX, &port->flags),
> +							10);

Shouldn't you make this line up with the ( above?  This indents it a bit
further :(

thanks,

greg k-h
