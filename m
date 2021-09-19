Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52DC8410C2E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 17:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbhISPjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 11:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbhISPjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 11:39:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18C2C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 08:37:39 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u15so24142887wru.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 08:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qxOyobLZn5i5+ghXkOmiy23gp8zoW0xgzcmJjVSUJjc=;
        b=RDQXPy7kcxIwgzVAYeEmDc/Zr3Tsf0x7SowPNr9khcD6znlVcCST6QV6H4tvEnKWJz
         +NQqXXJ8Ng6Q92u7yL/9JQBMuP/ANsJx8pVubeMAcRCOdkiO/9XUuTHfi8p5PIs99L/K
         oiKavx6kNMdKvMQ3wu3PG57t6797nxD28mpMYgIfDefnxqyB5rZj7Zo0c2vq2BnYDJEO
         WEgOWztg98TPfrWTnJBWbBOKAxkxd+Lfrjda7t9TStVyWXQxU9CBP5T5VHBT4n71hNwc
         qGq4oc+k0NFl9yRZOO/AB0VTPIL1e9CrcSV3Vv93PZVraeAceWXKZB087rpAmrSiNdfP
         DX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qxOyobLZn5i5+ghXkOmiy23gp8zoW0xgzcmJjVSUJjc=;
        b=qmmzIN/HSioq0wy6uM7QyPiOk43t9lIMh5ikOHzkOxvl2+Um3wE3lAldb8c5ZN9rky
         ibYYcD7NB+yc3ivU8Rlu13u3qoNVYPStqvGbzMsAYuSiCaIhgo26pGwJh1dpgO6nOp9p
         KTY5sIGA203MP0MziK4HW9Fz28wX+9IRVGZE9wLcDZZTh9FqFvsxG88JGxn6hSJTL6Gk
         c2R7pTGfArybqhsSeG0J8wJFNm1KZM6SF1ld6/Vnlv0F9ZZE+xJ9gN4B7PwrzSd9dPHx
         1kcy4xVvUrJuLBgXZ0NV2kVZVitIEyzQGnWLRpqViCi4l3PyhYBzgetFUEPo0iLtEAXb
         j8Ug==
X-Gm-Message-State: AOAM5329FKuQZ+FEh4yWa8h3FAO1dgF91WI4TzQ1KpF+tURPcQTiz84j
        so/EZWwTNsYHE44BomfF/T8=
X-Google-Smtp-Source: ABdhPJxD8UjgldRY+3Q95jeOI/NWh949OBuYzQdHN0t8XX/Z+eZQS+cdb8qssFMaxcT4Nlf01by15Q==
X-Received: by 2002:adf:ce84:: with SMTP id r4mr23813135wrn.107.1632065858458;
        Sun, 19 Sep 2021 08:37:38 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id l15sm16614501wme.42.2021.09.19.08.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 08:37:38 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/6] staging: r8188eu: remove ap_sta_info_defer_update()
Date:   Sun, 19 Sep 2021 17:36:54 +0200
Message-Id: <20210919153659.20826-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919153659.20826-1-straube.linux@gmail.com>
References: <20210919153659.20826-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ap_sta_info_defer_update() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c    | 9 ---------
 drivers/staging/r8188eu/include/rtw_ap.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index b265de3ff88d..49d65d5b3bac 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -1731,15 +1731,6 @@ void sta_info_update(struct adapter *padapter, struct sta_info *psta)
 	update_sta_info_apmode(padapter, psta);
 }
 
-/* called >= TSR LEVEL for USB or SDIO Interface*/
-void ap_sta_info_defer_update(struct adapter *padapter, struct sta_info *psta)
-{
-	if (psta->state & _FW_LINKED) {
-		/* add ratid */
-		add_RATid(padapter, psta, 0);/* DM_RATR_STA_INIT */
-	}
-}
-
 void start_ap_mode(struct adapter *padapter)
 {
 	int i;
diff --git a/drivers/staging/r8188eu/include/rtw_ap.h b/drivers/staging/r8188eu/include/rtw_ap.h
index c7cdab00538d..11e6f799d577 100644
--- a/drivers/staging/r8188eu/include/rtw_ap.h
+++ b/drivers/staging/r8188eu/include/rtw_ap.h
@@ -30,7 +30,6 @@ void associated_clients_update(struct adapter *padapter, u8 updated);
 void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta);
 u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta);
 void sta_info_update(struct adapter *padapter, struct sta_info *psta);
-void ap_sta_info_defer_update(struct adapter *padapter, struct sta_info *psta);
 u8 ap_free_sta(struct adapter *padapter, struct sta_info *psta,
 	       bool active, u16 reason);
 int rtw_sta_flush(struct adapter *padapter);
-- 
2.33.0

