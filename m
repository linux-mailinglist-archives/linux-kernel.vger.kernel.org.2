Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018F145B00E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 00:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238400AbhKWX3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 18:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbhKWX3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 18:29:37 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A574C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 15:26:29 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id b68so751439pfg.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 15:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mlAFOYJJELBcb2TVaSzn/i78GajJV1vHST7kCQwulgU=;
        b=DieFE11Nad3azkwEymKNvMKGZ3b+ZHRUWsngy8vvj2ED0Yk4A2eJDOHTFlFrshjVs0
         NIGQzlpCfARFgpgIuuOZKGg5O741HN8Qzf217JFFVN+sti4KniZpHNTtFnZ2xkLp5sAb
         mNFCj1xHOrvJ3UsLbnu8PjWLz/rQ0ix1TfmL26zGgcA+s3C6sxDjvDLY6PWmq+iuTBog
         vE6nQBBxZydWlTgny1MEb35wDMQlGqNajdMe/nQTngKqk/1bviayapOD6bVBJkOVqk8g
         Enmf4X7wIe/DfzLB6iCpeiWxF3gDwlJvtahMh98MuYqbqeox7ufvhGxVy4tE6gsgcQ0T
         5pBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mlAFOYJJELBcb2TVaSzn/i78GajJV1vHST7kCQwulgU=;
        b=16UUcfvAlZsl2mXHSE9EQjS2CwoyWjpVTVH3xbbRzerxD31Uh0vdM8cDS5ad+tKX18
         j480q4ILrXq/uT3ZQgUmh/xTGZyAt5KMUaOIPx9dy6qlYpn91VTA7rMgOLwGaWpyL3ev
         5fS5ZtSZO2dcZaaTOapLudd5cp/HbSS86v8lmuzoGImvOqY3wXV/mthrzR/Ve5gl/dxt
         Pr/aVUPsWrhKmRKL9yagYMSJZe/8LGi39yFxp7ilKKwW8oZZyLngy6gglqoDsWXjaTtS
         UlK1MlPmBQuXlbuaMXhIHVf+Xo1LagqYADe4LidXzCpO/eNld3/aoqL8t4OTQADs9iKn
         ElDA==
X-Gm-Message-State: AOAM531+ha8dru+A41MxWmOQYqXUpt84bJRTsxvZl6bXAlWi+ZHRpVCC
        xEj9UGZYz//2APGil5tVcl0=
X-Google-Smtp-Source: ABdhPJz6TO98H/bXryOdnUQ39IAWQaxdaWdZ3g3ByBdhJl8GGkGbluL6kuPwxpTXutnC4hKSMvlE1g==
X-Received: by 2002:a63:914a:: with SMTP id l71mr6407376pge.224.1637709988846;
        Tue, 23 Nov 2021 15:26:28 -0800 (PST)
Received: from localhost.localdomain ([103.85.8.147])
        by smtp.gmail.com with ESMTPSA id r16sm2632037pgk.45.2021.11.23.15.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 15:26:28 -0800 (PST)
From:   Vihas Mak <makvihas@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk
Cc:     gregkh@linuxfoundation.org, straube.linux@gmail.com,
        nathan@kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Vihas Mak <makvihas@gmail.com>
Subject: [PATCH] staging: r8188eu: use max() and min() macros
Date:   Wed, 24 Nov 2021 04:55:51 +0530
Message-Id: <20211123232551.210016-1-makvihas@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use max() and min() macros to fix following cocci warnings:

	drivers/staging/r8188eu/core/rtw_wlan_util.c:719: WARNING opportunity for min()
	drivers/staging/r8188eu/core/rtw_wlan_util.c:724: WARNING opportunity for max()

Signed-off-by: Vihas Mak <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 6d4e21a16783..d8fc54cc2389 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -716,15 +716,11 @@ void HT_caps_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
 			pmlmeinfo->HT_caps.u.HT_cap[i] &= (pIE->data[i]);
 		} else {
 			/* modify from  fw by Thomas 2010/11/17 */
-			if ((pmlmeinfo->HT_caps.u.HT_cap_element.AMPDU_para & 0x3) > (pIE->data[i] & 0x3))
-				max_AMPDU_len = (pIE->data[i] & 0x3);
-			else
-				max_AMPDU_len = (pmlmeinfo->HT_caps.u.HT_cap_element.AMPDU_para & 0x3);
-
-			if ((pmlmeinfo->HT_caps.u.HT_cap_element.AMPDU_para & 0x1c) > (pIE->data[i] & 0x1c))
-				min_MPDU_spacing = (pmlmeinfo->HT_caps.u.HT_cap_element.AMPDU_para & 0x1c);
-			else
-				min_MPDU_spacing = (pIE->data[i] & 0x1c);
+			max_AMPDU_len = min(pmlmeinfo->HT_caps.u.HT_cap_element.AMPDU_para & 0x3,
+						pIE->data[i] & 0x3);
+
+			min_MPDU_spacing = max(pmlmeinfo->HT_caps.u.HT_cap_element.AMPDU_para & 0x1c,
+							pIE->data[i] & 0x1c);
 
 			pmlmeinfo->HT_caps.u.HT_cap_element.AMPDU_para = max_AMPDU_len | min_MPDU_spacing;
 		}
-- 
2.25.1

