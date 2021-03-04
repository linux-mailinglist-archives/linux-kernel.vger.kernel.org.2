Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E48C32D506
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 15:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240655AbhCDOJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 09:09:59 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:51600 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240164AbhCDOJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 09:09:23 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Drt4x6GPgz9v4Tn;
        Thu,  4 Mar 2021 15:08:33 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id dT301ejb3PY6; Thu,  4 Mar 2021 15:08:33 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Drt4x59X3z9v4Tl;
        Thu,  4 Mar 2021 15:08:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B7EE28B80A;
        Thu,  4 Mar 2021 15:08:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LRqkBOW4SWOI; Thu,  4 Mar 2021 15:08:35 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0DB758B812;
        Thu,  4 Mar 2021 15:08:35 +0100 (CET)
Subject: Re: [RFC PATCH v1] powerpc: Enable KFENCE for PPC32
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        kasan-dev <kasan-dev@googlegroups.com>
References: <CAG_fn=WFffkVzqC9b6pyNuweFhFswZfa8RRio2nL9-Wq10nBbw@mail.gmail.com>
 <f806de26-daf9-9317-fdaa-a0f7a32d8fe0@csgroup.eu>
 <CANpmjNPGj4C2rr2FbSD+FC-GnWUvJrtdLyX5TYpJE_Um8CGu1Q@mail.gmail.com>
 <08a96c5d-4ae7-03b4-208f-956226dee6bb@csgroup.eu>
 <CANpmjNPYEmLtQEu5G=zJLUzOBaGoqNKwLyipDCxvytdKDKb7mg@mail.gmail.com>
 <ad61cb3a-2b4a-3754-5761-832a1dd0c34e@csgroup.eu>
 <CANpmjNOnVzei7frKcMzMHxaDXh5NvTA-Wpa29C2YC1GUxyKfhQ@mail.gmail.com>
 <f036c53d-7e81-763c-47f4-6024c6c5f058@csgroup.eu>
 <CANpmjNMn_CUrgeSqBgiKx4+J8a+XcxkaLPWoDMUvUEXk8+-jxg@mail.gmail.com>
 <7270e1cc-bb6b-99ee-0043-08a027b8d83a@csgroup.eu>
 <YEDXJ5JNkgvDFehc@elver.google.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <4b46ecc9-ae47-eee1-843e-e0638a356b51@csgroup.eu>
Date:   Thu, 4 Mar 2021 15:08:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YEDXJ5JNkgvDFehc@elver.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 04/03/2021 à 13:48, Marco Elver a écrit :
>  From d118080eb9552073f5dcf1f86198f3d86d5ea850 Mon Sep 17 00:00:00 2001
> From: Marco Elver <elver@google.com>
> Date: Thu, 4 Mar 2021 13:15:51 +0100
> Subject: [PATCH] kfence: fix reports if constant function prefixes exist
> 
> Some architectures prefix all functions with a constant string ('.' on
> ppc64). Add ARCH_FUNC_PREFIX, which may optionally be defined in
> <asm/kfence.h>, so that get_stack_skipnr() can work properly.


It works, thanks.

> 
> Link: https://lkml.kernel.org/r/f036c53d-7e81-763c-47f4-6024c6c5f058@csgroup.eu
> Reported-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Marco Elver <elver@google.com>

Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   mm/kfence/report.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/kfence/report.c b/mm/kfence/report.c
> index 519f037720f5..e3f71451ad9e 100644
> --- a/mm/kfence/report.c
> +++ b/mm/kfence/report.c
> @@ -20,6 +20,11 @@
>   
>   #include "kfence.h"
>   
> +/* May be overridden by <asm/kfence.h>. */
> +#ifndef ARCH_FUNC_PREFIX
> +#define ARCH_FUNC_PREFIX ""
> +#endif
> +
>   extern bool no_hash_pointers;
>   
>   /* Helper function to either print to a seq_file or to console. */
> @@ -67,8 +72,9 @@ static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries
>   	for (skipnr = 0; skipnr < num_entries; skipnr++) {
>   		int len = scnprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[skipnr]);
>   
> -		if (str_has_prefix(buf, "kfence_") || str_has_prefix(buf, "__kfence_") ||
> -		    !strncmp(buf, "__slab_free", len)) {
> +		if (str_has_prefix(buf, ARCH_FUNC_PREFIX "kfence_") ||
> +		    str_has_prefix(buf, ARCH_FUNC_PREFIX "__kfence_") ||
> +		    !strncmp(buf, ARCH_FUNC_PREFIX "__slab_free", len)) {
>   			/*
>   			 * In case of tail calls from any of the below
>   			 * to any of the above.
> @@ -77,10 +83,10 @@ static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries
>   		}
>   
>   		/* Also the *_bulk() variants by only checking prefixes. */
> -		if (str_has_prefix(buf, "kfree") ||
> -		    str_has_prefix(buf, "kmem_cache_free") ||
> -		    str_has_prefix(buf, "__kmalloc") ||
> -		    str_has_prefix(buf, "kmem_cache_alloc"))
> +		if (str_has_prefix(buf, ARCH_FUNC_PREFIX "kfree") ||
> +		    str_has_prefix(buf, ARCH_FUNC_PREFIX "kmem_cache_free") ||
> +		    str_has_prefix(buf, ARCH_FUNC_PREFIX "__kmalloc") ||
> +		    str_has_prefix(buf, ARCH_FUNC_PREFIX "kmem_cache_alloc"))
>   			goto found;
>   	}
>   	if (fallback < num_entries)
> 
