Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5413ADB30
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 19:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbhFSRyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 13:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbhFSRyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 13:54:04 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F196C061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 10:51:51 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id s6so13000132edu.10
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 10:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aGbz56H8ujbUDesy1/oT8I6SQUEMIvYV/AjVeEK4diU=;
        b=RFXr7S9jv2q6G4nXNWmwTF/d06A2om1azDDaVj46MDaDAMln+jhQNl9SSUcdkJ4QHo
         x0ZnTfUv8kquYonGLZ+NRrNAtqHe6YOriVQuIwA2d71wBqtJ5FO6RhIu14Ck4LJql8Vj
         XdOfVXHlxg91xQiDikqxyIw77KuNlNyX3cEyNeTgMM0eGvO03yyufZJXV4+uYwqB+jHq
         58cYahFLVLALbngvvGJlhSyJf4M/veKtUGJYcmfAfr89SbqCZMNZ+bFDtAgK3a1CFL/m
         QXA+5QE8NTYqJ+mldK+viXjQeMdQGJ//9OmWqtcIJSpZzxI0t8GUt+/zlDTwSQM8oER2
         NJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aGbz56H8ujbUDesy1/oT8I6SQUEMIvYV/AjVeEK4diU=;
        b=K1o8a5b2U1BEzHBCDa54hjagxFDKPurY05ZXCwT2/XHwmEJTs6YufsJInyasW8EhmY
         gk6xrrP2A6Vs3sIIdGmETqIns42Sn2RJ69sfrd8jCh6UJXXYM7k0HkZD+PhUAVqZvobC
         aetVT+yp4AoRNR8mbsppu/zBXwz4dzfBTEeZldCcks1+yLM25eB9wSoIwa9svysvcnUH
         Weg+IahpB/TfAOwS9n0RPjTh9BZguUZbrPgStdojfC7qidy8YLbIMsfYsjlT/aTzwihZ
         UgtCxCrH2fQZXEv9yCknmKgfrq5H3ox68rxTkgaPJWJUJomZbkMexm1oEX6mrK3T0OWw
         B+OA==
X-Gm-Message-State: AOAM530PdHT78U9IQIxH49WLyQYPxWVRdo1nUbeJ6AnLZVR0CFFiE7ny
        ezPnJ+tPcEE1Dq+qgenrfBg=
X-Google-Smtp-Source: ABdhPJyKk2RnEPNGJ3SuGvoYgX2qdYyaPrYa+QO0Ke2wDUFj6O6RzW75Zq/I/aS6GD5fSMg/Ndr6sg==
X-Received: by 2002:aa7:c04e:: with SMTP id k14mr11439392edo.157.1624125110116;
        Sat, 19 Jun 2021 10:51:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::1264])
        by smtp.gmail.com with ESMTPSA id s20sm5459428edr.50.2021.06.19.10.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 10:51:49 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, martin@kaiser.cx, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: remove useless comment
Date:   Sat, 19 Jun 2021 19:50:55 +0200
Message-Id: <20210619175055.5122-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove block comment about function HwSuspendModeEnable92Cu.
The comment contains no useful information and there is even
no HwSuspendModeEnable92Cu function in the driver code.
'git grep -n HwSuspendModeEnable92Cu drivers/staging/rtl8188eu'
returns nothing.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/usb_halinit.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index dcdf868b394d..6c88675ae251 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -601,22 +601,6 @@ static void _InitAntenna_Selection(struct adapter *Adapter)
 		haldata->CurAntenna = Antenna_B;
 }
 
-/*-----------------------------------------------------------------------------
- * Function:	HwSuspendModeEnable92Cu()
- *
- * Overview:	HW suspend mode switch.
- *
- * Input:		NONE
- *
- * Output:	NONE
- *
- * Return:	NONE
- *
- * Revised History:
- *	When		Who		Remark
- *	08/23/2010	MHC		HW suspend mode switch test..
- *---------------------------------------------------------------------------
- */
 enum rt_rf_power_state RfOnOffDetect(struct adapter *adapt)
 {
 	u8 val8;
-- 
2.32.0

