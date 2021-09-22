Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDE2414B30
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbhIVN4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:56:36 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:44439 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232213AbhIVN4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:56:34 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HF0D76Byhz9sSc;
        Wed, 22 Sep 2021 15:55:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Hao_HVFbY-Ej; Wed, 22 Sep 2021 15:55:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HF0D75Qbdz9sSS;
        Wed, 22 Sep 2021 15:55:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A63228B775;
        Wed, 22 Sep 2021 15:55:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qnJexAkC8nr1; Wed, 22 Sep 2021 15:55:03 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6638D8B763;
        Wed, 22 Sep 2021 15:55:03 +0200 (CEST)
Subject: Re: [RESEND PATCH 2/2] powerpc/powermac: constify device_node in
 of_irq_parse_oldworld()
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20210922084415.18269-1-krzysztof.kozlowski@canonical.com>
 <20210922084415.18269-2-krzysztof.kozlowski@canonical.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <a33f0978-b617-6a07-7240-ec011f894680@csgroup.eu>
Date:   Wed, 22 Sep 2021 15:55:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210922084415.18269-2-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 22/09/2021 à 10:44, Krzysztof Kozlowski a écrit :
> The of_irq_parse_oldworld() does not modify passed device_node so make
> it a pointer to const for safety.

AFAIKS this patch is unrelated to previous one so you should send them 
out separately instead of sending as a series.

> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>   arch/powerpc/platforms/powermac/pic.c | 2 +-
>   include/linux/of_irq.h                | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
> index 4921bccf0376..af5ca1f41bb1 100644
> --- a/arch/powerpc/platforms/powermac/pic.c
> +++ b/arch/powerpc/platforms/powermac/pic.c
> @@ -384,7 +384,7 @@ static void __init pmac_pic_probe_oldstyle(void)
>   #endif
>   }
>   
> -int of_irq_parse_oldworld(struct device_node *device, int index,
> +int of_irq_parse_oldworld(const struct device_node *device, int index,
>   			struct of_phandle_args *out_irq)
>   {
>   	const u32 *ints = NULL;
> diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
> index aaf219bd0354..6074fdf51f0c 100644
> --- a/include/linux/of_irq.h
> +++ b/include/linux/of_irq.h
> @@ -20,12 +20,12 @@ typedef int (*of_irq_init_cb_t)(struct device_node *, struct device_node *);
>   #if defined(CONFIG_PPC32) && defined(CONFIG_PPC_PMAC)
>   extern unsigned int of_irq_workarounds;
>   extern struct device_node *of_irq_dflt_pic;
> -extern int of_irq_parse_oldworld(struct device_node *device, int index,
> +extern int of_irq_parse_oldworld(const struct device_node *device, int index,
>   			       struct of_phandle_args *out_irq);

Please remove 'extern' which is useless for prototypes.

>   #else /* CONFIG_PPC32 && CONFIG_PPC_PMAC */
>   #define of_irq_workarounds (0)
>   #define of_irq_dflt_pic (NULL)
> -static inline int of_irq_parse_oldworld(struct device_node *device, int index,
> +static inline int of_irq_parse_oldworld(const struct device_node *device, int index,
>   				      struct of_phandle_args *out_irq)
>   {
>   	return -EINVAL;
> 
