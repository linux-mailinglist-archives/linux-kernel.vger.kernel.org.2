Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A272C4307EB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 12:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241888AbhJQKc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 06:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241881AbhJQKc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 06:32:27 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3D3B6103B;
        Sun, 17 Oct 2021 10:30:17 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mc3Ql-00HJIb-R3; Sun, 17 Oct 2021 11:30:15 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Jia He <justin.he@arm.com>
Cc:     Liu Shixin <liushixin2@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Eric Auger <eric.auger@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        kvmarm@lists.cs.columbia.edu,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v2 0/2] Add memcg accounting to Arm KVM
Date:   Sun, 17 Oct 2021 11:30:12 +0100
Message-Id: <163446660410.1612145.1235091428882070255.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907123112.10232-1-justin.he@arm.com>
References: <20210907123112.10232-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: suzuki.poulose@arm.com, james.morse@arm.com, alexandru.elisei@arm.com, justin.he@arm.com, liushixin2@huawei.com, catalin.marinas@arm.com, eric.auger@redhat.com, keescook@chromium.org, kvmarm@lists.cs.columbia.edu, ndesaulniers@google.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, yuzenghui@huawei.com, nixiaoming@huawei.com, will@kernel.org, samitolvanen@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2021 20:31:10 +0800, Jia He wrote:
> Inspired by what had been done by X86 kvm and kvm common codes, it would
> be better to make arm64 kvm consistent with them.
> 
> The memory allocations of VM scope should be charged into VM process.
> Hence change the allocation flag from GFP_KERNEL to GFP_KERNEL_ACCOUNT.
> 
> There remain some GFP_KERNEL unchanged since they are global allocations,
> instead of VM scope.
> 
> [...]

Applied to next, thanks!

[1/2] KVM: arm64: vgic: Add memcg accounting to vgic allocations
      commit: 3ef231670b9e9001316a426e794b2c74b8f6b4f6
[2/2] KVM: arm64: Add memcg accounting to KVM allocations
      commit: 115bae923ac8bb29ee635e0ed6b4d5a3eec9371e

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


