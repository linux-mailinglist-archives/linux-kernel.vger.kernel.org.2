Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C342035DD29
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 13:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbhDMLCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 07:02:21 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33126 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344576AbhDMLCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 07:02:07 -0400
Received: from zn.tnic (p200300ec2f0b840069f7e8348dd41416.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:8400:69f7:e834:8dd4:1416])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 054E31EC032C;
        Tue, 13 Apr 2021 13:01:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618311700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EapHv6oFwJH3m5E8yzDZ3r7waNuPmjlteZ0NxRRuJyI=;
        b=GrYWMUG/t9s1mlCo560HOgrajeQxxIgGSNEJch83ZwT3mM/8rK82Jtcer/mQlHTWjEm4GO
        3DT5AQecd1CmxvaulFNGQqJ/aK5u8v7UZzBI2x/FZXSzRWLAPMgWKJs//+jsrgutWVi3gE
        h3yW+K0CzdqH7wpcFoPzZtWhSaW8qwQ=
Date:   Tue, 13 Apr 2021 13:01:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH] x86: Accelerate copy_page with non-temporal in X86
Message-ID: <20210413110137.GD16519@zn.tnic>
References: <3f28adee-8214-fa8e-b368-eaf8b193469e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f28adee-8214-fa8e-b368-eaf8b193469e@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ linux-nvdimm

Original mail at https://lkml.kernel.org/r/3f28adee-8214-fa8e-b368-eaf8b193469e@huawei.com

On Tue, Apr 13, 2021 at 02:25:58PM +0800, Kemeng Shi wrote:
> I'm using AEP with dax_kmem drvier, and AEP is export as a NUMA node in

What is AEP?

> my system. I will move cold pages from DRAM node to AEP node with
> move_pages system call. With old "rep movsq', it costs 2030ms to move
> 1 GB pages. With "movnti", it only cost about 890ms to move 1GB pages.

So there's __copy_user_nocache() which does NT stores.

> -	ALTERNATIVE "jmp copy_page_regs", "", X86_FEATURE_REP_GOOD
> +	ALTERNATIVE_2 "jmp copy_page_regs", "", X86_FEATURE_REP_GOOD, \
> +                      "jmp copy_page_nt", X86_FEATURE_XMM2

This makes every machine which has sse2 do NT stores now. Which means
*every* machine practically.

The folks on linux-nvdimm@ should be able to give you a better idea what
to do.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
