Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253A43472C7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbhCXHhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:37:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235597AbhCXHhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:37:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 280E7619FD;
        Wed, 24 Mar 2021 07:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616571435;
        bh=+QcyXUUw3ewbAm4VgTuP5nM5CtDca5a/kAdAaPSavyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S1UNJzFaoitef7YqDdJPlHo8pSQSnPhKeqkZRCMjP3JoTtnn7dCm9xiPHW4lJ4hjZ
         kgtejDBHlyzbqBc85eBlAiFXRhBOiix3Lv/q4GrXdGWXCOO/co1TsJUlfVeN2wVO+T
         omkbPkxaoyUKxlx0eT4T6rabZ5oAARI2fjOl8MNY=
Date:   Wed, 24 Mar 2021 08:37:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Hongren Zheng (Zenithal)" <i@zenithal.me>
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Antonio Borneo <borneo.antonio@gmail.com>,
        matt mooney <mfm@muteddisk.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] usbip: tools: add options and examples in man
 page related to device mode
Message-ID: <YFrsKfRV5441TsSl@kroah.com>
References: <YFrBz6dvTip9+wm7@Sun>
 <YFrdyKKx1nx8bktm@Sun>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFrdyKKx1nx8bktm@Sun>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 02:35:52PM +0800, Hongren Zheng (Zenithal) wrote:
> The commit e0546fd8b748 ("usbip: tools: Start using VUDC backend in
> usbip tools") implemented device mode for user space tools, however the
> corresponding options are not documented in man page.
> 
> This commit documents the options and provides examples on device mode.
> Also the command `usbip port` is documented.
> 
> Signed-off-by: Hongren Zheng <i@zenithal.me>
> ---
>  tools/usb/usbip/doc/usbip.8  | 42 +++++++++++++++++++++++++++++++++++-
>  tools/usb/usbip/doc/usbipd.8 | 26 ++++++++++++++++++++++
>  2 files changed, 67 insertions(+), 1 deletion(-)
> 

Always resend the whole series, not just individual patches of the
series.  When you send individual updates, it's almost impossible to
figure out what patch is what to review and apply properly.

There's no "waste" by resending the whole series, it makes it obvious
what is going on and what needs to be reviewed.

thanks,

greg k-h
