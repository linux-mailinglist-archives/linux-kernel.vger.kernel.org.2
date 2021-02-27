Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37876326F27
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 23:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhB0WX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 17:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhB0WXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 17:23:54 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744E0C061786
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 14:23:13 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id d3so19390880lfg.10
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 14:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rfZlWxI/R5xeKS28z3X5cfpl9ggNIMoV6qqOm9PUtc4=;
        b=SQQKwE2G7ik0j8QvgTl2ClhKr4v7QE/u6FU1kJmegjXXJwhqD7W1I5A00X3v0xMEZH
         WpABduC6wgZ6gvJIaVFkc0llCt8DBbALHyyQtd9JEJ2WhTJVPd/H6G3VpK7ekJq/TKLG
         i9T4a7/aDFFagVCEQ4SLhR05SI4KlbGlZt+LE1G66U7xIiBCXY9DSTG95AgZK9sc1LGU
         HVKehPgL35ujf2sLHL+Z2Ml102+1y+21junHnHpYVqnMVl3ln0vD5Wfy6SoNR4YIrC/h
         pFqR5dg/v+B0+eyrnIcEh3c0J+5SjZL+7fkDiUSwvmeYkF8KKhpgEBx/FHqz3AH5RN/5
         xBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rfZlWxI/R5xeKS28z3X5cfpl9ggNIMoV6qqOm9PUtc4=;
        b=pmMsfOJ9hqB1+U3M3eMQjcQL+6wUbIWLlMOrp9KFsobTEPYWSe3ZXVsAD5DHI9ukDt
         MkT0/zv1dgPlq4TiTqwQUjN6AjYy4oK4GMZC4Rf7+CIQVzkYAo7e8OOAiwmjiJZO2Iwo
         AzTZaTq+lEiyZ/10hohuznavNgn2vBf7c9c1t7j11ae7794uGSeh8B2r2Xg3rtYtfNit
         XTLEx5mrpqmCh0IVfZnwHuLebgu+IYQp14xseYVuBXcaucQ5lsPILMgxgzMP0YRITwDb
         O0UrSr9AwSVaeRex4Vigg1f8l707yU7qKhOjYj8/Z2nSG8Jxr8H3GP5qtrrkUqoreOR+
         HeBg==
X-Gm-Message-State: AOAM533dxeir+17ELKNyibxilSiLKfkG12kFpc1YijETIpj4ek2xhxn+
        OD7tI9lICXdoNbpYLtm4i/o=
X-Google-Smtp-Source: ABdhPJy3FSYBMb4amkT06YcI80Ky0u5a2Vh8ts6I27irMGLcuXgrJfIBtbcOYxH4Ae27AG1pvVPsYw==
X-Received: by 2002:a05:6512:33b6:: with SMTP id i22mr5230727lfg.251.1614464591978;
        Sat, 27 Feb 2021 14:23:11 -0800 (PST)
Received: from alpha (10.177.smarthome.spb.ru. [109.71.177.10])
        by smtp.gmail.com with ESMTPSA id u12sm1841988lff.250.2021.02.27.14.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 14:23:11 -0800 (PST)
Received: (nullmailer pid 581551 invoked by uid 1000);
        Sat, 27 Feb 2021 22:23:10 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        Pascal Terjan <pterjan@google.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH 4/4] staging:rtl8712: replace cap_* definitions with native kernel WLAN_CAPABILITY_*
Date:   Sun, 28 Feb 2021 01:22:37 +0300
Message-Id: <20210227222236.581490-5-insafonov@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210227222236.581490-1-insafonov@gmail.com>
References: <20210227222236.581490-1-insafonov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cap_* definitions duplicate WLAN_CAPABILITY_*. Remove cap_* definitions,
improve code consistency.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8712/ieee80211.c | 6 +++---
 drivers/staging/rtl8712/wifi.h      | 7 -------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8712/ieee80211.c b/drivers/staging/rtl8712/ieee80211.c
index b4a099169c7c..13fc3c1ec0db 100644
--- a/drivers/staging/rtl8712/ieee80211.c
+++ b/drivers/staging/rtl8712/ieee80211.c
@@ -173,11 +173,11 @@ int r8712_generate_ie(struct registry_priv *registrypriv)
 	ie += 2;
 	/*capability info*/
 	*(u16 *)ie = 0;
-	*(__le16 *)ie |= cpu_to_le16(cap_IBSS);
+	*(__le16 *)ie |= cpu_to_le16(WLAN_CAPABILITY_IBSS);
 	if (registrypriv->preamble == PREAMBLE_SHORT)
-		*(__le16 *)ie |= cpu_to_le16(cap_ShortPremble);
+		*(__le16 *)ie |= cpu_to_le16(WLAN_CAPABILITY_SHORT_PREAMBLE);
 	if (dev_network->Privacy)
-		*(__le16 *)ie |= cpu_to_le16(cap_Privacy);
+		*(__le16 *)ie |= cpu_to_le16(WLAN_CAPABILITY_PRIVACY);
 	sz += 2;
 	ie += 2;
 	/*SSID*/
diff --git a/drivers/staging/rtl8712/wifi.h b/drivers/staging/rtl8712/wifi.h
index b7889ac3dce9..f941efb1f4e2 100644
--- a/drivers/staging/rtl8712/wifi.h
+++ b/drivers/staging/rtl8712/wifi.h
@@ -278,13 +278,6 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
 #define AUTH_ODD_TO				0
 #define AUTH_EVEN_TO			1
 
-#define cap_ESS BIT(0)
-#define cap_IBSS BIT(1)
-#define cap_CFPollable BIT(2)
-#define cap_CFRequest BIT(3)
-#define cap_Privacy BIT(4)
-#define cap_ShortPremble BIT(5)
-
 /*-----------------------------------------------------------------------------
  *			Below is the definition for 802.11i / 802.1x
  *------------------------------------------------------------------------------
-- 
2.26.2

