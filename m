Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA2C34FF6D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbhCaLZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:25:54 -0400
Received: from mail.kingsoft.com ([114.255.44.145]:18494 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbhCaLZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:25:43 -0400
X-AuditID: 0a580155-f55ff70000015057-03-60645c357ab1
Received: from mail.kingsoft.com (localhost [10.88.1.79])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id 82.14.20567.53C54606; Wed, 31 Mar 2021 19:25:41 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL4.kingsoft.cn
 (10.88.1.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 31 Mar
 2021 19:25:41 +0800
Date:   Wed, 31 Mar 2021 19:25:40 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     "HORIGUCHI =?UTF-8?B?TkFPWUE=?=(=?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=)" 
        <naoya.horiguchi@nec.com>, "Luck, Tony" <tony.luck@intel.com>,
        "Oscar Salvador" <osalvador@suse.de>,
        "david@redhat.com" <david@redhat.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        <yaoaili@kingsoft.com>, <sunhao2@kingsoft.com>
Subject: [PATCH v3] mm,hwpoison: return -EHWPOISON when page already
 poisoned
Message-ID: <20210331192540.2141052f@alex-virtual-machine>
In-Reply-To: <20210309143534.6c1a8ec5@alex-virtual-machine>
References: <20210304144524.795872d7@alex-virtual-machine>
        <20210304235720.GA215567@agluck-desk2.amr.corp.intel.com>
        <20210305093016.40c87375@alex-virtual-machine>
        <20210305093656.6c262b19@alex-virtual-machine>
        <20210305221143.GA220893@agluck-desk2.amr.corp.intel.com>
        <20210308064558.GA3617@hori.linux.bs1.fc.nec.co.jp>
        <3690ece2101d428fb9067fcd2a423ff8@intel.com>
        <20210308223839.GA21886@hori.linux.bs1.fc.nec.co.jp>
        <20210308225504.GA233893@agluck-desk2.amr.corp.intel.com>
        <20210309100421.3d09b6b1@alex-virtual-machine>
        <20210309060440.GA29668@hori.linux.bs1.fc.nec.co.jp>
        <20210309143534.6c1a8ec5@alex-virtual-machine>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL4.kingsoft.cn
 (10.88.1.79)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsXCFcHor2sak5JgsO2xvMWc9WvYLL6u/8Vs
        cXnXHDaLe2v+s1pcbDzAaHFmWpHFmwv3WBzYPRbvecnksenTJHaPEzN+s3i8uLqRxeP9vqts
        HptPV3t83iQXwB7FZZOSmpNZllqkb5fAlXHvfgNzwRuhivWrJjA1MD7l62Lk5JAQMJHYcKmL
        GcQWEpjOJHH5qlQXIxeQ/YpRYurK70wgCRYBVYm9v1pZQGw2IHvXvVmsIEUiAlcZJRbem8oO
        4jAL9DFJ7Nq+nLGLkYNDWMBfYuLPUJAGXgEriaPXF4EN4hSwljhyfAozxIZWVok9r6+AreYX
        EJPovfKfCeIke4m2LYsYIZoFJU7OfAK2mVlAR+LEqmPMELa8xPa3c6DOVpQ4vOQXO0SvksSR
        7hlsEHasRNOBW2wTGIVnIRk1C8moWUhGLWBkXsXIUpybbrSJERIfoTsYZzR91DvEyMTBeIhR
        goNZSYRX+EBighBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe7w+SEoQE0hNLUrNTUwtSi2CyTByc
        Ug1M0w+uiuasi45LFPxc96KmyCTs4erFCTxVb5pLrLM/3f+z6fXuQ4UvnJlm3Jz1N9T3RO57
        HZ9JfBfucH6bvP7SEeuvb3eUhLnf4eXxUzgQvJubncU24innSqtPPmcsWjifsN6/3Xz/2o74
        gr8bZ8gemaNfxM7/bQVD4x73LZuK7ev3B1dNMWFTLopcp7yrUUi3Il4hpL6jaMpXg9KtsZPV
        vovWvNy37l4M5/Wjr+6ufeTzrczjrvPVnfPSLvRM33D/47rVx6Jmpx8RPlNjXH7QWtT5be2m
        51VTLFtFXrVuqnyzROj5/UzjMnXrvLUMZw/d3sz4u1wnKiXq1cQcN+/1CzMmdraaPH4c5/ZZ
        Y+nzCCWW4oxEQy3mouJEAHFYImD+AgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the page is already poisoned, another memory_failure() call in the
same page now return 0, meaning OK. For nested memory mce handling, this
behavior may lead to one mce looping, Example:

1.When LCME is enabled, and there are two processes A && B running on
different core X && Y separately, which will access one same page, then
the page corrupted when process A access it, a MCE will be rasied to
core X and the error process is just underway.

2.Then B access the page and trigger another MCE to core Y, it will also
do error process, it will see TestSetPageHWPoison be true, and 0 is
returned.

3.The kill_me_maybe will check the return:

1244 static void kill_me_maybe(struct callback_head *cb)
1245 {

1254         if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) &&
1255             !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
1256                 set_mce_nospec(p->mce_addr >> PAGE_SHIFT,
p->mce_whole_page);
1257                 sync_core();
1258                 return;
1259         }

1267 }

4. The error process for B will end, and may nothing happened if
kill-early is not set, The process B will re-excute instruction and get
into mce again and then loop happens. And also the set_mce_nospec()
here is not proper, may refer to commit fd0e786d9d09 ("x86/mm,
mm/hwpoison: Don't unconditionally unmap kernel 1:1 pages").

For other cases which care the return value of memory_failure() should
check why they want to process a memory error which have already been
processed. This behavior seems reasonable.

Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
---
 mm/memory-failure.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 24210c9bd843..5cd42144b67c 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1228,7 +1228,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	if (TestSetPageHWPoison(head)) {
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
 		       pfn);
-		return 0;
+		return -EHWPOISON;
 	}
 
 	num_poisoned_pages_inc();
@@ -1430,7 +1430,7 @@ int memory_failure(unsigned long pfn, int flags)
 	if (TestSetPageHWPoison(p)) {
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
 			pfn);
-		return 0;
+		return -EHWPOISON;
 	}
 
 	orig_head = hpage = compound_head(p);
-- 
2.25.1

