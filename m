Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FE036CAEA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 20:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbhD0SLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 14:11:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235505AbhD0SLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:11:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 535C360BBB;
        Tue, 27 Apr 2021 18:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619547022;
        bh=hMNih56Z7Me63IH021Heuif5NMjLNzLrXKN9bgT0KrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qUwaSyxP3IEJLA0PXt00vgdVzEcxZZtxTM52qfHq2bNIPloTjmemV6IxceFsud7kt
         fdkFp3kTaxSfLl8WaqP7AMLbWLRF1VJ7DROBs8JN0zrIbB8ug0+0QULrqQSb55ynEj
         VBojc0fhMMdbXyIwEC37OwYoWSdE0Gc3PR99CEQ0=
Date:   Tue, 27 Apr 2021 20:10:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jitendra Khasdev <jkhasdev@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: fix array of flexible structures
Message-ID: <YIhTjGpmLSYKuCi3@kroah.com>
References: <20210427174945.1323-1-jkhasdev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427174945.1323-1-jkhasdev@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 11:19:45PM +0530, Jitendra Khasdev wrote:
> This patch fixes sparse warning "array of flexible structures"
> for rtllib.h.
> 
> eg. drivers/staging/rtl8192e/rtllib.h:832:48: warning: array of
> flexible structures
> 
> Signed-off-by: Jitendra Khasdev <jkhasdev@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtllib.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
> index 4cabaf2..c7cb318 100644
> --- a/drivers/staging/rtl8192e/rtllib.h
> +++ b/drivers/staging/rtl8192e/rtllib.h
> @@ -802,7 +802,7 @@ struct rtllib_authentication {
>  	__le16 transaction;
>  	__le16 status;
>  	/*challenge*/
> -	struct rtllib_info_element info_element[];
> +	struct rtllib_info_element *info_element;

You just changed the definition of this structure, and the other
structures here.  Are you sure this is working properly?

thanks,

greg k-h
