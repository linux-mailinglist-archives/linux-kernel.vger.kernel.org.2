Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7597C3402C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhCRKJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:09:15 -0400
Received: from a0.mail.mailgun.net ([198.61.254.59]:31006 "EHLO
        a0.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhCRKJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:09:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1616062150; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=nAQi2hXZoyVEBNQT5tcJTWbbCcR2EZVp9zkpfdPbwOY=; b=dwSxWOsLvirJmWoZYlg3V76cOnf7XEZUiFHZoa+EZVdV4OIvYqRVqhPTKmjie3wO1w6BiMtW
 C9ojWsv/WcF3M9SBQa0OvzFUIdjpRVLRpbNE9Cwef++bz9QKD1yh+fpoqiKjo6QbSsxWIVjk
 gX9glJ2IkFVeXrBswjHeKXq1Pxk=
X-Mailgun-Sending-Ip: 198.61.254.59
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 605326a8c32ceb3a91c7f746 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 18 Mar 2021 10:08:40
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 15792C433C6; Thu, 18 Mar 2021 10:08:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from vjitta-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 996FCC433CA;
        Thu, 18 Mar 2021 10:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 996FCC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vjitta@codeaurora.org
From:   vjitta@codeaurora.org
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     vjitta@codeaurora.org, vinmenon@codeaurora.org
Subject: [PATCH] mm: vmalloc: Prevent use after free in _vm_unmap_aliases
Date:   Thu, 18 Mar 2021 15:38:25 +0530
Message-Id: <1616062105-23263-1-git-send-email-vjitta@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijayanand Jitta <vjitta@codeaurora.org>

A potential use after free can occur in _vm_unmap_aliases
where an already freed vmap_area could be accessed, Consider
the following scenario:

Process 1						Process 2

__vm_unmap_aliases					__vm_unmap_aliases
	purge_fragmented_blocks_allcpus				rcu_read_lock()
		rcu_read_lock()
			list_del_rcu(&vb->free_list)
									list_for_each_entry_rcu(vb .. )
	__purge_vmap_area_lazy
		kmem_cache_free(va)
										va_start = vb->va->va_start

Here Process 1 is in purge path and it does list_del_rcu on vmap_block
and later frees the vmap_area, since Process 2 was holding the rcu lock
at this time vmap_block will still be present in and Process 2 accesse
it and thereby it tries to access vmap_area of that vmap_block which was
already freed by Process 1 and this results in use after free.

Fix this by adding a check for vb->dirty before accessing vmap_area
structure since vb->dirty will be set to VMAP_BBMAP_BITS in purge path
checking for this will prevent the use after free.

Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d5f2a84..ebb6f57 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1762,7 +1762,7 @@ static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)
 		rcu_read_lock();
 		list_for_each_entry_rcu(vb, &vbq->free, free_list) {
 			spin_lock(&vb->lock);
-			if (vb->dirty) {
+			if (vb->dirty && vb->dirty != VMAP_BBMAP_BITS) {
 				unsigned long va_start = vb->va->va_start;
 				unsigned long s, e;
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
2.7.4

