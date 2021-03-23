Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB0E345A36
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhCWI7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 04:59:37 -0400
Received: from m12-15.163.com ([220.181.12.15]:37803 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhCWI7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 04:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=8X1qg
        gjYrOr60RWTjePpjNY4Tvz0un9W9c9kxBNZccc=; b=ckSKexquUmMdAbMwdw1pK
        Vu4dQ/H88GnRk1kOkKZJfLEFhHN4l7jfpYuIDrjsq4IGN1ZkpT8pe+XvSv5XXQR5
        kB9/XIuAhHKVQVvHkUdV6kWB89Y534sK5tU0BNxKckL9QByjqGSfWOXkz8NR7zlT
        +jD+ZRhapu+gnU7sZqVMKw=
Received: from caizhichao.ccdomain.com (unknown [218.94.48.178])
        by smtp11 (Coremail) with SMTP id D8CowADHDAEDrVlgKAJaGA--.51S2;
        Tue, 23 Mar 2021 16:55:48 +0800 (CST)
From:   caizhichao <tomstomsczc@163.com>
To:     geoff@infradead.org, perex@perex.cz, tiwai@suse.com
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, caizhichao <caizhichao@yulong.com>
Subject: [PATCH] sound:ppc: fix spelling typo of values
Date:   Tue, 23 Mar 2021 16:55:43 +0800
Message-Id: <20210323085543.741-1-tomstomsczc@163.com>
X-Mailer: git-send-email 2.30.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowADHDAEDrVlgKAJaGA--.51S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr1DZw4rAF4kuFW5GF45Wrg_yoWxCwbE9a
        ykArW8WF95XFsrCr1YyF1rGr4Yqas8Cr929r47KF1DGw4Yvrs5G3yrAry7Jr92gF1vvry5
        WF9YgrnxKr92kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0RBTUUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: pwrp23prpvu6rf6rljoofrz/xtbBdRReilaD+k4Q8wAAs3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: caizhichao <caizhichao@yulong.com>

vaules -> values

Signed-off-by: caizhichao <caizhichao@yulong.com>
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


