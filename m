Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0DC35AEA7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 17:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbhDJPA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 11:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbhDJPA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 11:00:56 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477D6C06138A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 08:00:41 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id v6so11876075ejo.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 08:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+GS5YSfWFuaI4QAKIQGwDg4lsv5EguJ6x2s2YbgKL78=;
        b=XBAoLJGU1Gz/A/gMAcXAIHOyw/xJ6GQVtG9UVSMOnNEDap5BWU+A/2pekAzKgy7QGj
         nvLIonwIrbXh9TDom7KndIiqlQY9StdWdUFZOm7Zko3OGv+eOnHeysa0McQahXW/DHRP
         kAUG8Zi7EWayOGG+JgB/sejgspfOvRLyetjmPo96fsQ8p5E8vIBXxnIyxqlE4QCwQ1+P
         yPDCUeUX7Nj7oo1ptJQHDzDKqdo/qYp3QBe3KZCi2WH0lgyXoMi7wzs6U0Kb1RpZIS9p
         sSsWTL6TLaCRxsddem7IYmfNuAfh5nqVCIP7lNjGj31KewzOzwrOg/xPtbl3nVfttJbr
         ts6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+GS5YSfWFuaI4QAKIQGwDg4lsv5EguJ6x2s2YbgKL78=;
        b=qu0Kgc3oGk1668nHElMspZBt3TyHNYdb0vsDfQdpbIYz5ioMVuFytiwr6BWIaZNoWh
         oIgXC1UiHIEDfa9a8fihk1TpkoFY1vnK8flEDFTh/c9h2XfAWWIa9n3ghyrI6Y3vMXGq
         /QSVGReIGFjeM9GhlPOryBaruvaUp8ImNXBFxxvLuJ2KRWZnYasm3EAPS//iPQPUSI1U
         dyJfcvinPPQtkpdrQBw/u/+yzzCTBYy/53q82k1+1ANFrvVkBuNN0uDCDnpW9DY1feBZ
         avkcPb2BLtaeh11LXKsIkE3n8Zs6txDUO1mm43TxOVP43a44wzRq9QwLSBTvuOwqfwbD
         81sw==
X-Gm-Message-State: AOAM533h2DLl1LgY06TgrwAvVsSrHRQJfnrTSHqU91x0YzNZltedS5vG
        fF/K95ubUR6SX21G1zZyJtU=
X-Google-Smtp-Source: ABdhPJzUPJhD/Jw25OmsKVnptLqsNbw9k+oR68MuFXrpm1oxEr3dV8AQ2bx0m0E8+qZDdyfnNx6pGg==
X-Received: by 2002:a17:906:5413:: with SMTP id q19mr1563472ejo.8.1618066840031;
        Sat, 10 Apr 2021 08:00:40 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id gb4sm2719494ejc.122.2021.04.10.08.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 08:00:39 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH v2 4/5] staging: rtl8723bs: Change the type and use of a variable
Date:   Sat, 10 Apr 2021 17:00:07 +0200
Message-Id: <20210410150008.5460-5-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210410150008.5460-1-fmdefrancesco@gmail.com>
References: <20210410150008.5460-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the type of fw_current_in_ps_mode from u8 to bool, because
it is used everywhere as a bool and, accordingly, it should be
declared as a bool. Shorten the controlling expression of an 'if' statement.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Changes from v1: No changes.

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

