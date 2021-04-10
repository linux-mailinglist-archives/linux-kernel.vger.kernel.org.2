Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B2F35AC6F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 11:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbhDJJXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 05:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbhDJJXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 05:23:15 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5E8C061762
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 02:23:00 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z1so9247511edb.8
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 02:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6C1kuLI/6U1TSBMUqk9JLF9SDGzIgrVMBUMNpn8I56w=;
        b=kHFajjcjeY0LaYCjifNIp+F+rpF48yL0JPVutu8rI57pss6iPMuHp1GmPfMX2wnDM2
         4FSYE0Zi6UDF4+YpSmKeVYy6ut0NUT49icEe0+AA/cpLSq5T7CRZmeH4TE+8MLmJ8eRL
         1NR0GFo1f9DnAdKS6/H9ziMLKJV8HnP9seAgKpKWWDfUoH0k1PQm4AVLL+wJ4VqfA0OD
         QvhSaWV+yjjCzeyeszgU2iQtujAR6Kj5bRcqSVZCcbp2zZKfQZBnVb19Ikx3s/9Ws0j/
         kU/2cu0hW4L9nFDHj31wJFi+JcCuYNWIoqd3rw91KhozGXySfnF+awjvg1dK5R0oNKU4
         0UWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6C1kuLI/6U1TSBMUqk9JLF9SDGzIgrVMBUMNpn8I56w=;
        b=XGVVENsMTXZZ5BHI4cXTve9pSkDsKD96NUaV8DTVS7K1MDQ9Y97Um2lDbSbPuIq+Pm
         fruRj0PCTVylJ8mJLsOm0kjZxufyqbcBHaFEMRNhkz0dVIE4qdEnJF5KpyvH77bI75TE
         tbGlqrafxtL+vruIWm3CwuJYKMG/R81MgHsIWvTgtS+1GeWo56C9sJ7Irbtg081LWV8D
         goX856/WS1pVju3O5HbsOLSISct8owOM/i2LpnWuzCrZalyQ7tyjazeTsKc1m+qOa2qZ
         O1Fiz93WBnXr1KtpTEK3LVL9onY8jcfuR1PrGoeRRmSi4mt328p2/qmwlqUQdvKjunef
         aWcA==
X-Gm-Message-State: AOAM530Y2FAp/bGNqrGzVk2szZQVHfqRdWqP25FoUBTQIPr4PjX4SAba
        qUHkqeMv55M809jG/5Rt0iU=
X-Google-Smtp-Source: ABdhPJyFFwmjVHqbl6Ldl5E961acmImtDpzrBNYIi9NV8+qYIO0bB3G66dsmwsAIjvgRehs6lsQ00Q==
X-Received: by 2002:a05:6402:2209:: with SMTP id cq9mr5651190edb.216.1618046579364;
        Sat, 10 Apr 2021 02:22:59 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id a22sm2801624edu.14.2021.04.10.02.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 02:22:58 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH 4/4] staging: rtl8723bs: Change the type and use of a variable
Date:   Sat, 10 Apr 2021 11:22:32 +0200
Message-Id: <20210410092232.15155-5-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210410092232.15155-1-fmdefrancesco@gmail.com>
References: <20210410092232.15155-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the type of fw_current_in_ps_mode from u8 to bool, because
it is used everywhere as a bool and, accordingly, it should be
declared as a bool. Shorten the controlling
expression of an 'if' statement.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c        | 2 +-
 drivers/staging/rtl8723bs/include/rtw_pwrctrl.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 96fe172ced8d..8dc4dd8c6d4c 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -348,7 +348,7 @@ void rtw_hal_dm_watchdog(struct adapter *padapter)
 
 void rtw_hal_dm_watchdog_in_lps(struct adapter *padapter)
 {
-	if (adapter_to_pwrctl(padapter)->fw_current_in_ps_mode == true) {
+	if (adapter_to_pwrctl(padapter)->fw_current_in_ps_mode) {
 		if (padapter->HalFunc.hal_dm_watchdog_in_lps)
 			padapter->HalFunc.hal_dm_watchdog_in_lps(padapter); /* this function caller is in interrupt context */
 	}
diff --git a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
index 0a48f1653be5..0767dbb84199 100644
--- a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
+++ b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
@@ -203,7 +203,7 @@ struct pwrctrl_priv {
 	u8 LpsIdleCount;
 	u8 power_mgnt;
 	u8 org_power_mgnt;
-	u8 fw_current_in_ps_mode;
+	bool fw_current_in_ps_mode;
 	unsigned long	DelayLPSLastTimeStamp;
 	s32		pnp_current_pwr_state;
 	u8 pnp_bstop_trx;
-- 
2.31.1

