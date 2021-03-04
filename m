Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DBC32DA79
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbhCDTgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 14:36:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:45124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230409AbhCDTfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 14:35:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 320AE64F60;
        Thu,  4 Mar 2021 19:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614886506;
        bh=yYKWZ6QndHwWfsOdgKSOMpZxTE7UTXV1JxyvIovkYDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZpNz8lFeg3deiGdXUSucIiLylskK5XGCqj1AwyqBAb+2N8gZ5XpzwPPTSSHvhQoEx
         ehvWad8VPCVuHb/IPoGG9lnq9HMJstraBLRB+ntMWb/3Qss8JcVGqLtoic7SHvG5Bb
         AjFJ5CIAWumqND6y6Ys73womqixyps7o6Zpy7QWU8YYAOcq+Dkm5GLmEutN9D8ykRh
         w/qrsBjcwcX1jkDf6avPi3fDaVD/G91LUCi/8R70jepn057vy7WEET763yakPLpuDp
         AsfovY+zS9jTC+Zzw7V3u7ZCgoc3mOPGNr8R3A4lEjlvuoMuvNeezxn9Qp5qFy4p/t
         7KNucS/DhjuLQ==
Date:   Thu, 4 Mar 2021 19:35:00 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 20/32] KVM: arm64: Refactor kvm_arm_setup_stage2()
Message-ID: <20210304193459.GA21950@willie-the-truck>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-21-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302150002.3685113-21-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 02:59:50PM +0000, Quentin Perret wrote:
> In order to re-use some of the stage 2 setup code at EL2, factor parts
> of kvm_arm_setup_stage2() out into separate functions.
> 
> No functional change intended.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h | 26 +++++++++++++++++
>  arch/arm64/kvm/hyp/pgtable.c         | 32 +++++++++++++++++++++
>  arch/arm64/kvm/reset.c               | 42 +++-------------------------
>  3 files changed, 62 insertions(+), 38 deletions(-)

Looks much better than the big header in v2, thanks!

Acked-by: Will Deacon <will@kernel.org>

Will
