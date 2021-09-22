Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFB7415101
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbhIVUHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237406AbhIVUHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:07:15 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1065C0613E6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:43 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id w17so10317607wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z9p8PF9NWhXYm8/vlVRzN1zo7iSWjHxunaq2fDG+51w=;
        b=euKolRSbJmoASMOC8bo1KU69hczNJsHCAzssV/W/1/ZtHgEAsYBbVvrvDPcnNJnizz
         JnzUvkPIsN2DipdHxsdEzPVxhA5MsyPtejeDV5QHvBw6QHT/Wp4zuKljqupD+vKwAobB
         m64KwTKP+2Jj8DzHDVGU8IZMAhjwJMNrmv9dLWH8IJTaLMgajF7neqFdSrQTeatylWJS
         uEJSYwy8Vxx6J/IKJo2jlC/1NSYH6dp9I4Zvy1sK4SmuPdkqMs8wRUVyx1MBvxcIhgCE
         KBUIx2HUL22mmamvRNCeEuROnuFMj8SkdH+46jKUivaFXDMnszVvwMYssTjAjw7ECg/g
         T5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z9p8PF9NWhXYm8/vlVRzN1zo7iSWjHxunaq2fDG+51w=;
        b=bWuZ5BWQQ7+TdoItyElSehq63uolwPVkXJY7CIx15EyK6lyvu0rY6LZempUErBharq
         mUGIo024zS+sZeRU6Cp89EHSn9kbCzxwdzGBqaDJEgLW0ZA6Hp8M7/N7xVRmzQ0CTeE+
         LlCO1g4OZSm3GsIYdWymOeFzFRKRg/CCBMm0Gc7FKBhHC3eAPfmwzzFedjk+P+zsjxdl
         8IJcomVZTVR5QLrMhxQFlVDjCcvM9rxNEbjDKFY1eIK7fXy1i1B6ZcpwRHkWsYaJxytF
         dOJ0TXHiJUBQ06+6Jugoba7Hf0YAyXBLvzAY5Em4dLi0yMJymjT5mMZ2NGi4zLVdSVNc
         yi+w==
X-Gm-Message-State: AOAM533YJguHoOcmmzfDOTMgE4dKIpl+jFgNXV/P49ja3FDzhLzAqtJn
        //DQFp83yRXI8SAdzEih7+c=
X-Google-Smtp-Source: ABdhPJw27EckKV9yUXXiyXaaGPA7XRo2epd7DDvuT3XA/oo3cbVcadPzqIqqG07WdXpt/F2HJ5lzvw==
X-Received: by 2002:a5d:59ae:: with SMTP id p14mr937374wrr.278.1632341142496;
        Wed, 22 Sep 2021 13:05:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:42 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 17/47] staging: r8188eu: remove rtw_freq2ch()
Date:   Wed, 22 Sep 2021 22:03:50 +0200
Message-Id: <20210922200420.9693-18-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_freq2ch() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_rf.c    | 17 -----------------
 drivers/staging/r8188eu/include/rtw_rf.h |  1 -
 2 files changed, 18 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_rf.c b/drivers/staging/r8188eu/core/rtw_rf.c
index 321546c40446..2ec56012516e 100644
--- a/drivers/staging/r8188eu/core/rtw_rf.c
+++ b/drivers/staging/r8188eu/core/rtw_rf.c
@@ -53,20 +53,3 @@ u32 rtw_ch2freq(u32 channel)
 
 	return freq;
 }
-
-u32 rtw_freq2ch(u32 freq)
-{
-	u8	i;
-	u32	ch = 0;
-
-	for (i = 0; i < ch_freq_map_num; i++) {
-		if (freq == ch_freq_map[i].frequency) {
-			ch = ch_freq_map[i].channel;
-				break;
-		}
-	}
-	if (i == ch_freq_map_num)
-		ch = 1;
-
-	return ch;
-}
diff --git a/drivers/staging/r8188eu/include/rtw_rf.h b/drivers/staging/r8188eu/include/rtw_rf.h
index 48129da9c93f..fadb141c6945 100644
--- a/drivers/staging/r8188eu/include/rtw_rf.h
+++ b/drivers/staging/r8188eu/include/rtw_rf.h
@@ -121,6 +121,5 @@ enum rt_rf_type_def {
 };
 
 u32 rtw_ch2freq(u32 ch);
-u32 rtw_freq2ch(u32 freq);
 
 #endif /* _RTL8711_RF_H_ */
-- 
2.33.0

