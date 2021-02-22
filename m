Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6888321ECF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 19:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhBVSHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbhBVSG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:06:59 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC78AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 10:06:18 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id z190so13487795qka.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 10:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w/1v7qcxV6sXFq3hxXWf+zOxG2zTiP0+4CUMaFeTsMk=;
        b=hh90LbgHh4HvFm440ikVfcEEOikR/+r7DS0iYKRlzm9tZKNHikQxp8biTqRYaBhgYE
         8b6FdvJegN2lSjQhNg4sn8cTY+fYHfwRtZAV5wOfM3v7N0N8+9X2Ml6LcjOF1ZFv5cNa
         BGAHcVykRnvgR0eoUty0oE7GUYLECpZPcX5gY7gnwCtxsl1qh3lMBBJrBL+CpDL5cQfv
         WbmhA1qrC/WLJGy+c5pjRopHnWsW8rKzfsHVG6yE/wkm1oixSm1hEZwILhgBV1HwLAto
         9xGVj90eU5+zG/Mu+xuDR3O9hT98U0rG2/A7c04DkFOsIpYmJgSx4is9UGKEc6Fx+th7
         8BNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=w/1v7qcxV6sXFq3hxXWf+zOxG2zTiP0+4CUMaFeTsMk=;
        b=H8uA7UgOo0Vm5XasLMIUqfUctBtuXHOVXPjG/Q3Rglo+n3CXv6xbwKV2dI1jUrCZZm
         6Kqpqwz7+s6Uxm2BD6pKWKdnZDAAPqbZTZ+d7UH3+j7pmATlcgdbd7ro3N4jM7AP7viR
         A8Cp4jv80g38oJeG8Bi7qjozafHPXBZFCHtB1iTo+NTJjBG/JkclggL4xYR1fXTHPczu
         myjdfffe2AZpa/jRfq76Oqyx/6t/6QwnOiKRH3u22RZ9Cxy08737zGYOe7yyt4xyVEfa
         Qij+FhiC2qutkpFUM8t1EsSmNVmbV4axfK9esYj7PBInfsBZgCM0KSZY7pleuA3Ke27h
         iJLw==
X-Gm-Message-State: AOAM5325HINs05ikIy7e7ob6sGFuHgko+J33V93bVXLBQGy2heeQQEqn
        aTS2dLx/NlcUsJ910us4hoY=
X-Google-Smtp-Source: ABdhPJwz0uUQuS6SrOxnd9U5qO9ZiLgAHcC4GWDAyuSrpRSFXyQDaZW9Y29QL3L9YkZUF7/d+C+TcA==
X-Received: by 2002:a05:620a:e16:: with SMTP id y22mr2944198qkm.86.1614017178085;
        Mon, 22 Feb 2021 10:06:18 -0800 (PST)
Received: from localhost.localdomain ([208.64.158.253])
        by smtp.gmail.com with ESMTPSA id c63sm13109242qkf.8.2021.02.22.10.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 10:06:17 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH] staging: rtl8192e: fix kconfig dependency on CRYPTO
Date:   Mon, 22 Feb 2021 13:06:07 -0500
Message-Id: <20210222180607.399753-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When RTLLIB_CRYPTO_TKIP is enabled and CRYPTO is disabled,
Kbuild gives the following warning:

WARNING: unmet direct dependencies detected for CRYPTO_MICHAEL_MIC
  Depends on [n]: CRYPTO [=n]
  Selected by [m]:
  - RTLLIB_CRYPTO_TKIP [=m] && STAGING [=y] && RTLLIB [=m]

WARNING: unmet direct dependencies detected for CRYPTO_LIB_ARC4
  Depends on [n]: CRYPTO [=n]
  Selected by [m]:
  - RTLLIB_CRYPTO_TKIP [=m] && STAGING [=y] && RTLLIB [=m]
  - RTLLIB_CRYPTO_WEP [=m] && STAGING [=y] && RTLLIB [=m]

This is because RTLLIB_CRYPTO_TKIP selects CRYPTO_MICHAEL_MIC and
CRYPTO_LIB_ARC4, without depending on or selecting CRYPTO,
despite those config options being subordinate to CRYPTO.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/staging/rtl8192e/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8192e/Kconfig b/drivers/staging/rtl8192e/Kconfig
index 03fcc23516fd..6e7d84ac06f5 100644
--- a/drivers/staging/rtl8192e/Kconfig
+++ b/drivers/staging/rtl8192e/Kconfig
@@ -26,6 +26,7 @@ config RTLLIB_CRYPTO_CCMP
 config RTLLIB_CRYPTO_TKIP
 	tristate "Support for rtllib TKIP crypto"
 	depends on RTLLIB
+	select CRYPTO
 	select CRYPTO_LIB_ARC4
 	select CRYPTO_MICHAEL_MIC
 	default y
-- 
2.27.0

