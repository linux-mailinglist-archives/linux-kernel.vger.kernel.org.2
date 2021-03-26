Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F36A34A9F7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhCZOfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbhCZOfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:35:15 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A633EC0613B7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:14 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id a132-20020a1c668a0000b029010f141fe7c2so5061916wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dvVvI/0Wq9ZseHcmz0Zvsivscrc/Hml5KLcDLhGdq8Q=;
        b=smSaR1uiakul9vdqFvb9YgWh4OKhF08d0JzTod+aEWKDwhNZ6k/TlFu7fQQqBT/dNL
         6v/A7fm6GfMpe1sLSb3EOLBAxdueMEarsWLtFaCtU5JUSVMjEmHFyKdqt1WwyIfLZBFC
         o/RIgx+ip27kU87XZiVWR7sSNx8PtdFMEXAtBqJwwBvvif8G7FYB9hFXSaxYfZv3wFOY
         Ak0PH0KPxED+JSpAW5hJVgI41p8fGlU8WLrOXbY/qA8C/WOyo35qSHuKPjRknUvLFRTt
         O4yNxlLhO4pMB7I0jrLUgLcp+yGCpYZgrK0PvCEzx3eAI4/TKVw/LN9y+cEO0LRdjpWc
         kefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dvVvI/0Wq9ZseHcmz0Zvsivscrc/Hml5KLcDLhGdq8Q=;
        b=tX5WICWWM4/DepYnfvWkPMVY2jmzaftfC1aiJEKgQN8/wFFWhKHoEY+1YoguIYIF7m
         O7upaVKzhU8TRDYDPPmWUUB+47OBr/Ap+uzr4AN93HXkwyjING6kOGkw9H8Kj5Armppk
         /oQtkReK0MjyiTcaqLF+3C64A2QmpUDXLoXf5U/vkQZASng7uH4Cnk2T9QTxQQo6IknQ
         ueF/kVbqHMmBJg2fb/02twO+2aHFD7ZNBJMwXRXIGWNxxq/KnSGSVcxZENXFbx9hPKVV
         3VakAVp9kLsSRmb7D595/pMoVSLqvPEmhC9cWMc3H2vCOL8Mz0b4Cy253NGbeufGTiOU
         ZIVw==
X-Gm-Message-State: AOAM5331rekB38yK1Nb0pqzMsecT4q+sJza+We9dEph6rpi8cysEommj
        1mbyCbj2sqmb0x9W1ENty9y9yg==
X-Google-Smtp-Source: ABdhPJy4cPgeUtt+hXmAcmdBV050qDTDvNCgcfFSBylDcvsoPURbP7UhNazAD0cKIvwyFp+F1SIuHw==
X-Received: by 2002:a05:600c:19d1:: with SMTP id u17mr13278235wmq.141.1616769312972;
        Fri, 26 Mar 2021 07:35:12 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id j26sm12878225wrh.57.2021.03.26.07.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 07:35:12 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Vojtech Pavlik <vojtech@suse.cz>,
        Michael Haboustak <mike-@cinci.rr.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 11/25] HID: hid-core: Fix incorrect function name in header
Date:   Fri, 26 Mar 2021 14:34:44 +0000
Message-Id: <20210326143458.508959-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326143458.508959-1-lee.jones@linaro.org>
References: <20210326143458.508959-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/hid/hid-core.c:2142: warning: expecting prototype for store_new_id(). Prototype was for new_id_store() instead

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>
Cc: Michael Haboustak <mike-@cinci.rr.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/hid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 097cb1ee31268..0ae9f6df59d10 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2129,7 +2129,7 @@ struct hid_dynid {
 };
 
 /**
- * store_new_id - add a new HID device ID to this driver and re-probe devices
+ * new_id_store - add a new HID device ID to this driver and re-probe devices
  * @drv: target device driver
  * @buf: buffer for scanning device ID data
  * @count: input size
-- 
2.27.0

