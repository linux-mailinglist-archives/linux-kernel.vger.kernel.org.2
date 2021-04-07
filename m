Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FC9356FEE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353410AbhDGPO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:14:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353381AbhDGPON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:14:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 182C861222;
        Wed,  7 Apr 2021 15:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617808442;
        bh=nErVba1gmF100xpOfZS1/cp4xFDT4vG9CwBj8teGB8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IUC3ZTOpBBWQVK8+e74PjBBjhfSTOzvl2O1FI6g9/c+JItRtAz1asKOLYFIi11DLm
         XksLBJ9G/CdzHpHmtsLz139Yxa26hAKCQh0wU8FoGn1o2EVGktdBNf8dT4pmzPxhyO
         VoS5J6sRZgQH0URlJicrLxAGbOAJ9LvOgyaqD1OY=
Date:   Wed, 7 Apr 2021 17:14:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/19] drivers: rtl8723bs: rewrite comparison to null
Message-ID: <YG3MOCQHu3o/qHTg@kroah.com>
References: <cover.1617802415.git.fabioaiuto83@gmail.com>
 <0c6d53c851d1b07eb0183108e0bad7b4f273f04b.1617802415.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c6d53c851d1b07eb0183108e0bad7b4f273f04b.1617802415.git.fabioaiuto83@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 03:49:31PM +0200, Fabio Aiuto wrote:
> fix following post-commit hook checkpatch warnings:
> 
> CHECK: Comparison to NULL could be written "!psta"
> 97: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:2115:
> +		if (psta == NULL)
> 
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Nit, your subject line has "drivers:" not "staging:" here.  Be a bit
more careful next time please.

thanks,

greg k-h
