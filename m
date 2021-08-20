Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233803F3201
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 19:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbhHTRIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 13:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbhHTRI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 13:08:27 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95A2C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 10:07:48 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u22so21873891lfq.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 10:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xto8qI/A0qQwPlLzT2V7ZQFopod8JkuGsvPAgnxJwEo=;
        b=sZX9mQlvWM5DHaDz0Z4tP6sv7vieFMGNTfCO+oZLi/wnEmvbmvXI/MYtjs/T4QyB94
         QVvVFoXSvBpsI24mCxEvsAC+w/zmONjHCrTXehlHU6NcAb14GQg5/xKvrpMdCoeEradO
         mvQbXduaPA7qW2nqsMBhl/y16kGrocJv116FVQhaNIDhmXau3vHJzjE/aSY9CjpDebwQ
         TUIiS/UfKJMEgqVCzm2lry1Pv1jQaOsvLTIYgcZv4DW5eeVc3YuRaMERKv3jcnUSSjcw
         1ZoLFkRDqIvyno5NP753axHv3HnqoGXtNVdgIvbzPOgv6XHBueciZWGm1+jv46/+ePBa
         N0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xto8qI/A0qQwPlLzT2V7ZQFopod8JkuGsvPAgnxJwEo=;
        b=YuveqteRcB5WCR4gIsByGI/1TDpgxve4K3+I9VPG+q3S3uQMcKmjE5nJ00s18UGOjN
         XmPx2/4+jw191RndHHWrPr+lvHmBMPltT79E7YeDWFB4MjO1ybm9v2HcqafaHUkNbIjj
         oJg0UKC1U6Um+T7n8YNUMRtTB4y66e6xqQGPOtyo3u5NV7MQCDuuVwqxoc65Y4YF0GPe
         vWf9qNqk9McIQNXqtPGC1bvMKc5PmAdol3Z2S88zfk1GnUoLzkprplvHoeb1L6RtKAlO
         UfP0jL06OE5g7+E2XyP7iT+mVPz2yCYkxbYUHhe2ESqYzZSDdkWqt05D1j0pwx/n64ne
         qCJg==
X-Gm-Message-State: AOAM530qJOp8nrmsPlorlqlqJZbL9+G3zZD3HUgsS61dDwDhHaxN1Fon
        yiePdfX9cTDKiClpYuUIWiU=
X-Google-Smtp-Source: ABdhPJwpcIAZddPmjibeCGb0eMU0n6HW2yPMae4zk4lUBbvVTKS/lyMRXdpp/9aCOYUip6yFlQ/b0Q==
X-Received: by 2002:a05:6512:21c1:: with SMTP id d1mr14915539lft.21.1629479267235;
        Fri, 20 Aug 2021 10:07:47 -0700 (PDT)
Received: from localhost.localdomain ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id g17sm674906lfv.34.2021.08.20.10.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 10:07:46 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH RFC 3/3] staging: r8188eu: add error argument to read_macreg
Date:   Fri, 20 Aug 2021 20:07:45 +0300
Message-Id: <44a5a4ab2eae8e0deb969028a5488ea892008c8d.1629479152.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629479152.git.paskripkin@gmail.com>
References: <cover.1629479152.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since read_macreg() calls rtw_read*() internally we should tell
callers about an error on the read side.

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mp.c    | 9 ++++-----
 drivers/staging/r8188eu/include/rtw_mp.h | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index 601a1fd5d4e7..6bbea1cc364a 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -7,20 +7,19 @@
 #include "../include/odm_precomp.h"
 #include "../include/rtl8188e_hal.h"
 
-u32 read_macreg(struct adapter *padapter, u32 addr, u32 sz)
+u32 read_macreg(struct adapter *padapter, u32 addr, u32 sz, int *error)
 {
 	u32 val = 0;
-	int error;
 
 	switch (sz) {
 	case 1:
-		val = rtw_read8(padapter, addr, &error);
+		val = rtw_read8(padapter, addr, error);
 		break;
 	case 2:
-		val = rtw_read16(padapter, addr, &error);
+		val = rtw_read16(padapter, addr, error);
 		break;
 	case 4:
-		val = rtw_read32(padapter, addr, &error);
+		val = rtw_read32(padapter, addr, error);
 		break;
 	default:
 		val = 0xffffffff;
diff --git a/drivers/staging/r8188eu/include/rtw_mp.h b/drivers/staging/r8188eu/include/rtw_mp.h
index b64b16554343..c063e6216249 100644
--- a/drivers/staging/r8188eu/include/rtw_mp.h
+++ b/drivers/staging/r8188eu/include/rtw_mp.h
@@ -410,7 +410,7 @@ void mp_stop_test(struct adapter *padapter);
 u32 _read_rfreg(struct adapter *padapter, u8 rfpath, u32 addr, u32 bitmask);
 void _write_rfreg(struct adapter *padapter, u8 rfpath, u32 addr, u32 bitmask, u32 val);
 
-u32 read_macreg(struct adapter *padapter, u32 addr, u32 sz);
+u32 read_macreg(struct adapter *padapter, u32 addr, u32 sz, int *error);
 void write_macreg(struct adapter *padapter, u32 addr, u32 val, u32 sz);
 u32 read_bbreg(struct adapter *padapter, u32 addr, u32 bitmask);
 void write_bbreg(struct adapter *padapter, u32 addr, u32 bitmask, u32 val);
-- 
2.32.0

