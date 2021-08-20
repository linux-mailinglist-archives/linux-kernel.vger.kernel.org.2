Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243A53F2AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 13:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240568AbhHTLHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 07:07:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240262AbhHTLGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 07:06:30 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4016C60FDC;
        Fri, 20 Aug 2021 11:05:53 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mH2LO-006AgP-Dv; Fri, 20 Aug 2021 12:05:51 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, David Brazdil <dbrazdil@google.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: (subset) [PATCH 0/2] Fix off-by-one in range_is_memory
Date:   Fri, 20 Aug 2021 12:05:44 +0100
Message-Id: <162945752305.2126143.7959914980998500483.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210728153232.1018911-1-dbrazdil@google.com>
References: <20210728153232.1018911-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, dbrazdil@google.com, linux-kernel@vger.kernel.org, will@kernel.org, qperret@google.com, alexandru.elisei@arm.com, linux-arm-kernel@lists.infradead.org, james.morse@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2021 15:32:30 +0000, David Brazdil wrote:
> the range_is_memory function in hyp.
> 
> David Brazdil (2):
>   KVM: arm64: Fix off-by-one in range_is_memory
>   KVM: arm64: Minor optimization of range_is_memory
> 
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Applied to kvm-arm64/mmu/el2-tracking, thanks!

[2/2] KVM: arm64: Minor optimization of range_is_memory
      commit: 14ecf075fe5be01860927fdf3aa11d7b18023ab2

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


