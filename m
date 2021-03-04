Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7066A32DA8B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbhCDTpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 14:45:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:46032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231734AbhCDTpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 14:45:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A75E64F52;
        Thu,  4 Mar 2021 19:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614887078;
        bh=MCPai1ot4VOLKCgUqTHIX0hjr6qRhCdZXO2eAD7YTPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T/ZdMeD99zLdiu5Mf8+6r1+WLZj8tYYhFIwSur1ZSlTeN2C3FD8ngHfEZ5tQjAkKS
         i/2vkYjl3E62JA/s9bOuiA9Ozuv1Bwd8eKSuUy84Y565l7dNIBRFsmJY1ko/9BI1zO
         XGygWLtIKgQ0NQ4nv8T6rPaWer/Ow0WyrBR/Ad1jrJSdYga/wXwoZrr7EVVRgghzvG
         gUOnwjnLsSzN6a+or2rPjp0N11Y3HmKgPGYJLo3ZMBCltFV5AHcnHaelWNdGQFnxw7
         CFGqNl84TaX4bqlMCfYXdymJ1liZhxR/ckgJ55j5tiiFo6hEEgAqUyRO8jhFrQ2Bl5
         rl4k0yAsojpzw==
Date:   Thu, 4 Mar 2021 19:44:32 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 23/32] KVM: arm64: Make memcache anonymous in pgtable
 allocator
Message-ID: <20210304194431.GC21950@willie-the-truck>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-24-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302150002.3685113-24-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 02:59:53PM +0000, Quentin Perret wrote:
> The current stage2 page-table allocator uses a memcache to get
> pre-allocated pages when it needs any. To allow re-using this code at
> EL2 which uses a concept of memory pools, make the memcache argument of
> kvm_pgtable_stage2_map() anonymous, and let the mm_ops zalloc_page()
> callbacks use it the way they need to.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h | 6 +++---
>  arch/arm64/kvm/hyp/pgtable.c         | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
