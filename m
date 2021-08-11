Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B453E97D1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhHKSne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:43:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhHKSnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:43:32 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFB7561019;
        Wed, 11 Aug 2021 18:43:08 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mDtBy-004Oi9-RD; Wed, 11 Aug 2021 19:43:06 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Quentin Perret <qperret@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH] KVM: arm64: Return -EPERM from __pkvm_host_share_hyp()
Date:   Wed, 11 Aug 2021 19:43:02 +0100
Message-Id: <162870737148.2970653.12931848949565086445.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210811173630.2536721-1-qperret@google.com>
References: <20210811173630.2536721-1-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, james.morse@arm.com, kvmarm@lists.cs.columbia.edu, alexandru.elisei@arm.com, catalin.marinas@arm.com, qperret@google.com, suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org, will@kernel.org, tabba@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021 18:36:25 +0100, Quentin Perret wrote:
> Fix the error code returned by __pkvm_host_share_hyp() when the
> host attempts to share with EL2 a page that has already been shared with
> another entity.

Applied to next, thanks!

[1/1] KVM: arm64: Return -EPERM from __pkvm_host_share_hyp()
      commit: 12593568d7319c34c72038ea799ab1bd0f0eb01c

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


