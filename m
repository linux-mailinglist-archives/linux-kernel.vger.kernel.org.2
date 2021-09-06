Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F6E40204A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 21:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244994AbhIFTHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 15:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbhIFTET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 15:04:19 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913C6C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:03:14 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a25so15139567ejv.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 12:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vh8+u22pNgFmmQDYhuLqazbVUqiifTDWeSKfb70Q1zQ=;
        b=cfc0Thrf2j2pOl8FE13UIBaQct9YV6FwfNyxC+NVP5afcFm7UTerlLIU9ijGdePISP
         PrBcyRbeOSRSGyImBErOFQoNHuWOvMv9MBwhTAmaekXSMjK+meWS3T6QP9m2tkdeI7f7
         +Iqrw1/XMemAwBJcw303MY1b8ywCzQIGNndmTJcOX0WgXNwvSbJQ2f0yP2FopoPBqJ80
         xPQYtZxeZHkuxpRpt+Zw5qYeMXweChTkQ1EzlGwxYRunB8t+IW5kWLYmSc+Se1ePViFg
         0u05mGdm/o9oJCWsfye+mUi4zqBTCnoUHQbEnrtWbO7jbFJD39uuU2WbNfeA1aIc4dMP
         OwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vh8+u22pNgFmmQDYhuLqazbVUqiifTDWeSKfb70Q1zQ=;
        b=WRjiNs7p1A6C7SdOTVkyUZqwW+BW6vQxlZtt6umBEUQeRcBypxKFHHUUm2O41zGfLb
         vEgXalmkm0DZsatwCKTmExYs/P2F9QWdKk0I4qrxetrT9x73NPcJ81RVJgPD3aiLzJ4t
         Eb9o2/PYv/hM4DSEbNH0P9KHnUCrsIIPNm+MFaymTEMkqHvKTp6DvCotp+I8FHKRpdWw
         Je3g3PGHwVEekb1unb5eKbf3eXLff+yvm+zAsUduSIaAkGXBU9wC1O2CJPQs6u0dAkKl
         R/fp/yHszmOSmMF8eEZl/HEdyUtpf4QMkZv3YcVye+YjMwg4uEIPP70GekEddE3yawZa
         s+cw==
X-Gm-Message-State: AOAM531SETfrZbs013Nb/vF7tgkwYQOlAT6yp1pQU6IWyRUjyJo5No4J
        pcj8Tm/L69TJrkPCcx64QEs=
X-Google-Smtp-Source: ABdhPJx48kPMGUexlOkKBIiA68bGTTj0uOc0lKGIAQ90TSy1X6dPnvmGnHVPWgtOgmnlTsuWBRh4sw==
X-Received: by 2002:a17:906:6dcb:: with SMTP id j11mr14799311ejt.202.1630954993216;
        Mon, 06 Sep 2021 12:03:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id k15sm4372018ejb.92.2021.09.06.12.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 12:03:12 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 38/40] staging: r8188eu: remove unused function rtl8188e_clone_haldata()
Date:   Mon,  6 Sep 2021 21:02:21 +0200
Message-Id: <20210906190223.11396-39-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906190223.11396-1-straube.linux@gmail.com>
References: <20210906190223.11396-1-straube.linux@gmail.com>
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

