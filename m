Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92DF142D353
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 09:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhJNHPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 03:15:24 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:58750 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230082AbhJNHPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 03:15:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634195598; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=mRIWE8f6XRNaCkd6Yf1vosVkmzQcwujpWypJxd42mWM=; b=nFCAdMXauNmbah7ImdVIJ46wZslrprQI/YnejYjp9srfdQbxQ9fJ3r5wyAAa+5cZvTGjfHBS
 p9apR6+frWBKoDGaIgdTJ5Lb4wJHDnGcOOZWIUPptvtwDBpLf5S+D2a+YdSf06XG/qscYL/U
 LEJErOTh3egA8SlwlTyr3G5iZGM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 6167d879f3e5b80f1f1b9d48 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 14 Oct 2021 07:12:57
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A0663C4338F; Thu, 14 Oct 2021 07:12:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from faiyazm-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DCBFAC4360C;
        Thu, 14 Oct 2021 07:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org DCBFAC4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, david@redhat.com
Cc:     guptap@codeaurora.org, Faiyaz Mohammed <faiyazm@codeaurora.org>
Subject: [PATCH v3] mm: page_alloc: Add debug log in free_reserved_area for static memory
Date:   Thu, 14 Oct 2021 12:42:44 +0530
Message-Id: <1634195564-14048-1-git-send-email-faiyazm@codeaurora.org>
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
proper memblock added pr_debug log in "free_reserved_area".
After adding log:
[    0.294837] 0x00000083600000-0x00000083603000 free_initrd_mem+0x20/0x28
[    0.294848] Freeing initrd memory: 12K.
[    0.695246] 0x00000081600000-0x00000081a00000 free_initmem+0x70/0xc8
[    0.696688] Freeing unused kernel memory: 4096K.

Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
---
changes in v3:
	- Update the format specifier.
changes in v2:
	- To avoid confusion, remove the memblock_dbg print and drop the
	memblock_free string, now using pr_debug to print the address ranges.

 mm/page_alloc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b37435c..13adda5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8097,6 +8097,8 @@ EXPORT_SYMBOL(adjust_managed_page_count);
 
 unsigned long free_reserved_area(void *start, void *end, int poison, const char *s)
 {
+	const phys_addr_t pstart = __pa(start);
+	const phys_addr_t pend = __pa(end);
 	void *pos;
 	unsigned long pages = 0;
 
@@ -8125,9 +8127,12 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
 		free_reserved_page(page);
 	}
 
-	if (pages && s)
+	if (pages && s) {
 		pr_info("Freeing %s memory: %ldK\n",
 			s, pages << (PAGE_SHIFT - 10));
+		pr_debug("[%pa-%pa] %pS\n", &pstart, &pend,
+			(void *)__RET_IP_);
+	}
 
 	return pages;
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

