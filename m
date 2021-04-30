Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133FE36FCA9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbhD3OpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhD3OpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:45:12 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7B4C06138B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:24 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g14so23240870edy.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VSRdyXZZcxxoSZhQrgrWUXUUkaC+1Kk+0joSCnHO7Sk=;
        b=raecQFUEAjTAcD0ybJYZtycHV2pUBEPVmwqvZ4TDTGTI2HzieOua8IkaWpPW7K9901
         SKqqnFiaKpPH7OCk5K27cXNqSgU93EE4B8rjA4yWnN4V3qC1cqAX0i35uHe8dMx+YvJ3
         OedHYWYSASS5NIY+2iCowFCYrQullQJktDi3h3+ldZ7uCXv/s37VZrnHHyXHhwsSyusa
         +O4sIFUj4AH4f+iK3VX40Ua15RC2xQfUPwx+rMitLBaFGAbgXcAKumU5f8RtTYDcHKEz
         f0TzuoTZjd+1NMHAo60AtD6rEn/l4VU9EotWt7CBtfDjc6pb9g/8dsluNk/ZFUUlAMvG
         OGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VSRdyXZZcxxoSZhQrgrWUXUUkaC+1Kk+0joSCnHO7Sk=;
        b=c3H+pHgEDp2H5VjJCKGHRdbP1p+XYnVz2zgK1E9MRMnQGh9bJYCu9agPIK2lIUzjN/
         mWSarGFu2909qfcxZInpWLIRBwvVVLajt/oYWCpuqgMkh02Uk/t5amUBXMwDKqW+sPSw
         iIfD9ug3Zs27LHGhjk3XH7e8ZjdF6+8GLbi9k7S1hNjUI1+zBUO9AlNMxkYFMqScHagN
         iU5eydq02i9o65gl11aID7Eic+m/LvR9feBWOIYznTWphTXXwBqUjnkiX6guVEv32xgy
         9AMguWmt5faMqRlP8VV046gZXnzhsMdSHwRpj18xCYY7sEnQNVT4JuV5wj2KBOjE5Bqa
         s8Uw==
X-Gm-Message-State: AOAM5324RmwiRmz1cGQ8njz6/0MrS3FH/uwJueJn7dxvblSYoOQkLJWR
        O89xQSBFlsnUCm+U2P6j/eRPL2a1We4=
X-Google-Smtp-Source: ABdhPJyEZ6kdOPP7/wc0uNUsUa61ZyHPQf35fwMkOK2mg5JbBIL1985WeE5Ry6E1yW7ohkDUxEwT9Q==
X-Received: by 2002:a05:6402:b88:: with SMTP id cf8mr6366156edb.227.1619793862648;
        Fri, 30 Apr 2021 07:44:22 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id c12sm1599342edx.54.2021.04.30.07.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:44:22 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/43] staging: rtl8723bs: remove undefined function prototypes
Date:   Fri, 30 Apr 2021 16:43:35 +0200
Message-Id: <8a76e3dfd1fe754fa76b9bea91b2c7b672e45bca.1619793405.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove undefined function prototypes.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_PathDiv.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_PathDiv.h b/drivers/staging/rtl8723bs/hal/odm_PathDiv.h
index 7a5bc00c3682..de69d5ea6ffd 100644
--- a/drivers/staging/rtl8723bs/hal/odm_PathDiv.h
+++ b/drivers/staging/rtl8723bs/hal/odm_PathDiv.h
@@ -8,14 +8,4 @@
 #ifndef	__ODMPATHDIV_H__
 #define    __ODMPATHDIV_H__
 
-void
-odm_PathDiversityInit(
-	void *pDM_VOID
-	);
-
-void
-odm_PathDiversity(
-	void *pDM_VOID
-	);
-
  #endif		 /* ifndef  __ODMPATHDIV_H__ */
-- 
2.20.1

