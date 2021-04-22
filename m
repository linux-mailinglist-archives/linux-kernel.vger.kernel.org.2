Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23ED367D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 11:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbhDVJSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 05:18:21 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:31638 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235004AbhDVJSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 05:18:13 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210422091737epoutp03524641074601900aac3f69f586ae4015~4I3ZPx2w32216822168epoutp037
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 09:17:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210422091737epoutp03524641074601900aac3f69f586ae4015~4I3ZPx2w32216822168epoutp037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1619083057;
        bh=moCMty+hy6GEde6fVkbpppPU9h4RXN6mG5YwWbMgjuc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=HbpuTo8CbR4f0xGuLfKS97r0Bplx9M1JcpVxAn4LkvWtjSvhu2Qk84xwB/wNXoCXM
         Kf1sXI/bDIphypbFdqQcynR9rZdKmip/N+mE0YRzIF6sREuehjmL8eFAc47ffR86Ph
         nk6lBK96sGDKxI+aDSwyqKxJWNPgcmbwdlxX7afE=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20210422091736epcas5p497e47c9e7301881621d406e8845adef0~4I3YtmWeD0245902459epcas5p4P;
        Thu, 22 Apr 2021 09:17:36 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4C.23.09697.03F31806; Thu, 22 Apr 2021 18:17:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20210422081531epcas5p23d6c72ebf28a23b2efc150d581319ffa~4IBLdfpKd2379523795epcas5p20;
        Thu, 22 Apr 2021 08:15:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210422081531epsmtrp1110f38b91c9cb4caea94b3bc85405947~4IBLcO7hJ2412924129epsmtrp1C;
        Thu, 22 Apr 2021 08:15:31 +0000 (GMT)
X-AuditID: b6c32a4a-64fff700000025e1-6a-60813f30f140
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.24.08637.3A031806; Thu, 22 Apr 2021 17:15:31 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210422081529epsmtip221d1e82eb9ad9648c0a66f4c2673e534~4IBJfwv2f1502415024epsmtip2P;
        Thu, 22 Apr 2021 08:15:29 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        akpm@linux-foundation.org, dvyukov@google.com
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        Maninder Singh <maninder1.s@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Subject: [PATCH 1/2] mm/kasan: avoid duplicate KASAN issues from reporting
Date:   Thu, 22 Apr 2021 13:45:16 +0530
Message-Id: <1619079317-1131-1-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7bCmlq6BfWOCwcqtohYXd6dazFm/hs3i
        +8Tp7BYTHraxW7R/3MtsseLZfSaLy7vmsFncW/Of1eLw/DYWi+NbtzBbHDo5l9GB22PnrLvs
        Hgs2lXrsmXiSzWPTp0nsHidm/Gbx6NuyitHj8ya5APYoLpuU1JzMstQifbsErow7PzrYCzrl
        Ko5fP8PUwNgg2cXIySEhYCLxafMKxi5GLg4hgd2MEo9nPmaCcD4xSqyf94UZwvnGKPHoVwMb
        TMvkLTPZIBJ7GSX2reqGcr4wSqyZ+pEdpIpNQE9i1a49LCC2iECJxIG+LSwgRcwCexglDp65
        BZYQFvCS+Ph/CROIzSKgKtH8rB+smVfATeLB3E9Q6+Qkbp7rZIawr7FLbFogDWG7SOx9tIIF
        whaWeHV8CzuELSXxsr+NHWSZhEA3o8TMOZeZIZzVjBKbXlxnhaiyl3jd3AC0mQPoJE2J9bv0
        IcKyElNPrQM7iFmAT6L39xMmiDivxI55MLaqRMvNDVBjpCU+f/wIdYSHxIrfh8EOFRKIlfjc
        3sE2gVF2FsKGBYyMqxglUwuKc9NTi00LjPJSy/WKE3OLS/PS9ZLzczcxgtOGltcOxocPPugd
        YmTiYDzEKMHBrCTCu7a4IUGINyWxsiq1KD++qDQntfgQozQHi5I4r6BzdYKQQHpiSWp2ampB
        ahFMlomDU6qBSZfr9+9NWz9dmn/DVDUwKTRn36IuP4ffJZsdTt3c2MN6+MSKqwsq6zdNmhK3
        lu9U5UmlxHNiQn8KTdXO6RUK1jIL1t3Z+PiMX7nMPane4BV7ZeQn/A1+zLW2+/rFuqCDl/h0
        mfe/m3bntKFc2K7eE9cOzZN/PulspvjRZ0Url0TYseda+SQdX/y3nfddt8221QKCugIrf3td
        OXx30p6YENP8baxuYfw3/Htn/Z/ife2E7PublxvTvVOK75e88hHUUxPol1O/y5Pi7Xi67r/u
        BLY9782mp5g8yM+Z3nxz+55s6cPK8kYtM79efHr+k5qAYwPrvhsfithXVDTkr5ofrqeheurq
        BV35JY7Vyz/8WKDEUpyRaKjFXFScCADVhQsJigMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFLMWRmVeSWpSXmKPExsWy7bCSvO5ig8YEg+nLhSwu7k61mLN+DZvF
        94nT2S0mPGxjt2j/uJfZYsWz+0wWl3fNYbO4t+Y/q8Xh+W0sFse3bmG2OHRyLqMDt8fOWXfZ
        PRZsKvXYM/Ekm8emT5PYPU7M+M3i0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBl3fnSwF3TK
        VRy/foapgbFBsouRk0NCwERi8paZbF2MXBxCArsZJT49m88KkZCW+PnvPQuELSyx8t9zdhBb
        SOATo8Sh6SIgNpuAnsSqXXvAakQEqiSm/9rBBmIzCxxilOjdIQxiCwt4SXz8v4QJxGYRUJVo
        ftYPNodXwE3iwdxPbBDz5SRunutknsDIs4CRYRWjZGpBcW56brFhgWFearlecWJucWleul5y
        fu4mRnDwaWnuYNy+6oPeIUYmDkagXRzMSiK8a4sbEoR4UxIrq1KL8uOLSnNSiw8xSnOwKInz
        Xug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgsr1nulLOULMswFc+vWCWycHAtYeP85jnyU9Qvh9y
        fcPDGzJVN19orGXpbxSbssyo/cNHRV+OTXNW2S7ZEcDzOrzvzm7BcAGLzEli9+75zhZ2P53f
        tLC7PczOsWWlhbqwG/dfrooZ3QzivHZn14jo/vVdn+uhtfPmtS36fJ383KtqnEyN9SXMf3b7
        NTLksnEa+T+U03P/y3FWrXr71R0T5lmxNBcYxk39WlbP7TVry6wzRbeOtE1wzwldpvRAozGt
        J/b2qunOOdVTroncmxitU2Yfv/Hs7gCnRTfzDvc+N9oy2XFbcpnmqoYfixOWe3w6tik7fwr7
        siUXt9075u8xN1w1deHNqs+9KSsdJWYqsRRnJBpqMRcVJwIAc/BDTK0CAAA=
