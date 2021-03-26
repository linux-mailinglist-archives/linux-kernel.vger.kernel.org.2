Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D266E34A3C7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhCZJKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhCZJKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:10:01 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EC4C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:10:01 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 12so2571711wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LuVUGCrDYwzS4XJl5GG9GlS8NguBAubSl2Epx6ZZHf8=;
        b=pmiAGbRSMQbcmi8fiNSSsEWBLqaXAi+gA7rvW+EboM0H6bbmzfRsFSkgZRo/JWBn7M
         R2EZFn014knD17A+/+oNrG17BMYKHXRChXE2V9kNYQrCVBqj+gXMLvKkFFtzJdrddfCe
         vW6UjdRw8rQbHAfdKRHoobpQeRaycKsncYjwIwN0CW2jSqCypfkEqvFFiEP9Bwu4CVvy
         Wadc8mjHeeAlooFKaohllZfm/NZPRG/08eSd6FLfiKZcmRRo3dy7s1Z5Vi2EpuOs64df
         URklx61g/flWV+nXOwnqPN55LfNuDFqaPgr2byHyKnBS8gF3IBUOuyTSe8FOEKLfk2Gc
         H3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LuVUGCrDYwzS4XJl5GG9GlS8NguBAubSl2Epx6ZZHf8=;
        b=i0GzWX5vXEE2JXAgcysgSN+4c6t1RBQ/tUQ97EzeOzSypCmICZrsQ3YgOckGYUj4qZ
         gKspr18kiI/PW14pozRnDRH/smow/RK3M8+qW3LMDp7AaCdFa/BbLn9hGX93uAGuYaIO
         O2sKENMyOT7hRg+RKotko+wKWyMAKOenA2jAbIiKws6ioUxtztkWDI9KBxo1Aa06CyuM
         tX7VcubTERO/wVsBKzjGiMFU6p7e4MbdrF0xc9aVnCBNsMMR5g8QXBT6wzA9j3yKPbNv
         HP7wSH5oj71db1i2tV9hTYxjKuczh5Cw4SEPw4Ul8UeEZ+5pl/cV3zy2IlSdDvdpV/jc
         OzLg==
X-Gm-Message-State: AOAM530YlykmOHy6OXQZm9MfixQ4EM7NS6JsRLllUaLZp0oruAqf5CA3
        L0irqBFYeyb9p9JLqFQaNM8=
X-Google-Smtp-Source: ABdhPJz2kYNQwUxQxkJPuRENDkny8o4TLotxnKyeItE1GPN9vo9e3uZ1fQwKly8CWxs6R8ewitlP2g==
X-Received: by 2002:a1c:6309:: with SMTP id x9mr11987480wmb.62.1616749799841;
        Fri, 26 Mar 2021 02:09:59 -0700 (PDT)
Received: from agape ([5.171.81.75])
        by smtp.gmail.com with ESMTPSA id p17sm9431395wmd.42.2021.03.26.02.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:09:59 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 12/15] staging: rtl8723bs: put parentheses on macros with complex values in include/rtw_pwrctrl.h
Date:   Fri, 26 Mar 2021 10:09:19 +0100
Message-Id: <09367497eed0c43d8e4745c50c2a20c6c23883c2.1616748885.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616748885.git.fabioaiuto83@gmail.com>
References: <cover.1616748885.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch warnings:

ERROR: Macros with complex values should be enclosed in parentheses
92: FILE: drivers/staging/rtl8723bs/include/rtw_pwrctrl.h:92:
+#define LPS_DELAY_TIME	1*HZ /*  1 sec */
--
ERROR: Macros with complex values should be enclosed in parentheses
241: FILE: drivers/staging/rtl8723bs/include/rtw_pwrctrl.h:241:
+#define rtw_get_ips_mode_req(pwrctl) \
--
ERROR: Macros with complex values should be enclosed in parentheses
244: FILE: drivers/staging/rtl8723bs/include/rtw_pwrctrl.h:244:
+#define rtw_ips_mode_req(pwrctl, ips_mode) \

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_pwrctrl.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
index cec9fc0cf794..688436cf3610 100644
--- a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
+++ b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
@@ -89,7 +89,7 @@ struct reportpwrstate_parm {
 	unsigned short rsvd;
 };
 
-#define LPS_DELAY_TIME	1*HZ /*  1 sec */
+#define LPS_DELAY_TIME	(1*HZ) /*  1 sec */
 
 #define EXE_PWR_NONE	0x01
 #define EXE_PWR_IPS		0x02
@@ -239,10 +239,10 @@ struct pwrctrl_priv {
 };
 
 #define rtw_get_ips_mode_req(pwrctl) \
-	(pwrctl)->ips_mode_req
+	((pwrctl)->ips_mode_req)
 
 #define rtw_ips_mode_req(pwrctl, ips_mode) \
-	(pwrctl)->ips_mode_req = (ips_mode)
+	((pwrctl)->ips_mode_req = (ips_mode))
 
 #define RTW_PWR_STATE_CHK_INTERVAL 2000
 
-- 
2.20.1

