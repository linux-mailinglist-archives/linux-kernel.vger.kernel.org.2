Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA5631C471
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 00:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhBOXgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 18:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhBOXgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 18:36:08 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69C2C06178A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 15:34:47 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r21so10997059wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 15:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gdMjv3PHcQrBqt3IFxBp+nAvs8Tvvw+J+yRn42FzksY=;
        b=04ziwiH/3f5gWmZXWGLooWh2OkL/hHNSOWTSosSAXeDfYnNVeYZEa2sFQJbN8fww1r
         bINo77R6othLZUcT8LKoIF8oX9HeXmxhIaBctDuywrIVnUanwT+r9J2IMfUCmrafnZGK
         7gcpgCEAqrMJ/kllj0rksO8hU687UgwVg/9qLKKWjO2dXvGkcCbBGfIB0KNgdy2rhVag
         855GG8Rt/a5Bd945agv22XdSlTYOc68/ETy62b2NmI6mtb/xfQsLPE24eqhWcPk2otiV
         VuDTmrf19D4VHuTGuaNmx6Ajf0FVsxxn9UoriOrIN96a9mWcja+9P9C68RO3HKaWaMGN
         yeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gdMjv3PHcQrBqt3IFxBp+nAvs8Tvvw+J+yRn42FzksY=;
        b=IdEx/m8v1YjVlsQxb1mYg4r4p/1HGKTYvsLg2uqGbFu15TFkRoABvjjKzazeNm2Jv6
         COihfKPVtgGI9zm/Bx4IlxH+RhUiGia6eFPCZo8DnK3MoBI/nagvp4w0J/AOhRnCwPrv
         3r5K/89qn3y/jit2VXQuY7taU3RRWdbgetliYNe/FsupD+EXGBVyRkiGyE+6jb2v/2d7
         oL9IaTWwlbjsTE/IkqG4TDQ9q7P2CStJUwPHifLpUfKZvtSaqvhblN1K80GS0TXANlzY
         6WIkANlmLsjjRPQSY5b57gonDs2GDvjFjLHbEEaLzQ3pn19PJVP/UF9tdiZpEY8OtOUX
         iuBg==
X-Gm-Message-State: AOAM530dnjKH+HPvY67mg4LPFGojGQLl8LYFdcERqEod4LIDdRzkwkHF
        GbVJHI5kTvqDGUfVLkynRNgE9w==
X-Google-Smtp-Source: ABdhPJyPTPgp0sEyylnIEkgypLdLzkMrXaX1dCdc2cti2Bh/XNvmOuBu3hfEk8C06jwn3wB/tzhfRA==
X-Received: by 2002:adf:d0d2:: with SMTP id z18mr21614520wrh.40.1613432086757;
        Mon, 15 Feb 2021 15:34:46 -0800 (PST)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id y16sm21691445wrw.46.2021.02.15.15.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 15:34:46 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     ross.schm.dev@gmail.com, matthew.v.deangelis@gmail.com,
        pterjan@google.com, vkor@vkten.in, amarjargal16@gmail.com,
        foxhlchen@gmail.com, insafonov@gmail.com, yujian.wu1@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] staging: rtl8723bs: remove DBG_COUNTER definition from rtw_debug.h
Date:   Mon, 15 Feb 2021 23:34:39 +0000
Message-Id: <20210215233440.80617-6-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210215233440.80617-5-phil@philpotter.co.uk>
References: <20210215233440.80617-1-phil@philpotter.co.uk>
 <20210215233440.80617-2-phil@philpotter.co.uk>
 <20210215233440.80617-3-phil@philpotter.co.uk>
 <20210215233440.80617-4-phil@philpotter.co.uk>
 <20210215233440.80617-5-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove DBG_COUNTER macro definition from include/rtw_debug.h, as
all uses of it have now been removed and it is no longer required.
The DBG_COUNTER incremented values were never actually used anywhere
else in the driver.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index c90adfb87261..d1c557818305 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -252,12 +252,6 @@
 #endif /* defined(_dbgdump) */
 #endif /* DEBUG_RTL871X */
 
-#ifdef CONFIG_DBG_COUNTER
-#define DBG_COUNTER(counter) counter++
-#else
-#define DBG_COUNTER(counter) do {} while (0)
-#endif
-
 void dump_drv_version(void *sel);
 void dump_log_level(void *sel);
 
-- 
2.29.2

