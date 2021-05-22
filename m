Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454C538D645
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 17:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhEVPMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 11:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhEVPMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 11:12:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2219BC061574;
        Sat, 22 May 2021 08:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=fU4ucyA1aSCWI5PJ4vpM9CLBWWAQ+TAcqRAfBrYNkmk=; b=dmmuWxhTbOgfYg8hIYxH//TfQ8
        TVY1RQ+7v2UCk0I4Y0o8qjZ8lrjjpq24WjVKpXmtebUp6twCxhtZPxviFaJ840CXla0P7SutbJNKQ
        EwIuHtvghMj4aooK6QdLosqgxg4N8p37n3zJ7cJAxuB0LJWMfx6/WrMvM0IkXCD5KklxYcEUB91vz
        /pIvxfgEVtnPEMk74iY+BJMnV3KCd6IY4Juq3XrcZa/zdCoaXFu90mRy2oPji6EFYWLLdXeDHCufz
        pitSG5xX2vm+2d3j/+r73fuvuufYT/dWwzujfQcgu93cq2lnV6cLikGeBFfZUKTlEIDbwCrybscGD
        bAbvTJBw==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lkTHC-0008b1-Tc; Sat, 22 May 2021 15:10:55 +0000
Subject: Re: [PATCH] ipac: ipoctal: fix kernel-doc syntax and remove filename
 from file headers
To:     Aditya Srivastava <yashsri421@gmail.com>, siglesias@igalia.com
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jens.taprogge@taprogge.org, gregkh@linuxfoundation.org,
        industrypack-devel@lists.sourceforge.net
References: <20210522121944.11182-1-yashsri421@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <750267be-966b-e165-7c19-ee1872498e1e@infradead.org>
Date:   Sat, 22 May 2021 08:10:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210522121944.11182-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/21 5:19 AM, Aditya Srivastava wrote:
> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> The header for drivers/ipack/devices/ipoctal follows this syntax, but the
> content inside does not comply with kernel-doc.
> 
> This line was probably not meant for kernel-doc parsing, but is parsed
> due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
> causes unexpected warning from kernel-doc.
> 
> For e.g., running scripts/kernel-doc -none on
> drivers/ipack/devices/ipoctal.h emits:
> warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * ipoctal.h
> 
> Provide a simple fix by replacing this occurrence with general comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.
> 
> Also remove the redundant file name from the comment headers.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/ipack/devices/ipoctal.c | 4 +---
>  drivers/ipack/devices/ipoctal.h | 6 ++----
>  2 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ipack/devices/ipoctal.c b/drivers/ipack/devices/ipoctal.c
> index 3940714e4397..2a3a94f72dfb 100644
> --- a/drivers/ipack/devices/ipoctal.c
> +++ b/drivers/ipack/devices/ipoctal.c
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> - * ipoctal.c
> - *
> +/*
>   * driver for the GE IP-OCTAL boards
>   *
>   * Copyright (C) 2009-2012 CERN (www.cern.ch)
> diff --git a/drivers/ipack/devices/ipoctal.h b/drivers/ipack/devices/ipoctal.h
> index 75f83ba774a4..773dc41bd667 100644
> --- a/drivers/ipack/devices/ipoctal.h
> +++ b/drivers/ipack/devices/ipoctal.h
> @@ -1,9 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/**
> - * ipoctal.h
> - *
> +/*
>   * driver for the IPOCTAL boards
> -
> + *
>   * Copyright (C) 2009-2012 CERN (www.cern.ch)
>   * Author: Nicolas Serafini, EIC2 SA
>   * Author: Samuel Iglesias Gonsalvez <siglesias@igalia.com>
> 


-- 
~Randy

