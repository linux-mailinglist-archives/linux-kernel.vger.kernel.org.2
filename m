Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459AD30B212
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 22:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbhBAV2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 16:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhBAV2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 16:28:18 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907C0C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 13:27:38 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id 8so5442502plc.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 13:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=2zdbQAonuBlXaYvwXM20t/+hVpPWTDzFS1lpAy2rpGI=;
        b=QlXIHc70ObVQQMpMbzdk0TRQosUQKUx3AMRR+dRUfh6Q/To7HmgOkMv5Q2OxCWmMfr
         +S/PUEpZECdU9CzHR6CYqaU7IhQU/yUDiw1tVL3rZ/5Rhn+0Q2xVDeUh0MxI9Do54VEI
         wskqtlfu4xUPETNmF4qGwMA2ZmLegh+FmcizmeaEDOXlB95M2ocgcg/iRNpEo/SaFjqp
         LhNKs5+eR3x6NEkbxPTGRCApJvJxYOzoT3TQUXXnmTRf8XdWq8uyV0zdJ2F9nQ9PLuGw
         VRqeXFPFjygEq3JdnVxrol25XDZ58GF3MAtB1ec0Cww7WmKdyWfQhxRPk8tjLBFiJBv1
         7KCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=2zdbQAonuBlXaYvwXM20t/+hVpPWTDzFS1lpAy2rpGI=;
        b=ZrJWt8TXBkcdKR2qcqBLNcvA2urqW3vxn/2gANzzKsW4lGQFTGBY0z4146aw4IGJQP
         cjp9/glFEsP3rgGj8UQG8BkRI4Usot7qS3OyaIC1pDBsa/ty3ca8UfjLnS0MXPLURJDe
         Pndxz3R2ZiNbrhXDpmBdGd7aAPHbu2AkMfowKMrlfLSQbEMsBYQtX+/WG8TmQ3vLaoMu
         iyNX+SINJxJolUSD0l79qIKxf5GlLEPvWpBpkzCriLlVm7XYydxg5DdJ7JT13q1hi9jP
         3jeuxEwivxnoTe0gQRNsX1YyDZXMMuX9oz2bKkzta2oJulJZ5hHPnAmKV79ykQc2wYW9
         3o/g==
X-Gm-Message-State: AOAM5339NGO0W/DNUnoTVtF6peYsd4BeNSlea056cAb9GQhZMK9ItmaQ
        /6Pb9F48cQLVCP3F/F4T2EnZkA==
X-Google-Smtp-Source: ABdhPJzU22mZgFFzNc/VC757dwSCzmDfIjZJvsF9+7Nxj69aM/f9DnUOvpb352Xgm2e9zNRHZc9V3Q==
X-Received: by 2002:a17:902:758b:b029:df:d1f6:9af9 with SMTP id j11-20020a170902758bb02900dfd1f69af9mr19620371pll.21.1612214857988;
        Mon, 01 Feb 2021 13:27:37 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id l1sm12697812pgt.26.2021.02.01.13.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 13:27:37 -0800 (PST)
Date:   Mon, 1 Feb 2021 13:27:36 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory.c: use helper range_in_vma() in
 __split_huge_p[u|m]d_locked()
In-Reply-To: <20210201093259.52798-1-linmiaohe@huawei.com>
Message-ID: <b59215ff-d793-23ee-edc2-242fc810dc73@google.com>
References: <20210201093259.52798-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Feb 2021, Miaohe Lin wrote:

> The helper range_in_vma() is introduced via commit 017b1660df89 ("mm:
> migration: fix migration of huge PMD shared pages"). But we forgot to
> use it in __split_huge_pud_locked() and __split_huge_pmd_locked().
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/huge_memory.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 987cf5e4cf90..33353a4f95fb 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1959,8 +1959,7 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
>  		unsigned long haddr)
>  {
>  	VM_BUG_ON(haddr & ~HPAGE_PUD_MASK);
> -	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
> -	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PUD_SIZE, vma);
> +	VM_BUG_ON_VMA(!range_in_vma(vma, haddr, haddr + HPAGE_PUD_SIZE), vma);
>  	VM_BUG_ON(!pud_trans_huge(*pud) && !pud_devmap(*pud));
>  
>  	count_vm_event(THP_SPLIT_PUD);
> @@ -2039,8 +2038,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  	int i;
>  
>  	VM_BUG_ON(haddr & ~HPAGE_PMD_MASK);
> -	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
> -	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PMD_SIZE, vma);
> +	VM_BUG_ON_VMA(!range_in_vma(vma, haddr, haddr + HPAGE_PMD_SIZE), vma);
>  	VM_BUG_ON(!is_pmd_migration_entry(*pmd) && !pmd_trans_huge(*pmd)
>  				&& !pmd_devmap(*pmd));
>  

This actually loses information, right?  Before the patch, we can 
determine which conditional is failing because we know the line number 
that the VM_BUG_ON() is happening on.  After the patch, we don't know 
this.

I don't think that's crucial, but I'm not sure it makes sense to do this 
if the only upside is that we removed one total line of code :)
