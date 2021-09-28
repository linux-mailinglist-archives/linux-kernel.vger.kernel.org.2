Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CAB41B7A1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 21:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242470AbhI1Tdm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Sep 2021 15:33:42 -0400
Received: from mail.shanghaitech.edu.cn ([119.78.254.11]:4666 "EHLO
        mail.shanghaitech.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237134AbhI1Tdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 15:33:41 -0400
Received: from [10.15.44.215] by mail.shanghaitech.edu.cn with MESSAGESEC ESMTP id 480405207077045;
        Wed, 29 Sep 2021 03:31:47 +0800 (CST)
Received: from DESKTOP-FOJ6ELG.localdomain (10.15.44.220) by
 smtp.shanghaitech.edu.cn (10.15.44.215) with Microsoft SMTP Server (TLS) id
 14.3.399.0; Wed, 29 Sep 2021 03:31:46 +0800
From:   Mianhan Liu <liumh1@shanghaitech.edu.cn>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Mianhan Liu <liumh1@shanghaitech.edu.cn>
Subject: [PATCH -next] drivers/base/arch_topology.c: remove superfluous header
Date:   Wed, 29 Sep 2021 03:31:38 +0800
Message-ID: <20210928193138.24192-1-liumh1@shanghaitech.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-Originating-IP: [10.15.44.220]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_topology.c hasn't use any macro or function declared in linux/percpu.h,
linux/smp.h and linux/string.h.
Thus, these files can be removed from arch_topology.c safely without
affecting the compilation of the drivers/base/ module

Signed-off-by: Mianhan Liu <liumh1@shanghaitech.edu.cn>

---
 drivers/base/arch_topology.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 434076659..92200873b 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -12,15 +12,12 @@
 #include <linux/device.h>
 #include <linux/of.h>
 #include <linux/slab.h>
-#include <linux/string.h>
 #include <linux/sched/topology.h>
 #include <linux/cpuset.h>
 #include <linux/cpumask.h>
 #include <linux/init.h>
-#include <linux/percpu.h>
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
-#include <linux/smp.h>
 
 static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
 static struct cpumask scale_freq_counters_mask;
-- 
2.25.1


