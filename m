Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1251F34B79B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 15:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhC0OZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 10:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhC0OZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 10:25:10 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D51BC0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:25:10 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v11so8361028wro.7
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VT4u0yWArkExpu+HD8Gp/ujdm3PNXa++2YFnDEEI1cU=;
        b=VfMDfLKtxTYe8yFatS8Ezh1xcxNj3IerF1Vva1EW7brCXiCk8nB0WyYpjb3CKeO5Pd
         +90BMwsJdvCnTdOzPVfwfqRi6TwbzIy1OI/H3UPelCpaNNUA6V0WSgtovlqhBWFraYm7
         +isrOo7HMmxT/seuuLGwNq2Q8yvGhiBRVQYU1CDr0HqKIe9OdXIQJFLts2RzjRqmUPLJ
         uXIr5R/j5ca93nfGXbqjB8hqJcFhP2KkDy4zsA+ch6xb2HUUeVXxwzj7K5V/H6l6vRXX
         YF5Cdg2HMifGZpaIKzFnrZVQUGy8bJRr04QgydckqADm5I670jhSx0Y5S2otHDgt/dQJ
         arfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VT4u0yWArkExpu+HD8Gp/ujdm3PNXa++2YFnDEEI1cU=;
        b=eK6UGptijWcz3wbraZbPqy5qw8FEf/A84QA3v7bVshtG/YE82sS57F9AGlGFQGRwd0
         eufuZSkjjq1aCDEouV2UKUOxNgS+GXVFHaLo5JgPrC5BkpUfjrSN3/qjLqvnvTj6jW7F
         f5X+HtN23w6oEVV6ivuC13UI/tOUIx6Mc4UkHwW7wu+rm66pv+ktjPKQyPx6ZON48eVe
         YOtwZ+FhABZH+OYURlnv2ngFX3hb2+zf1NC9lEsPpXUEFbsYD7KoacA6IZPo2Bxxfh/h
         Pwdma1AGfm0qwE9QJNcv1dhAK4CUmDagACcSq74vNj+TT4cHYsVXqCGDkUBt/UHu8Qii
         046Q==
X-Gm-Message-State: AOAM533FffHRux6/nMjK6YR6EjmInKCpalZcazelwwH2/C1KcCKeWq9r
        +3F9GOCG3vwysb9Nfmn+v9M=
X-Google-Smtp-Source: ABdhPJwIiTTZkmheIaR9EVTNesJLkMk5Swe/7AcwDRcpDXcpHkKbPJx40cFpKutaHejCg7DhEcUc5w==
X-Received: by 2002:adf:84e6:: with SMTP id 93mr18847439wrg.376.1616855109014;
        Sat, 27 Mar 2021 07:25:09 -0700 (PDT)
Received: from agape ([151.46.211.242])
        by smtp.gmail.com with ESMTPSA id s83sm17566509wms.16.2021.03.27.07.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 07:25:08 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, david.laight@aculab.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 13/20] staging: rtl8723bs: put parentheses on macros with complex values in include/rtw_pwrctrl.h
Date:   Sat, 27 Mar 2021 15:24:12 +0100
Message-Id: <b3b7cf5ae7b0c1c07a629b618fd86a7b89331b33.1616854134.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616854134.git.fabioaiuto83@gmail.com>
References: <cover.1616854134.git.fabioaiuto83@gmail.com>
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
244: FILE: drivers/staging/rtl8723bs/include/rtw_pwrctrl.h:244:
+#define rtw_ips_mode_req(pwrctl, ips_mode) \

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_pwrctrl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
index 36d9ec82a7dc..6b2be97c2c07 100644
--- a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
+++ b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
@@ -89,7 +89,7 @@ struct reportpwrstate_parm {
 	unsigned short rsvd;
 };
 
-#define LPS_DELAY_TIME	1*HZ /*  1 sec */
+#define LPS_DELAY_TIME	(1*HZ) /*  1 sec */
 
 #define EXE_PWR_NONE	0x01
 #define EXE_PWR_IPS		0x02
@@ -238,7 +238,7 @@ struct pwrctrl_priv {
 };
 
 #define rtw_ips_mode_req(pwrctl, ips_mode) \
-	(pwrctl)->ips_mode_req = (ips_mode)
+	((pwrctl)->ips_mode_req = (ips_mode))
 
 #define RTW_PWR_STATE_CHK_INTERVAL 2000
 
-- 
2.20.1

