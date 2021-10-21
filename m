Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B275435939
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 05:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhJUDrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 23:47:20 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14836 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhJUDrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 23:47:19 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HZYC941jLz90MY;
        Thu, 21 Oct 2021 11:40:05 +0800 (CST)
Received: from dggpemm500015.china.huawei.com (7.185.36.181) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 21 Oct 2021 11:45:01 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500015.china.huawei.com
 (7.185.36.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 21 Oct
 2021 11:45:01 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <weiyongjun1@huawei.com>, <huawei.libin@huawei.com>,
        <rostedt@goodmis.org>, <bristot@kernel.org>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] trace/hwlat: Make internal symbol static
Date:   Thu, 21 Oct 2021 11:52:25 +0800
Message-ID: <20211021035225.1050685-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

kernel/trace/trace_hwlat.c:82:27: warning: symbol 'hwlat_single_cpu_data' was not declared. Should it be static?
kernel/trace/trace_hwlat.c:83:1: warning: symbol '__pcpu_scope_hwlat_per_cpu_data' was not declared. Should it be static?

This symbol is not used outside of trace_hwlat.c, so this commit
marks it static.

Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 kernel/trace/trace_hwlat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 1b83d75eb103..263dde9016e4 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -79,8 +79,8 @@ struct hwlat_kthread_data {
 	int			nmi_cpu;
 };
 
-struct hwlat_kthread_data hwlat_single_cpu_data;
-DEFINE_PER_CPU(struct hwlat_kthread_data, hwlat_per_cpu_data);
+static struct hwlat_kthread_data hwlat_single_cpu_data;
+static DEFINE_PER_CPU(struct hwlat_kthread_data, hwlat_per_cpu_data);
 
 /* Tells NMIs to call back to the hwlat tracer to record timestamps */
 bool trace_hwlat_callback_enabled;
-- 
2.25.1

