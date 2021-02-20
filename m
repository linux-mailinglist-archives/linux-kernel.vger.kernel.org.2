Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78BF320662
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 18:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhBTRXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 12:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhBTRXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 12:23:14 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A92AC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 09:22:49 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id z6so5820057qts.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 09:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R0A6YOTC5OENL7axcZ+QpFZ8S/KWCKBZLWbggOyg4tU=;
        b=nUksVtlGmG2giMPchAu/ssZ/ot36wJafNSX9iiXZvnSADLAE/yl8rlPaQXhff5ufx2
         jz8xxma8IvwnfgMJDNGK1jQO0RIU9a2FNs8lcCvDv9rwveWz1QoY93X1ni5DmH7yyPnu
         zRMqOeB3ypAnl6WsGPLvVa8pRsihkt7wGIom/ZJoTA/C8WxaNT0ZYt1RZeUNvH7W46Dn
         0EsmIbJ4RuxHZD0/djWiueJx6IXOmX5/Kfa0B9IZFWBhDn1S2rwruEdsflr3pQAUx7KK
         77JJBplnJPA1u7TG6B+YiPbp6ztSaTaOoTeGGmEqDb8g4N8PVSZTBsPwGUPUMkLCzVGK
         4zig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=R0A6YOTC5OENL7axcZ+QpFZ8S/KWCKBZLWbggOyg4tU=;
        b=Zi3DPmb2RuPr0/ewgU6HmWR7A1UhDJS4Tq0AjN6i1rfnBJ6NqVVVpfzK3hLycY/khd
         X50Hz4LT6e0+UZO+6EU8OOpdrLMB6Rp1p1cVOgj8GX46K7EvcWs3rEHKRPSjjoex84Q4
         S45QmS/gsmj1AgrAx+Bp5gpmK29+4iA+hAxcdWOwhuPSwfkhV9XW+TEQ63ziANy+i28U
         JYCP9y+Msficbe0DNUf9SVr90B39iGItWqx9ljHsMaaEtLEucXluJlDqKQMTrTq1uXwB
         pTUPqVDYpvDpI+EBJDhAaK6/IqP2/mXUxPqUm15VUEBIBu7WKN4qzNNRJnum6RjkNFbr
         7qaA==
X-Gm-Message-State: AOAM532P0cj+BoMHd2aPC6EeZMx1TFk0a6gel4uJ/t5GCwmWYl5E+2CD
        4ORRepZMaAiC+HktCUK9u3txXUKW4Q7UPJWr
X-Google-Smtp-Source: ABdhPJyBSt/Uf47WC79Gf+MXiDIPX9YElY5QrMheyVFzM85zZggudjy9Ny2qUze4d+k6cqhI9ssKOg==
X-Received: by 2002:ac8:6b57:: with SMTP id x23mr11069661qts.278.1613841768284;
        Sat, 20 Feb 2021 09:22:48 -0800 (PST)
Received: from ubuntu-mate-laptop.localnet ([208.64.158.253])
        by smtp.gmail.com with ESMTPSA id i5sm7685949qtw.3.2021.02.20.09.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 09:22:47 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH v1] Staging: rtl8192e: fix kconfig dependency on CRYPTO
Date:   Sat, 20 Feb 2021 12:22:43 -0500
Message-ID: <4036376.6NakBfNh49@ubuntu-mate-laptop>
In-Reply-To: <YDCz/6gQgp07NGw2@kroah.com>
References: <8483722.hVsnvgcxvV@ubuntu-mate-laptop> <YDCz/6gQgp07NGw2@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From fd949b204eeb6b685bbf5dc9a329c931fcf8b0da Mon Sep 17 00:00:00 2001
From: Julian Braha <julianbraha@gmail.com>
Date: Sat, 20 Feb 2021 12:07:30 -0500
Subject: [PATCH] staging: rtl8192e: fix kconfig dependency on CRYPTO

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


