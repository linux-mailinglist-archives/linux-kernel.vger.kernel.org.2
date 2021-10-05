Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1AF422651
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 14:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbhJEMZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 08:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234409AbhJEMZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 08:25:23 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80AD561186;
        Tue,  5 Oct 2021 12:23:33 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mXjTn-00EsEH-Ih; Tue, 05 Oct 2021 13:23:31 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Alexandru Elisei <alexandru.elisei@arm.com>,
        Quentin Perret <qperret@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Steven Price <steven.price@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     kernel-team@android.com
Subject: Re: [PATCH] KVM: arm64: Release mmap_lock when using VM_SHARED with MTE
Date:   Tue,  5 Oct 2021 13:23:28 +0100
Message-Id: <163343660135.3849383.15321540060917928025.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211005122031.809857-1-qperret@google.com>
References: <20211005122031.809857-1-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: alexandru.elisei@arm.com, qperret@google.com, will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, james.morse@arm.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, steven.price@arm.com, suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2021 13:20:31 +0100, Quentin Perret wrote:
> VM_SHARED mappings are currently forbidden in a memslot with MTE to
> prevent two VMs racing to sanitise the same page. However, this check
> is performed while holding current->mm's mmap_lock, but fails to release
> it. Fix this by releasing the lock when needed.

Applied to fixes, thanks!

[1/1] KVM: arm64: Release mmap_lock when using VM_SHARED with MTE
      commit: 6e6a8ef088e1222cb1250942f51ad9c1ab219ab2

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


