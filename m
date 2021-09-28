Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A84941B6B4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 20:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242328AbhI1Sxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 14:53:39 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:40652 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242305AbhI1Sxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 14:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1632855119; x=1664391119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=GMMRKpJEtRdcqo7mQHQKLh9TwKsB1pEChAZ7QINVZTE=;
  b=dhzyjelv+DEK+X/QkIlKyIWXgfByWKSj0s9tDhj7vJ3vcT/rjjdRyvKt
   EQCHk+T0SjahooWTzGSmq/IfWsKeJe1H0G3zY8bxRSnCw6iuUisQA94HH
   19/pWp0RPV+shIjq5VWTXYhzIoanPrS14F7zgZL14/FUP4vCkhxZqdrx2
   8=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 28 Sep 2021 11:51:59 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 11:51:58 -0700
Received: from hu-cgoldswo-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Tue, 28 Sep 2021 11:51:57 -0700
From:   Chris Goldsworthy <quic_cgoldswo@quicinc.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Sudarshan Rajagopalan" <quic_sudaraja@quicinc.com>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] arm64: mm: update max_pfn after memory hotplug
Date:   Tue, 28 Sep 2021 11:51:49 -0700
Message-ID: <a51a27ee7be66024b5ce626310d673f24107bcb8.1632853776.git.quic_cgoldswo@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1632853776.git.quic_cgoldswo@quicinc.com>
References: <cover.1632853776.git.quic_cgoldswo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>

After new memory blocks have been hotplugged, max_pfn and max_low_pfn
needs updating to reflect on new PFNs being hot added to system.
Without this patch, debug-related functions that use max_pfn such as
get_max_dump_pfn() or read_page_owner() will not work with any page in
memory that is hot-added after boot. 

Fixes: 4ab215061554 ("arm64: Add memory hotplug support")
Signed-off-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
Signed-off-by: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 arch/arm64/mm/mmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index cfd9deb..fd85b51 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1499,6 +1499,11 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	if (ret)
 		__remove_pgd_mapping(swapper_pg_dir,
 				     __phys_to_virt(start), size);
+	else {
+		max_pfn = PFN_UP(start + size);
+		max_low_pfn = max_pfn;
+	}
+
 	return ret;
 }
 
-- 
2.7.4

