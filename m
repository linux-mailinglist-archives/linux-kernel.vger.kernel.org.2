Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6394225E3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 14:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbhJEMGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 08:06:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234419AbhJEMF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 08:05:56 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33FF4613D5;
        Tue,  5 Oct 2021 12:04:06 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mXjAy-00Erv4-3G; Tue, 05 Oct 2021 13:04:04 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Quentin Perret <qperret@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        James Morse <james.morse@arm.com>,
        linux-kernel@vger.kernel.org, Fuad Tabba <tabba@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     kernel-team@android.com
Subject: Re: [PATCH v2 0/2] A couple of EL2 refcounts fixes
Date:   Tue,  5 Oct 2021 13:03:57 +0100
Message-Id: <163343543062.3848981.1421083280351176528.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211005090155.734578-4-qperret@google.com>
References: <20211005090155.734578-1-qperret@google.com> <20211005090155.734578-4-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: qperret@google.com, dbrazdil@google.com, suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org, will@kernel.org, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, linux-kernel@vger.kernel.org, tabba@google.com, catalin.marinas@arm.com, alexandru.elisei@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2021 10:01:40 +0100, Quentin Perret wrote:
> This is v2 of the series previously posted here:
> 
> https://lore.kernel.org/kvmarm/20211004090328.540941-1-qperret@google.com/
> 
> This addresses a couple of issues Will has found with the refcounting of
> page-tables at EL2. Patch 01 fixes a nasty bug, and probably wants to go
> in -stable. Patch 02 fixes a small inconsistency which made it harder to
> find refcount-related bugs at EL2.
> 
> [...]

Applied to fixes, thanks!

[1/2] KVM: arm64: Fix host stage-2 PGD refcount
      commit: 1d58a17ef54599506d44c45ac95be27273a4d2b1
[2/2] KVM: arm64: Report corrupted refcount at EL2
      commit: 7615c2a514788559c6684234b8fc27f3a843c2c6

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


