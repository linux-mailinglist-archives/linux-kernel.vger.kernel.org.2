Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3F735B348
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 13:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbhDKLFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 07:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbhDKLF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 07:05:29 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C649DC06138B
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 04:05:12 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ba6so11597390edb.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 04:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JgR0CTRBES+JH0dRGw9EL1OLGpfiMEzltNQasd/GpYw=;
        b=bq50PP137k3dGNY82HD9qOr1dABMX2TLzu7PaqFCvQm3BiGKf43yCJm1mGwllVPfdm
         V/rTTLeMRC6oLG9J+0oagsRBQdQ7I8EiCH6FJw+7OL7zEz3VPrgZN8lmZp+dNyTqHYjT
         6MPCJnbrD1HV50Ei4uzNHYk6YQ57qlUpCLFiAaVwzsayyXnIv/kqbHNldgxPVr1tPCbP
         Q8tQh7EWRKYvLsAjUDfOoAue+pow/JylzmfCghh5yxTL4MtXdM2ZnKrpohpzj9sN5MuE
         PfdaKDCqxS/wCGIkqgEDsQIQDQUaSc0hQ7WiuPhpsMjT84Jnq0az2N3gmNapwptqpe9m
         AR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JgR0CTRBES+JH0dRGw9EL1OLGpfiMEzltNQasd/GpYw=;
        b=lvRmbkQTDY2SecwHqThHpWk+vHq84MxuKxwCPTwK+jztjfwKFlhjs7+O/8FFS6Z4m5
         ueUinPiten5Ow6s5ozmKQz3gQxphK+U0EFrYlPIj2+m142O3edMynGE2/8ZaYSyn13eN
         /9XD5UMAN070dTJgUsVLobQ2qQm8Abn15ucpdAeUHO0J79KXyjtk5PQD0Pydk0jcH9bB
         gB9rIbw3xMZ5Qsxuq/siXtwskJOYTXvrhYCS83pJXmQoJ0e3elvU6zQSf21o2VKsLhV6
         SHupwE31DK4TXw8x3zA7IEQQpkiJyf4ZNk65fl/3k2u/f6grX9Y28QDlAXgLTNJdGw0+
         lQFw==
X-Gm-Message-State: AOAM531mTO0Eh9lDjmXeG6Nl09xn7iyDw5dz5K0ZQibOJ2tlqbUZH1bW
        Npuv8PBcfh3fx8mLWg4nZKY=
X-Google-Smtp-Source: ABdhPJyJn1l8MqZZe2S/MIi+lhhNIrLHgh+ETMd2mTmvxxrupQoDDTH0k889dolXsTNWap4jdoL1zg==
X-Received: by 2002:aa7:d2da:: with SMTP id k26mr11928787edr.156.1618139111532;
        Sun, 11 Apr 2021 04:05:11 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id i2sm4577202edy.72.2021.04.11.04.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 04:05:11 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH v5 4/4] staging: rtl8723bs: Change controlling expressions
Date:   Sun, 11 Apr 2021 13:04:58 +0200
Message-Id: <20210411110458.15955-5-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210411110458.15955-1-fmdefrancesco@gmail.com>
References: <20210411110458.15955-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change controlling expressions within 'if' statements: don't compare
with 'true'.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Changes from v4: Write patch version number in 2/4.
Changes from v3: Move changes of controlling expressions in patch 4/4.
Changes from v2: Rewrite subject in patch 0/4; remove a patch from the
series because it had alreay been applied (rtl8723bs: core: Remove an unused variable).
Changes from v1: Fix a typo in subject of patch 1/5, add patch 5/5.

 drivers/staging/rtl8723bs/core/rtw_cmd.c | 2 +-
 drivers/staging/rtl8723bs/hal/hal_intf.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 32079e0f71d5..0297fbad7bce 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -1507,7 +1507,7 @@ static void rtw_lps_change_dtim_hdl(struct adapter *padapter, u8 dtim)
 	if (pwrpriv->dtim != dtim)
 		pwrpriv->dtim = dtim;
 
-	if ((pwrpriv->fw_current_in_ps_mode == true) && (pwrpriv->pwr_mode > PS_MODE_ACTIVE)) {
+	if (pwrpriv->fw_current_in_ps_mode && (pwrpriv->pwr_mode > PS_MODE_ACTIVE)) {
 		u8 ps_mode = pwrpriv->pwr_mode;
 
 		rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_PWRMODE, (u8 *)(&ps_mode));
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
-- 
2.31.1

