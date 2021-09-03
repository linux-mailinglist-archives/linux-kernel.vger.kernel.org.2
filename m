Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B4F3FFD3B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 11:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348895AbhICJfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 05:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348864AbhICJfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 05:35:12 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8181C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 02:34:12 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m9so7325723wrb.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 02:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oznwyLooQ2rhxtSqFdj86ZRnOv4fBG2J3jHuHaF1yHE=;
        b=JoXcaDwhgnMRJEWj2g2has1eZ0yY4ltbJg6pxCKsVVuBwKcNCUGfosjNn2WWMsauY0
         Nu4ihue8A4cZI6pLYwsOuspwKJUQNp9+JXWzUbRW4X9Olrpy618jNbm0v2rPhQgDIZg0
         1S/fmKjnY2bhgJB8twzpX7aMZGsE6F6qQknJMs64KMRo5hwd+nVpXG/1mGuw63Qx8t3V
         c0GB7H81OfZPdegjsLn/X3o5cPN3QhPsNtNxqOqT+MyS981VRPe8mRkn1SCwRqhJSGGc
         TUolZvdXmV8KUbehSPsFJ4jt4a5ItvPMoa1q0p1J1WqGt+CJzmwvSnrdfsPXn0z5EF7B
         7JIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oznwyLooQ2rhxtSqFdj86ZRnOv4fBG2J3jHuHaF1yHE=;
        b=DHmiXeFuvhxpg0IwGy2KRDqzdQUCMthsnhmoKs5RC5geijIhpuNTAKeLwjqcdGDnOq
         OKzEwZryQhfG1oqGxJG7p0iUycr3SOdaamm2OV/DBcgOlAxxLLWRd28wNxRLMXf+XASs
         ib9W0RAu5l7teQtGB1GggPSnuO1Pd6gHUp4q6iwepMRQMTNMesmDUYt4ZkvSQA7vnLMU
         f6WxAGtiCPFVMk3JpZQQOqEk2ZZaAIYw1K2Myyn/IbomZ8LGpAUBRpGQqlrbEL4pCbqK
         kvLSbO9+XPESZotanZrZz7JNlAJOSKpn/CabAMqit8E/H/T2Io2P04CuMLIfapNV01vK
         VqhA==
X-Gm-Message-State: AOAM532miNbNMwWBOI0o6T2d4hqxioL4niBSdHueLmhqFz1cvafBu/eS
        XcRzOK868yfuTpSoAa+EdIM=
X-Google-Smtp-Source: ABdhPJx/+h8UZIFCxZiltfDZtgYQjnz6VeGEXE2xBJC2LwoUstv45cDQ6Ku0Mnsvv6luek7fadzOzg==
X-Received: by 2002:adf:80c8:: with SMTP id 66mr2931481wrl.65.1630661651619;
        Fri, 03 Sep 2021 02:34:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id x11sm3853060wmk.21.2021.09.03.02.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 02:34:11 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/6] staging: r8188eu: remove unused enum rt_eeprom_type
Date:   Fri,  3 Sep 2021 11:33:52 +0200
Message-Id: <20210903093354.12645-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210903093354.12645-1-straube.linux@gmail.com>
References: <20210903093354.12645-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused enum rt_eeprom_type.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/hal_intf.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 954de3ab2613..bbdbbf9697b1 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -254,12 +254,6 @@ struct hal_ops {
 	c2h_id_filter c2h_id_filter_ccx;
 };
 
-enum rt_eeprom_type {
-	EEPROM_93C46,
-	EEPROM_93C56,
-	EEPROM_BOOT_EFUSE,
-};
-
 #define RF_CHANGE_BY_INIT	0
 #define RF_CHANGE_BY_IPS	BIT(28)
 #define RF_CHANGE_BY_PS		BIT(29)
-- 
2.33.0

