Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B691390955
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 20:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhEYTAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 15:00:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232382AbhEYTAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 15:00:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EB0861413;
        Tue, 25 May 2021 18:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621969140;
        bh=Qqe87EyoB4lozNsqPrYbB+cuWxPZ5k6KkuROOZXyXQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Af7rGqFFpYM/qZxEAAkqCWUuAKrMBgbPU0BoAwOBiajuX/K7tga84ockAMSoG5l85
         UhQt+wLNtMLQeOJhuCOpBP6XAJ7iKLFN7v7loJBorajSMaL5N1NM5bx/F1ULX69vpG
         YdzjomVFrHL7vAxl1D0nQyKEgkOWRpvkuvC8CgQp3vmkk3/TpSBfOaHWdzpJD6hBuZ
         C5093f6fc7nlB7YzeOwdm6+q2Ijz2Ry10D1zGSwGlvLpf3OUUUmma7ujjxCgykc1IR
         U7VWowMG5pa6rlmfGo1uqPI1NpAKWsYOjMiI6Qoxoxk9Cu2Yx8hIehflCsMZeIxK1M
         HFEEsWUq83fRw==
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64/mm: Validate CONFIG_PGTABLE_LEVELS
Date:   Tue, 25 May 2021 19:58:43 +0100
Message-Id: <162196527964.2314761.8443537851296185272.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1620649326-24115-1-git-send-email-anshuman.khandual@arm.com>
References: <1620649326-24115-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021 17:52:06 +0530, Anshuman Khandual wrote:
> CONFIG_PGTABLE_LEVELS has been statically defined in (arch/arm64/Kconfig)
> depending on the page size and requested virtual address range. In order to
> validate this page table levels selection this adds a BUILD_BUG_ON() as per
> the existing formula ARM64_HW_PGTABLE_LEVELS(). This would help protect any
> inadvertent changes to CONFIG_PGTABLE_LEVELS selection.

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64/mm: Validate CONFIG_PGTABLE_LEVELS
      https://git.kernel.org/arm64/c/7e04cc918954

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
