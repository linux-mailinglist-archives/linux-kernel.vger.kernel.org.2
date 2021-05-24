Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC9738E362
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 11:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbhEXJeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 05:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbhEXJeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 05:34:06 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C9B3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 02:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=8QYGljFb5E
        AOcfFXhgSb6txhlNcsv6mgPjDeDUMQExc=; b=QI6rL/1AG/Nr3fR+4Xu7eSpmJX
        kDTi8rM3zUdlUXSS64u5EhHRpjtmVFL0AHTfmCh35ueGhqFQUgrtSsqjZp5SremW
        rX+5gHzDOJx7LQ7R/tJuq4gJskoxZ89xbuPX2QS9ZPnz3JvUV4XrW8EQQxznBjR+
        vcs+5Bx2q/ZfCaFI8=
Received: from ubuntu.localdomain (unknown [202.38.69.14])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygA3OoKfcqtgS0gKAA--.1158S4;
        Mon, 24 May 2021 17:32:15 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     siglesias@igalia.com, jens.taprogge@taprogge.org,
        gregkh@linuxfoundation.org
Cc:     industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH] ipack/carriers/tpci200: Fix a double free in tpci200_pci_probe
Date:   Mon, 24 May 2021 02:32:05 -0700
Message-Id: <20210524093205.8333-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygA3OoKfcqtgS0gKAA--.1158S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFyDWw48ur4fKryfGw4rZrb_yoW8GrWUpF
        45A345Gr9xXa4rCF4IvFWDZF15Cw48t3sYk3yIk3y3ZFs3Wr1jkFs3AFyUXF48tw4rGF1x
        XF1kt34UXF4UJwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
        UI43ZEXa7VUjAsqPUUUUU==
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the out_err_bus_register error branch of tpci200_pci_probe,
tpci200->info->cfg_regs is freed by tpci200_uninstall()->
tpci200_unregister()->pci_iounmap(..,tpci200->info->cfg_regs)
in the first time.

But later, iounmap() is called to free tpci200->info->cfg_regs
again.

My patch sets tpci200->info->cfg_regs to NULL after tpci200_uninstall()
to avoid the double free.

Fixes: cea2f7cdff2af ("Staging: ipack/bridges/tpci200: Use the TPCI200 in big endian mode")
Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 drivers/ipack/carriers/tpci200.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ipack/carriers/tpci200.c b/drivers/ipack/carriers/tpci200.c
index ec71063fff76..e1822e87ec3d 100644
--- a/drivers/ipack/carriers/tpci200.c
+++ b/drivers/ipack/carriers/tpci200.c
@@ -596,8 +596,11 @@ static int tpci200_pci_probe(struct pci_dev *pdev,
 
 out_err_bus_register:
 	tpci200_uninstall(tpci200);
+	/* tpci200->info->cfg_regs is unmapped in tpci200_uninstall */
+	tpci200->info->cfg_regs = NULL;
 out_err_install:
-	iounmap(tpci200->info->cfg_regs);
+	if (tpci200->info->cfg_regs)
+		iounmap(tpci200->info->cfg_regs);
 out_err_ioremap:
 	pci_release_region(pdev, TPCI200_CFG_MEM_BAR);
 out_err_pci_request:
-- 
2.25.1



