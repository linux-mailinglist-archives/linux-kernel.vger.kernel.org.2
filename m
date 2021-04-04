Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB13E353870
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 16:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhDDOLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 10:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbhDDOKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 10:10:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F67FC0613A6
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 07:10:41 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v11so8761859wro.7
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 07:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H7gV2Io75BmHpwhQaw6NovithxcDv0ix+Sn60I7HwJo=;
        b=OLM2g/sC2sRgrL6by+LFbhGXdMOYTRlVRGpBoL1+C0iyDrogXbbaegNmL9t6KMH7Yl
         Qw+agDzmfHlOYLB8JNgtxFYns7e9hVcQR+kG5kdM5n4owFIl58uQwZUC1Ic9UZa4a5O+
         p+oNXA9OcABwM9tqgXThGTAS6nuAyNYqnSkayHHbO81NkWIdyOBK0JEXCBVDr0LM+egN
         7m6JbGiWscQnHOZrR+4lg5acJcV7ib0Z9LB71tlk0/0yOfBXV7hGERR7/TMRU3RbiQoF
         GkwHbQLUq6uDjauhfZHPMZ5LzWnsUG7bS/WgzkvqXhtxFaWBBNlAwZzQO7ngaRlOVLv9
         PCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H7gV2Io75BmHpwhQaw6NovithxcDv0ix+Sn60I7HwJo=;
        b=diAgPDktmFWPnkEZH2LQVAF2WjgtKAzqVyfKEGmhjaoPeunAkfIuqKGUX6rLw77l3t
         rcFgpI1wBwiaWBGeKXmQhIca63GWItXLu1Nm5efGcoBwEfYENK5Od6exY/I4Uj+DZSvv
         VE878+k+aUiGAYCEzbS+mvN7jwWw0vDMW2vN1CC4NtDErTw71Beqy49E1rn6IYSbDumF
         y6IIRWttiKoNbgq3QsQbhPPuszdfq+6kgXsUPZu/KQCerKSL3QcWn6aZW/6QcjlNR/BB
         ERP8J+hSE9x93vxIq/fCKXuh8oEHwoDxor0yXkHPW0I8GEgjux21NUNFvsYzYTPJLgXd
         /JZA==
X-Gm-Message-State: AOAM5306Nwf314RMnjZFPRD26AKI5G8aW/kP8UrOZ2GEm4B9NRd+3l1C
        kIXmrt9isl+hT2IqZnveV8A=
X-Google-Smtp-Source: ABdhPJwaQt8xyr7nbxAYdSdpj0FhMdHLQbMIHGVqXd3bc8zOuEeXtqbmLHVhcNoSle4KUC4xFCUXgg==
X-Received: by 2002:adf:fbc8:: with SMTP id d8mr25080769wrs.94.1617545440071;
        Sun, 04 Apr 2021 07:10:40 -0700 (PDT)
Received: from agape ([5.171.81.112])
        by smtp.gmail.com with ESMTPSA id k13sm28725987wri.27.2021.04.04.07.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 07:10:39 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v4 30/30] staging: rtl8723bs: add spaces around operators in core/rtw_ieee80211.c
Date:   Sun,  4 Apr 2021 16:09:46 +0200
Message-Id: <1b5ee3d974c336e20f034d5de449fc29967a6213.1617545239.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617545239.git.fabioaiuto83@gmail.com>
References: <cover.1617545239.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix post-commit hook checkpatch issues:

CHECK: spaces preferred around that '+' (ctx:VxV)
161: FILE: drivers/staging/rtl8723bs/core/rtw_ieee80211.c:648:
+			*wpa_len = in_ie[cnt+1]+2;
 			                    ^

CHECK: spaces preferred around that '+' (ctx:VxV)
161: FILE: drivers/staging/rtl8723bs/core/rtw_ieee80211.c:648:
+			*wpa_len = in_ie[cnt+1]+2;
 			                       ^

CHECK: spaces preferred around that '+' (ctx:VxV)
162: FILE: drivers/staging/rtl8723bs/core/rtw_ieee80211.c:649:
+			cnt += in_ie[cnt+1]+2;  /* get next */
 			                ^

CHECK: spaces preferred around that '+' (ctx:VxV)
162: FILE: drivers/staging/rtl8723bs/core/rtw_ieee80211.c:649:
+			cnt += in_ie[cnt+1]+2;  /* get next */
 			                   ^

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index eb2058f2d139..a0d664e254a8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -645,8 +645,8 @@ void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie
 			if (wpa_ie)
 				memcpy(wpa_ie, &in_ie[cnt], in_ie[cnt+1]+2);
 
-			*wpa_len = in_ie[cnt+1]+2;
-			cnt += in_ie[cnt+1]+2;  /* get next */
+			*wpa_len = in_ie[cnt + 1] + 2;
+			cnt += in_ie[cnt + 1] + 2;  /* get next */
 		} else {
 			if (authmode == WLAN_EID_RSN) {
 				if (rsn_ie)
-- 
2.20.1

