Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A533DDAD5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 16:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbhHBOWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 10:22:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234558AbhHBOWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:22:22 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CACF60EC0;
        Mon,  2 Aug 2021 14:22:12 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mAYpW-002Toq-1N; Mon, 02 Aug 2021 15:22:10 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suzuki.poulose@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, kvmarm@lists.cs.columbia.edu,
        will@kernel.org, alexandru.elisei@arm.com
Subject: Re: [PATCH] KVM: arm64: fix comment typo
Date:   Mon,  2 Aug 2021 15:22:07 +0100
Message-Id: <162791412064.3442307.9131610789137541537.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210728130623.12017-1-wangborong@cdjrlc.com>
References: <20210728130623.12017-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: wangborong@cdjrlc.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, suzuki.poulose@arm.com, james.morse@arm.com, catalin.marinas@arm.com, kvmarm@lists.cs.columbia.edu, will@kernel.org, alexandru.elisei@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2021 21:06:23 +0800, Jason Wang wrote:
> Remove the repeated word 'the' from two comments.

Applied to next, thanks!

[1/1] KVM: arm64: fix comment typo
      commit: 013cc4c6788f1ce9885d3c0281904f93ee8f2271

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


