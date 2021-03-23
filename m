Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B41346544
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 17:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbhCWQez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 12:34:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233268AbhCWQel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 12:34:41 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C38561993;
        Tue, 23 Mar 2021 16:34:41 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lOjzL-003LZr-1d; Tue, 23 Mar 2021 16:34:39 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     leo.yan@linaro.org, catalin.marinas@arm.com,
        Linu Cherian <lcherian@marvell.com>,
        Will Deacon <will@kernel.org>, coresight@lists.linaro.org,
        Peter Zilstra <peterz@infradead.org>,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v5 00/19] coresight: Add support for ETE and TRBE
Date:   Tue, 23 Mar 2021 16:34:36 +0000
Message-Id: <161651726490.2050093.5536833570808361940.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210323120647.454211-1-suzuki.poulose@arm.com>
References: <20210323120647.454211-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com, leo.yan@linaro.org, catalin.marinas@arm.com, lcherian@marvell.com, will@kernel.org, coresight@lists.linaro.org, peterz@infradead.org, anshuman.khandual@arm.com, mike.leach@linaro.org, mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021 12:06:28 +0000, Suzuki K Poulose wrote:
> This series enables future IP trace features Embedded Trace Extension
> (ETE) and Trace Buffer Extension (TRBE). This series applies on
> v5.12-rc4 + some patches queued. A standalone tree is also available here [0].
> The queued patches (almost there) are included in this posting for
> the sake of constructing a tree from the posting.
> 
> ETE is the PE (CPU) trace unit for CPUs, implementing future
> architecture extensions. ETE overlaps with the ETMv4 architecture, with
> additions to support the newer architecture features and some restrictions
> on the supported features w.r.t ETMv4. The ETE support is added by extending
> the ETMv4 driver to recognise the ETE and handle the features as exposed by
> the TRCIDRx registers. ETE only supports system instructions access from the
> host CPU. The ETE could be integrated with a TRBE (see below), or with
> the legacy CoreSight trace bus (e.g, ETRs). Thus the ETE follows same
> firmware description as the ETMs and requires a node per instance.
> 
> [...]

Applied to fixes, thanks!

[01/19] kvm: arm64: Hide system instruction access to Trace registers
        commit: 4af0afe252a2701732c317585f7c3ef6596b8f3d

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


