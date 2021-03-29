Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A6B34C31F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 07:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhC2FmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 01:42:07 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:43064 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhC2FmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 01:42:01 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210329054159epoutp01c8a51b0b24518ee021b8550229145995~wucRYAnhj3157831578epoutp01b
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 05:41:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210329054159epoutp01c8a51b0b24518ee021b8550229145995~wucRYAnhj3157831578epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616996519;
        bh=fnjnlce7c5+O8UaVulFJGkolaqrYx/wpAW4FBl6bkMk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=E5AMwnzy0JfckqjMH3ciGedjPh1fA4/lUOa60oaYNBIqxga3QlftxZCaqewY+2CBa
         4LX4ZCFisRxOgl/d8dWzD2NB12i8v2laaYQZ5ysjiYXNru2DpepcoTgRQWIKbKgc/s
         Vo7l4+xVmmsww4FZeC/Ht0LZUeAPRA0NfOeKEKuo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20210329054158epcas2p494a583daa1d7b81536a0e3a5394269c0~wucQ_XwrA0567605676epcas2p47;
        Mon, 29 Mar 2021 05:41:58 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.188]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4F81fs2GmKz4x9QJ; Mon, 29 Mar
        2021 05:41:57 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        BF.FE.52511.4A861606; Mon, 29 Mar 2021 14:41:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20210329054156epcas2p31650fa755e6cbcc55c4f33a79878256f~wucOdq1_V2894328943epcas2p3H;
        Mon, 29 Mar 2021 05:41:56 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210329054156epsmtrp166e2d348e077ea4866c08bbd9f8653e7~wucOc-2ty1579715797epsmtrp1I;
        Mon, 29 Mar 2021 05:41:56 +0000 (GMT)
X-AuditID: b6c32a48-50fff7000000cd1f-62-606168a4135c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.82.08745.3A861606; Mon, 29 Mar 2021 14:41:55 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210329054155epsmtip154223f5978ff85a542569ba6add062ae~wucOQF2_C2876528765epsmtip1n;
        Mon, 29 Mar 2021 05:41:55 +0000 (GMT)
From:   Hyunsoon Kim <h10.kim@samsung.com>
To:     "Andrew Morton" <akpm@linux-foundation.org>
Cc:     dseok.yi@samsung.com, h10.kim@samsung.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: add ___GFP_NOINIT flag which disables zeroing on alloc
Date:   Mon, 29 Mar 2021 14:29:10 +0900
Message-Id: <1616995751-83180-1-git-send-email-h10.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsWy7bCmhe6SjMQEg70r9C3mrF/DZnFl2h9G
        i7+3L7JaXN41h83i3pr/rA6sHps+TWL3ODHjN4tH35ZVjB6fN8kFsETl2GSkJqakFimk5iXn
        p2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA7VVSKEvMKQUKBSQWFyvp29kU
        5ZeWpCpk5BeX2CqlFqTkFBgaFugVJ+YWl+al6yXn51oZGhgYmQJVJuRk7Lt3l73gj0BF02XW
        BsbpfF2MnBwSAiYSUzYtZeti5OIQEtjBKNH9cwMrSEJI4BOjRP+RJIjEZ0aJsz/bmGA6Gu89
        ZIRI7GKUWHL8BxOE84NR4tWcdjaQKjYBDYnbU2ayg9giAvoS85ZMButmFkiUmH7xAQuILSzg
        LXHwUidYDYuAqsTbP7vBangFnCXWvdzDBrFNTuLmuU5mkAUSApPZJT5+aIZKuEi8Wj6PGcIW
        lnh1fAs7hC0l8bK/Dcqul5h9+SRU8wRGiZfn+qF+MJaY9awd6AcOoIs0Jdbv0gcxJQSUJY7c
        YoG4k0+i4/Bfdogwr0RHmxBEo6LEihMzoaaLS7Q1boe6wENi3qrXTJCQi5W4sHUH6wRG2VkI
        8xcwMq5iFEstKM5NTy02KjBBjqNNjOCkpOWxg3H22w96hxiZOBgPMUpwMCuJ8LKejk0Q4k1J
        rKxKLcqPLyrNSS0+xGgKDK+JzFKiyfnAtJhXEm9oamRmZmBpamFqZmShJM5bZPAgXkggPbEk
        NTs1tSC1CKaPiYNTqoFpZ3e+4tUY4+Isvy3qu6+2Cv6sSzl/MCbdfWXyQ1HeXS+36bWdl7HY
        M/nEEj61nUUC3Xf2zj02aXm99qEncn3he8LWJ5XZq9oel305lX9pmn/RXa60AxymX/ZufsGX
        sWN/5tG6DovdcVVHJl8/5vZllvLcuNycqSZNQi4/Z/pWlK9033g2sCqI6VGeQCd7q9jMBL7k
        o5KKHw6GHFJTtb/wocrxEqt8V7veEp7IzSYi809s1G/NnuS3X1DOXrGd/0XZAw7997ryHzbm
        V7D/ePYl+uGU9Y9ka7sqLLZNWXgv56XipWWWH4UlO7fb1dkzTBTwCf9aes7wYq+wm5KZrp54
        nWa06r0D65P/s7Bt/63EUpyRaKjFXFScCABV67Tn0wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPJMWRmVeSWpSXmKPExsWy7bCSnO7ijMQEgyvXzCzmrF/DZnFl2h9G
        i7+3L7JaXN41h83i3pr/rA6sHps+TWL3ODHjN4tH35ZVjB6fN8kFsERx2aSk5mSWpRbp2yVw
        Zey7d5e94I9ARdNl1gbG6XxdjJwcEgImEo33HjJ2MXJxCAnsYJS4sb+NGSIhLvF0yQVGCFtY
        4n7LEVaIom+MEn3Xp7CBJNgENCRuT5nJDmKLCOhLzFsymQnEZhZIlbh5YjVYs7CAt8TBS51g
        NSwCqhJv/+wGq+EVcJZY93IPG8QCOYmb5zqZJzDyLGBkWMUomVpQnJueW2xYYJSXWq5XnJhb
        XJqXrpecn7uJERwmWlo7GPes+qB3iJGJg/EQowQHs5IIL+vp2AQh3pTEyqrUovz4otKc1OJD
        jNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamDL3TDLdc8fHZRtHlmxDXny8FduSJ5U5
        U3SOBLM83Faq82FDqhKflvqtoLmia6t9lB17867d2T5rq/v2hYsbK1M6tuw9mXNocs2/jr1N
        TAJrF0fb3//1n+/yk3LB1oXvay8G/ivxD5VQ3WIlt3uulp9J9Enpr0+YPlyeLpuv3f5D7q1O
        jtP53sfre57mHV2wRfZiUPeSoN6y2jfHHT8xZ3Dq/89bEXtx3Y3FZh6yrAsyWx4t+Lj6xmpH
        +y8iERE1Sv795/wnX7lwsd7ZXy0lUNOPZ2t9UL7wm888dt17OPtF36ssPWbyhzt67bvq608n
        M6/KjPSd9MflUsuXKx2JH5cllYgGOHN7tC01641/qsRSnJFoqMVcVJwIAIQ58C2CAgAA
