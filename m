Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B21359881
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhDIJCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:02:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16115 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbhDIJCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:02:21 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGsXC5rgcz19KpJ;
        Fri,  9 Apr 2021 16:59:55 +0800 (CST)
Received: from huawei.com (10.174.28.241) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 17:01:58 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <cuibixuan@huawei.com>, Michael Ellerman <mpe@ellerman.id.au>,
        "Athira Rajeev" <atrajeev@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] powerpc/perf: Make symbol 'isa207_pmu_format_attr' static
Date:   Fri, 9 Apr 2021 17:01:19 +0800
Message-ID: <20210409090119.59444-1-cuibixuan@huawei.com>
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

arch/powerpc/perf/isa207-common.c:24:18: warning:
 symbol 'isa207_pmu_format_attr' was not declared. Should it be static?

This symbol is not used outside of isa207-common.c, so this
commit marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
---
 arch/powerpc/perf/isa207-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
index e4f577da33d8..487f9e914b5c 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -21,7 +21,7 @@ PMU_FORMAT_ATTR(thresh_stop,	"config:32-35");
 PMU_FORMAT_ATTR(thresh_start,	"config:36-39");
 PMU_FORMAT_ATTR(thresh_cmp,	"config:40-49");
 
-struct attribute *isa207_pmu_format_attr[] = {
+static struct attribute *isa207_pmu_format_attr[] = {
 	&format_attr_event.attr,
 	&format_attr_pmcxsel.attr,
 	&format_attr_mark.attr,

