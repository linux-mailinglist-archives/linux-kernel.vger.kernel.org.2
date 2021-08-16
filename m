Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1393EDDED
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 21:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhHPTdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 15:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhHPTdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:33:07 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B0DC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 12:32:35 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id z20so33799696ejf.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 12:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RUip0byKTWINqq7HUHlw/1zObxHE53/yOMwnFMivC7s=;
        b=UfqMlnexxkVYO39i4ailUlIrA+3b73CHy5jrbvXm0N0Y0eWPMM5j6vX8krUFa1s2rm
         KZzaILUIzBGPu2rNY6m8AUn/m5TSlBJe2ErbDPC0mLzPhXddjzjPkVNWv/FUlId3QMim
         p5ShUKRyFnHJ3n8GBT+W9NnxqI17i0fAF1kP5fL4bCbCUT2VNPUtu9em3O3gqfK4tD+M
         YX0ppdOfb/GMVDLW6sIozFpqJh6E2RsUl0l68t2myDLMByIOMnG/FZ1vKTQ9y0PyBtwM
         HX8+xhuqEVQg4YPYbTB8ufPDarIruesP7z/mhJPlgIe31YSmA0ZghFPi8EIQi4TqCLdH
         VakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RUip0byKTWINqq7HUHlw/1zObxHE53/yOMwnFMivC7s=;
        b=ReOhYhjl/Qh6Y7C9/KiYvTBMgq1wjLB5S6Ru6PDnQ109jDmP6c9F6SS1YpdT4fkiSV
         vbHTmCa6pPUfAMcGh8gGidvy7BDSjBI02II0Hv+jkHMzAumFEL9bdLMKvKQU5nmNlE3l
         lKXKEsjIN4q4jFYzcKbWQS9XnaSVGo0B+Z0JIlSFyXJvkn9vHu9ECD1/muBfCsujWius
         Zr2BPbXbT9zcR6rpB2b/2VF2olT46Ntz/1yj+qFiKqIvsN3iRIiR8u7F51PSJblsntLs
         IHnudEUHwJgXeiVO3F85wn6fkkQuVagAtDzC+rGl/ybxhfQTPHmP18+UcPisNPuc7lyn
         D29A==
X-Gm-Message-State: AOAM530vd5mfVffJOFtrx5as5so2CkP241c/FgQURoeTs9xrgOZRtLYG
        tEiHxwSbyrQeC7rFcTwcKrV08luvqoY=
X-Google-Smtp-Source: ABdhPJxLbMMG2L56yXomJKvOR5YgUNZy6nNlvIQR/5rehXPGscXqjdRz9m0WKHvFelKas6eSvm4okA==
X-Received: by 2002:a17:907:785a:: with SMTP id lb26mr71436ejc.77.1629142353756;
        Mon, 16 Aug 2021 12:32:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id v13sm59312ejh.62.2021.08.16.12.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 12:32:33 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH] staging: r8188eu: refactor rtw_is_cckrates{only}_included()
Date:   Mon, 16 Aug 2021 21:31:25 +0200
Message-Id: <20210816193125.15700-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor functions rtw_is_cckrates_included() and
rtw_is_cckratesonly_included(). Add new helper function rtw_is_cckrate()
that allows to make the code more compact. Improves readability and
slightly reduces object file size. Change the return type to bool to
reflect that the functions return boolean values.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 27 +++++++++++---------
 drivers/staging/r8188eu/include/ieee80211.h  |  5 ++--
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index 0c7231cefdda..892ffcd92cc7 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -68,28 +68,31 @@ int rtw_get_bit_value_from_ieee_value(u8 val)
 	return 0;
 }
 
-uint	rtw_is_cckrates_included(u8 *rate)
+static bool rtw_is_cckrate(u8 rate)
 {
-	u32	i = 0;
+	rate &= 0x7f;
+	return rate == 2 || rate == 4 || rate == 11 || rate == 22;
+}
+
+bool rtw_is_cckrates_included(u8 *rate)
+{
+	u8 r;
 
-	while (rate[i] != 0) {
-		if  ((((rate[i]) & 0x7f) == 2) || (((rate[i]) & 0x7f) == 4) ||
-		     (((rate[i]) & 0x7f) == 11)  || (((rate[i]) & 0x7f) == 22))
+	while ((r = *rate++)) {
+		if (rtw_is_cckrate(r))
 			return true;
-		i++;
 	}
+
 	return false;
 }
 
-uint	rtw_is_cckratesonly_included(u8 *rate)
+bool rtw_is_cckratesonly_included(u8 *rate)
 {
-	u32 i = 0;
+	u8 r;
 
-	while (rate[i] != 0) {
-		if  ((((rate[i]) & 0x7f) != 2) && (((rate[i]) & 0x7f) != 4) &&
-		     (((rate[i]) & 0x7f) != 11)  && (((rate[i]) & 0x7f) != 22))
+	while ((r = *rate++)) {
+		if (!rtw_is_cckrate(r))
 			return false;
-		i++;
 	}
 
 	return true;
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index bc5b030e9c40..1205d13171b2 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -1206,9 +1206,8 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv);
 
 int rtw_get_bit_value_from_ieee_value(u8 val);
 
-uint	rtw_is_cckrates_included(u8 *rate);
-
-uint	rtw_is_cckratesonly_included(u8 *rate);
+bool rtw_is_cckrates_included(u8 *rate);
+bool rtw_is_cckratesonly_included(u8 *rate);
 
 int rtw_check_network_type(unsigned char *rate, int ratelen, int channel);
 
-- 
2.32.0