X-CMS-MailID: 20210329054156epcas2p31650fa755e6cbcc55c4f33a79878256f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210329054156epcas2p31650fa755e6cbcc55c4f33a79878256f
References: <CGME20210329054156epcas2p31650fa755e6cbcc55c4f33a79878256f@epcas2p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows programmer to avoid zero initialization on page
allocation even when the kernel config "CONFIG_INIT_ON_ALLOC_DEFAULT"
is enabled. The configuration is made to prevent uninitialized
heap memory flaws, and Android has applied this for security and
deterministic execution times. Please refer to below.

https://android-review.googlesource.com/c/kernel/common/+/1235132

However, there is a case that the zeroing page memory is unnecessary
when the page is used on specific purpose and will be zeroed
automatically by hardware that accesses the memory through DMA.
For instance, page allocation used for IP packet reception from Exynos
modem is solely used for packet reception. Although the page will be
freed eventually and reused for some other purpose, initialization at
that moment of reuse will be sufficient to avoid uninitialized heap
memory flaws. To support this kind of control, this patch creates new
gfp type called ___GFP_NOINIT, that allows no zeroing at the moment
of page allocation, called by many related APIs such as page_frag_alloc,
alloc_pages, etc.

Signed-off-by: Hyunsoon Kim <h10.kim@samsung.com>
---
 include/linux/gfp.h | 2 ++
 include/linux/mm.h  | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 8572a14..4ddd947 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -58,6 +58,8 @@ struct vm_area_struct;
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
+#define ___GFP_NOINIT		0x1000000u
+
 /* If the above are modified, __GFP_BITS_SHIFT may need updating */
 
 /*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8ba4342..06a23bb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2907,7 +2907,9 @@ static inline void kernel_unpoison_pages(struct page *page, int numpages) { }
 DECLARE_STATIC_KEY_FALSE(init_on_alloc);
 static inline bool want_init_on_alloc(gfp_t flags)
 {
-	if (static_branch_unlikely(&init_on_alloc))
+	if (flags & ___GFP_NOINIT)
+		return false;
+	else if (static_branch_unlikely(&init_on_alloc))
 		return true;
 	return flags & __GFP_ZERO;
 }
-- 
2.7.4

