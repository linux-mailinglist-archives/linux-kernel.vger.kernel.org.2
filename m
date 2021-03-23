Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823EE345671
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 04:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhCWDsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 23:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhCWDsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 23:48:03 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FBDBC061574;
        Mon, 22 Mar 2021 20:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=1GoWh5eS4L
        y3A4l/bsaEFyKFS7162BJKVfkr1mQVN2s=; b=FIsQNV9hksoXuqYWMxy0FqR3Em
        tFJj9b469QfN5LEuURJC5mqJCbdp6nQ5/+vCtU9btDnRDilyf7od5Nb2WnJC5sCp
        9JC6wqD5NHhi7IAVZFrBGW0HsjFqUtInzbXcFD9J1G2eFa+YR6YhZcUbNSHeiR63
        SYXIs+gMYONIHHYkM=
Received: from ubuntu.localdomain (unknown [202.38.69.14])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygCHj0PJZFlgc6waAA--.144S4;
        Tue, 23 Mar 2021 11:47:21 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH] usb: Add data checks in usbtmc_disconnect
Date:   Mon, 22 Mar 2021 20:47:17 -0700
Message-Id: <20210323034717.12818-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygCHj0PJZFlgc6waAA--.144S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr48Zr15ur1fZr4UGr4fGrg_yoWkJrX_ua
        1UWF1xtrW5CF9xC3W7tr1rZw1xt3W0qw48XFs0y343Za4jqw4kAr1Iqrs5J397WF4UtryD
        Zrn2qryruayxujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbV8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
        YxC7MxkIecxEwVAFwVW8GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUza0QUUUUU=
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In usbtmc_disconnect, data is got from intf with the
initial reference. There is no refcount inc operation
before usbmc_free_int(data). In usbmc_free_int(data),
the data may be freed.

But later in usbtmc_disconnect, there is another put
function of data. I think it is better to add necessary
checks to avoid the data being put twice. It could cause
errors in race.

Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 drivers/usb/class/usbtmc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 74d5a9c5238a..e0438cb46386 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -2494,7 +2494,9 @@ static void usbtmc_disconnect(struct usb_interface *intf)
 	}
 	mutex_unlock(&data->io_mutex);
 	usbtmc_free_int(data);
-	kref_put(&data->kref, usbtmc_delete);
+
+	if (data->iin_ep_present && data->iin_urb)
+		kref_put(&data->kref, usbtmc_delete);
 }
 
 static void usbtmc_draw_down(struct usbtmc_file_data *file_data)
-- 
2.25.1


