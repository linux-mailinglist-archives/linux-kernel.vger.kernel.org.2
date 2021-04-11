Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1492E35B33E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 12:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbhDKK4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 06:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbhDKK4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 06:56:40 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D39C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 03:56:23 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id ba6so11580563edb.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 03:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q1npjWd8vdjVzI836QvD79nNpNz24IQNsqdLifo9GH0=;
        b=f6xP84EIdrHfCpLbq2zehKVLF0fdPl/MmFhD3LPidsCDsrKXRqKIf/XUvdY6D7ZfqS
         4WaNFTuqcO5IqI2pWyISAYeoRe5IHVptcbp9RvkbU8mGfvMlkwGx8Lx2m2w16j4MMUxZ
         00gYkTcZ9YpTHk21ms9NUgm06UQt30BQYx39wisUHCOhw4uWJYIitpNy03Y/mps5ChIZ
         PFpKTuMcKpAmDDU90O1rh2tL+3JnM101kmSNjzGR3sXPC2YTONnjvMHI1boQ+ruk/dYq
         r8u2ZMLJvTEc4FTwlMJrR+kXcB5aSxE5cNxVvSMb5DtbvZE93omU1jhU6k57CdSfszDd
         YtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q1npjWd8vdjVzI836QvD79nNpNz24IQNsqdLifo9GH0=;
        b=lCOz79BhQxZrJBPRwayixcS/UPBGiwZxA4KRf5vpZDUhB56STJe8hr4FBUZPWFJ/WO
         Ps5y5+nXhvAfu0SwFCu/fXRIeOWHUoEB2i8AsXuanrts2l0vwGWBH0JacnbPMk/p5A0V
         t9MtNbjlERiM9JJtmozz/d/ZKSu/Ps8iRTQDDCtUMMJLCuKQ4JwR9y7iSE6pS9SJ4mWf
         YVrY0sRZtSgsGJVK88g8yqfJ+SOHrwQCBEAOcxaeZWgNOtRsxqBki9FPs6HowJvnSU+H
         M7aeEpOMvM/6aIWIbSwl9kTBzz/LgTRI0MnJD1IJE0GXB3BZ0DMnQb3qcHjN+6DHoQ1Q
         8/DQ==
X-Gm-Message-State: AOAM533e8PwdqNKBy5mLjNzDAPn1GxZINev84o7uCfKcPtHvrG6N4IUx
        pKdf20hMgGLwJiWlau2fhug=
X-Google-Smtp-Source: ABdhPJyt/f/XCCQ4jVqHM0MGNQwcU2nzXTp+mm1Ss+nSPSgWyBd8fPSTELDDYAczjdB429D4bl9kkQ==
X-Received: by 2002:a05:6402:51c6:: with SMTP id r6mr24567953edd.278.1618138582343;
        Sun, 11 Apr 2021 03:56:22 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id f10sm4369100edd.29.2021.04.11.03.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 03:56:21 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH v4 4/4] staging: rtl8723bs: Change controlling expressions
Date:   Sun, 11 Apr 2021 12:56:08 +0200
Message-Id: <20210411105608.12900-5-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210411105608.12900-1-fmdefrancesco@gmail.com>
References: <20210411105608.12900-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change controlling expressions within 'if' statements: don't compare
with 'true'.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

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

