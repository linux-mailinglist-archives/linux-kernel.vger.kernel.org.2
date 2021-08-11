Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40873E8E71
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 12:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbhHKKVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 06:21:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237115AbhHKKV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:21:29 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA9C160D07;
        Wed, 11 Aug 2021 10:21:06 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mDlM8-004IHl-MP; Wed, 11 Aug 2021 11:21:04 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH] arm64/mm: Define ID_AA64MMFR0_TGRAN_2_SHIFT
Date:   Wed, 11 Aug 2021 11:20:43 +0100
Message-Id: <162867723686.2542565.13397724425351239179.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1628569782-30213-1-git-send-email-anshuman.khandual@arm.com>
References: <1628569782-30213-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, anshuman.khandual@arm.com, catalin.marinas@arm.com, will@kernel.org, linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2021 09:59:42 +0530, Anshuman Khandual wrote:
> Streamline the Stage-2 TGRAN value extraction from ID_AA64MMFR0 register by
> adding a page size agnostic ID_AA64MMFR0_TGRAN_2_SHIFT. This is similar to
> the existing Stage-1 TGRAN shift i.e ID_AA64MMFR0_TGRAN_SHIFT.

Applied to kvm-arm64/misc-5.15, thanks!

[1/1] arm64/mm: Define ID_AA64MMFR0_TGRAN_2_SHIFT
      commit: 9efb41493ddfb19c7b3d0a21d68be6279520144f

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


