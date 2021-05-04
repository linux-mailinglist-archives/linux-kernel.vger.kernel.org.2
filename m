Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D038372893
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 12:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhEDKPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 06:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhEDKPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 06:15:18 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1498CC061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 03:14:16 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id e2so4568451plh.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 03:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=G4WSnegt7sWFXhiZUo/H8mFA8YOfhqB3H/FcAZj7hT8=;
        b=ntW8xcKQmgkUHISGAF4IzI224Ye5tabfMbPJRLiGbqY7Rr3tclDi+8u7+XIWZyZtp8
         W+24vVGh+Kb8PFB+eQPqOIeCNFJpo0a340nCJBRd3HIg5i0kBMtxTV6QbGjpSw5VUzPr
         Es0CARIQQfdBNbktqpmur+D+QCZX0ULZyXeGUbQHEgula8cLINk5YZ7mFyfkirrg/Xr7
         yDKIvXXPAtuNV4KAYn+xfXt2c4rFpKGP7HswvwXxlMCQtAfrysEUsciTLeiOxAc/wAEc
         U5TiqfL3po4tzJvQhJDbGhCfniUbK7Mchh6W4VAF1acttTlXf3QjdwcGFm0jCXD8cv2+
         PPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=G4WSnegt7sWFXhiZUo/H8mFA8YOfhqB3H/FcAZj7hT8=;
        b=YEPyiTsa00gL9zmNu+IvTVuqtoQDY9w2WTTnDzhpAv0JTIdrfDPujQ8W5gcE9e2JvM
         7F7k8g7k80T/EccUi1vsTitj68N98D8E+OCyRCsDs6zhYSIiT826/vAkCA7gWxJ8duVM
         rA6968e1F6787JShjsiseEXges0iEiq5Bhxn5iy6CsNmfx3T+hgOAewWwy+T7P1/jDzt
         Xv1DBinBE5wEK4OTR07FUUQu4Hhl7Q1TJY9Qp+BTfvGunPqd8lmNo19lxRDFgWEPjrJp
         coYZsCMVZL5M5rzr2XfNoalLKgK/F+yvEDbMko6vDDvIVJsmC/ExLA4qMdwO/Lo28ePe
         3cjg==
X-Gm-Message-State: AOAM532jiczmD3YiltiHxWkr+iv4vfPDxA/224s7hEq59i0Afo1VZJI1
        WCs8rnCdHf/hegptI1KuZUs=
X-Google-Smtp-Source: ABdhPJxdWLerj3PVzICFvrxooqDo1msdzSUrDqhSN6Tldy17O34vbf0IFxgXhrojl9ihycNwkeo44w==
X-Received: by 2002:a17:902:c211:b029:ed:7a6b:d4bf with SMTP id 17-20020a170902c211b02900ed7a6bd4bfmr25144155pll.63.1620123255583;
        Tue, 04 May 2021 03:14:15 -0700 (PDT)
Received: from localhost ([61.68.127.20])
        by smtp.gmail.com with ESMTPSA id b1sm3120712pgf.84.2021.05.04.03.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 03:14:15 -0700 (PDT)
Date:   Tue, 04 May 2021 20:14:09 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] powerpc/asm-offset: Remove unused items related to
 paca
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <f38728dbe96df5fef84c868640def5f6d7c114bc.1620060357.git.christophe.leroy@csgroup.eu>
In-Reply-To: <f38728dbe96df5fef84c868640def5f6d7c114bc.1620060357.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1620121538.q0b7uiea5y.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of May 4, 2021 2:46 am:
> PACA_SIZE, PACACONTEXTID, PACALOWSLICESPSIZE, PACAHIGHSLICEPSIZE,
> PACA_SLB_ADDR_LIMIT, MMUPSIZEDEFSIZE, PACASLBCACHE, PACASLBCACHEPTR,
> PACASTABRR, PACAVMALLOCSLLP, MMUPSIZESLLP, PACACONTEXTSLLP,
> PACALPPACAPTR, LPPACA_DTLIDX and PACA_DTL_RIDX are not used anymore
> by ASM code.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Also I think SIGSEGV, NMI_MASK, THREAD_DBCR0, KUAP?, TI_FLAGS,
TI_PREEMPT, [ID]CACHEL1*, STACK_REGS_KUAP, EXC_LVL_SIZE, KVM_NEED_FLUSH,=20
KVM_FWNMI, VCPU_DEC, VCPU_SPMC, HSTATE_XICS_PHYS, HSTATE_SAVED_XIRR,
PPC_DBELL_MSGTYPE I think. While we're cleaning it up.

