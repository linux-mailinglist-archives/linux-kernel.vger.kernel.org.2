Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1873378D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbhCKQJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:09:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:49948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234176AbhCKQJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:09:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5ADE964D5D;
        Thu, 11 Mar 2021 16:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615478966;
        bh=CMKCM7h0YQHLp6ZA1+GQSMClZW5GB0avjdcUEF2pvzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fwm0z8S4cbkmBI9wGOic+8gXazddLFOq+1WS0pmt2WIgCo8ilgf2CYIvNtECwnV+Y
         XaYEthzmQGBxR89fkBTfPZzUWe/Rr7c18eePTkUBJiBMw1JJasc4DXIUSo2ALGxOFB
         zlNhoVrlBOs+l8JYlCyyP/4JfnKQRuFEeoLQIl7oyBVsgZ5nT0XDiRARuJPIp3wArB
         AesXYfsTIGOsKHVN4B7fIwl8+EBKKYvx5V94kYCyF/ZupTGHO167M0sXqq28Xh8q6f
         kWn+P9jA33sbDslbET4BuzIGsvfgVYLaTaIdV6cQTkeQ+3xJKSPcBgxTKW0zfvaIWM
         1qXrNDcdpNpZA==
Date:   Thu, 11 Mar 2021 16:09:19 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org, ardb@kernel.org
Subject: Re: [PATCH v4 06/34] KVM: arm64: Factor memory allocation out of
 pgtable.c
Message-ID: <20210311160919.GA31206@willie-the-truck>
References: <20210310175751.3320106-1-qperret@google.com>
 <20210310175751.3320106-7-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310175751.3320106-7-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 05:57:23PM +0000, Quentin Perret wrote:
> In preparation for enabling the creation of page-tables at EL2, factor
> all memory allocation out of the page-table code, hence making it
> re-usable with any compatible memory allocator.
> 
> No functional changes intended.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h | 41 +++++++++++-
>  arch/arm64/kvm/hyp/pgtable.c         | 98 +++++++++++++++++-----------
>  arch/arm64/kvm/mmu.c                 | 66 ++++++++++++++++++-
>  3 files changed, 163 insertions(+), 42 deletions(-)

Thanks, looks good to me now:

Acked-by: Will Deacon <will@kernel.org>

Will
