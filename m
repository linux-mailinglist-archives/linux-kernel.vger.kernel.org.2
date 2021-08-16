Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C0A3ED17B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 11:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbhHPKAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 06:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbhHPKAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 06:00:07 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E6BC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 02:59:36 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso1748838wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 02:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=APmtX1P3ja8v/x20+NMdJ4eHxArTdJiEa3lLPOVHS3M=;
        b=cWsutDqGU5kvkAFS/4yhpnZTJF3yrJhPFbzE7FtZ2YD4xqryIGrJAYcMdnldfIimFT
         sQ2wpTi1V38SkfKHUUqogu5GyTdpRzweZh7oeWl9g/DAqwGpvDQOrN95lim0p+WPspJU
         KAUZn1sNDc9D+pFyxpK9V6iMgHlt67PbPQ5jWVR0ie3EVJnnMRvr2jg+B2NHN6LemV9U
         TDmX4yaz86sdDx7BAnHM/D3D6C4ClcvoJmyfK9zldqw9wyez9FkwlPwXw44ujAdsUf6z
         +N9rBMmzcJv3PLPlWF4Vnqbg9+rx5SrhU1nnbnd/+WVXlWG6YDzGZ+NPgQLaxiwkVyNv
         dSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=APmtX1P3ja8v/x20+NMdJ4eHxArTdJiEa3lLPOVHS3M=;
        b=nwNttbUx/92tgpp9cdmUIWQqeUnhVPufnl8h+Hj9PIAISUzWDvoB28obnvIypVuBlm
         dLu7x9NRMhnTdtvLJ0AVKVgCENoEiTEw7O/h4HShblQThE1T62c6cUmqC4F+I1UtSZpm
         znI5cAPCrVYYEbRj7aZdtPZtUCzUljCIWPkQZuBNFRg+uXtuBAyRNaAdG5QvHDfpy886
         XplSOqQ9wPWPNsSvg15xvidpf/GZWkhkv7mY9ybMMRPC3oDkdcbjoqy/vLHEZxVz0iVm
         nLXVBkYK8D5YnwNxsYYh2JXYYlIUHi9QkNmmZMl1myxcp/Ia5ny/ny6IMKvqo1fEEghu
         XaDg==
X-Gm-Message-State: AOAM533ICxpNNwdwAI7Ycrj+GlLuYu1VwYRcWcWm68oa/AQJxp9g/wC+
        n4TT44VI2sKxVB+tEYWr2cc=
X-Google-Smtp-Source: ABdhPJwyigbcGOn5B1d77aO/3zYxJYOCbQ9sBEAyfnMDcfh66z01g7dBH8iDqYOhaDi9GJUZY32CZA==
X-Received: by 2002:a7b:c5d2:: with SMTP id n18mr14574569wmk.97.1629107975044;
        Mon, 16 Aug 2021 02:59:35 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id g21sm1946635wmk.8.2021.08.16.02.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 02:59:34 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/4] staging: r8188eu: refactor rtw_is_cckratesonly_included()
Date:   Mon, 16 Aug 2021 11:58:39 +0200
Message-Id: <20210816095840.24259-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816095840.24259-1-straube.linux@gmail.com>
References: <20210816095840.24259-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor function rtw_is_cckratesonly_included(). Improves readability
and slightly reduces object file size.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index c8627ad83006..200c90b8ea51 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -82,15 +82,13 @@ bool rtw_is_cckrates_included(u8 *rate)
 
 uint	rtw_is_cckratesonly_included(u8 *rate)
 {
-	u32 i = 0;
+	while (*rate) {
+		u8 r = *rate & 0x7f;
 
-	while (rate[i] != 0) {
-		if  ((((rate[i]) & 0x7f) != 2) && (((rate[i]) & 0x7f) != 4) &&
-		     (((rate[i]) & 0x7f) != 11)  && (((rate[i]) & 0x7f) != 22))
+		if (r != 2 && r != 4 && r != 11 && r != 22)
 			return false;
-		i++;
+		rate++;
 	}
-
 	return true;
 }
 
-- 
2.32.0

