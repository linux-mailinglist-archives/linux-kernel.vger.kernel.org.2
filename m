Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180D839FB15
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 17:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhFHPpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 11:45:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231253AbhFHPps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:45:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CE5C60698;
        Tue,  8 Jun 2021 15:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623167035;
        bh=LeuhMPqbwF0tdilD8I1Tc0TS6TVdYXlP61hxMft9wI8=;
        h=From:To:Cc:Subject:Date:From;
        b=f2MZYibXESJ+3OOHBLWbd7Sj22+EaGfrXY/KeuGaheIsHMSI8SMhM3EF78GzHmEbb
         TJK53T1FhmMIU8OGrYXjXNwnBehFsRC/At8fw4Ik3OhQ9tcRWImaG3S0R9tUXohYLi
         BkewYT3WlAmNVhSx4W7YpR6bCWbK13gwCeNx+RZRBdVCDizvOYENtj4td1fTU2LDAZ
         DgxrptOzkNPtVOxcEcfzr3XERlCMFb7Y+B6Us9i0uqC/3fMhZesMyYEpt9E9c/SDAT
         Gu5fexhs+lHpXhWtpJKy4nh58c2mU8mifgSv0XfoeqOZiXjD4ac3ZxAgn4q0xQBiNz
         TbuqjXg+usb6A==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 0/2] Use Exynos-MCT timer as wakeup for Arm arch timer
Date:   Tue,  8 Jun 2021 16:43:39 +0100
Message-Id: <20210608154341.10794-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

These two patches build on top of my other series for adding per-cpu
wakeup timers [1] which is currently queued in -tip [2].

The basic idea is to prefer the Arm architected timer, even when
CLOCK_EVT_FEAT_C3STOP is set, as long as we have another timer which can
be used for the per-cpu wakeup. These patches use Exynos-MCT as an
example, since that driver currently goes out of its way to prevent use
of the Arm architected timer due to issues with a 32-bit SoC.

Cheers,

Will

[1] https://lore.kernel.org/lkml/20210524221818.15850-1-will@kernel.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=timers/core

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>

--->8

Will Deacon (2):
  clocksource/drivers/exynos_mct: Prioritise Arm arch timer on arm64
  clocksource/drivers/exynos_mct: Mark MCT device as
    CLOCK_EVT_FEAT_PERCPU

 drivers/clocksource/exynos_mct.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

-- 
2.32.0.rc1.229.g3e70b5a671-goog

