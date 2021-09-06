Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FD740202A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 21:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344341AbhIFTFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 15:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245493AbhIFTEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 15:04:00 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B658C0613D9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:02:55 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id i6so10662559edu.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 12:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lURT0bL/Ua3DL+p4fVIfhBItarDnpsIG5IN7GeJbB/Q=;
        b=aChiEZWVp3PwDKNCjzgrRAjXsk/tuCzpDMkgwoV0iX7fpzQIFOsOpBltOKxqlBbg8c
         kCkgCuZsmrq87reIL6Y7Abp6jYxELdDxHquGp6I5tMxUKzn98mpyOXXNmwtXEMPejRCe
         CxrHqPI7huitwFkiScseeU1rSwxHd9XaCLc/ayQCf2zAjKM7HTkLg/y2b1RWfOe9mXfC
         Ff6PYenRipq+qp7Bx2sCh3PQimu1ytPk77BSDYnJolqdUzssQPzt896nbrI4j3gEJX58
         zMTExMb1gGTu64BSs6e8bh9pDbPLAvaZPMzdmoCvCpxC4DJmqN3oF7Y4wCpOS1rWuV+B
         4GwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lURT0bL/Ua3DL+p4fVIfhBItarDnpsIG5IN7GeJbB/Q=;
        b=uTDk0ayvrDQpTQ7ZCdtDWA64CMqhAwGs80TXH9d1LjPFOKq9ID9Beiy8AmjFdX2XMV
         hSdIDMDoU9XzACSW7q+Apjl4qs47AdHHetcgR6vscglFm5TLteQjARl9EXyZ9jLn+cT8
         733UDF2gDN+KwbrJ0liMC1gQP4wFIqCM8duRKGRC8Ul+0eYezMqVvQxG2CW+of0QULdZ
         SmgwEcpxJZlzINvXGO72Mqm2NtRBxUzafi65J53tGJx+LCBfcJSE7dzFBYoW3ZfhtbI1
         0IwVQHFOYwqIM4Y87dbOCvKi+zCZMTNe969o5eXCV6y2QM8L6J+3O0UJ5d8/PWQ2BWhT
         /d/A==
X-Gm-Message-State: AOAM533V5oqU9JqMF2Qp4Y+SR/pOUuule2jfkMCDvgEqGlzq9VwVmZST
        n+Ff38PvQGuFb0BbLiyNuDc=
X-Google-Smtp-Source: ABdhPJxrCO/6K4O4x3PnLW/quSxv+YM6ch+/cx1KI5mXLM6lxtfFB1nvxGME5UgFrxr9Rvb1JvGPKQ==
X-Received: by 2002:aa7:c882:: with SMTP id p2mr14579275eds.46.1630954974250;
        Mon, 06 Sep 2021 12:02:54 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id k15sm4372018ejb.92.2021.09.06.12.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 12:02:53 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 12/40] staging: r8188eu: remove unused enum hal_intf_ps_func
Date:   Mon,  6 Sep 2021 21:01:55 +0200
Message-Id: <20210906190223.11396-13-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906190223.11396-1-straube.linux@gmail.com>
References: <20210906190223.11396-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HAL_USB_SELECT_SUSPEND and HAL_MAX_ID are both unused,
so enum hal_intf_ps_func can be removed.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/hal_intf.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index eab0b8576c92..3bf0d18e2ba8 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -121,11 +121,6 @@ enum hal_odm_variable {
 	HAL_ODM_WIFI_DISPLAY_STATE,
 };
 
-enum hal_intf_ps_func {
-	HAL_USB_SELECT_SUSPEND,
-	HAL_MAX_ID,
-};
-
 typedef s32 (*c2h_id_filter)(u8 id);
 
 struct hal_ops {
-- 
2.33.0

