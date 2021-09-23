Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6A141683B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 00:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243537AbhIWW4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 18:56:32 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:53816 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243528AbhIWW4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 18:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1632437699; x=1663973699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=nzSKhDY13mK++9t7Je2bVwF1BfPMf2B+QPve7nlub6g=;
  b=COCEcNoOxOvL++1ChLBcNlO2Lll4Kk9iXz22LIjm5QNg+ixYU2bF1dxd
   O7K+HD6orROuR5nZcqHO7aF6n8RY7Xrwx8OlFaSjtqDK/O3LC+eQaexUE
   NSQLNvCzJDMEWxylbwWFxiWxt7I/XgEZrCr4TC/h5vXjXyVo6LqS67kLl
   8=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 23 Sep 2021 15:54:59 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 15:54:58 -0700
Received: from hu-cgoldswo-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Thu, 23 Sep 2021 15:54:57 -0700
From:   Chris Goldsworthy <quic_cgoldswo@quicinc.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        Chris Goldsworthy <quic_cgoldswo@quicinc.com>
Subject: [RFC] arm64: mm: update max_pfn after memory hotplug
Date:   Thu, 23 Sep 2021 15:54:48 -0700
Message-ID: <595d09279824faf1f54961cef52b745609b05d97.1632437225.git.quic_cgoldswo@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1632437225.git.quic_cgoldswo@quicinc.com>
References: <cover.1632437225.git.quic_cgoldswo@quicinc.com>
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

Signed-off-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
Signed-off-by: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
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

