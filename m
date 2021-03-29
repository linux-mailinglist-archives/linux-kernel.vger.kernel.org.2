Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7602E34D5B4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 19:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhC2RH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 13:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhC2RHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 13:07:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1180BC061574;
        Mon, 29 Mar 2021 10:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=upsa9Q1nGEpyCmVrRsSKfVCiWk/ftvGAAkKdDkT7cfk=; b=K4jqMihSNW1ZqKa8wXHdqnwgld
        QfZiJiPDJxjU31nsSxI/1x3bNdhqCpWdfNYXakB+j68aVK0MikbriuFbp0umiuWWz+CGvcgHQ65iZ
        sj4Ou1Xh9Xpl4Cx//jaUFfzPBu0kdIO7sjCj0MtizMGV7q8H8OT0DVRDwIqTCmzMQ5N4RDPesrDdb
        y2mWkE4KiWyiASoRkjrL7P88Abmno0+9EA6CAMdLTLKkmQwY5hGGuuLv5zZeaDShn6+S95dc8TAH8
        W9wv2ClET591OaQpDEcSz4ox13qRqcBogQfa90RkJ46lB3GYV03hyX4rM2KMDTSWww89MhrmaLH2W
        OwK6ZaGw==;
Received: from [2601:1c0:6280:3f0::4557]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lQvMA-000qy0-13; Mon, 29 Mar 2021 17:07:14 +0000
Subject: Re: [PATCH] lib: fix incorrect kernel-doc comment syntax in file
To:     Aditya Srivastava <yashsri421@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, gustavoars@kernel.org, ojeda@kernel.org
References: <20210329121054.20474-1-yashsri421@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3c08eedb-1cc3-c058-ef55-341925eaff56@infradead.org>
Date:   Mon, 29 Mar 2021 10:07:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210329121054.20474-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/21 5:10 AM, Aditya Srivastava wrote:
> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> There are certain files in lib and lib/zstd, which follow this syntax,
> but the content inside does not comply with kernel-doc.
> Such lines were probably not meant for kernel-doc parsing, but are parsed
> due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
> causes unexpected warnings from kernel-doc.
> 
> E.g., presence of kernel-doc like comment in lib/zstd/compress.c at
> header causes these warnings by kernel-doc:
> "warning: cannot understand function prototype: 'const U32 g_searchStrength = 8;  '"
> 
> Similarly for other files too.
> 
> Provide a simple fix by replacing such occurrences with general comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> * Applies perfectly on next-20210326
> 
>  lib/win_minmax.c         | 2 +-
>  lib/zstd/compress.c      | 2 +-
>  lib/zstd/decompress.c    | 2 +-
>  lib/zstd/error_private.h | 2 +-
>  lib/zstd/mem.h           | 2 +-
>  lib/zstd/zstd_common.c   | 2 +-
>  lib/zstd/zstd_internal.h | 2 +-
>  lib/zstd/zstd_opt.h      | 2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/win_minmax.c b/lib/win_minmax.c
> index 6bdc1cd15f76..ec10506834b6 100644
> --- a/lib/win_minmax.c
> +++ b/lib/win_minmax.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/**
> +/*
>   * lib/minmax.c: windowed min/max tracker
>   *
>   * Kathleen Nichols' algorithm for tracking the minimum (or maximum)
> diff --git a/lib/zstd/compress.c b/lib/zstd/compress.c
> index b080264ed3ad..42604785c4f2 100644
> --- a/lib/zstd/compress.c
> +++ b/lib/zstd/compress.c
> @@ -1,4 +1,4 @@
> -/**
> +/*
>   * Copyright (c) 2016-present, Yann Collet, Facebook, Inc.
>   * All rights reserved.
>   *
> diff --git a/lib/zstd/decompress.c b/lib/zstd/decompress.c
> index 66cd487a326a..b28f10f21a6c 100644
> --- a/lib/zstd/decompress.c
> +++ b/lib/zstd/decompress.c
> @@ -1,4 +1,4 @@
> -/**
> +/*
>   * Copyright (c) 2016-present, Yann Collet, Facebook, Inc.
>   * All rights reserved.
>   *
> diff --git a/lib/zstd/error_private.h b/lib/zstd/error_private.h
> index 1a60b31f706c..f7dfa4a18f27 100644
> --- a/lib/zstd/error_private.h
> +++ b/lib/zstd/error_private.h
> @@ -1,4 +1,4 @@
> -/**
> +/*
>   * Copyright (c) 2016-present, Yann Collet, Facebook, Inc.
>   * All rights reserved.
>   *
> diff --git a/lib/zstd/mem.h b/lib/zstd/mem.h
> index 93d7a2c377fe..97d92eb431a5 100644
> --- a/lib/zstd/mem.h
> +++ b/lib/zstd/mem.h
> @@ -1,4 +1,4 @@
> -/**
> +/*
>   * Copyright (c) 2016-present, Yann Collet, Facebook, Inc.
>   * All rights reserved.
>   *
> diff --git a/lib/zstd/zstd_common.c b/lib/zstd/zstd_common.c
> index a282624ee155..ebf848c1f348 100644
> --- a/lib/zstd/zstd_common.c
> +++ b/lib/zstd/zstd_common.c
> @@ -1,4 +1,4 @@
> -/**
> +/*
>   * Copyright (c) 2016-present, Yann Collet, Facebook, Inc.
>   * All rights reserved.
>   *
> diff --git a/lib/zstd/zstd_internal.h b/lib/zstd/zstd_internal.h
> index dac753397f86..5f02411bded1 100644
> --- a/lib/zstd/zstd_internal.h
> +++ b/lib/zstd/zstd_internal.h
> @@ -1,4 +1,4 @@
> -/**
> +/*
>   * Copyright (c) 2016-present, Yann Collet, Facebook, Inc.
>   * All rights reserved.
>   *
> diff --git a/lib/zstd/zstd_opt.h b/lib/zstd/zstd_opt.h
> index 55e1b4cba808..b4a02b9f76d8 100644
> --- a/lib/zstd/zstd_opt.h
> +++ b/lib/zstd/zstd_opt.h
> @@ -1,4 +1,4 @@
> -/**
> +/*
>   * Copyright (c) 2016-present, Przemyslaw Skibinski, Yann Collet, Facebook, Inc.
>   * All rights reserved.
>   *
> 


-- 
~Randy

