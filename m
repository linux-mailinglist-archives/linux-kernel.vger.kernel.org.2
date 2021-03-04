Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C72232D03E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 10:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbhCDJ4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 04:56:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:50066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230393AbhCDJ4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:56:16 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 128D664F20;
        Thu,  4 Mar 2021 09:55:36 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lHkhh-00HE83-Tl; Thu, 04 Mar 2021 09:55:34 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Jia He <justin.he@arm.com>, kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] KVM: arm64: Fix unaligned addr case in mmu walking
Date:   Thu,  4 Mar 2021 09:55:30 +0000
Message-Id: <161485171220.119036.4621661434944217679.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210303024225.2591-1-justin.he@arm.com>
References: <20210303024225.2591-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: justin.he@arm.com, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, will@kernel.org, catalin.marinas@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2021 10:42:25 +0800, Jia He wrote:
> If the start addr is not aligned with the granule size of that level.
> loop step size should be adjusted to boundary instead of simple
> kvm_granual_size(level) increment. Otherwise, some mmu entries might miss
> the chance to be walked through.
> E.g. Assume the unmap range [data->addr, data->end] is
> [0xff00ab2000,0xff00cb2000] in level 2 walking and NOT block mapping.
> And the 1st part of that pmd entry is [0xff00ab2000,0xff00c00000]. The
> pmd value is 0x83fbd2c1002 (not valid entry). In this case, data->addr
> should be adjusted to 0xff00c00000 instead of 0xff00cb2000.
> 
> [...]

Applied to fixes, thanks!

[1/1] KVM: arm64: Fix unaligned addr case in mmu walking
      commit: e85583b3f1fe62c9b371a3100c1c91af94005ca9

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


