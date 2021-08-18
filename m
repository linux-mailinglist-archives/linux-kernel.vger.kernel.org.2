Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06C73F0519
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237534AbhHRNqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:46:38 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35127 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237097AbhHRNqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:46:32 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GqTgl0rVwz9sRf; Wed, 18 Aug 2021 23:45:54 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <e9d501da0c59f60ca767b1b3ea4603fce6d02b9e.1625486440.git.christophe.leroy@csgroup.eu>
References: <e9d501da0c59f60ca767b1b3ea4603fce6d02b9e.1625486440.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/non-smp: Inconditionaly call smp_mb() on switch_mm
Message-Id: <162929391862.3619265.13703317304945129576.b4-ty@ellerman.id.au>
Date:   Wed, 18 Aug 2021 23:38:38 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jul 2021 12:00:50 +0000 (UTC), Christophe Leroy wrote:
> Commit 3ccfebedd8cf ("powerpc, membarrier: Skip memory barrier in
> switch_mm()") added some logic to skip the smp_mb() in
> switch_mm_irqs_off() before the call to switch_mmu_context().
> 
> However, on non SMP smp_mb() is just a compiler barrier and doing
> it inconditionaly is simpler than the logic used to check
> whether the barrier is needed or not.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/non-smp: Inconditionaly call smp_mb() on switch_mm
      https://git.kernel.org/powerpc/c/c8a6d91005343dea0d53be0ff0620c66934dcd44

cheers
