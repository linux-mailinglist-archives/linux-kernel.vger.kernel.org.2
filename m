Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A1A344EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhCVSol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbhCVSoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:44:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5E8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=ckI2oDkSNlHxwB+Qa10YGdkI1GW+2orJLb949OkIIdQ=; b=uMpb/T04cBIZFG1Ws03pyN6B7R
        Q1SyhRi5qA7fDNpSZRmz7V5/2V7gkFZ7SY58qziDd/sNqSS8v/hR7OAMMwvISWGMupezSyNHRlXuw
        xN2kWQTibu5q/AchXXJ5uKZKuhzqM5RJVeEh3mVrbJQUosXLPMdaEKnpFWapFoMmEG1wEFicPHm77
        NVe0fuBniUzvYUK29GgAyjKxT6sjDtxtdbAQ9U696NVn4LVELp9TGhS47aVJxDu6lZjK3hue6TNG0
        liN08s0vu3UU7iepvijS2jgVt+Kj9gzF55lUggS3QBG0a+Y8JfYovun9Nk4Le4gdmRKltzvhglsS8
        UAIu/R2g==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOPWw-008vog-Qk; Mon, 22 Mar 2021 18:44:03 +0000
Subject: Re: [PATCH] powerpc/8xx: Fix a typo
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@csgroup.eu, rppt@kernel.org, npiggin@gmail.com,
        akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20210322120314.2085782-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <572845d8-3c47-acaa-97ea-7ccfe011b547@infradead.org>
Date:   Mon, 22 Mar 2021 11:43:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322120314.2085782-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 5:03 AM, Bhaskar Chowdhury wrote:
> 
> s/poiners/pointers/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  arch/powerpc/kernel/head_8xx.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
> index 46dff3f9c31f..8a85a984609a 100644
> --- a/arch/powerpc/kernel/head_8xx.S
> +++ b/arch/powerpc/kernel/head_8xx.S
> @@ -819,7 +819,7 @@ EXPORT_SYMBOL(empty_zero_page)
>  swapper_pg_dir:
>  	.space	PGD_TABLE_SIZE
> 
> -/* Room for two PTE table poiners, usually the kernel and current user
> +/* Room for two PTE table pointers, usually the kernel and current user
>   * pointer to their respective root page table (pgdir).
>   */
>  	.globl	abatron_pteptrs
> --


-- 
~Randy

