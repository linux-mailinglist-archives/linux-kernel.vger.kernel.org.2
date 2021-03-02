Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084C332A284
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381554AbhCBIFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 03:05:12 -0500
Received: from m12-14.163.com ([220.181.12.14]:59570 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241425AbhCBHpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 02:45:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6+L6S
        3PF+6atFy4jcL2HpjZWPg77zuao14pJR5Pd/C8=; b=M4IAEP65qhN9uRUtZBpE4
        er8phBbh0WUyuH6eIuy4+yqBs0rp34D0r3bf6HOHHqK5W7dQsYyWLmGwi0Mg3wZH
        nn0lxXc2G79me9A0skSg/6isswce54SHbSWwoyjD/AnuAlWOAOvbWB0fxSvjUI7f
        jsivNSHZxFPLyf5wOC0si4=
Received: from COOL-20201222LC.ccdomain.com (unknown [218.94.48.178])
        by smtp10 (Coremail) with SMTP id DsCowACHnyvHsz1gggkAnQ--.8851S2;
        Tue, 02 Mar 2021 11:40:57 +0800 (CST)
From:   dingsenjie@163.com
To:     geoff@infradead.org, perex@perex.cz, tiwai@suse.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        dingsenjie <dingsenjie@yulong.com>
Subject: [PATCH] sound: pps: fix spelling typo of values
Date:   Tue,  2 Mar 2021 11:40:53 +0800
Message-Id: <20210302034053.34524-1-dingsenjie@163.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowACHnyvHsz1gggkAnQ--.8851S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF4rtrWDur4UWFyUJryxZrb_yoWxCwbE9a
        ykt3y8Wr95XFsrAr4jyF1rJrWFqas5Aryqgr4xKF4DGw15Zrs5C3y5Cry7Jr97WF4DXFyr
        ZFnYgrnxKr92kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnzT5PUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5glqw25hqmxvi6rwjhhfrp/1tbiTglJyFUDH86npgAAsA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dingsenjie <dingsenjie@yulong.com>

vaules -> values

Signed-off-by: dingsenjie <dingsenjie@yulong.com>
---
 sound/ppc/snd_ps3_reg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/ppc/snd_ps3_reg.h b/sound/ppc/snd_ps3_reg.h
index 566a318..e2212b7 100644
--- a/sound/ppc/snd_ps3_reg.h
+++ b/sound/ppc/snd_ps3_reg.h
@@ -308,7 +308,7 @@
 each interrupt in this register.
 Writing 1b to a field containing 1b clears field and de-asserts interrupt.
 Writing 0b to a field has no effect.
-Field vaules are the following:
+Field values are the following:
 0 - Interrupt hasn't occurred.
 1 - Interrupt has occurred.
 
-- 
1.9.1


