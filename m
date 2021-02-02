Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723A630CBA9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239770AbhBBTb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:31:56 -0500
Received: from m12-17.163.com ([220.181.12.17]:44336 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239626AbhBBT3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 14:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=6qdfUkx636JZda/diR
        GYx/P2eDRmGvPnIoq8RRlXT4o=; b=cllRTyVxoQ5txdXmbYd5gtsPoUV0Qz4chP
        iph4j/GtAv8rpzkHWC3QcQKSawXaJj31xJmiwsnyd2ABPtEeyWQMI/5bVWeDpym9
        HOb6CN8/0KwbZs/qkD08h5w5WxTn/qmGkCo8l1Qbct62EWuhGgnH8sSogsszBZ22
        o55+CCpTM=
Received: from localhost.localdomain (unknown [117.139.251.135])
        by smtp13 (Coremail) with SMTP id EcCowAAHA4vRahlgPNhTjA--.35282S2;
        Tue, 02 Feb 2021 23:08:02 +0800 (CST)
From:   Hailong Liu <liuhailongg6@163.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hailong Liu <liu.hailong6@zte.com.cn>
Subject: [PATCH] arm64/ptdump:display the Linear Mapping start marker
Date:   Tue,  2 Feb 2021 23:07:49 +0800
Message-Id: <20210202150749.10104-1-liuhailongg6@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EcCowAAHA4vRahlgPNhTjA--.35282S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZryDXw15Ww4xur17WF4DArb_yoWfGrg_J3
        42qa4Ygr1fZr1Sq3yru3Z5ury7Jw1qgrWFqw43Kr1ktay8Xrs8GFW0qFWSgF1kJws7GrZa
        kr97Was8Gr42qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnDku7UUUUU==
X-Originating-IP: [117.139.251.135]
X-CM-SenderInfo: xolxxtxlor0wjjw6il2tof0z/xtbBFRMnYFXlns83LAABs6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hailong Liu <liu.hailong6@zte.com.cn>

The current /sys/kernel/debug/kernel_page_tables does not display the
*Linear Mapping start* marker on arm64, which I think should be paired
with the *Linear Mapping start* marker.

Since *Linear Mapping start* is the first marker, use level=-1 to display it.

Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
---
 arch/arm64/mm/ptdump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 04137a8f3d2d..0e050d76b83a 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -324,6 +324,7 @@ void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
 	st = (struct pg_state){
 		.seq = s,
 		.marker = info->markers,
+		.level = -1,
 		.ptdump = {
 			.note_page = note_page,
 			.range = (struct ptdump_range[]){
-- 
2.17.1


