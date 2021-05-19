Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059ED388A99
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344887AbhESJ0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:26:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4744 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344782AbhESJ0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:26:42 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FlS725M0VzpfRm;
        Wed, 19 May 2021 17:21:50 +0800 (CST)
Received: from dggema764-chm.china.huawei.com (10.1.198.206) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 17:25:19 +0800
Received: from huawei.com (10.44.142.101) by dggema764-chm.china.huawei.com
 (10.1.198.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 19
 May 2021 17:25:18 +0800
From:   Jingxian He <hejingxian@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>, <hpa@zytor.com>
CC:     <hejie3@huawei.com>, <hewenliang4@huawei.com>,
        <wuxu.wu@huawei.com>, <hejingxian@huawei.com>
Subject: [PATCH] rtc: Fix hwclock write fail problem in x86 arch
Date:   Wed, 19 May 2021 17:23:49 +0800
Message-ID: <20210519092349.513729-1-hejingxian@huawei.com>
X-Mailer: git-send-email 2.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.44.142.101]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema764-chm.china.huawei.com (10.1.198.206)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When RTC_ALWAYS_BCD is set as 1, the function mc146818_set_time
ignores the reading value of RTC_CONTROL register,
and assumes that RTC always operates in binary mode.

However, the mc146818 development manual says that:
if !(CMOS_READ(RTC_CONTROL) & 0x04), then
the rtc time is in binary mode;
if (CMOS_READ(RTC_CONTROL) & 0x04), then
the rtc time is in bcd mode.

We use 'hwclock -w' to set the RTC from the system time
at our x86 machines, and we find that when 
(CMOS_READ(RTC_CONTROL) & 0x04) is equal to 1,
'hwclock -w' will fail to set the RTC.

We change the RTC_ALWAYS_BCD to 0 to parse the rtc
time according to the read value of RTC_CONTROL register.

Signed-off-by: Jingxian He <hejingxian@huawei.com>
Signed-off-by: Jie He <hejie3@huawei.com>
---
 arch/x86/include/asm/mc146818rtc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mc146818rtc.h b/arch/x86/include/asm/mc146818rtc.h
index 9719800..63cf0d5 100644
--- a/arch/x86/include/asm/mc146818rtc.h
+++ b/arch/x86/include/asm/mc146818rtc.h
@@ -10,7 +10,7 @@
 
 #ifndef RTC_PORT
 #define RTC_PORT(x)	(0x70 + (x))
-#define RTC_ALWAYS_BCD	1	/* RTC operates in binary mode */
+#define RTC_ALWAYS_BCD	0
 #endif
 
 #if defined(CONFIG_X86_32)
-- 
2.9.5

