Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAB132FFC8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 10:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhCGJBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 04:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhCGJAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 04:00:40 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B630C06174A;
        Sun,  7 Mar 2021 01:00:40 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id z7so3450196plk.7;
        Sun, 07 Mar 2021 01:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=s4gFl7SGAYFTP4ZBTRFs+Ij/virx6YISf2jqubAENRM=;
        b=RL1FOIOroOB3CihKg27Uggf5JY4Y/Df3UKpX2AWC4ZRv7a0+0J+HbNb+dZzAhsUJa4
         MVw+gfEUHuOdwUf1HuLCO6FUsLdrTOszycBUKls8jtwNkm4Txb8NOaSBcIAm5C8vaFfp
         BcDsLvXEGr5jNMrUUWiltsRtc4EDZeKAGnhJNtih8RL6QiQxPHmtQbTf8xAhvqZ7X210
         53RILUWkcdVm7/UAZwHi03mIz7c4gOzJJ74zwRLKAktrt/NLrNtKHq4tDfQQCYK1750/
         Ecw09KtTUkrGgej3tdotQtvnWtT/yTrQR9+x+Ys5Ezp+7ujBcbMpSSB00dy17i7/8RFE
         92Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s4gFl7SGAYFTP4ZBTRFs+Ij/virx6YISf2jqubAENRM=;
        b=oNMpiK3mfXkN287KbWKOZV26LvmRbIgptMzQGQclZEGl4n+mDANzGC4azaoQbkX33I
         OEmMF4x1p2VZ4B1aOM0JqhpPEi1IezNmj+t2ozY8gd1yGOcN2tLYPy+X/IZH50S1+6a/
         zR7wEYb/iYulhlvZAvM6RbE26tXhDoHJRyRJUsS2Ys5T6oqzfvv4IlJ2PSi9ZkWwXGdP
         keXQqyQW6GEq2thP098+50YkqKqQctY8WEKA7xKtltxZ+zXKnDH6b4dMr0QuBbsJmAol
         Id8azD5X43VZQ3MT2W7Hez6rAq/ZSYg723WAK7YD750WYAuhVEns4O8+kThZ0Chj/+aW
         1YBQ==
X-Gm-Message-State: AOAM532DXS2/BINMFcMxzwzjYzGr0F0z05L503r7bAXGr9AkexMotV9g
        hk3ZPJF1XO4FhKfYlEOKGtmb3vc7fdDADuOZ
X-Google-Smtp-Source: ABdhPJwq3W3JzapllBN/oSvIHMGdK565ofiqya4NtR/HRfOGq2gH5ZoPE+7jtEujxr4xw1oKLe6q+Q==
X-Received: by 2002:a17:902:6b02:b029:da:c6c0:d650 with SMTP id o2-20020a1709026b02b02900dac6c0d650mr16454723plk.74.1615107639705;
        Sun, 07 Mar 2021 01:00:39 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.66])
        by smtp.gmail.com with ESMTPSA id ch15sm7281858pjb.46.2021.03.07.01.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 01:00:39 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     gregkh@linuxfoundation.org, yoshihiro.shimoda.uh@renesas.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] usb: renesas_usbhs: fix error return code of usbhsf_pkt_handler()
Date:   Sun,  7 Mar 2021 01:00:30 -0800
Message-Id: <20210307090030.22369-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When __usbhsf_pkt_get() returns NULL to pkt, no error return code of
usbhsf_pkt_handler() is assigned.
To fix this bug, ret is assigned with -EINVAL in this case.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/usb/renesas_usbhs/fifo.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
index e6fa13701808..b5e7991dc7d9 100644
--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -160,8 +160,10 @@ static int usbhsf_pkt_handler(struct usbhs_pipe *pipe, int type)
 	usbhs_lock(priv, flags);
 
 	pkt = __usbhsf_pkt_get(pipe);
-	if (!pkt)
+	if (!pkt) {
+		ret = -EINVAL;
 		goto __usbhs_pkt_handler_end;
+	}
 
 	switch (type) {
 	case USBHSF_PKT_PREPARE:
-- 
2.17.1

