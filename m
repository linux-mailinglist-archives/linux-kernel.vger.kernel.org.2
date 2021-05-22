Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425F138D652
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 17:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhEVPRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 11:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhEVPRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 11:17:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87827C061574;
        Sat, 22 May 2021 08:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=gpBbXPxbY6dJggNUT09a9pIjkh7x3hHZUTOVHYAoqBU=; b=fcybyXKDz3Z9NjGnSLDl/0uaUQ
        837brYpw1dvWwdWAEtlCoL2nSsHFnqRAsUm3OxqZ+utavJEWr/v8zDKzx4yVcWzROP1BtWCKrhXyW
        mgRSq/EBp/QRlEHgzG5DxSX3DcyCrM7962Nd24nRnPLDKueY24oEpMyXu9qtIqlK9H3Ra+z70G18N
        MzX9a9IOZuAukmKsbMUJf6TJyMjhKK813XzUszn0JZrZnSDefetsoXZm+BAJ2clMW5xyo/40Rlogf
        xQm+MvVTkOEG+AwmKc4S/UVg2o2mRdH5Yi66+P+T9uvyOZek6uh5Gkj+Q+VONDg/jZosOgHTEXZHr
        QOXevfvw==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lkTMM-0008e7-5M; Sat, 22 May 2021 15:16:14 +0000
Subject: Re: [PATCH v2] Phonet: fix kernel-doc syntax in file headers and
 remove file names
To:     Aditya Srivastava <yashsri421@gmail.com>, courmisch@gmail.com
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <52313028.m8L9TnScQ9@philogene>
 <20210522113408.8766-1-yashsri421@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <afc92a2f-c0c7-c7f5-b6ee-7bce55a99043@infradead.org>
Date:   Sat, 22 May 2021 08:16:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210522113408.8766-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/21 4:34 AM, Aditya Srivastava wrote:
> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> For e.g., the header for include/linux/phonet.h follows this syntax, but
> the content inside does not comply with kernel-doc.
> 
> This line was probably not meant for kernel-doc parsing, but is parsed
> due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
> causes unexpected warning from kernel-doc:
> warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * file phonet.h
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
> Changes in v2:
> - Remove file name information from comment headers as well, as suggested by Randy and Remi
> 
>  include/linux/phonet.h      | 4 +---
>  include/uapi/linux/phonet.h | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/phonet.h b/include/linux/phonet.h
> index bc7d1e529efc..6117a0e462d3 100644
> --- a/include/linux/phonet.h
> +++ b/include/linux/phonet.h
> @@ -1,7 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/**
> - * file phonet.h
> - *
> +/*
>   * Phonet sockets kernel interface
>   *
>   * Copyright (C) 2008 Nokia Corporation. All rights reserved.
> diff --git a/include/uapi/linux/phonet.h b/include/uapi/linux/phonet.h
> index a2f6b37a5937..e7e14b5e59c6 100644
> --- a/include/uapi/linux/phonet.h
> +++ b/include/uapi/linux/phonet.h
> @@ -1,7 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -/**
> - * file phonet.h
> - *
> +/*
>   * Phonet sockets kernel interface
>   *
>   * Copyright (C) 2008 Nokia Corporation. All rights reserved.
> 


-- 
~Randy

