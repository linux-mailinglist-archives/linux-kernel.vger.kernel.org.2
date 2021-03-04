Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B737032DAD5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 21:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237935AbhCDUGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 15:06:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:50972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237815AbhCDUGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 15:06:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A63364F73;
        Thu,  4 Mar 2021 20:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614888336;
        bh=FUVg1X26+WbK2+gd2WkNaErZqBQdZJhpxO9hYC8znog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WUr7W1rh47prVwLZBWbrrPMqyCxV00k+dS5ZnJDRPr2cMW6WQsdrq/M/PS7r/Pzy3
         W4qo0y207uXNLxAcdMVtzWEVDPz5JTyVXKX4nuZyouLO7V7JT6348kngpINsHAtCt6
         G5gFQ3JRCRNINW0Pkchn4UYGlNtU/e2maqDp/StTkhKSzv8KEi8DMl7mRVm4rWCv/F
         iEon2O6RRPX4DDSJ4Eo5cO2uRlycMmd+p+52Vrolqi+7HddTDCJNNpPnhUzlqO1yWL
         kVE50r9BOGSzb5pw+F5lzRixyLo5nYBXdvfb8fBxGweos7wpC1cpOlcC2gnRAmQ8C6
         tRDQdmYw4gWIA==
Date:   Thu, 4 Mar 2021 20:05:31 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 30/32] KVM: arm64: Page-align the .hyp sections
Message-ID: <20210304200530.GH21950@willie-the-truck>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-31-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302150002.3685113-31-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 03:00:00PM +0000, Quentin Perret wrote:
> We will soon unmap the .hyp sections from the host stage 2 in Protected
> nVHE mode, which obvisouly works with at least page granularity, so make
> sure to align them correctly.

s/obvisouly/obviously/

> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kernel/vmlinux.lds.S | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)

With the typo fixed:

Acked-by: Will Deacon <will@kernel.org>

Will
