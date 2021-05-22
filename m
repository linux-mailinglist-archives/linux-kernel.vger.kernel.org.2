Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA4838D648
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 17:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhEVPNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 11:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhEVPNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 11:13:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E94CC061574;
        Sat, 22 May 2021 08:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=aHoWqS6wBA7auWs741xKAHDKHGtZ/8QwNVQ3vHvVUzU=; b=0DHTjS7S9U1aCaxLl0zaAQ+GZi
        gkqH0xt5ITJJJproyTzuKh0voqLTDx706Afp/xjqt0WrLtQhQgpJDzaRYFpdg7+EbV49nfVab+gPW
        lGytLrSM/EKenAQLWXlfa+CrMe4P99Ou2Pei7coiJg6oTGe4BYSzGVA1m8DFSdHXB98AW0k0kaPqm
        hkRpchh+bLeVfX6FHHeQq98PMYlRVJHwnnsJ+YJXtjDit8B6QeKbHIsBBtSMqnZOWJ4KqVAu2yor2
        tDKg6X7rWB2iWkd6wxuQs7zoeaZN1f19r2/k99JeKxpgPChvCgZCliOixelQOFZJ/7S8Z2x/sPkmT
        MWsElMdQ==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lkTHv-0008c4-C4; Sat, 22 May 2021 15:11:39 +0000
Subject: Re: [PATCH] ipac: tpci200: fix kernel-doc syntax and remove filename
 from file header
To:     Aditya Srivastava <yashsri421@gmail.com>, siglesias@igalia.com
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jens.taprogge@taprogge.org, gregkh@linuxfoundation.org,
        industrypack-devel@lists.sourceforge.net
References: <20210522124051.12540-1-yashsri421@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a6e13d99-d08c-cc4d-d159-6aba5a2dca09@infradead.org>
Date:   Sat, 22 May 2021 08:11:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210522124051.12540-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/21 5:40 AM, Aditya Srivastava wrote:
> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> The header for drivers/ipack/carriers/tpci200 follows this syntax, but the
> content inside does not comply with kernel-doc.
> 
> This line was probably not meant for kernel-doc parsing, but is parsed
> due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
> causes unexpected warning from kernel-doc.
> 
> For e.g., running scripts/kernel-doc -none on
> drivers/ipack/carriers/tpci200.c emits:
> warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * tpci200.c
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
>  drivers/ipack/carriers/tpci200.c | 4 +---
>  drivers/ipack/carriers/tpci200.h | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ipack/carriers/tpci200.c b/drivers/ipack/carriers/tpci200.c
> index ec71063fff76..a867906777bd 100644
> --- a/drivers/ipack/carriers/tpci200.c
> +++ b/drivers/ipack/carriers/tpci200.c
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> - * tpci200.c
> - *
> +/*
>   * driver for the TEWS TPCI-200 device
>   *
>   * Copyright (C) 2009-2012 CERN (www.cern.ch)
> diff --git a/drivers/ipack/carriers/tpci200.h b/drivers/ipack/carriers/tpci200.h
> index 2619f827e33f..e79ac64abcff 100644
> --- a/drivers/ipack/carriers/tpci200.h
> +++ b/drivers/ipack/carriers/tpci200.h
> @@ -1,7 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/**
> - * tpci200.h
> - *
> +/*
>   * driver for the carrier TEWS TPCI-200
>   *
>   * Copyright (C) 2009-2012 CERN (www.cern.ch)
> 


-- 
~Randy

