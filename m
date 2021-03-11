Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40849337931
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbhCKQWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:22:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:53112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234172AbhCKQWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:22:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEB776146B;
        Thu, 11 Mar 2021 16:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615479728;
        bh=1VYaodho3Fb2my+EoZ2QcmI2TzkSbTeXP60JfAHZD8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LMKLdG1n8750gfq5NUbVfRcgOwLwtLSBp3+oVjApFw4OYSxxjnjWcqHa03ztA92Lz
         aIt3vMqS5PAIsqZ/1Tc5fgLYV01t5Qpa1vW/trKAd1UbcPQHhuHQQJyRhoOmHN+9FE
         CwQFfFya4qUmSQ+mjHGeeHKoSJNPNZJp3O2uOR+PJKFSW5ItcWOZBHoGHMEsX6krZu
         7aA2bw3TkZPz3opFzfInaDpCUrGBjXnzjSRj6mBdmfms6NdwbP2xM1rlIivbNrhOnZ
         rIy1RttdU7npdm8PONdNhLosyN+ckCZnw1kWirSPCqXBI10DjY5YUnSEuezjQeLpze
         P3xanJ9ns49jw==
Date:   Thu, 11 Mar 2021 16:22:01 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org, ardb@kernel.org
Subject: Re: [PATCH v4 15/34] arm64: asm: Provide set_sctlr_el2 macro
Message-ID: <20210311162201.GE31206@willie-the-truck>
References: <20210310175751.3320106-1-qperret@google.com>
 <20210310175751.3320106-16-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310175751.3320106-16-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 05:57:32PM +0000, Quentin Perret wrote:
> We will soon need to turn the EL2 stage 1 MMU on and off in nVHE
> protected mode, so refactor the set_sctlr_el1 macro to make it usable
> for that purpose.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/assembler.h | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
