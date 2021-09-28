Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED0141AB67
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239818AbhI1JGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:06:00 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:25401 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239618AbhI1JF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:05:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632819860; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=R237/v8v/nmLlhRkG5uGYpDMHZS5jcY1B3ZSLRJyF2E=; b=w4ThUSGrTg2qtaEBmo+Ggu0yEzpd5iND3dofX1KpEJPBkeAlUyXkJhMXyZQSxgpDv6K/jbuX
 dUfbxzKwmVuvbPff8GYJrR4+XQP1K88W5MrorPYYDOUyS6UHb6K3ScH8BfcxFz5nydGwHzB1
 zKdG8MqepO8sCA3t8RMxJIXBCrc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6152da94713d5d6f968b7a65 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Sep 2021 09:04:20
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 51EB4C43617; Tue, 28 Sep 2021 09:04:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from faiyazm-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CF244C4360D;
        Tue, 28 Sep 2021 09:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org CF244C4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     guptap@codeaurora.org, Faiyaz Mohammed <faiyazm@codeaurora.org>
Subject: [PATCH v1] mm: page_alloc: Add debug log in free_reserved_area for static memory
Date:   Tue, 28 Sep 2021 14:34:09 +0530
Message-Id: <1632819849-511-1-git-send-email-faiyazm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For INITRD and initmem memory is reserved through "memblock_reserve"
during boot up but it is free via "free_reserved_area" instead
of "memblock_free".
For example:
[    0.294848] Freeing initrd memory: 12K.
[    0.696688] Freeing unused kernel memory: 4096K.

To get the start and end address of the above freed memory and to account
proper memblock added memblock_dbg log in "free_reserved_area".
After adding log:
[    0.294837] memblock_free: [0x00000083600000-0x00000083603000] free_initrd_mem+0x20/0x28
[    0.294848] Freeing initrd memory: 12K.
[    0.695246] memblock_free: [0x00000081600000-0x00000081a00000] free_initmem+0x70/0xc8
[    0.696688] Freeing unused kernel memory: 4096K.

Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
---
 mm/page_alloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b37435c..f85c3b2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8129,6 +8129,11 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
 		pr_info("Freeing %s memory: %ldK\n",
 			s, pages << (PAGE_SHIFT - 10));
 
+#ifdef CONFIG_HAVE_MEMBLOCK
+		memblock_dbg("memblock_free: [%#016llx-%#016llx] %pS\n",
+			__pa(start), __pa(end), (void *)_RET_IP_);
+#endif
+
 	return pages;
 }
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

