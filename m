Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069D0382390
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 06:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhEQEz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 00:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbhEQEz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 00:55:26 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CD9C061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 21:54:11 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id h7so2456643plt.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 21:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wv9HmEbNzXquV71c2I1HoKTY3dM9rr3O2ebUyy9oJlA=;
        b=J3O71pOfBC4c67/UCF1GYqUXtR5/eWHqt4hyfGm49iNpD/8JW8r9V4JfzVONbW/Rw1
         +Ne7KuuufvOrCP8dFI0DzQVTPzJ8EZFnn1pFgZXRhdg92Ko8L02es1+iKLQKjQ1fO1jO
         P2xr4Ox+ZApexHrUA8b9s9wKPZ2VANWuIsjqdRxRwMRfTMiGD1r5qXsxmAn+C7rYhN3o
         iyxNtTI9wuZTFEbbGF8pZyfycFGTXHYmXBO3AFBdXc22t9eP5jszvMOioXqbSyEyWSjw
         QDoruDTCzwEvi7e4IheT+MPQtlzPX+CVFbHGA7twyvPYhYDSfxBNCAlgPv2/XjX6ToAO
         dcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wv9HmEbNzXquV71c2I1HoKTY3dM9rr3O2ebUyy9oJlA=;
        b=Qvi/KsovMEenHgDbgHSVINh6yf12zTgRQdoxRKwzwt7URbibpiYRpwTSV6DvOEX9zz
         sjaJUw4C7BqbmDOUFKg2iRcX2xOdnbjskLt++6yMgwQyVfpHWxWjLDf0k2q4gKetNW7c
         MSwmqWHTFkv/yYGLAOJKOEzpssVr1afI1liXxZXq36GSvHsWv3Boqgr9om+50wG9ScXM
         3ruUD1+hjqJyT6EOylcYaKy0kf9i1XOD6FVFxnBOh5tm47IZYTmVF/oNMaH0oJIBSjAz
         iPWWc4vj73470AJ6c0mb6/tTP91ys4RTCWGywb3oHRGvzVTZ6jLhESAaEhXvwmfrH0s8
         oqWA==
X-Gm-Message-State: AOAM532BYuKZd9b7VA3BeiBN3N35ZgtPS9UHGaxD6ko87dL0+tYq6z0Y
        KPuXC311zbnWOMxWeSM3Hg==
X-Google-Smtp-Source: ABdhPJyxCSt0gPoL3zDCxj/Lgxk1wqc86x5Lgwrtz6EXekFEtEzmYEAhJFBEvTXHIkXT0eyiA3gKww==
X-Received: by 2002:a17:90a:da06:: with SMTP id e6mr24442241pjv.183.1621227250533;
        Sun, 16 May 2021 21:54:10 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id j29sm9439038pgl.30.2021.05.16.21.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 21:54:10 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] mm,hwpoison: fix race with compound page allocation
Date:   Mon, 17 May 2021 13:54:00 +0900
Message-Id: <20210517045401.2506032-2-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517045401.2506032-1-nao.horiguchi@gmail.com>
References: <20210517045401.2506032-1-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

When hugetlb page fault (under overcommitting situation) and
memory_failure() race, VM_BUG_ON_PAGE() is triggered by the following race:

    CPU0:                           CPU1:

                                    gather_surplus_pages()
                                      page = alloc_surplus_huge_page()
    memory_failure_hugetlb()
      get_hwpoison_page(page)
        __get_hwpoison_page(page)
          get_page_unless_zero(page)
                                      zero = put_page_testzero(page)
                                      VM_BUG_ON_PAGE(!zero, page)
                                      enqueue_huge_page(h, page)
      put_page(page)

__get_hwpoison_page() only checks page refcount before taking additional
one for memory error handling, which is wrong because there's a time
window where compound pages have non-zero refcount during initialization.

So makes __get_hwpoison_page() check page status a bit more for a few
types of compound pages. PageSlab() check is added because otherwise
"non anonymous thp" path is wrongly chosen.

Fixes: ead07f6a867b ("mm/memory-failure: introduce get_hwpoison_page() for consistent refcount handling")
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Reported-by: Muchun Song <songmuchun@bytedance.com>
Cc: stable@vger.kernel.org # 5.12+
---
ChangeLog v4:
- all hugetlb related check in hugetlb_lock,
- fix build error with #ifdef CONFIG_HUGETLB_PAGE
---
 mm/memory-failure.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git v5.12/mm/memory-failure.c v5.12_patched/mm/memory-failure.c
index a3659619d293..761f982b6d7b 100644
--- v5.12/mm/memory-failure.c
+++ v5.12_patched/mm/memory-failure.c
@@ -1094,6 +1094,16 @@ static int page_action(struct page_state *ps, struct page *p,
 static int __get_hwpoison_page(struct page *page)
 {
 	struct page *head = compound_head(page);
+	int ret = 0;
+
+#ifdef CONFIG_HUGETLB_PAGE
+	spin_lock(&hugetlb_lock);
+	if (PageHuge(head) && (HPageFreed(head) || HPageMigratable(head)))
+		ret = get_page_unless_zero(head);
+	spin_unlock(&hugetlb_lock);
+	if (ret > 0)
+		return ret;
+#endif
 
 	if (!PageHuge(head) && PageTransHuge(head)) {
 		/*
-- 
2.25.1

