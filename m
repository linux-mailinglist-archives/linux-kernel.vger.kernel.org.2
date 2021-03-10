Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8968E3337D8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 09:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhCJIwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 03:52:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:57286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232467AbhCJIwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 03:52:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4873D64FEE;
        Wed, 10 Mar 2021 08:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615366325;
        bh=ijxRDmvFdE54TR+aDgU5N1hfbWna1xc6Q27akx3/hM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V8n/vzKH3R44LtbnDPf4SgMvZiOaXnicZHLbuoOaZ+XFFKIH1yTDUrj5iikx+y692
         rNvDSDQVFhEb/rwUZFAt1RN5kknz+fUVVMWOQt5l6L+WiG2jnLGJHCl66JnqBPjwn1
         DT0mpYekRczHJ13a+Ivts1EnziAiysFCymMa4yX8=
Date:   Wed, 10 Mar 2021 09:52:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char/mwave: turn tp3780I_InitializeBoardData() into void
 function
Message-ID: <YEiIsmZ3O3Wk6DDq@kroah.com>
References: <1615365963-2096-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615365963-2096-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 04:46:03PM +0800, Yang Li wrote:
> This function always return '0' and no callers use the return value.
> So make it a void function.
> 
> This eliminates the following coccicheck warning:
> ./drivers/char/mwave/tp3780i.c:182:5-11: Unneeded variable: "retval".
> Return "0" on line 187
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/char/mwave/tp3780i.c | 6 +-----
>  drivers/char/mwave/tp3780i.h | 2 +-
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/mwave/tp3780i.c b/drivers/char/mwave/tp3780i.c
> index 5e1618a..8588b51 100644
> --- a/drivers/char/mwave/tp3780i.c
> +++ b/drivers/char/mwave/tp3780i.c
> @@ -177,14 +177,10 @@ int tp3780I_InitializeBoardData(THINKPAD_BD_DATA * pBDData)
>  	return retval;
>  }
>  
> -int tp3780I_Cleanup(THINKPAD_BD_DATA * pBDData)
> +void tp3780I_Cleanup(THINKPAD_BD_DATA *pBDData)

Your subject line does not match what the patch does :(

