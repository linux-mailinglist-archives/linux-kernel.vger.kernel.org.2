Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77B0447E47
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238749AbhKHKxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:53:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238707AbhKHKxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:53:23 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97C20610A2;
        Mon,  8 Nov 2021 10:50:39 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mk2EX-00485M-AC; Mon, 08 Nov 2021 10:50:37 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        alexandru.elisei@arm.com
Cc:     linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] KVM: arm64: change the return type of kvm_vcpu_preferred_target()
Date:   Mon,  8 Nov 2021 10:50:31 +0000
Message-Id: <163636862371.2539804.18004750098496093510.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211105011500.16280-1-yuehaibing@huawei.com>
References: <20211105011500.16280-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: yuehaibing@huawei.com, catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com, alexandru.elisei@arm.com, linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Nov 2021 09:15:00 +0800, YueHaibing wrote:
> kvm_vcpu_preferred_target() always return 0 because kvm_target_cpu()
> never returns a negative error code.

Applied to next, thanks!

[1/1] KVM: arm64: change the return type of kvm_vcpu_preferred_target()
      commit: 08e873cb70f30e11e912a93390f1c0c4e65fae1c

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


