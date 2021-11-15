Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FD7451A67
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 00:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354727AbhKOXib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 18:38:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:44626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343629AbhKOTVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:21:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0420A635C1;
        Mon, 15 Nov 2021 18:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637001799;
        bh=9f530FjgKtL5dObJRAQpL0RSVE0qnws0lH1fjBI63ik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rb87jNf7VKVwQRiwIXpM3iyLueNh97sB2JqzkkQNqwAWw8yCkTgtxYfVnN8tFK2c3
         g9jNksAakVeYfhvLwgtaJdr7g/XvHelvtiEXXlAhOXQ7Y/Vic+xAhHLc4MHfDMbEQ1
         KEkKEyFAfww0A7UA18dDpHtaT8IOyw9A6SXA+lpE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 325/917] perf/x86/intel/uncore: Fix Intel SPR M2PCIE event constraints
Date:   Mon, 15 Nov 2021 17:57:00 +0100
Message-Id: <20211115165439.762924048@linuxfoundation.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115165428.722074685@linuxfoundation.org>
References: <20211115165428.722074685@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit f01d7d558e1855d4aa8e927b86111846536dd476 ]

Similar to the ICX M2PCIE  events, some of the SPR M2PCIE events also
have constraints. Add the constraints for SPR M2PCIE.

Fixes: f85ef898f884 ("perf/x86/intel/uncore: Add Sapphire Rapids server M2PCIe support")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1629991963-102621-7-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/uncore_snbep.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 2d75d212c8cc4..cd53057fd52de 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5690,9 +5690,16 @@ static struct intel_uncore_type spr_uncore_irp = {
 
 };
 
+static struct event_constraint spr_uncore_m2pcie_constraints[] = {
+	UNCORE_EVENT_CONSTRAINT(0x14, 0x3),
+	UNCORE_EVENT_CONSTRAINT(0x2d, 0x3),
+	EVENT_CONSTRAINT_END
+};
+
 static struct intel_uncore_type spr_uncore_m2pcie = {
 	SPR_UNCORE_COMMON_FORMAT(),
 	.name			= "m2pcie",
+	.constraints		= spr_uncore_m2pcie_constraints,
 };
 
 static struct intel_uncore_type spr_uncore_pcu = {
-- 
2.33.0



