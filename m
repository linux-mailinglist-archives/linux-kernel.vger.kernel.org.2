Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92165402034
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 21:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343821AbhIFTFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 15:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245572AbhIFTEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 15:04:08 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335A0C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:03:03 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id n27so15128994eja.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 12:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qc2GV8eyLuBArlRm4HdaZBsA+XfwTyg8ciFIuh8ckds=;
        b=pmoVLdJklMzp16dnMTMZVchSnb5AYgOoCCNU+noJLZ4pd31XGwu4cBCXMIMpubJxVc
         cZGx7Q/2+0qwKTrw8wxYKcBpc/6wRdWuasF44Y0oTLrsoPIJL9aOqhdwJ8MJrfRQ8mOn
         XmWxkBfjJEHdhmfgTMDJhE4SyQwJ8cz8XDRusNeqFVJ8SAFI5plojKqMEBKfEjTf0vwZ
         3/PPJheRnp9CebW8FdrqyFdB1oHbkQDwKgHHDG3FY8SnX6wXlJZF84eJSt/Xf3qLjVEW
         aarmHKImWuJu/abMicuO9WfsiaDSrKp8qlp4PpuCP6Rtw+s2rKKq/Mbb0zjwUJYp7r8u
         vYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qc2GV8eyLuBArlRm4HdaZBsA+XfwTyg8ciFIuh8ckds=;
        b=LdEni0cOrhI1WhnVmXfguU6NLnOAfipsgaJa6n5aJM8H8taImkTpqZa62FNiQeyCro
         GPdZJNXe4FCmfKGGx7T2+6inRTn8KHWI9R/jvUTYvntlS7wu8kGtUtuMgqQPXEbF0qlz
         PZeX43thRQe1Y9iY1o75eaY7tZVv0HxFvjm/7pl8MStBj+lZ33kAPvfqVBJc7UIoaoAo
         EwRv2pv3RSfBH3MyPskz1s0/R2HCf4XwasJ/wb7By5dBw3OrPqhKN2VgFqJ5Aq3WXbfr
         TaISav+O0b+XapmqgFlmDgLbrEXj/xlxL4QCba1aeVjpkovPHPqmADQ+15DCBKdNJebZ
         rmTw==
X-Gm-Message-State: AOAM531fucCtOKAAM4WYI1vTlsQZKoKHuUqjsKMJzXuzDT7WP0ELrdBa
        l0+D/PsM1TaXR3sv4N7M7gU=
X-Google-Smtp-Source: ABdhPJxFyOr1ERQ6qj1fHmJSBjHzQKvakGk9IBX6omhramNy7o4gpxkRBi7IJOsExI0qCsUOYtptyw==
X-Received: by 2002:a17:906:d52:: with SMTP id r18mr14819291ejh.47.1630954981814;
        Mon, 06 Sep 2021 12:03:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id k15sm4372018ejb.92.2021.09.06.12.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 12:03:01 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 22/40] staging: r8188eu: rename hal_EfusePowerSwitch_RTL8188E()
Date:   Mon,  6 Sep 2021 21:02:05 +0200
Message-Id: <20210906190223.11396-23-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906190223.11396-1-straube.linux@gmail.com>
References: <20210906190223.11396-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename hal_EfusePowerSwitch_RTL8188E() to get rid of a wrapper.

hal_EfusePowerSwitch_RTL8188E() -> rtl8188e_EfusePowerSwitch().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index c7edb9ba4085..b5d0cd332165 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -707,11 +707,7 @@ hal_EfusePgPacketWriteData(
 		struct pgpkt *pTargetPkt,
 		bool bPseudoTest);
 
-static void
-hal_EfusePowerSwitch_RTL8188E(
-		struct adapter *pAdapter,
-		u8 bWrite,
-		u8 PwrState)
+void rtl8188e_EfusePowerSwitch(struct adapter *pAdapter, u8 bWrite, u8 PwrState)
 {
 	u8 tempval;
 	u16	tmpV16;
@@ -757,11 +753,6 @@ hal_EfusePowerSwitch_RTL8188E(
 	}
 }
 
-void rtl8188e_EfusePowerSwitch(struct adapter *pAdapter, u8 bWrite, u8 PwrState)
-{
-	hal_EfusePowerSwitch_RTL8188E(pAdapter, bWrite, PwrState);
-}
-
 static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 	u16			_offset,
 	u16			_size_byte,
-- 
2.33.0

