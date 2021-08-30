Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1F73FB588
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbhH3MF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236943AbhH3MFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:05:36 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6079EC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:04:42 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x6so13856045wrv.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/i9rKJcPxsCwJ6kNIOQV+qImhOF+UG8aTJL9Wyv+hOs=;
        b=Z8ZxKE3vgmgSAWDZVVC5/8vEObPeybEpmS3Eo8ppspSkw43KLlKKIWu7K+LRZCBwuo
         sjvFtX1t/zGGSDhg/QwXSq5c3dnpdumuhVpCwORY35BMozhSbs6xkT1lCfdJBc3uuolP
         DETv4ZNLqq7B6lzK4QanIGuZXzAbmV8Hks5XzU6f64YPf4MwZLpa2EZq/4AtSGm1a+nR
         0mXe6r0wmKpC2iN+pknrThIomc08Y4V+tmfURb4RiQoxrkudY0o7Zh5Hv9o5IqrRPBaW
         Iz38LyfipFRhh4+O8sTBBY8yxdBlByyfNKp75ZNMVTCpWapl3dQWnCdjLGxT5WpHvgSN
         0Ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/i9rKJcPxsCwJ6kNIOQV+qImhOF+UG8aTJL9Wyv+hOs=;
        b=nY8OJRj1JeJQJamCgn4nu4W1c/8a0jqE4ACTX2EHOwQedmWxSbgr1tcUemdF3BRGiD
         Wm8paZB3ef2ksMet1eQyhH/G81xbvdVnAngaOxjPlcm38rQE9EIF2m8ZDuXrasyHR2pr
         88o0pKd17ZHqJeTgAIzNtlXq8MT5D2ZP3L/GJshaGPKjcvCHqkCcRSFiJkVUfGL8c3Kf
         PPnrrR/TXSGe5BkcJ11uaGbdnxXUC+HyfT16w1IXbMEdaasdRj3VZrYiRnFq0aQU8bCQ
         KRx/If2OvhwlizuAjzURyEzSm48gSdGcoUd1WGCw0MLkVOYye95DMVFej6Chdb9Xd/1o
         097Q==
X-Gm-Message-State: AOAM530qKR/gHIw/BfrsJaZwft3W+MjasA8UI4XCZPW9rr6cxf35lRdE
        ZhAVtyzM5Vyh7RPq+/TrZb3t/+SgmEgG9g==
X-Google-Smtp-Source: ABdhPJz6FHW97fyClmIKQgF+1gRc+BTTknCGsc9HlU+jmUMqfWtMtLdLwEwcYl3kAmIkx05VMZ7lHw==
X-Received: by 2002:adf:f541:: with SMTP id j1mr24554982wrp.180.1630325080928;
        Mon, 30 Aug 2021 05:04:40 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id f18sm13184195wmc.6.2021.08.30.05.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 05:04:40 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 8/8] staging: r8188eu: remove unnecessary parentheses
Date:   Mon, 30 Aug 2021 14:04:20 +0200
Message-Id: <20210830120420.5287-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830120420.5287-1-straube.linux@gmail.com>
References: <20210830120420.5287-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses around a variable to improve
readability.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index f76c762ccd4b..952ad3eec5bc 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -1038,7 +1038,7 @@ void rtw_macaddr_cfg(u8 *mac_addr)
 		DBG_88E("MAC Address from efuse error, assign random one !!!\n");
 	}
 
-	DBG_88E("rtw_macaddr_cfg MAC Address  = %pM\n", (mac_addr));
+	DBG_88E("rtw_macaddr_cfg MAC Address  = %pM\n", mac_addr);
 }
 
 void dump_ies(u8 *buf, u32 buf_len)
-- 
2.33.0

