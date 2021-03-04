Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04ECE32DA9A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbhCDTwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 14:52:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:47406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235123AbhCDTwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 14:52:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFB9164F36;
        Thu,  4 Mar 2021 19:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614887497;
        bh=ppev95IRq0ko0CFGee8LBgrN4g0vaWYUMRdDU803TPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kss5eJZbCOMAhR49LUrOU62oxFhl6HZfRQt1aJrNyfWTPUoHuXX1EUXLCdTGgrfHh
         Ab2sNWyll1YeBA4fCCVlDzvgH13S+eB8f4BTd3QS1dZKZIl7/zpUT1cY/eWRkNHj2x
         Uqa3f3rhwC9L8EUyN9sHVV80SHr3sJTJEevY+1fNSnb0XuYNa1xSj7NiCizLL6Cm00
         i07ORjh0/fra1zDhCSxw59N5jZgQwF53m3o7Jfy8a7+ygzQ83WFvXAObocL/22nNyV
         CfcWezrT0SY4ZwhTSgVsHloW0KQd9Th6OaMlYLfYpPSAqiabzDG2+272k9olN/KPkX
         7fyIWZUX3kFUA==
Date:   Thu, 4 Mar 2021 19:51:31 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 25/32] KVM: arm64: Sort the hypervisor memblocks
Message-ID: <20210304195131.GE21950@willie-the-truck>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-26-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302150002.3685113-26-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 02:59:55PM +0000, Quentin Perret wrote:
> We will soon need to check if a Physical Address belongs to a memblock
> at EL2, so make sure to sort them so this can be done efficiently.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/reserved_mem.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Acked-by: Will Deacon <will@kernel.org>

Will
