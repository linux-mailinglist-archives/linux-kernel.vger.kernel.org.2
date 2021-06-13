Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2CA3A5ABB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 00:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhFMWCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 18:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhFMWCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 18:02:39 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DD9C061574
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 15:00:24 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id x14so17393830ljp.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 15:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a8IxlEz8UeTgLFpNy/eVZ6B8zP8vaSJFbv8R3k+S30I=;
        b=XAHYDOlHieLxkHx8JsBFYlfHNldNu78W6W4X9gVvvXUGSaT6Z5VDHyEeFb0lWaofG2
         9k0QK/Xz8TGjlFzkxJJd3gnZb+DjGN0n4uxj9yCRdKiwL6yzQkFANLYh72swUMQnDpbR
         UX8nUpxCp0TFQCLWIPbE4oTXz3g9DF/Lt8zKhmzfs2Uk3lR3BHqYGlThW+S0xNOcc0bt
         qxjFC7LICHsOOnKshBM5v2nEgJZB/0OzwMCZacHhZd1JSrQK7hZVRGIg3uwNZtnO8csB
         hDijMZyJCaRahiyELnjAVffFwfQMouYd/9SDjOQbk62FJ6832StWY3dqTdeaVZcFmtxq
         X0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a8IxlEz8UeTgLFpNy/eVZ6B8zP8vaSJFbv8R3k+S30I=;
        b=XV19+LarRRe/qX2gJtAWtZrGvSCKmnj97v4YJPdX082SewLMZuumkDiYSaF1dndlP1
         Dbbs4bbZBkcwxhRkvRDr8OupxRNrO7YShcB8+4z2yTlJ4Wsz4ihdUD+V6zHM1nT2CqI/
         MHH14hL5lZtpnrA0/Iqr5gXjqLfCe+HXcc8b1L2Fpeh4Mmz18isbyaBwzW65kaAVMp27
         MNiLEIre8k5meDI4gqGfoG4GLl96wXbs/hXiW5iq5BfN0ppjefVlLcFBBHLXqM/BPoAI
         z1KgZd80OdILiXjYy5nVcyDfmRLDP3CjhGPjeIR9zv9fi0DLMRy6oUgrHXPcJHUCa5VH
         gx+g==
X-Gm-Message-State: AOAM533vPMLY3LSmJ8F0bpO1TED+2uuxXCLP2YjHQTYCl/49iIxd0BRs
        5MWZGsPKH+r2ZdMtAqbOaGg=
X-Google-Smtp-Source: ABdhPJxdgf41BUap//pV72ZYfdDkUJGx1BSn76T+9UpNdwIW7NKSjTrKIj+rK4ui9a7vzEUJDCJWoA==
X-Received: by 2002:a2e:b528:: with SMTP id z8mr11162776ljm.350.1623621621739;
        Sun, 13 Jun 2021 15:00:21 -0700 (PDT)
Received: from localhost.localdomain ([94.103.229.24])
        by smtp.gmail.com with ESMTPSA id q19sm862668lfu.307.2021.06.13.15.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 15:00:21 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH 3/3] staging: rtl8712: fix memory leak in rtl871x_load_fw_cb
Date:   Mon, 14 Jun 2021 01:00:19 +0300
Message-Id: <81e68fe0194499cc2e7692d35bc4dcf167827d8f.1623620630.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623620630.git.paskripkin@gmail.com>
References: <cover.1623620630.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a leak in rtl8712 driver.
The problem was in non-freed adapter data if
firmware load failed.

This leak can be reproduced with this code:
https://syzkaller.appspot.com/text?tag=ReproC&x=16612f02d00000,
Autoload must fail (to not hit memory leak reported by syzkaller)

There are 2 possible ways how rtl871x_load_fw_cb() and
r871xu_dev_remove() can be called (in case of fw load error).

1st case:
	r871xu_dev_remove() then rtl871x_load_fw_cb()

	In this case r871xu_dev_remove() will wait for
	completion and then will jump to the end, because
	rtl871x_load_fw_cb() set intfdata to NULL:

	if (pnetdev) {
		struct _adapter *padapter = netdev_priv(pnetdev);

		/* never exit with a firmware callback pending */
		wait_for_completion(&padapter->rtl8712_fw_ready);
		pnetdev = usb_get_intfdata(pusb_intf);
		usb_set_intfdata(pusb_intf, NULL);
		if (!pnetdev)
			goto firmware_load_fail;

		... clean up code here ...
	}

2nd case:
	rtl871x_load_fw_cb() then r871xu_dev_remove()

	In this case pnetdev (from code snippet above) will
	be zero (because rtl871x_load_fw_cb() set it to NULL)
	And clean up code won't be executed again.

So, in all cases we need to free adapted data in rtl871x_load_fw_cb(),
because disconnect function cannot take care of it. And there won't be
any race conditions, because complete() call happens after setting
intfdata to NULL.

In previous patch I moved out free_netdev() from r8712_free_drv_sw()
and that's why now it's possible to free adapter data and then call
complete.

Fixes: 8c213fa59199 ("staging: r8712u: Use asynchronous firmware loading")
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/rtl8712/hal_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/rtl8712/hal_init.c b/drivers/staging/rtl8712/hal_init.c
index 715f1fe8b472..22974277afa0 100644
--- a/drivers/staging/rtl8712/hal_init.c
+++ b/drivers/staging/rtl8712/hal_init.c
@@ -40,7 +40,10 @@ static void rtl871x_load_fw_cb(const struct firmware *firmware, void *context)
 		dev_err(&udev->dev, "r8712u: Firmware request failed\n");
 		usb_put_dev(udev);
 		usb_set_intfdata(usb_intf, NULL);
+		r8712_free_drv_sw(adapter);
+		adapter->dvobj_deinit(adapter);
 		complete(&adapter->rtl8712_fw_ready);
+		free_netdev(adapter->pnetdev);
 		return;
 	}
 	adapter->fw = firmware;
-- 
2.32.0

