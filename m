Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EE0326F1B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 23:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhB0WD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 17:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhB0WD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 17:03:27 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB13C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 14:02:47 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id t29so8633289pfg.11
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 14:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Mkan3JMKfxNYoG4rfnYGH7/Pk2eAhI86Q13ePVKjnns=;
        b=eNqSPEdxIXv9OuBgPovuLgvUXqAWiHNqCy2dXA2hJknCs9ip6Hid0bct5xs6iy1c7A
         qlf965G4LIVWKiwNF6RThNzAXC+fZdbrDT3483nvJUs0qGT9ZaHAA0C8juk666CZ6Tzu
         6Qj0Q38Ndw1KYdYZgq1qzVerq+chh0xwwd2suqGLwM6Fx653hY256+hsz9SL2/DWaUbS
         RDocK+/nO/yOLzc4ZSLinhmH4yA1TZvQeM+nQ6y8SROnfJGt3tZbCVQKyUqPeBT4npZi
         0EL+Zn24dI+HP6wSK1DhMBsSf8axOner+ISIUJP4dl8CBz7wWcuEVcxWTJRjag9qeOmt
         Qc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Mkan3JMKfxNYoG4rfnYGH7/Pk2eAhI86Q13ePVKjnns=;
        b=J50mOpiM2GllznqZRFUDgCurlnHs7DNkNtKMjNY3JsKIIZVmzX+IZ1PchUmNpbU/QM
         gvqWt5O7RLghkFZUyrSXqawwQcH9wEhmiw7R0zjV98d77SXxWC+uUtWkcNF9MOlyvzgw
         n0EATX501tIKOKtO8AcWguHWkfraa6b80yr3Gzc9S/bqppqx4+8QhbDMBO7l3kAn39zx
         8REKDWWDt9b1JRzRstkMrQG1qd1z7wZ6S8zEBbvOEPn9cBbyOMa6qJ1acQfiTuUFPQxI
         KGQa5GO/Cmbsbu7TUUrcxEqtYR3UbUEEgzCvkP2bfqh3ndeBoWqqBVrn6W9iaCFO3lt1
         Cr3w==
X-Gm-Message-State: AOAM5327/bHEpjYgAcvM88AjqgH51D/bxVmeMk+Tlin1dpK5ukyRLNg5
        A1QdjqGmhLfqS4xe9l1c4m8=
X-Google-Smtp-Source: ABdhPJyxzOdFcXfruhFLvm1j36aKPw2ycDWIEr+Ao1x1so7V6nulUMlQ2PSkvaXT47diGhYo8Eyrpw==
X-Received: by 2002:a63:580d:: with SMTP id m13mr8039461pgb.342.1614463366866;
        Sat, 27 Feb 2021 14:02:46 -0800 (PST)
Received: from rayare.domain.name ([106.51.141.71])
        by smtp.googlemail.com with ESMTPSA id z13sm14293258pfk.178.2021.02.27.14.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 14:02:46 -0800 (PST)
From:   chakravarthikulkarni <chakravarthikulkarni2021@gmail.com>
Cc:     chakravarthikulkarni2021@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fox Chen <foxhlchen@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: Fixed indentation and coding style
Date:   Sun, 28 Feb 2021 03:32:30 +0530
Message-Id: <20210227220233.10259-1-chakravarthikulkarni2021@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This clean up indentaion issue as well as coding style issue.

Signed-off-by: chakravarthikulkarni <chakravarthikulkarni2021@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_cmd.h | 30 ++++++++++-----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_cmd.h b/drivers/staging/rtl8723bs/include/rtw_cmd.h
index 56c77bc7ca81..3545a98ef94e 100644
--- a/drivers/staging/rtl8723bs/include/rtw_cmd.h
+++ b/drivers/staging/rtl8723bs/include/rtw_cmd.h
@@ -678,13 +678,13 @@ struct setratable_parm {
 };
 
 struct getratable_parm {
-                uint rsvd;
+	uint rsvd;
 };
 struct getratable_rsp {
-        u8 ss_ForceUp[NumRates];
-        u8 ss_ULevel[NumRates];
-        u8 ss_DLevel[NumRates];
-        u8 count_judge[NumRates];
+	u8 ss_ForceUp[NumRates];
+	u8 ss_ULevel[NumRates];
+	u8 ss_DLevel[NumRates];
+	u8 count_judge[NumRates];
 };
 
 
@@ -786,7 +786,7 @@ struct TDLSoption_param {
 
 /*H2C Handler index: 64 */
 struct RunInThread_param {
-	void (*func)(void*);
+	void (*func)(void *);
 	void *context;
 };
 
@@ -795,14 +795,14 @@ struct RunInThread_param {
 
 
 /*
-
-Result:
-0x00: success
-0x01: sucess, and check Response.
-0x02: cmd ignored due to duplicated sequcne number
-0x03: cmd dropped due to invalid cmd code
-0x04: reserved.
-
+*
+*Result:
+*0x00: success
+*0x01: sucess, and check Response.
+*0x02: cmd ignored due to duplicated sequcne number
+*0x03: cmd dropped due to invalid cmd code
+*0x04: reserved.
+*
 */
 
 #define H2C_RSP_OFFSET			512
@@ -824,7 +824,7 @@ struct sta_info;
 extern u8 rtw_setstakey_cmd(struct adapter  *padapter, struct sta_info *sta, u8 unicast_key, bool enqueue);
 extern u8 rtw_clearstakey_cmd(struct adapter *padapter, struct sta_info *sta, u8 enqueue);
 
-extern u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network* pnetwork);
+extern u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork);
 u8 rtw_disassoc_cmd(struct adapter *padapter, u32 deauth_timeout_ms, bool enqueue);
 extern u8 rtw_setopmode_cmd(struct adapter  *padapter, enum NDIS_802_11_NETWORK_INFRASTRUCTURE networktype, bool enqueue);
 extern u8 rtw_setdatarate_cmd(struct adapter  *padapter, u8 *rateset);
-- 
2.17.1

