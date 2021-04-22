Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17703367E5F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbhDVKNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:13:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230285AbhDVKNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:13:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 774D36143B;
        Thu, 22 Apr 2021 10:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619086363;
        bh=xHKPEQ4rcxCoaoX7HHU+f4xF6ZurqSwjiO2kgl0XZEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nmD0vSGiage1GdxJRvwvfMgbsweu+fvjzpGgnfBeZ/qVftWHsKa9wke+gTlCUot7K
         v7XGRPs7rBQYnbPPw5ieWm1HjPTgaSCNX/5I0IGtXFfGIVWwr05s2XBJ/7jtHTxSD+
         bKD3QEbhHJLoKrUxpEwSfjpkLU/tybGDO66L+4fl22k+sZSnMHbp+NRNPEs3P1noZe
         Eq3C+ZA+8XObEa+GKzwK/jARmOcp+RAm6teSB92lraAcrG2kOPwYnRlPgdEX31fc9O
         r0urkIQXyPphlxPoEvSsjmH/aG5H7MjTso5pMZ1v88fB4RMJlAljKXDSo8AcSV77s0
         pE2cBelCj/uVA==
Date:   Thu, 22 Apr 2021 11:12:37 +0100
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Fuad Tabba <tabba@google.com>,
        Andrew Scull <ascull@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Quentin Perret <qperret@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: build perf support only when enabled
Message-ID: <20210422101236.GB1039@willie-the-truck>
References: <20210421134922.3309033-1-arnd@kernel.org>
 <87y2dbpwqn.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2dbpwqn.wl-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:56:16PM +0100, Marc Zyngier wrote:
> On Wed, 21 Apr 2021 14:49:01 +0100,
> Arnd Bergmann <arnd@kernel.org> wrote:
> > 
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The perf_num_counters() function is only defined when CONFIG_PERF_EVENTS
> > is enabled:
> > 
> > arch/arm64/kvm/perf.c: In function 'kvm_perf_init':
> > arch/arm64/kvm/perf.c:58:43: error: implicit declaration of function 'perf_num_counters'; did you mean 'dec_mm_counter'? [-Werror=implicit-function-declaration]
> >    58 |         if (IS_ENABLED(CONFIG_ARM_PMU) && perf_num_counters() > 0
> >       |                                           ^~~~~~~~~~~~~~~~~
> > 
> > Use conditional compilation to disable this feature entirely when
> > CONFIG_PERF_EVENTS is disabled in the host.
> > 
> > Fixes: 6b5b368fccd7 ("KVM: arm64: Turn kvm_arm_support_pmu_v3() into a static key")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > Not sure if this is the correct symbol to check for, but this is
> > one way to avoid the build failure.
> 
> I think a better way is to get rid of perf_num_counters() entirely,
> see [1]. If someone acks the second and last patches, I'll even take
> the whole series in (nudge nudge...).

Sorry, behind at the moment! Will get to it today.

Will
