Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE1C352E52
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbhDBRa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbhDBRag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:30:36 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92B3C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 10:30:34 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id g20so2805370wmk.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 10:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6DXbe4IYvmFdTJ6TZ9KJIXC4BttTk31KU7HbbVtW6IA=;
        b=j0Kj+KgNjhtrVZdfha6ltMQMvJ/xVSm0nDIT4GfkvYzY4fVgoJUXcN1bpkD9qN/W3c
         ZfUSC5WcYgo5x+hQ8Lr1LdSyy03g7lnsbzdq9THgG9CdMvBZZgnCCOxG2NoqXlr6Wa5m
         YkO/EsZANqS5D0f2RuntMeuvyWjhHXs47eFdK/irlAoNCOwkdYpEY4VhcdjG/fa2OXGt
         lW4kwEYLKWeLMvN59SXOdNh+eC7cBYwDiFK3Ybu1uzO9gx1g2bNm3qykF+00trs6sy2F
         +jgg3ninpF+Wb7sj8Odqq7J1dIW6xuFMSUNBeJIRQeIbfbS+Y1DIVo1oksqT2WG3mI+U
         jAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6DXbe4IYvmFdTJ6TZ9KJIXC4BttTk31KU7HbbVtW6IA=;
        b=TmYgqOhKttYKz5R18Wyih4JQudArSIkK97VVBAErwkm52yvYzHFYjC9htIWECC1Zw2
         u0x/hvWJ2eb+uccD2cLFZ71QuT041rNgB0zt5eCuxQS80f0IzmAKEAfWIQQgZAb8NRHC
         iOjAOqqK6czC4sFVNbmgNDD+cxxv648zEs+tTAJQkPETzv/zF8iWAyaObm/EW5etEa9G
         gEBkzglcPzUPY6N277lEYAgBxtnfZ3HQkQvuf7prEZUk04xnNCcmToGWsA4VQspy3YZj
         BEtffDveQWk2t9xNEoa9DC2D3eGa7HSakNT8akiZya6+KOlv20F7JyZXsJEXiKOKbRUF
         1ifA==
X-Gm-Message-State: AOAM532F++aW7490yOe+avU3kDBYBg9PQ2tuLftP8auS39Q4NOFsJCTR
        WQmYnKuf+XgxvFY5X3EylUs=
X-Google-Smtp-Source: ABdhPJwrYOiJuTpu7AWQJv7gLaYbZ35zFySo7WGpk7t/pGureytTFE06LaoMFhakfL/xgwnM7YOC+A==
X-Received: by 2002:a1c:a958:: with SMTP id s85mr13351580wme.138.1617384633468;
        Fri, 02 Apr 2021 10:30:33 -0700 (PDT)
Received: from agape ([5.171.81.4])
        by smtp.gmail.com with ESMTPSA id u17sm11882917wmq.3.2021.04.02.10.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 10:30:33 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 10/30] staging: rtl8723bs: remove unnecessary parentheses in if-condition
Date:   Fri,  2 Apr 2021 19:29:52 +0200
Message-Id: <72f5d8324886a072f0699040161953065da92997.1617384172.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617384172.git.fabioaiuto83@gmail.com>
References: <cover.1617384172.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following post-commit hook issues:

CHECK: Unnecessary parentheses around 'pwrpriv->rpwm == pslv'
26: FILE: drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:269:
+		if ((pwrpriv->rpwm == pslv) ||
+		    ((pwrpriv->rpwm >= PS_STATE_S2)
	&& (pslv >= PS_STATE_S2)))

CHECK: Unnecessary parentheses around 'pwrpriv->rpwm >= PS_STATE_S2'
26: FILE: drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:269:
+		if ((pwrpriv->rpwm == pslv) ||
+		    ((pwrpriv->rpwm >= PS_STATE_S2)
	&& (pslv >= PS_STATE_S2)))

CHECK: Unnecessary parentheses around 'pslv >= PS_STATE_S2'
26: FILE: drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:269:
+		if ((pwrpriv->rpwm == pslv) ||
+		    ((pwrpriv->rpwm >= PS_STATE_S2)
	&& (pslv >= PS_STATE_S2)))

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index fa06144337ce..09bf25940e92 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -266,8 +266,8 @@ void rtw_set_rpwm(struct adapter *padapter, u8 pslv)
 	if (pwrpriv->brpwmtimeout) {
 		DBG_871X("%s: RPWM timeout, force to set RPWM(0x%02X) again!\n", __func__, pslv);
 	} else {
-		if ((pwrpriv->rpwm == pslv) ||
-		    ((pwrpriv->rpwm >= PS_STATE_S2) && (pslv >= PS_STATE_S2)))
+		if (pwrpriv->rpwm == pslv ||
+		    (pwrpriv->rpwm >= PS_STATE_S2 && pslv >= PS_STATE_S2))
 			return;
 
 	}
-- 
2.20.1

