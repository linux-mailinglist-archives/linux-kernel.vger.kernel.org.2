Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F338E44BF1E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhKJK5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhKJK5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:57:33 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0735FC061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:54:46 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id k4so2629357plx.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qt7zreSDUacj2v2u5kH5eyo4ziYtzmNFB0lGNIs9uO4=;
        b=l8SsT/vCxWFUSSMF7MX9Zo49Dqycpk/E1y+Wj4vtEiwoSuYn6Ot7lQu1+VmZimpDHK
         HYWgzARYq87nMhl+I6uWWdQRfQkz9hlfQW9ZUj5tw6KuEoL3xriYFo8Ofw1f8TxO4Kq7
         TOr4HKwhTU6YNx9YjOX6HnODyTjswL+NE+DsDz2wqNYDFRkbSA7+rxI6jURVgWrby9sZ
         aQ5/aR94ZsBmjchdXP177x5J/cVtS+qn8XSbWLirL2JpO262nb7ovAfN6lmQAx5key0i
         61WEurRpY1dhr6PTI8E/yv02FgJvUvY1/lBbg0vdFLL8vsYCSGc6pD9eKyvA4FXeblJt
         9xHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qt7zreSDUacj2v2u5kH5eyo4ziYtzmNFB0lGNIs9uO4=;
        b=m/Icwk0yWRjXaMLS+ADnNOt3wH0xClViPdbVHr00rISMz2HQsCYLQximUc9lesqebw
         a1TpEsGcSG63qxF35V4layuJjOtbJg6EizlXEyPGyE+lLqC6HRFB+CkKSjDICG2Zcra0
         ebcmz7qsj84VzmU60S146Y1FITt+Vacu4hptm7JQ73jo1UU0x4X25+mUc5zeRitz/t/4
         cA+DKB/HgK7uglGwv2gr3LJmG1YTJzjrZXmUi9rsKLEg02f1QuD58rnpMz3q1noIHvcb
         nDjEpkJokfXbXF9jo1mFserVcyPsTAoDPipZGa2YhgJIEf8xW48w/4qLaNp6qnk3eW2u
         VDGA==
X-Gm-Message-State: AOAM531uIFOk0b3mWLymBlxSbNlDhG2mbMfQRGtCpwYlRoNL3PD1Hk6c
        z5x5P1QMomnz3Qv/D94EVcunvg==
X-Google-Smtp-Source: ABdhPJza7nfvYf9STeiUke1V+/jRoDSu267dlbThM8QvxtxpYIF51oy/+RM2CrjL2b6yY0gkHT246A==
X-Received: by 2002:a17:902:8f93:b0:142:8731:1a5d with SMTP id z19-20020a1709028f9300b0014287311a5dmr14860865plo.60.1636541685575;
        Wed, 10 Nov 2021 02:54:45 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id v38sm5865829pgl.38.2021.11.10.02.54.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 02:54:45 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 01/15] mm: do code cleanups to filemap_map_pmd()
Date:   Wed, 10 Nov 2021 18:54:14 +0800
Message-Id: <20211110105428.32458-2-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
References: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we have two times the same few lines repeated
in filemap_map_pmd(). Deduplicate them and fix some code
style issues.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/filemap.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index daa0e23a6ee6..07c654202870 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3203,11 +3203,8 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
 	struct mm_struct *mm = vmf->vma->vm_mm;
 
 	/* Huge page is mapped? No need to proceed. */
-	if (pmd_trans_huge(*vmf->pmd)) {
-		unlock_page(page);
-		put_page(page);
-		return true;
-	}
+	if (pmd_trans_huge(*vmf->pmd))
+		goto out;
 
 	if (pmd_none(*vmf->pmd) && PageTransHuge(page)) {
 		vm_fault_t ret = do_set_pmd(vmf, page);
@@ -3222,13 +3219,15 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
 		pmd_install(mm, vmf->pmd, &vmf->prealloc_pte);
 
 	/* See comment in handle_pte_fault() */
-	if (pmd_devmap_trans_unstable(vmf->pmd)) {
-		unlock_page(page);
-		put_page(page);
-		return true;
-	}
+	if (pmd_devmap_trans_unstable(vmf->pmd))
+		goto out;
 
 	return false;
+
+out:
+	unlock_page(page);
+	put_page(page);
+	return true;
 }
 
 static struct page *next_uptodate_page(struct page *page,
-- 
2.11.0

