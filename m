Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074D838B60A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 20:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbhETSb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 14:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbhETSbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 14:31:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54534C061574;
        Thu, 20 May 2021 11:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=agiakZtvhMa1O9T2XzsnpNjO6uMLLfnHhIvJ8sxlh1Y=; b=Ew5DIjR56nVHadIx3pywARpTvd
        Kgq0VyI+O62d0VLyFLIu4w7CjQvihMOMTaRgdL8VG7HB0i6DOjHbQxlwccFvsRL6HlnU87Kle5NKO
        T/EvFNAW3TnfAReeo8nt1ucuvPbyUmN5KKzlmEI/Nbie6KLnfjxukn2+fTEL7ic/44bk/PK5pnYW6
        6eF40guPIS7n/zLzzE+mrKkKw7N0FSq9BObMkmzj1B6W7Mdn9CDYem5oEFLFi0RNu1vQSLlwkNaVK
        lm7gK8J0uTRyq/zLQa0fmnnqamK5wzCi3XycoZ+rz1lsaWlkTcgZ3o8T8BxPLEl5gbVjTih08AIF/
        OMutOsyA==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ljnRJ-00GZgm-Jd; Thu, 20 May 2021 18:30:33 +0000
Subject: Re: [PATCH] Phonet: fix kernel-doc syntax in file headers
To:     Aditya Srivastava <yashsri421@gmail.com>, courmisch@gmail.com
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210520182159.31462-1-yashsri421@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7cb9bfad-55b1-b5f3-5051-a2e837dda736@infradead.org>
Date:   Thu, 20 May 2021 11:30:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210520182159.31462-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/21 11:21 AM, Aditya Srivastava wrote:
> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> The header for include/*/linux/phonet.h files follows this syntax, but
> the content inside does not comply with kernel-doc.
> 
> This line was probably not meant for kernel-doc parsing, but is parsed
> due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
> causes unexpected warning from kernel-doc.
> For e.g., running scripts/kernel-doc -none include/linux/phonet.h emits:
> warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * file phonet.h
> 
> Provide a simple fix by replacing this occurrence with general comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>

Hi,
This all looks good, but it would be even better to remove
the file names. We tend to prefer not to have filenames in their files
because they get moved or renamed -- and because it's redundant info.

Anyway,
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/linux/phonet.h      | 2 +-
>  include/uapi/linux/phonet.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/phonet.h b/include/linux/phonet.h
> index bc7d1e529efc..09ecb1f94c5e 100644
> --- a/include/linux/phonet.h
> +++ b/include/linux/phonet.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/**
> +/*
>   * file phonet.h
>   *
>   * Phonet sockets kernel interface
> diff --git a/include/uapi/linux/phonet.h b/include/uapi/linux/phonet.h
> index a2f6b37a5937..6b873c460994 100644
> --- a/include/uapi/linux/phonet.h
> +++ b/include/uapi/linux/phonet.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -/**
> +/*
>   * file phonet.h
>   *
>   * Phonet sockets kernel interface
> 


-- 
~Randy

