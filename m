Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F8A3AACC8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 08:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhFQG54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 02:57:56 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:49406 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhFQG5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 02:57:54 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G5CW62V8YzBDt2;
        Thu, 17 Jun 2021 08:55:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dKW6sfhlMRMC; Thu, 17 Jun 2021 08:55:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G5CW61XjmzBDLt;
        Thu, 17 Jun 2021 08:55:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 176178B804;
        Thu, 17 Jun 2021 08:55:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 3xwBsrTEU-ED; Thu, 17 Jun 2021 08:55:46 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3D8EB8B801;
        Thu, 17 Jun 2021 08:55:45 +0200 (CEST)
Subject: Re: [PATCH v14 2/4] kasan: allow architectures to provide an outline
 readiness check
To:     Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com, elver@google.com,
        akpm@linux-foundation.org, andreyknvl@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
References: <20210617063956.94061-1-dja@axtens.net>
 <20210617063956.94061-3-dja@axtens.net>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <853a39a4-5ec3-08a9-87d0-d599e8828e8b@csgroup.eu>
Date:   Thu, 17 Jun 2021 08:55:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210617063956.94061-3-dja@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 17/06/2021 à 08:39, Daniel Axtens a écrit :
> Allow architectures to define a kasan_arch_is_ready() hook that bails
> out of any function that's about to touch the shadow unless the arch
> says that it is ready for the memory to be accessed. This is fairly
> uninvasive and should have a negligible performance penalty.
> 
> This will only work in outline mode, so an arch must specify
> ARCH_DISABLE_KASAN_INLINE if it requires this.
> 
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> 
> --
> 
> Both previous RFCs for ppc64 - by 2 different people - have
> needed this trick! See:
>   - https://lore.kernel.org/patchwork/patch/592820/ # ppc64 hash series
>   - https://patchwork.ozlabs.org/patch/795211/      # ppc radix series
> 
> I haven't been able to exercise the arch hook error for !GENERIC as I
> don't have a particularly modern aarch64 toolchain or a lot of experience
> cross-compiling with clang. But it does fire for GENERIC + INLINE on x86.

Modern toolchains are available here https://mirrors.edge.kernel.org/pub/tools/crosstool/

