Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFCB3F8569
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 12:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241488AbhHZKip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 06:38:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233929AbhHZKij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 06:38:39 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F0A06108F;
        Thu, 26 Aug 2021 10:37:52 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mJCla-007KET-3u; Thu, 26 Aug 2021 11:37:50 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Raghavendra Rao Ananta <rananta@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>
Cc:     Jing Zhang <jingzhangos@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Reiji Watanabe <reijiw@google.com>,
        kvmarm@lists.cs.columbia.edu, Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Ricardo Koller <ricarkol@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] KVM: arm64: Trim guest debug exception handling
Date:   Thu, 26 Aug 2021 11:37:46 +0100
Message-Id: <162997424183.1640651.9657746284386330796.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210823223940.1878930-1-rananta@google.com>
References: <20210823223940.1878930-1-rananta@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: rananta@google.com, alexandru.elisei@arm.com, suzuki.poulose@arm.com, james.morse@arm.com, jingzhangos@google.com, catalin.marinas@arm.com, reijiw@google.com, kvmarm@lists.cs.columbia.edu, pshier@google.com, oupton@google.com, linux-kernel@vger.kernel.org, will@kernel.org, ricarkol@google.com, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2021 22:39:40 +0000, Raghavendra Rao Ananta wrote:
> The switch-case for handling guest debug exception covers
> all the debug exception classes, but functionally, doesn't
> do anything with them other than ESR_ELx_EC_WATCHPT_LOW.
> Moreover, even though handled well, the 'default' case
> could be confusing from a security point of view, stating
> that the guests' actions can potentially flood the syslog.
> But in reality, the code is unreachable.
> 
> [...]

Applied to next, thanks!

[1/1] KVM: arm64: Trim guest debug exception handling
      commit: 8ce8a6fce9bfd3fcabe230ad104e2caf08b2e58d

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


