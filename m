Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5466F456ECB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 13:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbhKSM3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 07:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234929AbhKSM3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 07:29:47 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F17C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 04:26:45 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id e3so42052386edu.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 04:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uuvO/6huRHErRBfX6Opsxwgn6NenzRt+7b8WseBiimA=;
        b=YQxCcKbmMcCr98FzdsSf2v3TCLd0h9QkM5VKZlfY7ub5a7zP3ZQMCCpcUT9NCNm/26
         HEZKWrpfSbgGRf0K0DrQfx3seB4tM8yT9OCkQisMIDdmhsZdvMog6ZQ/kuaqIwXitw3W
         9bu9k/BHTWI6F1YI7KucIGpsro55rI2Yw1iZYo6r1gCVfL+IzLXwqeHmV7k0kwh914o+
         bZ2X9YDATIdLG35oWnEe/JClGtV7sd7t/bU6l5mEJPtJjt7+aJ9EabBCny5fyOTkRPU9
         U075/f6GChk/NRgFDkMlQHSU7PXC7n4mGZAq/ps60s9um+KVeLMaXRYi7drOV1IilGbq
         EDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uuvO/6huRHErRBfX6Opsxwgn6NenzRt+7b8WseBiimA=;
        b=1N90n9ODEq5OdjG+V2REw5M/oiJFCR+AR+Ox4NVxWQSNn5OdEkGMuC9fSCNkCBchq/
         0Lxpuf9Cu4/JLSy5W/CuQhs6AdG7XbMUcbuXNbGgiQ7tcNq7Kd309VxZ8neMiz1k2Cfc
         fb1iGmhLtOOFjwhDIkvkZhEb9jSH53vVNYYHKY6P4wnnJT6pJ7kFhoWoUt8U0tlPy6B0
         5R568wicmWSrVPfE15SF8ZyWE0COr377/l3Tdozsrzc1ruJevwvlvZ7a6y+FzsG60pN3
         1Hgqn9WTbHEe1lygMheLCHE2ZTtQxUHlz9Nyn/M34LFh0QE0WkFPgyFNjxiwBltPPqNT
         DamQ==
X-Gm-Message-State: AOAM5338DjGpLYD+DwblzksriZhSEID6iKH+05RcA7e/EzvjvLNgQg/J
        vWbLrDcOrrP/3O/4kiyS7sU=
X-Google-Smtp-Source: ABdhPJz0Mq60L4kH1ZmQwx5FfA4MZETakdK3lv2FcQD7Z/yqkd+wwrfdQkxIi9aWC2wxjKkuY1LMkA==
X-Received: by 2002:a17:906:b01:: with SMTP id u1mr7191042ejg.504.1637324803937;
        Fri, 19 Nov 2021 04:26:43 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::79b5])
        by smtp.gmail.com with ESMTPSA id v10sm1374994edt.24.2021.11.19.04.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 04:26:43 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: r8188eu: remove rf_type from HT_caps_handler()
Date:   Fri, 19 Nov 2021 13:26:35 +0100
Message-Id: <20211119122635.28435-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119122635.28435-1-straube.linux@gmail.com>
References: <20211119122635.28435-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rf_type is always RF_1T1R. Remove it from HT_caps_handler() and
remove related dead code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 6d4e21a16783..3c8876822602 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -695,7 +695,6 @@ static void bwmode_update_check(struct adapter *padapter, struct ndis_802_11_var
 void HT_caps_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
 {
 	unsigned int	i;
-	u8	rf_type;
 	u8	max_AMPDU_len, min_MPDU_spacing;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
@@ -730,15 +729,9 @@ void HT_caps_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
 		}
 	}
 
-	GetHwReg8188EU(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
-
 	/* update the MCS rates */
-	for (i = 0; i < 16; i++) {
-		if ((rf_type == RF_1T1R) || (rf_type == RF_1T2R))
-			pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate[i] &= MCS_rate_1R[i];
-		else
-			pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate[i] &= MCS_rate_2R[i];
-	}
+	for (i = 0; i < 16; i++)
+		pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate[i] &= MCS_rate_1R[i];
 }
 
 void HT_info_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
-- 
2.33.1

