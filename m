Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B789744B524
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 23:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245261AbhKIWK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 17:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245214AbhKIWKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 17:10:23 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C551C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 14:07:37 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id p18so1062730plf.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 14:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M2qdUNiBEBQDeK0BjbS3vsx6fFE75Q9hfv1+Lcc9xKI=;
        b=eKyfJx4ekZ7PKZ/Tla5faumT+492L4SC54+KYXAkhQAcdzW22mIf2s9kWFbED2yOj0
         Kg5Cn5Fn01+GxO79KBfrOxbEAkoRJfB25dR2RHQD2qKWXZVBvLIY5wTW5YOxLb2cFyb4
         /3ELMtkgqgdc1L6CD3Z+yKp94HSgFH5VwtJFzLHdG89v0qwISM3Nnc9LCqyeQ8/7r0vs
         JisKCKBVn/3bpn3bUpBZebr05rKiDooEYveat59RjfsiZTYW8IRSbHi4uB4DzoDOGBl+
         ZLCoZuc+wgqwP6VG6jKGvKTT9Gacq6ZSejHgky3zeioEgoH1gjbre5c5eUga70/9z2wR
         zLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M2qdUNiBEBQDeK0BjbS3vsx6fFE75Q9hfv1+Lcc9xKI=;
        b=WO1SXzuiEBkrPe0198RTV1mU1jKEIeqCgnb438uylgUiqBjL8HzcLr61R0nujA8GZ1
         AO1Z5pkfpejXBGthwJw2B8SQ51GrVX91/XDLoHvqTuWcFKgYPbTR12/xiPDi9FF/jv/5
         mYO0WusSvJxt2Wor1Sxj1Q/bYoJTMy85aaIsOhH/Y4mvoRtW6g2xnfVhxdPqJoD+7f92
         hRbaAI9JlBAsmx//0fDUd+y7YDzILcDRwlNn2kVyokc9pGpn+0tbfSuPCzkiJilsUNO5
         9JRHuxPmgIF42ClW+NWlYPAlTUEPIC5Y3Ij2K2O9bICOoKalR+JQ4va+23OSkf9DnbGm
         gOkQ==
X-Gm-Message-State: AOAM5305Vig7A3DDtSj8CrdEaqT5iwEH/lcah61e0MQK3x4afRQE00CP
        MFbxHC5iy0i9n7m8D4Wqz1mZDoYB+q0pMGiN
X-Google-Smtp-Source: ABdhPJzgmkyJPbY+SnYexa4HTcdeCtfp+gbvf7WqTezcXpy3HRG4A9ofKpesggnd2wwr4fO2QHFdrg==
X-Received: by 2002:a17:90a:4fa1:: with SMTP id q30mr11094832pjh.12.1636495656765;
        Tue, 09 Nov 2021 14:07:36 -0800 (PST)
Received: from thinkpad.localdomain ([2804:14d:5c21:92d0:458e:ac7b:f0d6:7ef4])
        by smtp.gmail.com with ESMTPSA id y130sm14494685pfg.202.2021.11.09.14.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 14:07:36 -0800 (PST)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     ojeda@kernel.org
Cc:     linux-kernel@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v2 2/2] auxdisplay: charlcd: checking for pointer reference before dereferencing
Date:   Tue,  9 Nov 2021 19:07:32 -0300
Message-Id: <20211109220732.7973-3-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211109220732.7973-1-sampaio.ime@gmail.com>
References: <CANiq72kgm-5CidoN8VRLnWokiDSWsQcMFbaUd4WKOnbPsON9RQ@mail.gmail.com>
 <20211109220732.7973-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if the pointer lcd->ops->init_display exists before dereferencing it.
If a driver called charlcd_init() without defining the ops, this would
return segmentation fault, as happened to me when implementing a charlcd
driver.  Checking the pointer before dereferencing protects from
segmentation fault.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 drivers/auxdisplay/charlcd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index cca3b600c0ba..6d309e4971b6 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -578,6 +578,9 @@ static int charlcd_init(struct charlcd *lcd)
 	 * Since charlcd_init_display() needs to write data, we have to
 	 * enable mark the LCD initialized just before.
 	 */
+	if (WARN_ON(!lcd->ops->init_display))
+		return -EINVAL;
+
 	ret = lcd->ops->init_display(lcd);
 	if (ret)
 		return ret;
-- 
2.33.1

