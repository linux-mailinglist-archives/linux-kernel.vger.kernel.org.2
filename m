Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDC136C795
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238342AbhD0ONC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbhD0ONB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:13:01 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5012CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 07:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=3kRlgrHU/R
        zKvWpF9JGNE04REd3B6WRhvxi8qVtWdng=; b=mg8Mkadpd2f97VqjjF3KO0CVQ0
        XrZrVP2tvXeAF3ufnjCbKuOMp7msOawu4NtOeF+Vu9vwXOMEwUCkJaMFUEQQm8Zz
        wy4JyTmoz6VTd/o55sdVb5pDiuBCxdpICYWUFuoaHjfutuNR6cwBl+6vrcHq47W4
        a++AlC2H2v0RGjT4Y=
Received: from ubuntu.localdomain (unknown [202.38.69.14])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygDHzDSZG4hgy6tTAA--.6149S4;
        Tue, 27 Apr 2021 22:11:37 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        rcy@google.com, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH] Staging:gasket:core: Fix a double free in gasket_enable_device
Date:   Tue, 27 Apr 2021 07:11:29 -0700
Message-Id: <20210427141129.6207-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygDHzDSZG4hgy6tTAA--.6149S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AF15Gr4rAw4xJr4UGFW3Jrb_yoW8CFy5pF
        W8Cas8XrZrtw1Iyw4UJFW0yrs8Xrn8CryYka1vy3yUAr4DK348Xry7JFyUAFWYkFW3A3W3
        ZrnYy3y5Z3yDJr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lc2xSY4AK67AK6ry5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAI
        cVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7VUbSdgPUUUUU==
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gasket_enable_device, it calls gasket_interrupt_init().
Inside gasket_interrupt_init, interrupt_data is allocated via
kzalloc() and then is assigned to gasket_dev->interrupt_data.
If the later two kzalloc() failed, interrupt_data will be freed
and gasket_dev->interrupt_data will point to a freed memory.

After gasket_enable_device received the error, the freed
gasket_dev->interrupt_data is freed again in
gasket_interrupt_cleanup(gasket_dev).

My patch moves the "gasket_dev->interrupt_data = interrupt_data"
assignment behind the later kzalloc() all successd, to avoid
gasket_dev->interrupt_data pointing to a freed memory

Fixes: 80666096eb78f ("staging: gasket: core: remove static function forward declarations")
Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 drivers/staging/gasket/gasket_interrupt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_interrupt.c b/drivers/staging/gasket/gasket_interrupt.c
index 864342acfd86..d4993d7abb87 100644
--- a/drivers/staging/gasket/gasket_interrupt.c
+++ b/drivers/staging/gasket/gasket_interrupt.c
@@ -322,7 +322,6 @@ int gasket_interrupt_init(struct gasket_dev *gasket_dev)
 	interrupt_data = kzalloc(sizeof(*interrupt_data), GFP_KERNEL);
 	if (!interrupt_data)
 		return -ENOMEM;
-	gasket_dev->interrupt_data = interrupt_data;
 	interrupt_data->name = driver_desc->name;
 	interrupt_data->type = driver_desc->interrupt_type;
 	interrupt_data->pci_dev = gasket_dev->pci_dev;
@@ -349,6 +348,8 @@ int gasket_interrupt_init(struct gasket_dev *gasket_dev)
 		return -ENOMEM;
 	}
 
+	gasket_dev->interrupt_data = interrupt_data;
+
 	switch (interrupt_data->type) {
 	case PCI_MSIX:
 		ret = gasket_interrupt_msix_init(interrupt_data);
-- 
2.25.1