X-CMS-MailID: 20210422081531epcas5p23d6c72ebf28a23b2efc150d581319ffa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210422081531epcas5p23d6c72ebf28a23b2efc150d581319ffa
References: <CGME20210422081531epcas5p23d6c72ebf28a23b2efc150d581319ffa@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when KASAN multishot is ON and some buggy code hits same code path
of KASAN issue repetetively, it can flood logs on console.

Check for allocaton, free and backtrace path at time of KASAN error,
if these are same then it is duplicate error and avoid these prints
from KASAN.

Co-developed-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 mm/kasan/kasan.h  |  6 +++++
 mm/kasan/report.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 78cf99247139..d14ccce246ba 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -102,6 +102,12 @@ struct kasan_access_info {
 	unsigned long ip;
 };
 
+struct kasan_record {
+	depot_stack_handle_t	bt_handle;
+	depot_stack_handle_t	alloc_handle;
+	depot_stack_handle_t	free_handle;
+};
+
 /* The layout of struct dictated by compiler */
 struct kasan_source_location {
 	const char *filename;
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 87b271206163..4576de76991b 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -39,6 +39,10 @@ static unsigned long kasan_flags;
 #define KASAN_BIT_REPORTED	0
 #define KASAN_BIT_MULTI_SHOT	1
 
+#define MAX_RECORDS		(200)
+static struct kasan_record kasan_records[MAX_RECORDS];
+static int stored_kasan_records;
+
 bool kasan_save_enable_multi_shot(void)
 {
 	return test_and_set_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags);
@@ -360,6 +364,65 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
 	end_report(&flags, (unsigned long)object);
 }
 
+/*
+ * @save_report()
+ *
+ * returns false if same record is already saved.
+ * returns true if its new record and saved in database of KASAN.
+ */
+static bool save_report(void *addr, struct kasan_access_info *info, u8 tag, unsigned long *flags)
+{
+	struct kasan_record record = {0};
+	depot_stack_handle_t bt_handle;
+	int i = 0;
+	const char *bug_type;
+	struct kasan_alloc_meta *alloc_meta;
+	struct kasan_track *free_track;
+	struct page *page;
+	bool ret = true;
+
+	kasan_disable_current();
+	spin_lock_irqsave(&report_lock, *flags);
+
+	bug_type = kasan_get_bug_type(info);
+	page = kasan_addr_to_page(addr);
+	bt_handle = kasan_save_stack(GFP_KERNEL);
+
+	if (page && PageSlab(page)) {
+		struct kmem_cache *cache = page->slab_cache;
+		void *object = nearest_obj(cache, page, addr);
+
+		alloc_meta = kasan_get_alloc_meta(cache, object);
+		free_track = kasan_get_free_track(cache, object, tag);
+		record.alloc_handle = alloc_meta->alloc_track.stack;
+		if (free_track)
+			record.free_handle = free_track->stack;
+	}
+
+	record.bt_handle = bt_handle;
+
+	for (i = 0; i < stored_kasan_records; i++) {
+		if (record.bt_handle != kasan_records[i].bt_handle)
+			continue;
+		if (record.alloc_handle != kasan_records[i].alloc_handle)
+			continue;
+		if (!strncmp("use-after-free", bug_type, 15) &&
+			(record.free_handle != kasan_records[i].free_handle))
+			continue;
+
+		ret = false;
+		goto done;
+	}
+
+	memcpy(&kasan_records[stored_kasan_records], &record, sizeof(struct kasan_record));
+	stored_kasan_records++;
+
+done:
+	spin_unlock_irqrestore(&report_lock, *flags);
+	kasan_enable_current();
+	return ret;
+}
+
 static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 				unsigned long ip)
 {
@@ -388,6 +451,10 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 	info.is_write = is_write;
 	info.ip = ip;
 
+	if (addr_has_metadata(untagged_addr) &&
+		!save_report(untagged_addr, &info, get_tag(tagged_addr), &flags))
+		return;
+
 	start_report(&flags);
 
 	print_error_description(&info);
-- 
2.17.1

