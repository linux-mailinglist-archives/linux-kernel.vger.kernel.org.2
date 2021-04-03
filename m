Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C188E353343
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 11:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbhDCJQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 05:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236602AbhDCJPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 05:15:05 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912A5C061793
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 02:15:02 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a6so529292wrw.8
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 02:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H7gV2Io75BmHpwhQaw6NovithxcDv0ix+Sn60I7HwJo=;
        b=asIeDQEamcOTEZcUcmXrveR7Pg1uGOXeAPUsohxX1pNb4E3hk8BucbNyQY41n5RUwd
         gwSwRXwD5/JwKZJgmePs0F01P5D17Cpd6cE88l/4kF/UGZXhQnoM1Y1NFARFRbM8o3IV
         9r6y1T3Xw/1IPTey8dA8SGIiuWzgkMXrD0vsAhEzbA3t12MDXwHOtVSRpXQONHEYxCxm
         xNDxt5+NkS1lhZVM/DLEDOwhCGWk8rRHgVKnuRbgAqlOOvMgFByp4CXsPmuVw2tVXqae
         9e51udcInG361JliXefb8fpGHsz75zrgw7c2XaHOTH6Pie/QNrtVIUlpORDA9AhrhpW1
         auog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H7gV2Io75BmHpwhQaw6NovithxcDv0ix+Sn60I7HwJo=;
        b=KSJdH6azGPAp8qNRI0DtZPwSpxHgXd5UyiroSoiA5MHxbU7/7lVrTgWJAklj8D1VgN
         ar+Up2h2lB+EZDtY8f+gQec0U/G7lkpeDKiGyR4PugW+fKzvCQ87AoKPYbvVxAjfqqZH
         MM5jfH0quml9IgvabdFCvRJanTdWItPn65c5SrjCbUjRn5PvaxP3qWLimiqlVApWBFQE
         D3pzQk1V/fVZSbGDRzS+5vy9nbiMpG1G0I62v+9Qh0ZBEDLL3XjTqneucANpB3lBXHCr
         11VdeXDbp67lnbRmys9BjKfLflC8sNmQrDPipDMJJ/xcqF57yfxNO5Zj/8ctpkUtA6/d
         4Pgg==
X-Gm-Message-State: AOAM531MwAMfEKkmzcd0ommY9qNPPJ0lPFz6XF901KG6mTJJlBmpOxyY
        R7kKDyWeDmeHWFAz4+6Ns6c=
X-Google-Smtp-Source: ABdhPJzepbrYuBB7nKXngRQiPe5TDMA4FBkptclD5AQlng/KkxFWZFxoagrXV+iLDG+Kbj+Sv9hMBA==
X-Received: by 2002:adf:bc01:: with SMTP id s1mr19612218wrg.240.1617441301333;
        Sat, 03 Apr 2021 02:15:01 -0700 (PDT)
Received: from agape ([5.171.72.64])
        by smtp.gmail.com with ESMTPSA id c9sm17419840wrr.78.2021.04.03.02.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 02:15:01 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v3 30/30] staging: rtl8723bs: add spaces around operators in core/rtw_ieee80211.c
Date:   Sat,  3 Apr 2021 11:13:52 +0200
Message-Id: <33914c8c2b09ea2bcf845912dfe0ef04f2464856.1617440834.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617440833.git.fabioaiuto83@gmail.com>
References: <cover.1617440833.git.fabioaiuto83@gmail.com>
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

