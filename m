Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D51359883
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbhDIJC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:02:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16500 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbhDIJCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:02:23 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGsWY5hzHzPpQ3;
        Fri,  9 Apr 2021 16:59:21 +0800 (CST)
Received: from huawei.com (10.174.28.241) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 17:02:03 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <cuibixuan@huawei.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        "Madhavan Srinivasan" <maddy@linux.ibm.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] powerpc/perf/hv-24x7: Make some symbols static
Date:   Fri, 9 Apr 2021 17:01:24 +0800
Message-ID: <20210409090124.59492-1-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.28.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

arch/powerpc/perf/hv-24x7.c:229:1: warning:
 symbol '__pcpu_scope_hv_24x7_txn_flags' was not declared. Should it be static?
arch/powerpc/perf/hv-24x7.c:230:1: warning:
 symbol '__pcpu_scope_hv_24x7_txn_err' was not declared. Should it be static?
arch/powerpc/perf/hv-24x7.c:236:1: warning:
 symbol '__pcpu_scope_hv_24x7_hw' was not declared. Should it be static?
arch/powerpc/perf/hv-24x7.c:244:1: warning:
 symbol '__pcpu_scope_hv_24x7_reqb' was not declared. Should it be static?
arch/powerpc/perf/hv-24x7.c:245:1: warning:
 symbol '__pcpu_scope_hv_24x7_resb' was not declared. Should it be static?

This symbol is not used outside of hv-24x7.c, so this
commit marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
---
 arch/powerpc/perf/hv-24x7.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index e5eb33255066..1816f560a465 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -226,14 +226,14 @@ static struct attribute_group event_long_desc_group = {
 
 static struct kmem_cache *hv_page_cache;
 
-DEFINE_PER_CPU(int, hv_24x7_txn_flags);
-DEFINE_PER_CPU(int, hv_24x7_txn_err);
+static DEFINE_PER_CPU(int, hv_24x7_txn_flags);
+static DEFINE_PER_CPU(int, hv_24x7_txn_err);
 
 struct hv_24x7_hw {
 	struct perf_event *events[255];
 };
 
-DEFINE_PER_CPU(struct hv_24x7_hw, hv_24x7_hw);
+static DEFINE_PER_CPU(struct hv_24x7_hw, hv_24x7_hw);
 
 /*
  * request_buffer and result_buffer are not required to be 4k aligned,
@@ -241,8 +241,8 @@ DEFINE_PER_CPU(struct hv_24x7_hw, hv_24x7_hw);
  * the simplest way to ensure that.
  */
 #define H24x7_DATA_BUFFER_SIZE	4096
-DEFINE_PER_CPU(char, hv_24x7_reqb[H24x7_DATA_BUFFER_SIZE]) __aligned(4096);
-DEFINE_PER_CPU(char, hv_24x7_resb[H24x7_DATA_BUFFER_SIZE]) __aligned(4096);
+static DEFINE_PER_CPU(char, hv_24x7_reqb[H24x7_DATA_BUFFER_SIZE]) __aligned(4096);
+static DEFINE_PER_CPU(char, hv_24x7_resb[H24x7_DATA_BUFFER_SIZE]) __aligned(4096);
 
 static unsigned int max_num_requests(int interface_version)
 {

