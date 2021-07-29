Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7000E3DA818
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 17:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238247AbhG2P5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 11:57:31 -0400
Received: from [43.250.32.171] ([43.250.32.171]:15113 "EHLO email.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S238224AbhG2P4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 11:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=From:To:Date; bh=ptREmgSy9AQZ1hFdza5yGK+0EixV+4y6ei5ru
        CicvSA=; b=kYELn9hq4nRUqvc6vOWImsjNPNvACZ74MKrLAwnHqLt5l8Qf1OVQi
        3Q/M7hvdB0C447rbq8e3QchlUOkPq3bpS760ndrYtCfb6kyYqJkuUtUWWeUsVkD7
        /qs1u4vBg6VDgwrrD37iT9d/J/s5dsdtCH2tETVEtlZLjmyuBxXuns=
Received: from localhost.localdomain (unknown [113.251.12.143])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgA3RAOszwJhHf4MAA--.40231S4;
        Thu, 29 Jul 2021 23:56:49 +0800 (CST)
From:   Hu Haowen <src.res@email.cn>
To:     corbet@lwn.net
Cc:     panyunwang849@gmail.com,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/3] MAINTAINERS: add entry for traditional Chinese documentation
Date:   Thu, 29 Jul 2021 23:56:27 +0800
Message-Id: <20210729155627.41744-3-src.res@email.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729155627.41744-1-src.res@email.cn>
References: <20210729155627.41744-1-src.res@email.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LCKnCgA3RAOszwJhHf4MAA--.40231S4
X-Coremail-Antispam: 1UD129KBjvdXoW7GF15Jw4fXw4DWFy5XF1UJrb_yoWfXwb_Jw
        4UJayxXr43GFn7K395ZFZ2kryava93Jr18u3Z5t3s8Xa4DJrZ0yFn2ywn3u3s8uFsruryD
        AF9xJr4FqrnxujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbYAYjsxI4VW3JwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
        s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
        8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VWxJr1U
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6ryrMxAIw2
        8IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Cr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_
        Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
        CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
        I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
        8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
        UjIFyTuYvjxUnfHUUUUUU
X-Originating-IP: [113.251.12.143]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainer information for traditional Chinese documentation.

Signed-off-by: Hu Haowen <src.res@email.cn>
Reviewed-by: Pan Yunwang <panyunwang849@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 66d047dc6880..22d8ca2d5616 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18829,6 +18829,14 @@ F:	arch/x86/mm/testmmiotrace.c
 F:	include/linux/mmiotrace.h
 F:	kernel/trace/trace_mmiotrace.c
 
+TRADITIONAL CHINESE DOCUMENTATION
+M:	Hu Haowen <src.res@email.cn>
+L:	linux-doc-tw-discuss@lists.sourceforge.net
+S:	Maintained
+W:	https://github.com/srcres258/linux-doc
+T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
+F:	Documentation/translations/zh_TW/
+
 TRIVIAL PATCHES
 M:	Jiri Kosina <trivial@kernel.org>
 S:	Maintained
-- 
2.25.1

