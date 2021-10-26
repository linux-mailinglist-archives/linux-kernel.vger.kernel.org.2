Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC0843B353
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 15:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236273AbhJZNph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 09:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhJZNpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 09:45:35 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473E5C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 06:43:12 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d9so14395314pfl.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 06:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JwzvnEtQyFzINH8lrQUN82IVP9LOJxQIr47i06O+OtU=;
        b=HdYCeMf81a8N+pUWVFHfIQSCcxlHrwBfZlUQeZ4JyooMtF9ug68RWnwbg8WZPsuF6A
         u7m1fyfzrReBF93Sl6ssvbnhYSlmlJebvX5420PBgCreVLAwDHGTtkpukUjmu+l7UZ2y
         YPH/pj/RqZCTrPNFmjnB+t9WdHrG4vBj9z96O9movWQuZMv2qBIBnqmWGeimYUDpR9ZX
         DeP3+cJslFQEQPtLR4//9HtQGhOarmEGeWUF3s+A4fy281NvM2KeNV1AQnYgddaPXWk5
         21IEFfgQvJWLHfVsP17imCowSUlf7d44DpibSAGCHRsomCgQbLJ7+m99s6YDNWA1tVJI
         T5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JwzvnEtQyFzINH8lrQUN82IVP9LOJxQIr47i06O+OtU=;
        b=U8TmYfmL5Zhf4KHVThIZcxziVRKpM5ZbgcJ721nTACpEzSsr4dtbr//apkWuUPhkgF
         Z/Oc/ZuNkrqPtDeXBDlBeKtAX6fdvEizGxaSUATOis4xityOR1PP/xiPQ9xO/59zAVFp
         ucyMBlcSOXwdwsjbN14ZNenGvsjc4xFxH10ACRl4wMrgdlUHTxbFCmVsHnAS7mcuyQh8
         ZKPMxaERR/UGfA5TgD4+zlInuURcggIWuEHTicM1yKDjuo3ZMGiZpGwELb6XKHFraBaX
         DBnPxILDsX4AQaHokwt38Uj0sYJlm7sXdRw3eeXlk7o3Se04rSXWAv0abtUZu3pY8vuI
         qc6Q==
X-Gm-Message-State: AOAM532f3kOVl1KkfJdao8P6hsGSf2wBCncdKi5jk8juAIyBt+DhNkLM
        d7Qkh7GuAzKke5l9kEHh0JI=
X-Google-Smtp-Source: ABdhPJzoj0kvpHRxoTcjkPZO9BW2iW8gCKlYY/TxwhYww0PmpXsQ/bpgiVYkIeOJMqAZA/Yl3bPrTw==
X-Received: by 2002:a63:9d0b:: with SMTP id i11mr16378932pgd.429.1635255791737;
        Tue, 26 Oct 2021 06:43:11 -0700 (PDT)
Received: from kushal ([2401:4900:1d67:6055:69c2:a862:1f6e:c9e4])
        by smtp.gmail.com with ESMTPSA id m10sm1000844pjs.21.2021.10.26.06.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 06:43:11 -0700 (PDT)
From:   Kushal Kothari <kushalkothari285@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, hdegoede@redhat.com,
        marcocesati@gmail.com, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mike.rapoport@gmail.com,
        kushalkothari2850@gmail.com
Cc:     Kushal Kothari <kushalkothari285@gmail.com>
Subject: [PATCH v2] staging: rtl8723bs: core: Refactor nested if-else
Date:   Tue, 26 Oct 2021 19:12:53 +0530
Message-Id: <20211026134253.7868-1-kushalkothari285@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor nested if-else to avoid deep indentations. There is no change
in the logic of the new code, however, now it is simple because it gets
rid of five unnecessary else conditionals and it combines nested if into
single if-else-if. This refactor also leads to fix warning detected by
checkpatch.pl:
WARNING: Too many leading tabs - consider code refactoring

Signed-off-by: Kushal Kothari <kushalkothari285@gmail.com>
---

Changes in v2: Fix the bug of not handling properly the else logic
when p is not null in else-if. Also, reword the subject line and break 
it up at 72 columns.

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 69 ++++++++-----------
 1 file changed, 29 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 0f82f5031c43..267d853b1514 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1192,50 +1192,39 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 		p = pframe + WLAN_HDR_A3_LEN + ie_offset; ie_len = 0;
 		for (;;) {
 			p = rtw_get_ie(p, WLAN_EID_VENDOR_SPECIFIC, &ie_len, pkt_len - WLAN_HDR_A3_LEN - ie_offset);
-			if (p) {
-				if (!memcmp(p+2, WMM_IE, 6)) {
-
-					pstat->flags |= WLAN_STA_WME;
-
-					pstat->qos_option = 1;
-					pstat->qos_info = *(p+8);
-
-					pstat->max_sp_len = (pstat->qos_info>>5)&0x3;
-
-					if ((pstat->qos_info&0xf) != 0xf)
-						pstat->has_legacy_ac = true;
-					else
-						pstat->has_legacy_ac = false;
-
-					if (pstat->qos_info&0xf) {
-						if (pstat->qos_info&BIT(0))
-							pstat->uapsd_vo = BIT(0)|BIT(1);
-						else
-							pstat->uapsd_vo = 0;
-
-						if (pstat->qos_info&BIT(1))
-							pstat->uapsd_vi = BIT(0)|BIT(1);
-						else
-							pstat->uapsd_vi = 0;
-
-						if (pstat->qos_info&BIT(2))
-							pstat->uapsd_bk = BIT(0)|BIT(1);
-						else
-							pstat->uapsd_bk = 0;
-
-						if (pstat->qos_info&BIT(3))
-							pstat->uapsd_be = BIT(0)|BIT(1);
-						else
-							pstat->uapsd_be = 0;
-
-					}
-
-					break;
+			if (p && memcmp(p+2, WMM_IE, 6)) {
+				p = p + ie_len + 2;
+			} else if (p && !memcmp(p+2, WMM_IE, 6)) {
+				pstat->flags |= WLAN_STA_WME;
+				pstat->qos_option = 1;
+				pstat->qos_info = *(p+8);
+				pstat->max_sp_len = (pstat->qos_info>>5)&0x3;
+
+				pstat->has_legacy_ac = false;
+				if ((pstat->qos_info&0xf) != 0xf)
+					pstat->has_legacy_ac = true;
+
+				if (pstat->qos_info&0xf) {
+					pstat->uapsd_vo = 0;
+					if (pstat->qos_info&BIT(0))
+						pstat->uapsd_vo = BIT(0)|BIT(1);
+
+					pstat->uapsd_vi = 0;
+					if (pstat->qos_info&BIT(1))
+						pstat->uapsd_vi = BIT(0)|BIT(1);
+
+					pstat->uapsd_bk = 0;
+					if (pstat->qos_info&BIT(2))
+						pstat->uapsd_bk = BIT(0)|BIT(1);
+
+					pstat->uapsd_be = 0;
+					if (pstat->qos_info&BIT(3))
+						pstat->uapsd_be = BIT(0)|BIT(1);
 				}
+				break;
 			} else {
 				break;
 			}
-			p = p + ie_len + 2;
 		}
 	}
 
-- 
2.25.1

