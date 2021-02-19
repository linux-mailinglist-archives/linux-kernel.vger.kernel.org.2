Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9108831F9B6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 14:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhBSNRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 08:17:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:47842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhBSNRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 08:17:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55ACA64EB1;
        Fri, 19 Feb 2021 13:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613740615;
        bh=fPbHxMLrEmvBJRzhGkUecG7yzmcuMrZN/Qxn/XfmJEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NVNrJ09Gn2etYs5h0w42h6cJ2Gi7vPhxLqTj+ww6kvYvN7dLDfLPMgzQzZuZSs/aq
         p059IA59YlA5+FE7Eia3D6T6XC7D7HbEYL5H+/ZnvkU/3ji0ZAk8IUgvSU4Fg9GvXk
         o29+DDs29xHcn5MhxIhPpB3KleHOLlIHdzzeJUX4=
Date:   Fri, 19 Feb 2021 14:16:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prakash Dubey <prakashdubey1999@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: fwserial: fix alignment of function
 parameters
Message-ID: <YC+6QxVMfl2cq7QC@kroah.com>
References: <20210219105112.GA8315@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219105112.GA8315@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 04:21:12PM +0530, Prakash Dubey wrote:
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
> index a92741b8b6c6..137e97c9406c 100644
> --- a/drivers/staging/fwserial/fwserial.c
> +++ b/drivers/staging/fwserial/fwserial.c
> @@ -1318,8 +1318,8 @@ static int fwtty_break_ctl(struct tty_struct *tty, int state)
>  	if (state == -1) {
>  		set_bit(STOP_TX, &port->flags);
>  		ret = wait_event_interruptible_timeout(port->wait_tx,
> -							!test_bit(IN_TX, &port->flags),
> -							10);
> +						       !test_bit(IN_TX, &port->flags),
> +						       10);
>  		if (ret == 0 || ret == -ERESTARTSYS) {
>  			clear_bit(STOP_TX, &port->flags);
>  			fwtty_restart_tx(port);
> -- 
> 2.25.1

Does not apply to my tree at all, please be sure to always work off of
linux-next or my staging-next tree so as not to duplicate work that
others have already done.

thanks,

greg k-h
