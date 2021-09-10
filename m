Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA4F406947
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 11:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhIJJs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 05:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbhIJJs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 05:48:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A0CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 02:47:18 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631267236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LpneDQ785AsPPg8q9lqKzPVD0Ent+hqUaf94R+vEyNg=;
        b=0nMKhMsHhzFUQAsJ361Oq8F37P84jZjBNptt60ZSs1LrC5lKg/z7yl9xETqLVrEDk2Cg9F
        ynkHzK3n6+wrsHXadbT/CNiZ1a9fAfJ69U1Qv2CMU7tYb7nOMih+D6Fo6RrbTg65KP0EYf
        csKOZ9xNbJLuWEJxpi6zn+8r2CTQjmPXTVhpxvInfVDtlWXJahhltBMmtJS9prMp/p2074
        T4lu94Hst04wmtmXYxMEZWoGEvBAxGw5PBQ8QnBVF77RQ8dFJE5/8ts435XjYhSQUxQPEP
        LXcbo3KB2yMLuXs5ulMJqytb/aXz4VF2oa76zRnuvpfZFK/9u4icAPRp0K9qlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631267236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LpneDQ785AsPPg8q9lqKzPVD0Ent+hqUaf94R+vEyNg=;
        b=qAYpJ/82BsiaL4ZgRrdINh+CHr65iEwjPnZI7fEgecDeq3PctmsxanPjTkt0/8NU40nfiS
        TAiczL0Z1Xnq/5BA==
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fei Li <fei1.li@intel.com>
Subject: [PATCH] virt: acrn: Remove unsued acrn_irqfds_mutex.
Date:   Fri, 10 Sep 2021 11:47:08 +0200
Message-Id: <20210910094708.3430340-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

acrn_irqfds_mutex is not used, never was.

Remove acrn_irqfds_mutex.

Fixes: aa3b483ff1d71 ("virt: acrn: Introduce irqfd")
Cc: Fei Li <fei1.li@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/virt/acrn/irqfd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/virt/acrn/irqfd.c b/drivers/virt/acrn/irqfd.c
index df5184979b282..d4ad211dce7a3 100644
--- a/drivers/virt/acrn/irqfd.c
+++ b/drivers/virt/acrn/irqfd.c
@@ -17,7 +17,6 @@
 #include "acrn_drv.h"
=20
 static LIST_HEAD(acrn_irqfd_clients);
-static DEFINE_MUTEX(acrn_irqfds_mutex);
=20
 /**
  * struct hsm_irqfd - Properties of HSM irqfd
--=20
2.33.0

