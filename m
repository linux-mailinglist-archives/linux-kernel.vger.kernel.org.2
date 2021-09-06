Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237C3401F8B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244569AbhIFS0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238873AbhIFS0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:26:13 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12679C061757
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:25:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id eb14so10506173edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qYfDSWWLfbRbSNVuId0vyBxYwKOU4bWEtZJKFkrF65E=;
        b=MHbWuWVD0vZCejmgPY/wtmLFAlAwwMFzuocwyanmRVnSkQ6mCTwhicCyyamb09x+Gq
         k04cDeqCkw4SXZ9Ai0Cu9NcApzxIiunRfgiaANz0Ea6o7AY57Kzr4s+cfxCq0NyGtSYK
         5kBeBiJ6lwk7OdSKWuRmTQVjGwh2XYHRoPQVhesDXqNQ68/1DElrdwzOnV9TRV6mA/n4
         CiNHddzEsICv1mnDVeUTRQf4rAi7NOPVBcCZT+k7VmMXLZrJimdC9/w8pu5A43FvPGG5
         Xc8Ru4rT4J41By+qwPvLQ6oU2HD4/VO+bhe9x14zxGOzAsnbGroZR/c263LhS3pH2pFC
         K9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qYfDSWWLfbRbSNVuId0vyBxYwKOU4bWEtZJKFkrF65E=;
        b=DBCZnKEYh0Bmy4kJHvicP9xE5mfDFWFMw+2R8ELOZX3YMZxRv1mTQzxGR0YapWAYyc
         7if7rNzeUgk0edExECnwGDhO3jlqoncYZ7lgf2LWTaOc1zY4FkjHxvQZ+Xzy2lfmwYMM
         IcgMC0v2k0Cfg3yIVN7eGpv7Bm2BuoqnmAw11exrgaMRtaiimk7NHkmehyN9UpKCD4H7
         xFTRZFcL5BCwdgpgL/KUt2H8YBA6RpIg6sUWd0iyHlvB0RyulAfcxoK1DoqCp7W0LQkH
         ONfncqEWJrxtrX54m18yvUQ1y6KVvbdePhICzEyAe+i6tgNT11N1gHcaVPkwtT7sth1i
         UxQw==
X-Gm-Message-State: AOAM531Of387AeGG4JjxQ5qoWtq9/mTLwMv3fccpvPVvqn2pCSQiVdPV
        oCmOkNCDvSCV8wie1qY912Q=
X-Google-Smtp-Source: ABdhPJz9B+j6Nntr0yDi/jttSoTS9bICVvyHFwLLk4MWkQtGrZqBUS7SNS03NGsE1ba5cgLi/PSt2Q==
X-Received: by 2002:aa7:c790:: with SMTP id n16mr14723358eds.223.1630952706657;
        Mon, 06 Sep 2021 11:25:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id s25sm4284492ejq.17.2021.09.06.11.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:25:06 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 07/40] staging: r8188eu: remove unused function rtw_interface_ps_func()
Date:   Mon,  6 Sep 2021 20:24:05 +0200
Message-Id: <20210906182438.5417-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906182438.5417-1-straube.linux@gmail.com>
References: <20210906182438.5417-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused function rtw_interface_ps_func().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    | 8 --------
 drivers/staging/r8188eu/include/rtw_pwrctrl.h | 2 --
 2 files changed, 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index c3897b29121c..00750394c50b 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -473,14 +473,6 @@ void rtw_free_pwrctrl_priv(struct adapter *adapter)
 
 }
 
-u8 rtw_interface_ps_func(struct adapter *padapter, enum hal_intf_ps_func efunc_id, u8 *val)
-{
-	u8 bResult = true;
-	rtw_hal_intf_ps_func(padapter, efunc_id, val);
-
-	return bResult;
-}
-
 inline void rtw_set_ips_deny(struct adapter *padapter, u32 ms)
 {
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
diff --git a/drivers/staging/r8188eu/include/rtw_pwrctrl.h b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
index 543f928e8089..8446dfb50f34 100644
--- a/drivers/staging/r8188eu/include/rtw_pwrctrl.h
+++ b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
@@ -251,8 +251,6 @@ s32 LPS_RF_ON_check(struct adapter *adapter, u32 delay_ms);
 void LPS_Enter(struct adapter *adapter);
 void LPS_Leave(struct adapter *adapter);
 
-u8 rtw_interface_ps_func(struct adapter *adapter,
-			 enum hal_intf_ps_func efunc_id, u8 *val);
 void rtw_set_ips_deny(struct adapter *adapter, u32 ms);
 int _rtw_pwr_wakeup(struct adapter *adapter, u32 ips_defer_ms,
 		    const char *caller);
-- 
2.33.0

