Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43D33DCD26
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 21:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhHATFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 15:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhHATEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 15:04:54 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC0EC06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 12:04:44 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id i10-20020a05600c354ab029025a0f317abfso2673338wmq.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 12:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FTHDgszgVXhUCFQHz+1EdbXmzNspoceHr2u/r5lVlDE=;
        b=LnXapNdmyQpTNWfP1QumUkCemtwMJ1E4NaIuCsKKgxBULVuDG9UJQIO1fZuOFaSudm
         1RjMRl6X+77fDJ++q02NVGOVGOJ5KdzHFeM2FkL4jv4bCSzL7isycygfcbqcXLdJy+dS
         Cr8xvnUVfhIv+9aLgDAt1H9AOi/uUF24ZpxIb8kGGDOwHDZnIbh+rH6eg5vNW5vHWXI2
         6B4I8C8UJO/ZUErKz3g7sd3nQr8C+vhJSxNX1MqM9UJF9jWFeNCNwyHLpABCAZqIjZrw
         9PktDeril9/nW7nWgeA+mpm8OgW37Z6jxXBvmCH7utIJpWKNo3pjBIdLICkdnHNAzv5L
         s51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FTHDgszgVXhUCFQHz+1EdbXmzNspoceHr2u/r5lVlDE=;
        b=Z3+kOxrlJthb35aHLkv0vPoQBGqXAR93aafkhXy76jKJ+ooKekIhgw/MNg9IJ4m92L
         ZK8YXSHDPIk32sDbFqSiOe8aT62uqCtOgznl6nsAVFTdKSMCeHn47RRv77IkfkehLQwG
         uoab9VGf0msAXYGsGq5/qgT5/PIX50tJWAoSnN2C80MjZsS+SbWiIwQXzl3/tJFDpzwV
         dKZIUXXfqMyyMQHu3yxkeqYkeIigU0tkgzugrhQNGHhGiEekyKVvK/T4XsG58FIyuc6p
         V0Zb4BoY2lmlbRib3d/a4X3cZeFX5PPofg30vyWGr7/MEAcMNZZj0jFLBgmAeBb0lqo1
         2LmQ==
X-Gm-Message-State: AOAM5321xdn3X/2zwLAPhUCM8sJcTEuVm+k3k0kQ9aq0Z9ndCdeW044p
        G5/WbZy6mQqE/rGBkH3SbJSwiw==
X-Google-Smtp-Source: ABdhPJwi+O6xFgy7/P4k6rRsBF/E552X5iPNJasRlHrTEXnidGz4AyWiDob2t/FagFqcUxjWjt1t6A==
X-Received: by 2002:a7b:cd83:: with SMTP id y3mr6343834wmj.126.1627844683610;
        Sun, 01 Aug 2021 12:04:43 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id c10sm8196026wmb.40.2021.08.01.12.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 12:04:43 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, martin@kaiser.cx
Subject: [PATCH 05/15] staging: r8188eu: remove RT_TRACE calls from core/rtw_io.c
Date:   Sun,  1 Aug 2021 20:04:27 +0100
Message-Id: <20210801190437.82017-6-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210801190437.82017-1-phil@philpotter.co.uk>
References: <20210801190437.82017-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RT_TRACE macro calls from core/rtw_io.c, so that ultimately the
macro definition itself can eventually be removed.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_io.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188eu/core/rtw_io.c
index 2c8e7707c9fa..5e3a190d319e 100644
--- a/drivers/staging/r8188eu/core/rtw_io.c
+++ b/drivers/staging/r8188eu/core/rtw_io.c
@@ -182,12 +182,8 @@ void _rtw_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem)
 	struct	intf_hdl		*pintfhdl = &(pio_priv->intf);
 
 
-	if (adapter->bDriverStopped || adapter->bSurpriseRemoved) {
-	     RT_TRACE(_module_rtl871x_io_c_, _drv_info_,
-		      ("rtw_read_mem:bDriverStopped(%d) OR bSurpriseRemoved(%d)",
-		      adapter->bDriverStopped, adapter->bSurpriseRemoved));
+	if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
 	     return;
-	}
 	_read_mem = pintfhdl->io_ops._read_mem;
 	_read_mem(pintfhdl, addr, cnt, pmem);
 
@@ -216,12 +212,8 @@ void _rtw_read_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem)
 
 
 
-	if (adapter->bDriverStopped || adapter->bSurpriseRemoved) {
-	     RT_TRACE(_module_rtl871x_io_c_, _drv_info_,
-		      ("rtw_read_port:bDriverStopped(%d) OR bSurpriseRemoved(%d)",
-		      adapter->bDriverStopped, adapter->bSurpriseRemoved));
+	if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
 	     return;
-	}
 
 	_read_port = pintfhdl->io_ops._read_port;
 
-- 
2.31.1