>=20
> Remove them.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/asm-offsets.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-=
offsets.c
> index 28af4efb4587..419ab4a89114 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -197,7 +197,6 @@ int main(void)
>  	OFFSET(ICACHEL1LOGBLOCKSIZE, ppc64_caches, l1i.log_block_size);
>  	OFFSET(ICACHEL1BLOCKSPERPAGE, ppc64_caches, l1i.blocks_per_page);
>  	/* paca */
> -	DEFINE(PACA_SIZE, sizeof(struct paca_struct));
>  	OFFSET(PACAPACAINDEX, paca_struct, paca_index);
>  	OFFSET(PACAPROCSTART, paca_struct, cpu_start);
>  	OFFSET(PACAKSAVE, paca_struct, kstack);
> @@ -212,15 +211,6 @@ int main(void)
>  	OFFSET(PACAIRQSOFTMASK, paca_struct, irq_soft_mask);
>  	OFFSET(PACAIRQHAPPENED, paca_struct, irq_happened);
>  	OFFSET(PACA_FTRACE_ENABLED, paca_struct, ftrace_enabled);
> -#ifdef CONFIG_PPC_BOOK3S
> -	OFFSET(PACACONTEXTID, paca_struct, mm_ctx_id);
> -#ifdef CONFIG_PPC_MM_SLICES
> -	OFFSET(PACALOWSLICESPSIZE, paca_struct, mm_ctx_low_slices_psize);
> -	OFFSET(PACAHIGHSLICEPSIZE, paca_struct, mm_ctx_high_slices_psize);
> -	OFFSET(PACA_SLB_ADDR_LIMIT, paca_struct, mm_ctx_slb_addr_limit);
> -	DEFINE(MMUPSIZEDEFSIZE, sizeof(struct mmu_psize_def));
> -#endif /* CONFIG_PPC_MM_SLICES */
> -#endif
> =20
>  #ifdef CONFIG_PPC_BOOK3E
>  	OFFSET(PACAPGD, paca_struct, pgd);
> @@ -241,21 +231,9 @@ int main(void)
>  #endif /* CONFIG_PPC_BOOK3E */
> =20
>  #ifdef CONFIG_PPC_BOOK3S_64
> -	OFFSET(PACASLBCACHE, paca_struct, slb_cache);
> -	OFFSET(PACASLBCACHEPTR, paca_struct, slb_cache_ptr);
> -	OFFSET(PACASTABRR, paca_struct, stab_rr);
> -	OFFSET(PACAVMALLOCSLLP, paca_struct, vmalloc_sllp);
> -#ifdef CONFIG_PPC_MM_SLICES
> -	OFFSET(MMUPSIZESLLP, mmu_psize_def, sllp);
> -#else
> -	OFFSET(PACACONTEXTSLLP, paca_struct, mm_ctx_sllp);
> -#endif /* CONFIG_PPC_MM_SLICES */
>  	OFFSET(PACA_EXGEN, paca_struct, exgen);
>  	OFFSET(PACA_EXMC, paca_struct, exmc);
>  	OFFSET(PACA_EXNMI, paca_struct, exnmi);
> -#ifdef CONFIG_PPC_PSERIES
> -	OFFSET(PACALPPACAPTR, paca_struct, lppaca_ptr);
> -#endif
>  	OFFSET(PACA_SLBSHADOWPTR, paca_struct, slb_shadow_ptr);
>  	OFFSET(SLBSHADOW_STACKVSID, slb_shadow, save_area[SLB_NUM_BOLTED - 1].v=
sid);
>  	OFFSET(SLBSHADOW_STACKESID, slb_shadow, save_area[SLB_NUM_BOLTED - 1].e=
sid);
> @@ -264,9 +242,7 @@ int main(void)
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>  	OFFSET(PACA_PMCINUSE, paca_struct, pmcregs_in_use);
>  #endif
> -	OFFSET(LPPACA_DTLIDX, lppaca, dtl_idx);
>  	OFFSET(LPPACA_YIELDCOUNT, lppaca, yield_count);
> -	OFFSET(PACA_DTL_RIDX, paca_struct, dtl_ridx);
>  #endif /* CONFIG_PPC_BOOK3S_64 */
>  	OFFSET(PACAEMERGSP, paca_struct, emergency_sp);
>  #ifdef CONFIG_PPC_BOOK3S_64
> --=20
> 2.25.0
>=20
>=20
