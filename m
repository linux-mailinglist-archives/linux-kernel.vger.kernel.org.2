Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFF23E2018
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 02:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243041AbhHFAlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 20:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242932AbhHFAlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 20:41:02 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EDCC061799
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 17:40:47 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n12-20020a05600c3b8cb029025a67bbd40aso7659502wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 17:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lcww6fXDpTmULdvzVewaSV3VUVStabGEyj46LGigwwY=;
        b=g0g4Dvw0fPH7hrjofAc+k293+vo1om1ud5E1D/3cNmh/KYcN5lDppX2cnji32VyxhD
         Em5xE/S12dPaSQw77O4wFWVr0zi60jsguxGmX/Rj7vRsHzrVdrXMVWvuRue4FZayns3a
         w8GGjowu3VhRYV4FcAo/JtaY+4vcXwMJZdgskz5MjROYy3te3uq0m1jZQvFPUtYYW2gp
         176qgTYXkwn3AcKijGhlr+H6liulj204LQs/AUA9S8QWBD9x8auX31dtfLi4dL2SKf75
         NHGKVOiOlWC6ryEyFPNlLd4SWScTQvKiSXI4hBu3woHiat9O9h88+2lGFO3YaYUJLFeL
         1QVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lcww6fXDpTmULdvzVewaSV3VUVStabGEyj46LGigwwY=;
        b=HwegQh1sOORZriG0d8gXWUu9IZ1JateuSLbS5c8HLcm5uwsCn1g5PyU9Klary0Ph1Y
         ExNncn5loCfggi49kDsgCmdBiiR+yH8TO/ZvW00ZXRK9fjeC0OmWEsZs3xg9saCm9oAb
         udHNQLvR/8z5sQZNTh0hMqCcOpKhHFRE4DM331PtJTNVGVH45zEseSOx6aFk5ADeM72i
         fuSbetGiRxmyo/+qYFDvilVu5k7C+jqLUnzkNUd7CtveY6sLxtOObkztVhdy51nlbV/c
         kuwtgV2kvFyZ7ojD6zDnNYxY67EODJ4O5euTNLjNjSJONtqlT5UeQyui7vkBmubHvzd5
         28sw==
X-Gm-Message-State: AOAM532xKrzdiGWN+Przm3puiW9qjNxCm3G6YeSv+ixPUbIHnQGW56um
        hpz4CnM0IppChOmyjshYFfNf3Q==
X-Google-Smtp-Source: ABdhPJzV+3jNBI7ucRyAmBoa5ZbVnFub/bcPlJioTb8iMIvRxLaWeyR+bc999hRbfbHVMmlcPtVi/g==
X-Received: by 2002:a05:600c:c2:: with SMTP id u2mr668044wmm.106.1628210445764;
        Thu, 05 Aug 2021 17:40:45 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id y19sm10727181wmq.5.2021.08.05.17.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 17:40:45 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, martin@kaiser.cx
Subject: [PATCH v2 10/11] staging: r8188eu: fix unused variable warnings in core/rtw_ieee80211.c
Date:   Fri,  6 Aug 2021 01:40:33 +0100
Message-Id: <20210806004034.82233-11-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210806004034.82233-1-phil@philpotter.co.uk>
References: <20210806004034.82233-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an unused variable and a set but unused variable within
core/rtw_ieee80211.c to fix a kernel test robot warning.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index e54926e1f569..ff77e686721c 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -626,7 +626,7 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
 
 int rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie, u16 *wpa_len)
 {
-	u8 authmode, sec_idx, i;
+	u8 authmode;
 	u8 wpa_oui[4] = {0x0, 0x50, 0xf2, 0x01};
 	uint	cnt;
 
@@ -634,8 +634,6 @@ int rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie,
 
 	cnt = (_TIMESTAMP_ + _BEACON_ITERVAL_ + _CAPABILITY_);
 
-	sec_idx = 0;
-
 	while (cnt < in_len) {
 		authmode = in_ie[cnt];
 
-- 
2.31.1

