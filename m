Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4242B428987
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 11:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbhJKJUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 05:20:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234280AbhJKJUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 05:20:49 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 176C760EB6;
        Mon, 11 Oct 2021 09:18:50 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mZrSK-00FyHU-7y; Mon, 11 Oct 2021 10:18:48 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH 0/2] KVM: arm64: Clean up CONFIG_KVM vs CONFIG_HAVE_KVM
Date:   Mon, 11 Oct 2021 10:18:45 +0100
Message-Id: <163394386541.587062.11992680510514299329.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210921222231.518092-1-seanjc@google.com>
References: <20210921222231.518092-1-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: will@kernel.org, catalin.marinas@arm.com, seanjc@google.com, linux-arm-kernel@lists.infradead.org, alexandru.elisei@arm.com, suzuki.poulose@arm.com, james.morse@arm.com, linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sep 2021 15:22:29 -0700, Sean Christopherson wrote:
> Fix an oddity where arm64 can end up with KVM=y and HAVE_KVM=n.  This
> doesn't cause problems today as no generic code that supports arm64 uses
> HAVE_KVM, but that may not always be the case, e.g. I stumbled across this
> when exploring hiding perf's guest callbacks behind HAVE_KVM=y.
> 
> Sean Christopherson (2):
>   KVM: arm64: Unconditionally include generic KVM's Kconfig
>   KVM: arm64: Depend on HAVE_KVM => OF instead of directly on OF
> 
> [...]

Applied to next, thanks!

[1/2] KVM: arm64: Unconditionally include generic KVM's Kconfig
      commit: c8f1e96734069c788b10545f4fd82bcbb6b55dfa
[2/2] KVM: arm64: Depend on HAVE_KVM => OF instead of directly on OF
      commit: e26bb75aa2f17fc079e6a24dff653b098e1f5d37

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


