Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADED33C1EB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhCOQcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:32:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233780AbhCOQcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:32:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6331064F2A;
        Mon, 15 Mar 2021 16:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615825922;
        bh=iwo+by8AySGGmHW/D8BGbdboYbUVduzmcnfSM8i4yqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zo5DGjgEb+KZdOnvPRLKgdHlv3B25inChQcgjGYHXp8AzplO8TabMLfYjT/Ccmz0o
         1cp/2IDbT74ivkPFSf6Uisml5wHb1ToqK1JRrs/Nemj5GyNuiwxWdQxxO1xhPrm3lI
         dO1rpqxCH7ukRLd/ggPorCQ885P9zx8cvuGExdxEw3I3d9ojcrZh96ipsRbnm27aoe
         0ZzT9E89a7YHggAOzzqsIsDL0rfyPKiZ//KALPKvnPdsdmHiRR3VaRc3hqguF6x+3s
         Z1liXeug6LkIYG5X15x5y+LuGL6Ad04c7Vo0B2zSIqorZ2Ffj3R3VtL7tmu1tt0QXJ
         zoepJNRQPxEmg==
Date:   Mon, 15 Mar 2021 16:31:56 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com
Subject: Re: [PATCH v5 32/36] KVM: arm64: Provide sanitized mmfr* registers
 at EL2
Message-ID: <20210315163155.GB3430@willie-the-truck>
References: <20210315143536.214621-1-qperret@google.com>
 <20210315143536.214621-33-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315143536.214621-33-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 02:35:32PM +0000, Quentin Perret wrote:
> We will need to read sanitized values of mmfr{0,1}_el1 at EL2 soon, so
> add them to the list of copied variables.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_cpufeature.h | 2 ++
>  arch/arm64/kvm/sys_regs.c               | 2 ++
>  2 files changed, 4 insertions(+)

Acked-by: Will Deacon <will@kernel.org>

Will
