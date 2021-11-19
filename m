Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF82B456CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 10:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbhKSJst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 04:48:49 -0500
Received: from xmbg8.mail.qq.com ([116.128.173.86]:45037 "EHLO
        xmbg8.mail.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhKSJss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 04:48:48 -0500
X-Greylist: delayed 11234 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Nov 2021 04:48:47 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1637315082;
        bh=3708+Mfh+zJTCD8kMqzQyKwRz6cgzdVxOwONIux6TME=;
        h=From:To:Cc:Subject:Date;
        b=we50jw4gUfptVBj+7i+VWY8BS8Tvd4r5Jaog7LxONDrecNojW5pojMt7Q/8CyyEfE
         lcMii6b7RXqqr2y/0KuhKKjyc1rkairdEs7qJD+41z78UPuHP4v9IZar5mGcGMpzvp
         1UJ1bcZeJ8NRdpjaa8Iyz/szEDcNDLJM5ukrIVmM=
Received: from localhost.localdomain ([159.226.95.43])
        by newxmesmtplogicsvrsza9.qq.com (NewEsmtp) with SMTP
        id 3239B626; Fri, 19 Nov 2021 17:12:35 +0800
X-QQ-mid: xmsmtpt1637313155tl2drclly
Message-ID: <tencent_BA28CC6897B7C95A92EB8C580B5D18589105@qq.com>
X-QQ-XMAILINFO: MpO6L0LObisW1c6wsWy9l5h1QvWkiNyInZrGzZGx8VZ/M8UcrvZCTGzupqj/DR
         jmugwBZeT/jxEZIAkC45WrsX9T2TGL1rTU/rzjzBngiIe6Wsb5WKDLpK7vMMl58ealshK0jX2vkr
         /K8MQr/UcwP4VRmHr/+4Tk28r1hhSd9Zb4GRD+gg8rcRRvVF7Dre2aISejLZzxch/Vwq1N/w1Ok4
         yS6N2wMiL2q67EK4o403axJvAQ7j1UX3aqm0SvJuZ3eFPdVJ9ABPCHassru5XmCs4BhY7y/8rJ4j
         3ncniYJecH2QTC3M9taADco9ZbE9tEwloBYsFJfmvm/05CMGMQPO+MH1fGwhguFgyLZP0brV5U8G
         +flDF5VjJHlXYC3tuc99ZEdU/w7fFgA+0saRJaTVH3ToXmbPgmRr/Wj3QmXpuLjkDcLjGT8vh3VW
         bMJ6hS/3886vzgPH/lXswxGlWimHoBlMSogv5QFeBj6pEi/FkqqNP3J0GlNs8lZAx4eKAbvlFTdQ
         kMS0mrgTYRI6NpiWBbxX4u4EfWZei7MFBZe/sttLVXcZc8p8ItD8OO/FpZde+1yVhRMJYtJxhfIZ
         I4fOxsuu0Rxcl54fwKoD5jnsKIZBKtbRlEI8pezx6SJb7m+oa6Zjjzy7lUTFqLQ6VLnIuLAFBktG
         yQA4dWICUR+1IamPbrItaldTjmfu5/MQSDgIifvaoAumJceb2Uc4qYQbssdOl9XYU/LJJPKanpK8
         QT6G8VKYbXDWZOk67CbVJu2YFeQ/EMFIwxRldFAVumDcWdM6JgN9Te1odl4mIu9CKjprWvaCplJ6
         2eYiqOs3NW6X52Ohbs7/d74flBSnvtQfeO12rPUTxYUiUuPEdC/QOQhCSDdL+6PHbNn+c+2Re7B7
         5trULPrY6m
From:   Peiwei Hu <jlu.hpw@foxmail.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        aneesh.kumar@linux.ibm.com, ardb@kernel.org,
        rafael.j.wysocki@intel.com, masahiroy@kernel.org,
        npiggin@gmail.com, andriy.shevchenko@linux.intel.com,
        adobriyan@gmail.com, clg@kaod.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org, Peiwei Hu <jlu.hpw@foxmail.com>
Subject: [PATCH] powerpc/prom_init: fix the improper check of prom_getprop
Date:   Fri, 19 Nov 2021 17:12:18 +0800
X-OQ-MSGID: <20211119091218.2215024-1-jlu.hpw@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prom_getprop() can return PROM_ERROR. Binary operator can not identify it.

Signed-off-by: Peiwei Hu <jlu.hpw@foxmail.com>
---
 arch/powerpc/kernel/prom_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 18b04b08b983..f845065c860e 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2991,7 +2991,7 @@ static void __init fixup_device_tree_efika_add_phy(void)
 
 	/* Check if the phy-handle property exists - bail if it does */
 	rv = prom_getprop(node, "phy-handle", prop, sizeof(prop));
-	if (!rv)
+	if (rv <= 0)
 		return;
 
 	/*
-- 
2.25.1

