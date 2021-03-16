Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E9033D9B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238937AbhCPQm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238816AbhCPQlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:41:46 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41412C06174A;
        Tue, 16 Mar 2021 09:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=fp851wafBMSyp+A1XTVUbYnllw6+VPptuI+8gjmb6n8=; b=STxmi+g1NdHNPpMQiJKSmZZn1l
        Xvocf1dcyqBccJ+ZQlZiZneUFIkoQFaGDlTQmA9qA2tBdaFMq9mBBga0sidukp6g5GPnB8xAwvg2z
        cyp2RlBARE62O8shJaeCO6ON4Y3ImtIEcD08oHgE7ZIlc2P+YixBCqE7xUAr4e53ogmXC2J+QdwhG
        mm0/fvOXUA7rs03yQ6pLnHMfk/zTKP41kv0JSOBEPw4yI4bW/Suzljhq8v+BWNvjNpiVUaA2NT0ua
        GbkALsaEOEebvvnWcu4p91lSw1eBji1KTbRA3iHlteuJ2gii3ISHcBgsTOrsldtKuslctFW69T27G
        6QMtotcA==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMClL-001UBG-1Q; Tue, 16 Mar 2021 16:41:43 +0000
Subject: Re: [PATCH] riscv: Fix spelling mistake "initialisation" ->
 "initialization
To:     Muhammad Usama Anjum <musamaanjum@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210316093054.GA1081018@LEGION>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f59f5c57-ff37-6e53-93ef-bcedf8dd7193@infradead.org>
Date:   Tue, 16 Mar 2021 09:41:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210316093054.GA1081018@LEGION>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/21 2:30 AM, Muhammad Usama Anjum wrote:
> There is a spelling mistake in a comment. Fix it.
> 
> Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
> ---
>  arch/riscv/kernel/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index ea028d9e0d24..1ec014067855 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * SMP initialisation and IPI support
> + * SMP initialization and IPI support
>   * Based on arch/arm64/kernel/smp.c
>   *
>   * Copyright (C) 2012 ARM Ltd.

Hi--

We accept British or American spellings, so it's OK as it was.

-- 
~Randy

