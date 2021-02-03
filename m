Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECCE30DE4E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbhBCPg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:36:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:57500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233983AbhBCPfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:35:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B226B64F8D;
        Wed,  3 Feb 2021 15:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612366478;
        bh=S9+Bq4aGL8vsbiEdvdMBV0S68KqoN1oduE+b7bzwEXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nubzrsC4b6rjzazEb1YDuQhppwUNSktXo9CXG8NdZGVSsf5LLvZvo5fop0k6fZ2Hh
         kqgNvs+M/pwwFN+R3Cun3MjtUUhBP62uFcdsxxMiG/hIZs9bYge9MlW8iFAR27X230
         wIBaOixNb7z4pyTKDSjGw/WuPm5iXml+XAjkBmQFWOIBRcoBjXeIvxBD+OGVDuhbYK
         3kspVhQQzIwm+nsVyyCbv760KcMS/v9wU+xXSCYn98alZRNLrNmUV2AghECbIqTqKv
         zRbpuBwLp2CaSm0VeMmn72CI2WmWdcz+VeRdcpMD1cKBJWEzTEvXSzew9b9F6YL7l/
         WbN8/SMs9Ofnw==
Date:   Wed, 3 Feb 2021 15:34:32 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Subject: Re: [RFC PATCH v2 18/26] KVM: arm64: Use kvm_arch for stage 2 pgtable
Message-ID: <20210203153431.GC18974@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-19-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108121524.656872-19-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 12:15:16PM +0000, Quentin Perret wrote:
> In order to make use of the stage 2 pgtable code for the host stage 2,
> use struct kvm_arch in lieu of struct kvm as the host will have the
> former but not the latter.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h | 5 +++--
>  arch/arm64/kvm/hyp/pgtable.c         | 6 +++---
>  arch/arm64/kvm/mmu.c                 | 2 +-
>  3 files changed, 7 insertions(+), 6 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
