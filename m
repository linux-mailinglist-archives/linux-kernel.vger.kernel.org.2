Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D130B3A41FF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 14:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhFKMaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 08:30:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230188AbhFKMaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 08:30:09 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2A856109E;
        Fri, 11 Jun 2021 12:28:11 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1lrgGf-006yMy-FF; Fri, 11 Jun 2021 13:28:09 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     suzuki.poulose@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Quentin Perret <qperret@google.com>, alexandru.elisei@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] KVM: arm64: Reduce hyp_vmemmap overhead
Date:   Fri, 11 Jun 2021 13:27:57 +0100
Message-Id: <162341446985.1357134.6545944671032237373.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210608114518.748712-1-qperret@google.com>
References: <20210608114518.748712-1-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: suzuki.poulose@arm.com, james.morse@arm.com, catalin.marinas@arm.com, will@kernel.org, qperret@google.com, alexandru.elisei@arm.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, kernel-team@android.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2021 11:45:11 +0000, Quentin Perret wrote:
> This is a v3 of the patch series previously posted here:
> 
>   https://lore.kernel.org/r/20210602094347.3730846-1-qperret@google.com
> 
> Please refer to the cover letter of v1 for the context and motivation
> behind the series.
> 
> [...]

Applied to next, thanks!

[1/7] KVM: arm64: Move hyp_pool locking out of refcount helpers
      commit: 6cbf874e51b68e5b2eb0cc50be3676f5d5601dab
[2/7] KVM: arm64: Use refcount at hyp to check page availability
      commit: 581982decc635c93934aaeb88d62c21238c63f11
[3/7] KVM: arm64: Remove list_head from hyp_page
      commit: 914cde58a03cc5eef858db34687433e17d0e44be
[4/7] KVM: arm64: Unify MMIO and mem host stage-2 pools
      commit: 7c350ea39e53ade33ca7be00b0947f2b9f53dda0
[5/7] KVM: arm64: Remove hyp_pool pointer from struct hyp_page
      commit: d978b9cfe6fe8008467f8c5d51677f52e7815b39
[6/7] KVM: arm64: Use less bits for hyp_page order
      commit: 87ec0606733e1aa9568f54ddb41f03aa6b5687f2
[7/7] KVM: arm64: Use less bits for hyp_page refcount
      commit: 6929586d8eddad184f43526efe7bf0a8be4f18b2

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


