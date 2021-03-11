Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02AE8337673
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 16:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbhCKPED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 10:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbhCKPEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 10:04:01 -0500
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFAC3C061574;
        Thu, 11 Mar 2021 07:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=z9RQwR+u8Z
        1vrbiS9Q7LDRwA1h5csTWHrA1fRIMw1Go=; b=hvSHT87I1FPtk2iWcD3SSd0FxT
        ZCl+8DAjhhwKFMgyEeVu3QUaEr9vZyNj9YvEl3WX0/0X2NTbHTfxeEvzb9ImKDid
        KoUJMw5d6wE5Je1BsyolbUUU7coKHQm3P30dWM2L7lCD5bGFWAVnHgCp2/F9rPOE
        kmC0xvZtpAlSJ0TNU=
Received: from ubuntu.localdomain (unknown [114.214.226.60])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygCXmxtcMUpgKCYNAA--.5291S4;
        Thu, 11 Mar 2021 23:03:56 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH] usb/usbtmc: Remove a redundant kref_put in usbtmc_disconnect
Date:   Thu, 11 Mar 2021 07:03:54 -0800
Message-Id: <20210311150354.8723-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygCXmxtcMUpgKCYNAA--.5291S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKrWDKF18Kry7tw48Aw43KFg_yoWkGFb_ua
        yUCFsrtr4YkasrCF47Jr1rZw4fta1Fqr4xXF4kt34fZ3Wjgw4qyr1IvrZ5J397Ww4UtFyD
        Zrn2qr98uay8ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4AFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
        YxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Gr0_
        Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUj3fH7
        UUUUU==
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of usbtmc_free_int(), it already calls
kref_put() to free the data as shown below. So, in
usbtmc_disconnect, call an extra kref_put() is redundant.

"""
static void usbtmc_free_int(struct usbtmc_device_data *data)
{
	if (!data->iin_ep_present || !data->iin_urb)
		return;
	usb_kill_urb(data->iin_urb);
	kfree(data->iin_buffer);
	data->iin_buffer = NULL;
	usb_free_urb(data->iin_urb);
	data->iin_urb = NULL;
	kref_put(&data->kref, usbtmc_delete);
}
"""

Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 drivers/usb/class/usbtmc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 74d5a9c5238a..adcdd2df1949 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -2494,7 +2494,6 @@ static void usbtmc_disconnect(struct usb_interface *intf)
 	}
 	mutex_unlock(&data->io_mutex);
 	usbtmc_free_int(data);
-	kref_put(&data->kref, usbtmc_delete);
 }
 
 static void usbtmc_draw_down(struct usbtmc_file_data *file_data)
-- 
2.25.1


