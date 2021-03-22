Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1AA343FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhCVL0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:26:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229972AbhCVLZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:25:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAA1E61984;
        Mon, 22 Mar 2021 11:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616412359;
        bh=PzLkd0Gp9jIBSRQCzJxuUu+Zrn0Xf64IlgL4+coMbzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QJQ3wCuUvGBWF4pZF546GIrJMojyVKWgUqpt/xEtubgwefRVr/2s3NPpZKO1k8Ofa
         M1SJmXGhMdM/t7PZ/207GcxroaIx4feVCPUNwXNf6yebFiqnQYHCOLEJtvVheJyXg2
         DSw+i0MCQPS/VsY4YQ0PqF7eIsCw4o4BKaUX9OChAUXj6VFYHNXXG8tL4Kl3uvIgav
         Fj7YKK2fFhskNfN8+Cs/UNVZGqlt0MMBujxt8i4dS9W95bI9OWkoE8mzVvlCYzgz6E
         nQtdgYwRCByxcqczfhmEcevstblWjGUlmU7OJA2XbYaKAFJC6fLlHSdFywvkJAHBaW
         P3BCZSWpUihIQ==
Date:   Mon, 22 Mar 2021 11:25:53 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com
Subject: Re: [PATCH v6 14/38] KVM: arm64: Provide __flush_dcache_area at EL2
Message-ID: <20210322112553.GB10318@willie-the-truck>
References: <20210319100146.1149909-1-qperret@google.com>
 <20210319100146.1149909-15-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319100146.1149909-15-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 10:01:22AM +0000, Quentin Perret wrote:
> We will need to do cache maintenance at EL2 soon, so compile a copy of
> __flush_dcache_area at EL2, and provide a copy of arm64_ftr_reg_ctrel0
> as it is needed by the read_ctr macro.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_cpufeature.h |  2 ++
>  arch/arm64/kvm/hyp/nvhe/Makefile        |  3 ++-
>  arch/arm64/kvm/hyp/nvhe/cache.S         | 13 +++++++++++++
>  arch/arm64/kvm/hyp/nvhe/hyp-smp.c       |  6 ++++++
>  arch/arm64/kvm/sys_regs.c               |  1 +
>  5 files changed, 24 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/kvm/hyp/nvhe/cache.S

Acked-by: Will Deacon <will@kernel.org>

Will
