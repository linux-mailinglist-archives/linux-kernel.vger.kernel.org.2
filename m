Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DBD3803A9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 08:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhENGby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 02:31:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2917 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbhENGbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 02:31:53 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FhJVk5hCczBvLb;
        Fri, 14 May 2021 14:27:58 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Fri, 14 May 2021 14:30:30 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] percpu: make symbol 'pcpu_free_slot' static
Date:   Fri, 14 May 2021 06:39:52 +0000
Message-ID: <20210514063952.3240527-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

mm/percpu.c:138:5: warning:
 symbol 'pcpu_free_slot' was not declared. Should it be static?

This symbol is not used outside of percpu.c, so marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 mm/percpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index a257c3efdf18..73c249f3b6a3 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -135,7 +135,7 @@ static int pcpu_unit_size __ro_after_init;
 static int pcpu_nr_units __ro_after_init;
 static int pcpu_atom_size __ro_after_init;
 int pcpu_nr_slots __ro_after_init;
-int pcpu_free_slot __ro_after_init;
+static int pcpu_free_slot __ro_after_init;
 int pcpu_sidelined_slot __ro_after_init;
 int pcpu_to_depopulate_slot __ro_after_init;
 static size_t pcpu_chunk_struct_size __ro_after_init;

