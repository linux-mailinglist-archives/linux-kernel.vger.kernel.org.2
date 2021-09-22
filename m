Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29A2414B16
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhIVNxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:53:49 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:56961 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232213AbhIVNxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:53:48 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HF08x589pz9sSc;
        Wed, 22 Sep 2021 15:52:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3GF460nfqq_t; Wed, 22 Sep 2021 15:52:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HF08x4HJJz9sSS;
        Wed, 22 Sep 2021 15:52:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7F6CE8B775;
        Wed, 22 Sep 2021 15:52:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ZU-NHBvRosTT; Wed, 22 Sep 2021 15:52:17 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 608838B763;
        Wed, 22 Sep 2021 15:52:17 +0200 (CEST)
Subject: Re: [RESEND PATCH 1/2] powerpc/powermac: add missing
 g5_phy_disable_cpu1() declaration
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20210922084415.18269-1-krzysztof.kozlowski@canonical.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <ee9fc44e-daab-10e6-f293-fb45b43ff5b1@csgroup.eu>
Date:   Wed, 22 Sep 2021 15:52:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210922084415.18269-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 22/09/2021 à 10:44, Krzysztof Kozlowski a écrit :
> g5_phy_disable_cpu1() is used outside of platforms/powermac/feature.c,
> so it should have a declaration to fix W=1 warning:
> 
>    arch/powerpc/platforms/powermac/feature.c:1533:6:
>      error: no previous prototype for ‘g5_phy_disable_cpu1’ [-Werror=missing-prototypes]


While you are at it, can you clean it up completely, that is remove the 
declaration in arch/powerpc/platforms/powermac/smp.c ?


> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>   arch/powerpc/include/asm/pmac_feature.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/pmac_feature.h b/arch/powerpc/include/asm/pmac_feature.h
> index e08e829261b6..7703e5bf1203 100644
> --- a/arch/powerpc/include/asm/pmac_feature.h
> +++ b/arch/powerpc/include/asm/pmac_feature.h
> @@ -143,6 +143,10 @@
>    */
>   struct device_node;
>   
> +#ifdef CONFIG_PPC64
> +void g5_phy_disable_cpu1(void);
> +#endif /* CONFIG_PPC64 */
> +
>   static inline long pmac_call_feature(int selector, struct device_node* node,
>   					long param, long value)
>   {
> 
