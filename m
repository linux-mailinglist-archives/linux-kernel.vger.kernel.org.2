Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B97B45D6F6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 10:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353721AbhKYJTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 04:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351363AbhKYJRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 04:17:44 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7928AC06174A;
        Thu, 25 Nov 2021 01:06:38 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d24so10127204wra.0;
        Thu, 25 Nov 2021 01:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jNNIPip2h8ygz6aWA8IjTUMOry53VnVtZZgUn1liZPY=;
        b=pZlZ6TWgERRy02Vfa1iyfy41bVGcH8ZbLdkbRL1NTiwSz2XNURB3N/0aMae8pxllAv
         6aVQly78QWPlr8rEtpNNd3EVX7G86WzrQJdcYnI3bQ+kmbiFN8JdAUCP8tKESWzwntIP
         hdSWKxV5O7VbYQ8f65Qa20PYxipSLpQ3kaBFkZ24TgU89/0wizUz8lXPT6XN8WQz37vd
         ZR8Of6w6Y/JSUD8eg8Mu1pE94V5J7+Howf7/iUZsjUrCIOsWDKCKkDUbkUKyDFEji3A5
         ITD/ZVCftMMCUoP3qNAPXvOy0RFleTiuf6Fc3crfjqi8XQdNdTHLVPNfPt0a03rks6ID
         QLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jNNIPip2h8ygz6aWA8IjTUMOry53VnVtZZgUn1liZPY=;
        b=aS87hCz7OdXUBLBShU92+7RPjx9EvZMtG7e1YO/B+PNaxd4p7WY5VhoMynXDeu56qy
         7NZuGMAVWFNSho0xkekpWstSSJt0i+9NL/8cgdmfdSLYlZ9eLvH7EqFX6HOAPWJ+xsIb
         52wnsI/2E7Q2SyeS+S0qvSCdhU5ZODNscySBGvR4n9QVF+BmIKrrroho3k/qNmKzJz55
         xd3UlKD0ybzn4N6P/0ul3T1BrDLhiJmPGwhdDSqTW5aBl8DiXzfI1lZG6MicReb19tQR
         VcHBPv4e/VsYhSTqtIyZMYN4rQcKRYzu48Q3RMZhGq2ycPnpdAWzd6kcLjF2etPGrJPp
         Cejw==
X-Gm-Message-State: AOAM533VYNpb1larPpHOwhENm8Sf+Edt29oS6mALkQqocp07em9mp80U
        6LIplBJiB/dL6A==
X-Google-Smtp-Source: ABdhPJz1Pq+uzntfyxuuBXLiuoJ9QTDopTRleeCuk2GruWk9dswY8VyWPNPKg5v2C03WkpPlOpnsIg==
X-Received: by 2002:a5d:6e82:: with SMTP id k2mr4559901wrz.147.1637831197042;
        Thu, 25 Nov 2021 01:06:37 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o4sm2728594wry.80.2021.11.25.01.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 01:06:36 -0800 (PST)
From:   Colin Ian King <colin.i.king@googlemail.com>
X-Google-Original-From: Colin Ian King <colin.i.king@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] hugetlb: Fix spelling mistake "hierarichal" -> "hierarchical"
Date:   Thu, 25 Nov 2021 09:06:35 +0000
Message-Id: <20211125090635.23508-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a literal string and a comment. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 mm/hugetlb_cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 9bdcf6560849..9eebe8df3c39 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -495,11 +495,11 @@ static int hugetlb_cgroup_read_numa_stat(struct seq_file *seq, void *dummy)
 	 * The hierarchical total is pretty much the value recorded by the
 	 * counter, so use that.
 	 */
-	seq_printf(seq, "%stotal=%lu", legacy ? "hierarichal_" : "",
+	seq_printf(seq, "%stotal=%lu", legacy ? "hierarchical_" : "",
 		   page_counter_read(&h_cg->hugepage[idx]) * PAGE_SIZE);
 
 	/*
-	 * For each node, transverse the css tree to obtain the hierarichal
+	 * For each node, transverse the css tree to obtain the hierarchical
 	 * node usage.
 	 */
 	for_each_node_state(nid, N_MEMORY) {
-- 
2.33.1

