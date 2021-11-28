Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE7C4607E0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 18:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358763AbhK1RPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 12:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358558AbhK1RNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 12:13:07 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2164C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:09:50 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m25-20020a7bcb99000000b0033aa12cdd33so4819890wmi.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YLIQJab5wHT1hsE/76jhgQKsIzuBjk3iIIUzCckcPmw=;
        b=d+2U/R8yBD05iqUXOtrn/Pz6/Mm5T8yM4kd/WyAktGZScRYskMLaUBd3Eo0qRqo8dH
         l6JGm0eOD3iyXFJCl3rt9gBChXQYRKo9sh8YCG61wDiccBVfWZy/R9wOLbCnII36GPuw
         8zYrEo5CJCOg+hiK0QpqWPkBzxJhlr9/THftWK7OD4aO4l3j/JsfqPUzzXMsXYO0bs/+
         jNW5M4RKqqUal4p7l9HGEOLRdIGVlMOOWel/pvhVdM/dJ4coRHLuQUGVn+pIxyH0qxNQ
         v3MCRXg3moFr6yXZ7gYL0LAXNVO9NrDSixhulH7dKPruktlq/BqrcoiBLksWgRChatp3
         oaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YLIQJab5wHT1hsE/76jhgQKsIzuBjk3iIIUzCckcPmw=;
        b=xDF9EoVv1u5B4ZYyR+zus2d8FXoRRG1C4wn4NpUVC8m4zqR6efl6yV2xaz/HvRsfsb
         2L+WgqUn75OFzzsZQd2Gt7N8upbuCfn+mOqj5ElC87FULOgf4I3IX9E73KOiW/Bhw46y
         54AAKk27JRPDtk1EK0lciMTiCufUns0IIOnuUFUPRDhuBOnf336jwoBoabbpw6zG4ATA
         GMeswaG1s56swpJ2IeqwegpXPATXFPQJeUd9LiYZu5wO3quN41vBhOB8YantbVw/6Z94
         QmunIld+3Ngymkw5hlnyCREUKpJexk6+rYrgvsWlxQiBtXYD56y3FlJP6REkJNiNZqU7
         89VA==
X-Gm-Message-State: AOAM5329DqN7+IbKmdt97RxbGZ1Wjnb7EjUJLUD/XWru9hVz6UMbwSDZ
        rgppUCD6KryEx4tpZnjA/8o=
X-Google-Smtp-Source: ABdhPJxzboVKvk6Arn9847UVlQuL94e3J/PAeFbnB4Debgjge/8xrI41HXvo1Rlt1MEUEgqqmZ53ew==
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr30549784wmj.37.1638119389228;
        Sun, 28 Nov 2021 09:09:49 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ac86])
        by smtp.gmail.com with ESMTPSA id n15sm18243845wmq.38.2021.11.28.09.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 09:09:48 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 01/10] staging: r8188eu: remove rf_type from rtw_update_ht_cap()
Date:   Sun, 28 Nov 2021 18:09:15 +0100
Message-Id: <20211128170924.5874-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211128170924.5874-1-straube.linux@gmail.com>
References: <20211128170924.5874-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rf_type is always RF_1T1R. Remove it from rtw_update_ht_cap() and
remove related dead code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 8d14aff32f61..a3996a7ee814 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1999,17 +1999,11 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len)
 	    (le16_to_cpu(pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info) & BIT(1)) &&
 	    (pmlmeinfo->HT_info.infos[0] & BIT(2))) {
 		int i;
-		u8	rf_type;
-
-		GetHwReg8188EU(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
 
 		/* update the MCS rates */
-		for (i = 0; i < 16; i++) {
-			if ((rf_type == RF_1T1R) || (rf_type == RF_1T2R))
-				pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate[i] &= MCS_rate_1R[i];
-			else
-				pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate[i] &= MCS_rate_2R[i];
-		}
+		for (i = 0; i < 16; i++)
+			pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate[i] &= MCS_rate_1R[i];
+
 		/* switch to the 40M Hz mode according to the AP */
 		pmlmeext->cur_bwmode = HT_CHANNEL_WIDTH_40;
 		switch ((pmlmeinfo->HT_info.infos[0] & 0x3)) {
-- 
2.34.0

