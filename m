Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96713B8A04
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 23:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbhF3VN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 17:13:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:4263 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235168AbhF3VMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 17:12:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="195720735"
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="195720735"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 14:10:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="558431195"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga004.jf.intel.com with ESMTP; 30 Jun 2021 14:10:15 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, gregkh@linuxfoundation.org,
        acme@kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 09/16] perf/x86/intel/uncore: Add Sapphire Rapids server UPI support
Date:   Wed, 30 Jun 2021 14:08:33 -0700
Message-Id: <1625087320-194204-10-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1625087320-194204-1-git-send-email-kan.liang@linux.intel.com>
References: <1625087320-194204-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Sapphire Rapids uses a coherent interconnect for scaling to multiple
sockets known as Intel UPI. Intel UPI technology provides a cache
coherent socket to socket external communication interface between
processors.

The layout of the control registers for a UPI uncore unit is similar to
a M2M uncore unit.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index ff2cc02..d74f918 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5540,6 +5540,11 @@ static struct intel_uncore_type spr_uncore_m2m = {
 	.name			= "m2m",
 };
 
+static struct intel_uncore_type spr_uncore_upi = {
+	SPR_UNCORE_PCI_COMMON_FORMAT(),
+	.name			= "upi",
+};
+
 #define UNCORE_SPR_NUM_UNCORE_TYPES		12
 
 static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
@@ -5551,7 +5556,7 @@ static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
 	NULL,
 	&spr_uncore_imc,
 	&spr_uncore_m2m,
-	NULL,
+	&spr_uncore_upi,
 	NULL,
 	NULL,
 	NULL,
-- 
2.7.4

