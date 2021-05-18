Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CF3387576
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348003AbhERJrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:47:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4658 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241211AbhERJrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:47:06 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fkrdy13jwz16QPM;
        Tue, 18 May 2021 17:43:02 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 17:45:47 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 17:45:46 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Vitor Massaru Iha <vitor@massaru.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] lib: kunit: Suppress a compilation warning of frame size
Date:   Tue, 18 May 2021 17:45:33 +0800
Message-ID: <20210518094533.7652-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lib/bitfield_kunit.c: In function ‘test_bitfields_constants’:
lib/bitfield_kunit.c:93:1: warning: the frame size of 7456 bytes is larger than 2048 bytes [-Wframe-larger-than=]
 }
 ^

As the description of BITFIELD_KUNIT in lib/Kconfig.debug, it "Only useful
for kernel devs running the KUnit test harness, and not intended for
inclusion into a production build". Therefore, it is not worth modifying
variable 'test_bitfields_constants' to clear this warning. Just suppress
it.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Makefile b/lib/Makefile
index e11cfc18b6c0826..2cc359ec1fdd3e1 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -348,6 +348,7 @@ obj-$(CONFIG_OBJAGG) += objagg.o
 obj-$(CONFIG_PLDMFW) += pldmfw/
 
 # KUnit tests
+CFLAGS_bitfield_kunit.o := $(call cc-option,-Wframe-larger-than=10240)
 obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
-- 
2.26.0.106.g9fadedd


