Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5D1416DA8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 10:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244719AbhIXI0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 04:26:15 -0400
Received: from esa10.hc1455-7.c3s2.iphmx.com ([139.138.36.225]:16752 "EHLO
        esa10.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244707AbhIXI0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 04:26:14 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Sep 2021 04:26:14 EDT
IronPort-SDR: z0DgfYjJ++ZxbVDhHb6xJS7JSQP7x/1gZs6sjF8dAVhRpON0CwHmJmh5+C4nWsvYDbxKHNCW2g
 NdsthFlXNllZ2d2XHmc6J49qy7aqAbRnrqICClrzxoolPj1ushit3wyQBK7Jz0/h1J4b8e8+QD
 Pyl3q1zNUxITOTwx3FMerdPz7nJ5zsFGiN0uEtHmdtScvLZRTqwG1GF+uAznrmTZBnl0/RSoe1
 YtoGSou1WGuzqkJcnc4wS4mKSOz82it5IMbuSouTCzFUTmZ7ckd5yrUnOBOUYdutvJmfXOElMo
 RhwEWzTGYmIfMmR+RUzzwU1u
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="34174853"
X-IronPort-AV: E=Sophos;i="5.85,319,1624287600"; 
   d="scan'208";a="34174853"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP; 24 Sep 2021 17:17:32 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 186ED6CC26
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 17:17:32 +0900 (JST)
Received: from oym-om1.fujitsu.com (oym-om1.o.css.fujitsu.com [10.85.58.161])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 5C3E9C9CFB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 17:17:31 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om1.fujitsu.com (Postfix) with ESMTP id 24FD34011E82E;
        Fri, 24 Sep 2021 17:17:31 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        tan.shaopeng@jp.fujitsu.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/resctrl: Fix return code in mkdir_rdt_prepare()
Date:   Fri, 24 Sep 2021 17:17:13 +0900
Message-Id: <20210924081713.502039-1-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kzalloc fails, we should return ENOMEM instead of ENOSPC.

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
Hello,

I just noticed this when I read the code.

Thanks,

 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index b57b3db9a6a7..a92d047476f6 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2854,7 +2854,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 	/* allocate the rdtgroup. */
 	rdtgrp = kzalloc(sizeof(*rdtgrp), GFP_KERNEL);
 	if (!rdtgrp) {
-		ret = -ENOSPC;
+		ret = -ENOMEM;
 		rdt_last_cmd_puts("Kernel out of memory\n");
 		goto out_unlock;
 	}
-- 
2.27.0

