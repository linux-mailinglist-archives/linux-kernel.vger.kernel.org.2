Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E059E3F3690
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 00:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238675AbhHTWly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 18:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbhHTWlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 18:41:53 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54B7C061756;
        Fri, 20 Aug 2021 15:41:14 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id f10so8757107lfv.6;
        Fri, 20 Aug 2021 15:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SFicaIfoYz57CJTwaU362imjBTcDv84/jGlGPzq+gP0=;
        b=O7gDmfWpTTkJeOJPaVYVyofz4iDJu+Mrj133OGy09FgtY/eXRABIw1rUkYb8sfclJT
         Y20x5vVWOcvl1oUQn3eEqlRcawKrWTRhyQhF2Kx4BEp0U5fi4DulPvP+WJ9eI1an4x2T
         ZxBsLequ4yRJeSJ+/F0rTdYngPcjg8qDevEEpzupdCP68RcUbA3tpo2j6sUEiz0w2KC1
         vox0Zphyy3AOZBbntGlqWMgtjLqvbQj9s4+nI4LTRukaSsmUQN5lUCqqzLkLym4q28tx
         N7/+9E114pZgtM69PGiq+AAMvWUrVfK7TtHxCV+hY1kVMawwZKkV+Qu1HMXLvHC3Yehi
         wGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SFicaIfoYz57CJTwaU362imjBTcDv84/jGlGPzq+gP0=;
        b=VioLbTsN2xT93C//0qyw+1OxoGOPZ35qBey8i4PD9rrYIVr05JDGeXWyxr7DCbr7YV
         lSWr79g3nHq2U17g61ir4scq4D8TLmREv9AM9VJ2aw+5d1nWJ8C4q4Hv5sPdd03jUJgP
         wn0lRjDTfRmtdhcXXRleEaLjgKHscAEOQ8rPt1BYZEXp7tDpyIud6dEnxybe9/F6+JGU
         dSpNI7D5IvNqLCOgavBJkMt5N+sSKlJRoPf+L4eboE6TaT6v2uf0uiuvFmyLobhm/tNu
         keJDTHvLW+Ck3cAJPTctSV+XqEK/Tw1Ls1UBO7+huF9rP/wz+hEvyqAxqupWz07GlpY8
         hRKw==
X-Gm-Message-State: AOAM530zC6hqHoxfhliscUz8+5a195/yNx1CE9/9X+ovy+lASQbGnAzk
        hB2actolwKcQvsx0EDuobmk=
X-Google-Smtp-Source: ABdhPJxBzL38mkx4u0Uk+QhJtzLCxmj6Qwp9/GdWcEydclqxJIn6QLZfzt2kVEuKYEDOyHR0wZkosA==
X-Received: by 2002:a05:6512:3f15:: with SMTP id y21mr15771947lfa.370.1629499273263;
        Fri, 20 Aug 2021 15:41:13 -0700 (PDT)
Received: from localhost.localdomain (h-62-63-208-27.A230.priv.bahnhof.se. [62.63.208.27])
        by smtp.googlemail.com with ESMTPSA id i5sm640022ljm.33.2021.08.20.15.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 15:41:12 -0700 (PDT)
From:   Niklas Lantau <niklaslantau@gmail.com>
To:     stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org,
        Niklas Lantau <niklaslantau@gmail.com>
Subject: [PATCH] Usb: storage: usb: fixed coding style issues
Date:   Sat, 21 Aug 2021 00:39:54 +0200
Message-Id: <20210820223954.2945-1-niklaslantau@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed coding style issues that generated 1 error and 1 warning.

Signed-off-by: Niklas Lantau <niklaslantau@gmail.com>
---
 drivers/usb/storage/usb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
index 90aa9c12ffac..c3d710f323f6 100644
--- a/drivers/usb/storage/usb.c
+++ b/drivers/usb/storage/usb.c
@@ -295,7 +295,7 @@ void fill_inquiry_response(struct us_data *us, unsigned char *data,
 }
 EXPORT_SYMBOL_GPL(fill_inquiry_response);
 
-static int usb_stor_control_thread(void * __us)
+static int usb_stor_control_thread(void *__us)
 {
 	struct us_data *us = (struct us_data *)__us;
 	struct Scsi_Host *host = us_to_host(us);
@@ -926,9 +926,8 @@ static unsigned int usb_stor_sg_tablesize(struct usb_interface *intf)
 {
 	struct usb_device *usb_dev = interface_to_usbdev(intf);
 
-	if (usb_dev->bus->sg_tablesize) {
+	if (usb_dev->bus->sg_tablesize)
 		return usb_dev->bus->sg_tablesize;
-	}
 	return SG_ALL;
 }
 
-- 
2.33.0

