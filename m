Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D19433C1E3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhCOQbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:31:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233118AbhCOQbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:31:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4077264F2A;
        Mon, 15 Mar 2021 16:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615825874;
        bh=z4NG2AwrvKp1rnGS0SnMJpQVrKZy6B5wV36WyKhoKEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tyt+CaZLBoLOKlgYe6sqDGdASlo2gRzBQ+4lDt1Z7Tzr1mCndmIzDb2TXpey2Nbg4
         5bWEAEWryYnRe4wowJCAUc1QEee1xbU9dqctOglt4WC536c8iLm1vvZuFsWk5rhWEw
         drmFCiy+bHWWLhnDQwtl1FTAqcCBZgmumzZvIs+t+0k4VwliM1L9cZLaRBWNqU8W4G
         K//s+7Z91kz8PIDC8y24LSW1moBBJwSZC0usRSUlgzvFgLKEOSnY0NcPzuemBLuHQw
         adv65R533Yx5o4pv0LMMsyYb3CU5YSiSIH64GKnwAhh+HOBLfwtIII6RpEC7wiK92G
         hINYWbd8VDEjg==
Date:   Mon, 15 Mar 2021 16:31:07 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com
Subject: Re: [PATCH v5 31/36] KVM: arm64: Add kvm_pgtable_stage2_find_range()
Message-ID: <20210315163107.GA3430@willie-the-truck>
References: <20210315143536.214621-1-qperret@google.com>
 <20210315143536.214621-32-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315143536.214621-32-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 02:35:31PM +0000, Quentin Perret wrote:
> Since the host stage 2 will be identity mapped, and since it will own
> most of memory, it would preferable for performance to try and use large
> block mappings whenever that is possible. To ease this, introduce a new
> helper in the KVM page-table code which allows to search for large
> ranges of available IPA space. This will be used in the host memory
> abort path to greedily idmap large portion of the PA space.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h | 29 +++++++++
>  arch/arm64/kvm/hyp/pgtable.c         | 89 ++++++++++++++++++++++++++--
>  2 files changed, 114 insertions(+), 4 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
