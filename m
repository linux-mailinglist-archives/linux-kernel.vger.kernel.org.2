Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDB732D50A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 15:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240445AbhCDOKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 09:10:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:36532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241370AbhCDOKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 09:10:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EC5F64EDF;
        Thu,  4 Mar 2021 14:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614866982;
        bh=6EzIY8mKBs6byT+yHKkgcBlOIVV0b78KDf87tIOxB00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UrLovbK0Yz6BuDjF+iBIgvC9apQ074oZiquUsRoxNP57gxQyf9vO1V7aqG39ne+DE
         lkGnQAkCi6sUhrxkNYWD3ADJEMIpD/BFXFX8cjv4F7wW66vLoLYqbOwqQ3nt36Pz5W
         n7o34V0bjYFFuma7ZsasQa21f3v2oxb0pC768CNiwtN8cKp3quhy6YOMrbPrL08Qjf
         +ATR9QY5jJSBoRKvFRwX9X8JeEjse7Ds20/btLeZ/dwbCA10Jc0qEG3FHmLJ+TUwU3
         fKD0cE07a1LfyCT8184I4jX0lCy4g9thQJoKyNngaMrF9K71BYbQYVDLyvWoivjN0L
         HoCTbDrMG6cFA==
Date:   Thu, 4 Mar 2021 14:09:36 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 07/32] KVM: arm64: Introduce a BSS section for use at
 Hyp
Message-ID: <20210304140935.GD21229@willie-the-truck>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-8-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302150002.3685113-8-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 02:59:37PM +0000, Quentin Perret wrote:
> Currently, the hyp code cannot make full use of a bss, as the kernel
> section is mapped read-only.
> 
> While this mapping could simply be changed to read-write, it would
> intermingle even more the hyp and kernel state than they currently are.
> Instead, introduce a __hyp_bss section, that uses reserved pages, and
> create the appropriate RW hyp mappings during KVM init.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/sections.h |  1 +
>  arch/arm64/kernel/vmlinux.lds.S   | 52 ++++++++++++++++++++-----------
>  arch/arm64/kvm/arm.c              | 14 ++++++++-
>  arch/arm64/kvm/hyp/nvhe/hyp.lds.S |  1 +
>  4 files changed, 49 insertions(+), 19 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
