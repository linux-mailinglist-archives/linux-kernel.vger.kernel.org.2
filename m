Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A512734F0A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 20:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbhC3SNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 14:13:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232691AbhC3SMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 14:12:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2D4B619BD;
        Tue, 30 Mar 2021 18:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617127970;
        bh=8cd65BTZtf101g5mY/B2N2CWYMXY6mJvb6XeSEgiiw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pg2Q4AK75NrfrWXZT3PUBFl9K54f3b8hbTOYWjniYC6bhvA9NGRLfPqG8ha/zdqjR
         P1B6v0jCfCXn+83Val1IPREf5G2/GFb4FbUTph0Q49JGv7VqDefQ836CJPxOt9JYTN
         gd1AUU7FTBiLYOfMKTT6oeWDJgSgbGM36CTfo5kvx/m8Vx1pBYQgK9uWGWerJmnm0M
         HSjZl+lbwMNA66qGlX+p65+UpgKtkuj4SPtHTzWY6337EpvQXh6BdUKIWe9D0KlF0G
         q/9P8JYsThsKElJvRlJLlsqMwsNOHYRlfaxKbSWsDBP9iMl+u6KfNmRUWUYRups/SJ
         pcNE7ZmrHPf9w==
Date:   Tue, 30 Mar 2021 23:42:45 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: xr: fix CSIZE handling
Message-ID: <20210330181245.GC27256@work>
References: <20210330143716.9042-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330143716.9042-1-johan@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 04:37:16PM +0200, Johan Hovold wrote:
> The XR21V141X does not have a 5- or 6-bit mode, but the current
> implementation failed to properly restore the old setting when CS5 or
> CS6 was requested. Instead an invalid request would be sent to the
> device.
> 
> Fixes: c2d405aa86b4 ("USB: serial: add MaxLinear/Exar USB to Serial driver")
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/usb/serial/xr_serial.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
> index 0ca04906da4b..c59c8b47a120 100644
> --- a/drivers/usb/serial/xr_serial.c
> +++ b/drivers/usb/serial/xr_serial.c
> @@ -467,6 +467,11 @@ static void xr_set_termios(struct tty_struct *tty,
>  		termios->c_cflag &= ~CSIZE;
>  		if (old_termios)
>  			termios->c_cflag |= old_termios->c_cflag & CSIZE;
> +		else
> +			termios->c_cflag |= CS8;
> +
> +		if (C_CSIZE(tty) == CS7)
> +			bits |= XR21V141X_UART_DATA_7;
>  		else
>  			bits |= XR21V141X_UART_DATA_8;
>  		break;
> -- 
> 2.26.3
> 
