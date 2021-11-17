Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7827E4541B3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 08:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbhKQHX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 02:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhKQHX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 02:23:28 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B116C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 23:20:30 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c71-20020a1c9a4a000000b0032cdcc8cbafso1300742wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 23:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TgMULFmcc96fBRsKNWsxFC73m46YoZVeygK+f1wHseo=;
        b=pSEg0Mh9p5hEEt8mN9ZxtILWfLdO4LFVVmT/eM8NW7kqw5qS3D2JPZ7Z8v7Ic7hwZV
         Zs+43w18b9E3921OdQ1NpQSaW+M1ZmG9H7CgsYno7WxFyJTF/mYRcIPuttFWHLsO2rQu
         jyrdcR51wiD68/Cm5ARAuYkBHT75ro6RH8cNRA7LwLP9Lk8X/cV+tDIIFLZ7zrpvzLvH
         2xXKuO+b/Q1oRgEzEdn4XgZmdMzaK8iMkxuix/JTfRBGCab6cyUlVRkFwElr5PhTzDEa
         gcNHUnWkQMbC2JIihMYXRKpwTbMdLtSWu2NOJSrBbR7+KM5Ty0GyjJXrf4lCtGLSw7oE
         0ptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TgMULFmcc96fBRsKNWsxFC73m46YoZVeygK+f1wHseo=;
        b=vhnmYkwZ0f8+2Ljwgibnw1pcHFeXOUESpc2k4b4brSuKWtT0JalokCWszLD0LTi67/
         gasZ+iWEbJxHsTs1+WBsWeJ+htzLpyPvYI7TX1NHrRsSA9G+qXyuBSnwjhJ7oR3sxuOR
         +Pq7g+83U+qfoLx6YB+r/8JGhXfvXTyo5rUbsHl8pUwDYuPDuVYEHx9OgW/cAe7VrqDc
         nHaV0xYIc1dSPCa73C+hErGYJOUJAzc48dVunLJ9F90kcbgzFcbW4ZC+sF8vKsHzwXnJ
         V4w4htsNCD86Hfigagsas3cxQb7u9DmX2Kx+OHGPHvtl4dnqrXllRmbqqE/iByMa2D3b
         e5ng==
X-Gm-Message-State: AOAM532JSWZXC6x3p5EtDLwh1qUS/KpEuZnOkhnRqrYXah/jTn2zyhJa
        Z0E/5rVM8YKpKERnMYm9WFzHQBV1k3o=
X-Google-Smtp-Source: ABdhPJzbG3x0zTbiQ9wOKrQi3EDrjDOSzdij/LYzGu6uDxp5Z11TIWuQbgshUm4W1rF65fd/16Ph8Q==
X-Received: by 2002:a05:600c:3553:: with SMTP id i19mr75820715wmq.97.1637133628699;
        Tue, 16 Nov 2021 23:20:28 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::79b5])
        by smtp.gmail.com with ESMTPSA id l2sm5248353wmq.42.2021.11.16.23.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 23:20:28 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: code indent should use tabs
Date:   Wed, 17 Nov 2021 08:20:07 +0100
Message-Id: <20211117072007.19924-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace spaces with tab to clear the following checkpatch issues.

usb_intf.c:38: ERROR: code indent should use tabs where possible
usb_intf.c:38: WARNING: please, no spaces at the start of a line

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/os_dep/usb_intf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 5a35d9fe3fc9..eca1036a721f 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -35,7 +35,7 @@ static struct usb_device_id rtw_usb_id_tbl[] = {
 	{USB_DEVICE(0x07B8, 0x8179)}, /* Abocom - Abocom */
 	{USB_DEVICE(0x0DF6, 0x0076)}, /* Sitecom N150 v2 */
 	{USB_DEVICE(0x2001, 0x330F)}, /* DLink DWA-125 REV D1 */
-        {USB_DEVICE(0x2001, 0x3310)}, /* Dlink DWA-123 REV D1 */
+	{USB_DEVICE(0x2001, 0x3310)}, /* Dlink DWA-123 REV D1 */
 	{USB_DEVICE(0x2001, 0x3311)}, /* DLink GO-USB-N150 REV B1 */
 	{USB_DEVICE(0x2001, 0x331B)}, /* D-Link DWA-121 rev B1 */
 	{USB_DEVICE(0x056E, 0x4008)}, /* Elecom WDC-150SU2M */
-- 
2.33.1

