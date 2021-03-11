Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED33337AE7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 18:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhCKRdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 12:33:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhCKRdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:33:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA49D64F3B;
        Thu, 11 Mar 2021 17:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615484026;
        bh=o1Y/vDKuu7aZiyDLEgSjzY1Vv/0l7khcTBK8HwjsoGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=StXTdMIYRq9vcgvR/dNjfS56cBddLlVJKJKQCvqtMCFBUNOmXutiPeoJ11Xx+VuFf
         /+KHCvw2+OwLpL5UG3eIpA7QD+TTLKRBf0ZNuXB0dXulvFP4o8j0qXCShLJTTRziEJ
         Jz93U5S57TqEzZGJGMG3o+bJfkctMgi7nsgqDrS6tbFL2JVzI0kj4XQPNvj03uWuX8
         aQe+reCBQMj3x6wujDSOp9VOMDgySuxMMasbiUj2/yB8tsH1wzLGSBQSdbFO4ZR+Nl
         oLgn3H/8voL9Qn7/3w3ZDyYgX4JmD3GrntZ7HSnGS021nluLybNz8+xGkf6pjORDrJ
         FuNIT9hRcqnyA==
Date:   Thu, 11 Mar 2021 17:33:38 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org, ardb@kernel.org
Subject: Re: [PATCH v4 27/34] KVM: arm64: Always zero invalid PTEs
Message-ID: <20210311173338.GB31378@willie-the-truck>
References: <20210310175751.3320106-1-qperret@google.com>
 <20210310175751.3320106-28-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310175751.3320106-28-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 05:57:44PM +0000, Quentin Perret wrote:
> kvm_set_invalid_pte() currently only clears bit 0 from a PTE because
> stage2_map_walk_table_post() needs to be able to follow the anchor. In
> preparation for re-using bits 63-02 from invalid PTEs, make sure to zero

Why do you exclude bit 1 from this range?

> it entirely by ensuring to cache the anchor's child upfront.
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/pgtable.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)

For the patch:

Acked-by: Will Deacon <will@kernel.org>

Will
