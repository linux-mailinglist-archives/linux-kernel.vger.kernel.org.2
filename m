Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340F0348A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhCYHtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:49:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229935AbhCYHti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:49:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40E8061574;
        Thu, 25 Mar 2021 07:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616658577;
        bh=Z6AdtYNRcQDu8jslmJqvzfkJlEgJk3BeyjR/NpKGz3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JAW3CAljmXyDfOuMIkfI/1fQjkuFrGdNjfsY17CbiuMeXQR2+a991Ek3gBSdAD6bN
         RtdX1mzqwndo9pyHd0Se2eYtuxox9xC0egKGnAktPoseM5Rqdml2YSqYEvW2f9y7gd
         T0eEhHOvdiTihcsTlzale1eAcUzT6xlISoHknxNE=
Date:   Thu, 25 Mar 2021 08:49:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kael_w@yeah.net
Subject: Re: [PATCH] [v2] drivers: staging: _adapter is declared twice
Message-ID: <YFxAjxnJk3qTJxNV@kroah.com>
References: <20210325074150.860167-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325074150.860167-1-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 03:41:47PM +0800, Wan Jiabing wrote:
> struct _adapter has been declared at 23rd line. 

Trailing whitespace :(

> Remove the duplicate.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/staging/rtl8712/drv_types.h | 2 --
>  1 file changed, 2 deletions(-)

If this is a v2 patch, you need to list what you changed below the ---
line as documented.

Please fix up and resend a v3.

thanks,

greg k-h
