Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314AD411299
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 12:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbhITKJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 06:09:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhITKJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 06:09:56 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0532960F25;
        Mon, 20 Sep 2021 10:08:30 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mSGDs-00Bjgb-1s; Mon, 20 Sep 2021 11:08:28 +0100
MIME-Version: 1.0
Date:   Mon, 20 Sep 2021 11:08:27 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Quentin Perret <qperret@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm: add Kbuild FORCE prerequisite for hyp-reloc
In-Reply-To: <20210920100515.1554788-1-arnd@kernel.org>
References: <20210920100515.1554788-1-arnd@kernel.org>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <1785d70bf2211832c4640763114d3f8d@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: arnd@kernel.org, catalin.marinas@arm.com, will@kernel.org, dbrazdil@google.com, arnd@arndb.de, james.morse@arm.com, alexandru.elisei@arm.com, suzuki.poulose@arm.com, qperret@google.com, keescook@chromium.org, samitolvanen@google.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-20 11:05, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Commit e1f86d7b4b2a ("kbuild: warn if FORCE is missing for
> if_changed(_dep,_rule)
> and filechk") added a helpful check for Kbuild, which now notices
> that a problem with the hyp-reloc rule:
> 
> arch/arm64/kvm/hyp/nvhe/Makefile:58: FORCE prerequisite is missing
> 
> Do as suggested and add FORCE here.
> 
> Fixes: 8c49b5d43d4c ("KVM: arm64: Generate hyp relocation data")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/kvm/hyp/nvhe/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile 
> b/arch/arm64/kvm/hyp/nvhe/Makefile
> index 5df6193fc430..8d741f71377f 100644
> --- a/arch/arm64/kvm/hyp/nvhe/Makefile
> +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> @@ -54,7 +54,7 @@ $(obj)/kvm_nvhe.tmp.o: $(obj)/hyp.lds $(addprefix
> $(obj)/,$(hyp-obj)) FORCE
>  #    runtime. Because the hypervisor is part of the kernel binary, 
> relocations
>  #    produce a kernel VA. We enumerate relocations targeting hyp at 
> build time
>  #    and convert the kernel VAs at those positions to hyp VAs.
> -$(obj)/hyp-reloc.S: $(obj)/kvm_nvhe.tmp.o $(obj)/gen-hyprel
> +$(obj)/hyp-reloc.S: $(obj)/kvm_nvhe.tmp.o $(obj)/gen-hyprel FORCE
>  	$(call if_changed,hyprel)
> 
>  # 5) Compile hyp-reloc.S and link it into the existing partially 
> linked object.

I already have queued [1], which does the same thing.

Thanks,

         M.

[1] https://lore.kernel.org/r/20210907052137.1059-1-yuzenghui@huawei.com
-- 
Jazz is not dead. It just smells funny...
