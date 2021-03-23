Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37CE345AD2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhCWJ3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhCWJ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:29:03 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06B06C061574;
        Tue, 23 Mar 2021 02:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=KVfGFrlimU
        dpFHwtyrzzDaTFmMpJQp6HKhWAnn+9MfY=; b=wUmvVjtrpHorkDLJGZc1xkj4+D
        U/oi1RCab5TvliV50xDgB7WzvvUjPZ5cg3bcPEFiCXVFlyEiFzozGSIN5UBiMxaj
        gt4/BsawVfVlVmULKxzjGnFhmwKC/JhqG9BIRNX34vDDP/NeNsagShfoDJTVMe0j
        gtaAjVTxgbs+Bu71g=
Received: from ubuntu.localdomain (unknown [202.38.69.14])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygB3fEjctFlgTtMgAA--.116S4;
        Tue, 23 Mar 2021 17:29:00 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH v2] usb: Add a lock when freeing data in usbtmc_disconnect
Date:   Tue, 23 Mar 2021 02:28:54 -0700
Message-Id: <20210323092854.18911-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygB3fEjctFlgTtMgAA--.116S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr48Zr15ur1fZr4UGr4fGrg_yoWkWFX_ua
        15W3WIyry5AFy3C3W2qr1rZw1xK3Wvvr4xXFZ0vw13ZayUtws5Jr42qrZ3J39rWF4UJF9r
        Arnagryrua1xXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbV8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
        YxC7MxkIecxEwVAFwVW8uwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvE
        x4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JU5sqZUUUUU=
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In usbtmc_disconnect, data is got from intf with the initial reference.
There is no refcount inc operation before usbmc_free_int(data). In
usbmc_free_int(data), the data may be freed.

But later in usbtmc_disconnect, there is another put function of data.
It could cause errors in race.

My patch adds a lock to protect kref from changing in race.

Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 drivers/usb/class/usbtmc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 74d5a9c5238a..44f1fcabbb1e 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -2493,8 +2493,13 @@ static void usbtmc_disconnect(struct usb_interface *intf)
 		usb_scuttle_anchored_urbs(&file_data->in_anchor);
 	}
 	mutex_unlock(&data->io_mutex);
+
+	spinlock_t *dev_lock = &data->dev_lock;
+
+	spin_lock_irq(dev_lock);
 	usbtmc_free_int(data);
 	kref_put(&data->kref, usbtmc_delete);
+	spin_unlock_irq(dev_lock);
 }
 
 static void usbtmc_draw_down(struct usbtmc_file_data *file_data)
-- 
2.25.1


