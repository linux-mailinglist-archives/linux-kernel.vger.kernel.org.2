Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0D342877F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 09:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbhJKHNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 03:13:39 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:39516 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234280AbhJKHNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 03:13:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633936296; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=SxkqQM4LqWhI9JoDud74skgu9QyWuT32tUB57PZ42fM=; b=XCY0jtMseobOzcPTxDciRBgPBmuPHT7lJx18tTRjuRPb5aq/iKSQnSdBw2ZAmlWvXeXxpKIC
 khTDRrn+GyGxmOYkQAIdMz2Q5ze6OyfDcYW8bky8EGMaRkYR6cNG1a6AXSiQv8sQn9aKMkY0
 +MSrkoFFe4koQKmwGJJjkEUsJfA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6163e3a58ea00a941fe39168 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 07:11:33
 GMT
Sender: quic_faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9A67CC43617; Mon, 11 Oct 2021 07:11:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from faiyazm-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BCB74C4338F;
        Mon, 11 Oct 2021 07:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org BCB74C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Faiyaz Mohammed <quic_faiyazm@codeaurora.org>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, david@redhat.com
Cc:     guptap@codeaurora.org, Faiyaz Mohammed <faiyazm@codeaurora.org>
Subject: [PATCH v2] mm: page_alloc: Add debug log in free_reserved_area for static memory
Date:   Mon, 11 Oct 2021 12:41:19 +0530
Message-Id: <1633936279-26856-1-git-send-email-quic_faiyazm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Faiyaz Mohammed <faiyazm@codeaurora.org>

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
changes in v2:
	- To avoid confusion, remove the memblock_dbg print and drop the
	memblock_free string, now using pr_debug to print the address ranges.

 mm/page_alloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 668edb1..395df3f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8153,6 +8153,11 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
 	if (pages && s)
 		pr_info("Freeing %s memory: %ldK\n", s, K(pages));
 
+#ifdef CONFIG_HAVE_MEMBLOCK
+		pr_debug("%#016llx-%#016llx %pS\n",
+			__pa(start), __pa(end), (void *)_RET_IP_);
+#endif
+
 	return pages;
 }
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

