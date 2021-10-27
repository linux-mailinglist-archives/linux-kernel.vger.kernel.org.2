Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE8E43C40D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 09:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240520AbhJ0Hjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 03:39:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232045AbhJ0Hjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 03:39:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 349F560C4A;
        Wed, 27 Oct 2021 07:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635320232;
        bh=FRBog1tZWZi2KIk+C4NUR+287z9q0T1v5SYwsgJ3a2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hp+D7l/0metU0vwZubbT50AhWOWxepnxz0aH+R3ssX2EAovAtfr052vm79z9WYEiG
         YDt62rrku7de17CVxCGQadznxkw2+eUKD2SHhrF1myXTv/0rgKyxRlQPkWl+z26LvZ
         K8gyUdC65IM1Tfc65K3NRs5hL6VpSk8iFiATxITZFQvjIWGnu/JzsB3XDEoN0d3mQV
         pJEsMz24F5nGVaIIR3IqpYvSHApsT7/fkbqLC35iIKgyFMCqHrMGa3U6RW/jvuWAo0
         IIhV7fDrHKRDoUHx1NvXJRQBeENzm01Zh/UAK2aJcTgihnUtz+cwv8Bxhbjvlb4n0c
         uIHeBvvg1Yz7w==
Date:   Wed, 27 Oct 2021 08:37:07 +0100
From:   Will Deacon <will@kernel.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Remove unused TRNG_NO_ENTROPY
Message-ID: <20211027073707.GB22231@willie-the-truck>
References: <20211026210913.57006-1-quic_qiancai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026210913.57006-1-quic_qiancai@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 05:09:13PM -0400, Qian Cai wrote:
> TRNG_NO_ENTROPY was unused when introduced and now. This is also caught by
> GCC (W=2):
> 
> arch/arm64/kvm/trng.c:17: warning: macro "TRNG_NO_ENTROPY" is not used [-Wunused-macros]
>    17 | #define TRNG_NO_ENTROPY   ((unsigned long)-3)

This return value is defined by the TRNG SMCCC spec (Arm DEN0098) so I'd
rather just keep it around given that it's not causing any problems.

Will
