Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5767E3ED17A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 11:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbhHPKAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 06:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbhHPKAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 06:00:06 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79022C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 02:59:35 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id f9-20020a05600c1549b029025b0f5d8c6cso14531315wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 02:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KyjJYN2XshsuYz7jaJUcoW7fAV9lvNvVVnkMA0KNgnM=;
        b=OEw8qQAjUDWS9e/Sah4oTcuvnNpKs21Hwe6tgIG4zC9B26MNDiF8cAAf6/4uXqPz4s
         OAqh/MKDC3ypuRxElNNTW1ixB5xZVmaSdIjIlLKmCekH/YY5nOj1NtVHTbm1pBexj6h7
         HWLwkZ1GbY2ULb5qjzSC1jaRc3W8kvNwZuvfuGnty+bM5vNnCvnqCXyfeogzahApLpdx
         L5/F2Jcrl1c6E9Gk+4LT9h5u5ZqWmjrsgWq97PqlQGd7h4xszLjYBF+v57yzZ5Mgos19
         zo6RgDC3zwmRJ8xhe51Jcp2m76uSa1if1ow3hNDVYsm8BRJS0l63n9Tod6T3iTLGuIwG
         GQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KyjJYN2XshsuYz7jaJUcoW7fAV9lvNvVVnkMA0KNgnM=;
        b=MiEk2EUE74jpgl3yIIsx2rMvqCZdvSa3+sBtCzvYy1ByJUOow4RdvqUJabOcUsByWV
         bJzo1CZwQjztIHnAtEqNgH3GFMfjrjUudOMjPXFqL8K61Sekoj84Yg0VHyRT+j17cB2n
         U+GasqG/k/S7e5dXaLmNsq2sStR5JSPeXSPeKJTomCZr0nBScFPkGNbxDcHD1BbccZzG
         PG5KTsAq2j0vRT61dRoWit62SDYRlWNJchEoHXd2JJH5YMhf23eM8TOcdkIeKoNyItzL
         /XulUW/2t3bTgFZ1dfY1wmuzB5KO88Lrl9/1Xnd2CDHT5TExHgCM9DK2EKjaHphdZibI
         6d4w==
X-Gm-Message-State: AOAM533BlHQbIBKBCifTAuLz/6DlgiySi8AqSjv4T2meqcNhqnr4gClA
        5Y77Cq1tZsSKtcjDmf25hEU=
X-Google-Smtp-Source: ABdhPJxvRwKpN2Y+CdTLakHeOwLVSwUL6uNnLI4HWG8a4WxRRDMVKa1qYle0lO9QCb5Fwo0L44n3sQ==
X-Received: by 2002:a1c:4c05:: with SMTP id z5mr14126776wmf.145.1629107974195;
        Mon, 16 Aug 2021 02:59:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id g21sm1946635wmk.8.2021.08.16.02.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 02:59:33 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/4] staging: r8188eu: convert rtw_is_cckrates_included() to bool
Date:   Mon, 16 Aug 2021 11:58:38 +0200
Message-Id: <20210816095840.24259-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816095840.24259-1-straube.linux@gmail.com>
References: <20210816095840.24259-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_is_cckrates_included() returns boolean values.
Change the return type to bool to reflect this.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 2 +-
 drivers/staging/r8188eu/include/ieee80211.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index beff2ab73a1a..c8627ad83006 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -68,7 +68,7 @@ int rtw_get_bit_value_from_ieee_value(u8 val)
 	return 0;
 }
 
-uint	rtw_is_cckrates_included(u8 *rate)
+bool rtw_is_cckrates_included(u8 *rate)
 {
 	while (*rate) {
 		u8 r = *rate & 0x7f;
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index bc5b030e9c40..cbefd7af1d4f 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -1206,7 +1206,7 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv);
 
 int rtw_get_bit_value_from_ieee_value(u8 val);
 
-uint	rtw_is_cckrates_included(u8 *rate);
+bool rtw_is_cckrates_included(u8 *rate);
 
 uint	rtw_is_cckratesonly_included(u8 *rate);
 
-- 
2.32.0

