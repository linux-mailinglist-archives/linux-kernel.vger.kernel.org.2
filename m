Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF1E401FB3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245673AbhIFS2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244680AbhIFS0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:26:39 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2AAC0613A3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:25:30 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id i21so14991900ejd.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vh8+u22pNgFmmQDYhuLqazbVUqiifTDWeSKfb70Q1zQ=;
        b=O7iaNXjAyAdSfQOeZ235n6Iwh7TV8emA5/xwuHfKB+9Z6AOtgzxpSCa5tz26CSpbLc
         3ws8oRW6+1CUHyPnWMEzTQM2i0vDMjw9JnzTlE7HNf4c7KDk842H5U+sO9YrpRzNe0ln
         Wv0xind7WJ/ngmOENF84ClD4vombWRezezq6p5/r1Ao/zhiuuVYmSH8kviqUCn4UHRlL
         pOzdLQzmNx7TPxZMnch8G2tMwFKI1DQhpO5hWZOTXHA4ATOGDDTBCKWmDI63K5oxZaoh
         ncwAAIhgIH1M4kFIdc0DlJCOnp3ZtgvHUBRgc7/xiyCspGpkZSiAiok6b/7sonv8OtC/
         vOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vh8+u22pNgFmmQDYhuLqazbVUqiifTDWeSKfb70Q1zQ=;
        b=LZ3dl32eBlYjmI44YJ1QVnJDpDxXGg/z8rUSgOVwW9Me4hPS7rDUky/w0Z1n/9f5Ka
         ayt8M3rgEHZos8Aea5jVDabuEkKuHLNQVezEm3ofRSGV5dXzQlGgp2ezleDk7znfErfD
         FvqvJU8ArmO5z/NCYTjGw7HRn20HPMDtNkz1zyT0eCTNF26o9PChO4sFtiY7GV4Vs/Gg
         gQ1QKgCLEIKXoSfi5NjZxmT6Kb+yKA4+zmv4LZ+MbQU3I4AGNM7ccAqTkw4EBXylQcSb
         rDIDwo99izF04yH5wp12w+A55DcRAyFnWpxxJqIuG/mqMtxCgZoWgjK5DCpqxK64F1Ri
         y6IQ==
X-Gm-Message-State: AOAM531TgiHyoXrCsBOdLVULzVmtFkByUugNf5z8JQckdOzWGKDeis4V
        8edmrQW70QQFrlRSoeI5mMQ=
X-Google-Smtp-Source: ABdhPJzr3lLkgvFVvAE1uTKJKGgTgdFJse9iVERPnG0aDKOIYUHHOx8IUVero7+FYU7YUT7JDcbqyw==
X-Received: by 2002:a17:906:7d83:: with SMTP id v3mr14811979ejo.216.1630952729435;
        Mon, 06 Sep 2021 11:25:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id s25sm4284492ejq.17.2021.09.06.11.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:25:29 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 38/40] staging: r8188eu: remove unused function rtl8188e_clone_haldata()
Date:   Mon,  6 Sep 2021 20:24:36 +0200
Message-Id: <20210906182438.5417-39-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906182438.5417-1-straube.linux@gmail.com>
References: <20210906182438.5417-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused function rtl8188e_clone_haldata().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 5 -----
 drivers/staging/r8188eu/include/rtl8188e_hal.h  | 2 --
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 22750cd40d45..760ca114a7cc 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1741,11 +1741,6 @@ void rtl8188e_SetHalODMVar(struct adapter *Adapter, enum hal_odm_variable eVaria
 	}
 }
 
-void rtl8188e_clone_haldata(struct adapter *dst_adapter, struct adapter *src_adapter)
-{
-	memcpy(dst_adapter->HalData, src_adapter->HalData, dst_adapter->hal_data_sz);
-}
-
 void hal_notch_filter_8188e(struct adapter *adapter, bool enable)
 {
 	if (enable) {
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 40bc00a9b23b..13217789d495 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -438,8 +438,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc);
 
 void rtl8188e_read_chip_version(struct adapter *padapter);
 
-void rtl8188e_clone_haldata(struct adapter *dst, struct adapter *src);
-
 void rtw_IOL_cmd_tx_pkt_buf_dump(struct adapter  *Adapter, int len);
 s32 rtl8188e_iol_efuse_patch(struct adapter *padapter);
 void rtw_cancel_all_timer(struct adapter *padapter);
-- 
2.33.0

