Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BC636C494
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbhD0LFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:05:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235181AbhD0LE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:04:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 513F461059;
        Tue, 27 Apr 2021 11:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619521452;
        bh=cqPRQBwFdJsS+yR4cI8L7m7kv5wtmCh0H022sKhkUcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PJXwR/TeTiSvcYz/LUHCnFGUuuwehU1xawHu4FgOksv7XU07iD0hT4hwG62rfSr9i
         4aQcVZ3eFDQKzOVQ9XhRqT/KAsX2TvUHEs0j7pii3zCT38eKY1dXvpF1qtltOTDvM8
         FKrZig1N2/DCib39F6OtxtCzKj5P2AbIXgnjc47s=
Date:   Tue, 27 Apr 2021 13:04:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 50/50] staging: rtl8723bs: macro DRIVER_PREFIX expands
 to lowercase driver name
Message-ID: <YIfvqU2bEpDSj/hK@kroah.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
 <c986e9a3c9b2f73cb784bd5dc7c877eb9a669c89.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c986e9a3c9b2f73cb784bd5dc7c877eb9a669c89.1619254603.git.fabioaiuto83@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 24, 2021 at 11:02:33AM +0200, Fabio Aiuto wrote:
> macro DRIVER_PREFIX expands to lowercase driver name.
> 
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> ---
>  drivers/staging/rtl8723bs/include/rtw_debug.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
> index 189f02a8300a..3a5b083e95a1 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_debug.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
> @@ -7,7 +7,7 @@
>  #ifndef __RTW_DEBUG_H__
>  #define __RTW_DEBUG_H__
>  
> -#define DRIVER_PREFIX "RTL8723BS: "
> +#define DRIVER_PREFIX "rtl8723bs: "

KBUILD_MODNAME should be used here, in the future.

But really, this shouldn't be needed at all, it's kind of pointless (if
it is being used, then odds are the places it is being used is wrong...)

thanks,

greg k-h
