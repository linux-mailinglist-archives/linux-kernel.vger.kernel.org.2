Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAB438B61D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 20:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbhETSgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 14:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbhETSgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 14:36:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A33DC061574;
        Thu, 20 May 2021 11:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=V+JOfDgV7psnkj9YIO5jH92IC9XuEYZaAjsGKe0XexU=; b=xTP5O2cQQJsLksrvH79y45+Bkv
        V3Q2iFmUSM/LouF/+t/bmVFzQeKVSNHXIlfXo1Jr92T4rRrsQaTLADiY45CIz2GaX6gdQO6DTxHbX
        0yndj/n79FqynwJupu6W4GEVL7VFRF6Xm460otL4s6Gz1J/L66YIzPRWylOMkS0PODnR1RM+t9NiT
        k6c6yNfsp4nAjTevHLoYByTs+MOWfIkOX62J86cagaD5m1Q3VvH5gSs3F75LDZHJX+20TAYUkDc4O
        g59DKwmjMI8JC+NaRRO/WTZS5HSdN34JxKrM5ob9p1lfWJbeEJLcUTi7E03hjpGvaxfljBWdZL2PJ
        AAzICuOg==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ljnVY-00GZnc-28; Thu, 20 May 2021 18:34:56 +0000
Subject: Re: [PATCH] f2fs: fix kernel-doc syntax in file header
To:     Aditya Srivastava <yashsri421@gmail.com>, jaegeuk@kernel.org
Cc:     lukas.bulwahn@gmail.com, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org
References: <20210520182933.31965-1-yashsri421@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d1e7aaa1-4f59-2480-003d-5a5a37443c75@infradead.org>
Date:   Thu, 20 May 2021 11:34:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210520182933.31965-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/21 11:29 AM, Aditya Srivastava wrote:
> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> The header for include/linux/f2fs_fs.h follows this syntax, but the
> content inside does not comply with kernel-doc.
> 
> This line was probably not meant for kernel-doc parsing, but is parsed
> due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
> causes unexpected warning from kernel-doc:
> warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * include/linux/f2fs_fs.h
> 
> Provide a simple fix by replacing this occurrence with general comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Even better would be to remove the filename from the file.

Thanks.

> ---
>  include/linux/f2fs_fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index 5487a80617a3..028d1b18f0e7 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/**
> +/*
>   * include/linux/f2fs_fs.h
>   *
>   * Copyright (c) 2012 Samsung Electronics Co., Ltd.
> 


-- 
~Randy

