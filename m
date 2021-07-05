Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD5E3BB7B5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 09:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhGEHYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 03:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhGEHYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 03:24:09 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330F9C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 00:21:33 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x12so22471937eds.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 00:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t+aKvXsIn+8avSn4PCSFQNGMZzjkorhkw7aPWteLK30=;
        b=rvMTQbOCIISgB7aNd4XTI02RUU2FQpAVEo/TwhNqBu0YnbWNy30VOiGkAp29ylhcCT
         IQxVFrLehlSCGSTJLf1C106d/J7/EIGgpfoQtS1u8GjgpEEjrro0Y9k7Ua+lXZS7Tvuk
         d8kg4tw+Unbx5X4aNHuKRnybKiTV/L0jbBS2/U/UZA6dJ5r+9qBbru5WDEbyTMXt0sJk
         51LcFbSgU/cBPfhQmBGexWQfVRf6I98CzdIeMSU0Fm/Bh2nEx1Z9GgTj5vk0OGSlG7PR
         xv2gQdkhCAxpqmrTYaPT3WDJ3MxTqb8BwIOkDno5OkZlh/mSi9Tc6j+Q49Ca7NFyH4NJ
         4M1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t+aKvXsIn+8avSn4PCSFQNGMZzjkorhkw7aPWteLK30=;
        b=JouNShJ1W5S7oFKiiYu/2whEuUEPQuf52E8pm5KI5vKYccuidp550Hqz1KVy6kqKL8
         cv/Pa3ZxmfWbeH8TdCaQHhRWo94PoX3xVX+shIiDUJHT8UUaNjkzmzEGnIsJwbj/SPBq
         KNPM7yZ4oVWgaVQBRFg6kEXqVp1aJR1uk9heHxP7nXoId3Mz1WYqI78ozDsZALnW3i9a
         tjNIJl/QB7hRZIACdHhuzfoWHJx7ObAUCuedap/ASPowh11GL8NiMIvjODENUMN7m889
         188DXC7+YChbLETrnARghFo2Aa/Aj0jglvQnfMlHffl8gDjqOF7b13C89lYpyLgIiqyL
         KMkw==
X-Gm-Message-State: AOAM533Z41onTIiAxnBybXVeQNFNUmS8RDNnWR9otUg5xVof+2fbnJ0Y
        YCqXtjKitOSGTyGeFMLB9PiLGkYpIy4v2G69
X-Google-Smtp-Source: ABdhPJytDKoI65qz/wTy6ObSEtLix5FvlaiIuCu5GKuSRZdCr9DU3alh4OF/bAPWO8FJXWCPozCNHw==
X-Received: by 2002:a50:ee9a:: with SMTP id f26mr14310171edr.96.1625469691849;
        Mon, 05 Jul 2021 00:21:31 -0700 (PDT)
Received: from uhost.fritz.box (p508df717.dip0.t-ipconnect.de. [80.141.247.23])
        by smtp.gmail.com with ESMTPSA id n22sm3981283eje.3.2021.07.05.00.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 00:21:31 -0700 (PDT)
From:   Jan Gruber <j4n6ru@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Jan Gruber <j4n6ru@gmail.com>
Subject: [PATCH] staging: rtl8188eu: remove unnecessary braces
Date:   Mon,  5 Jul 2021 09:21:25 +0200
Message-Id: <20210705072125.199810-1-j4n6ru@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes the following checkpatch.pl warning:
WARNING: braces {} are not necessary for single statement blocks

Signed-off-by: Jan Gruber <j4n6ru@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/usb_intf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/usb_intf.c b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
index b7e2692c35f3..f8519bfec020 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
@@ -379,9 +379,8 @@ static int rtw_usb_if1_init(struct usb_interface *pusb_intf)
 
 	/* step 6. Tell the network stack we exist */
 	err = register_netdev(pnetdev);
-	if (err) {
+	if (err)
 		goto free_hal_data;
-	}
 
 	pr_debug("bDriverStopped:%d, bSurpriseRemoved:%d, bup:%d, hw_init_completed:%d\n"
 		, padapter->bDriverStopped
-- 
2.25.1

