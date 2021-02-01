Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD0C30AFAF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhBASoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:44:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231134AbhBASn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:43:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 805CE64DDF;
        Mon,  1 Feb 2021 18:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612204995;
        bh=RhFJNirKCc5qirqDWt9dnB9pJEbvJC3OwoCh/S0tJag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GvsXOT9M6tx7XU32S2LQD3zE2QDOGi4NxYCdsgJUaIrVYsIaqjvwPE2ahcsSZOj+P
         DGfrm+cXrn9/hr2JY9DDEnNhvSNIi01Yg9AdtEzGT9z5D8RoJpCNGlZUTJCM8hayoC
         G4vUpck6IZGgopBzuKucK0HQdLAoaC1pq58RoB/dU8TBUxAc8qggzgQHUslRP3ay7k
         +ATbfYqpcmfFwBAFaIfMcCGPu+fAvqmkodFkVr6KkGlUwsBw+TluMAKEBHXbmuB7um
         1OooYeBO0KUdUF5+ux23pxikLy0zOGTvP52Oiiwo2AScyIHpoIHB/mdnPvm6YvyP7W
         MPwRJF6Mu3s3g==
Date:   Mon, 1 Feb 2021 18:43:09 +0000
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
Subject: Re: [RFC PATCH v2 09/26] KVM: arm64: Allow using kvm_nvhe_sym() in
 hyp code
Message-ID: <20210201184309.GH15632@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-10-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108121524.656872-10-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 12:15:07PM +0000, Quentin Perret wrote:
> In order to allow the usage of code shared by the host and the hyp in
> static inline library function, allow the usage of kvm_nvhe_sym() at el2

typo: functions

> by defaulting to the raw symbol name.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/hyp_image.h | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Will Deacon <will@kernel.org>

Will
