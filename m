Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5344F3DC1E6
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 02:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbhGaAYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 20:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbhGaAYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 20:24:03 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C767C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:23:57 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id p5so13343168wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hqdwyoZf1vpfOIbIS80UeAc68MaSamPymPd5+ezVtws=;
        b=aIu4Jq5Bo+Meo+3tqF3/Jj7g9Z9pxGGi0yugNf701A6exyKd2qndeExTN8iPZnocSM
         LQa6Mbd8W4+2DDe9htwOSarlMDs3kx5GHzb6IYBRo3MzqqaK+w0yiuu6RvypY/ZU8e8I
         XRNGwOExB18t0YREJ3ucElEAwA6OxklEfAWJgmlTEOwvlOdhHxZlLvG0/y4W5qKvONIU
         Id6P4A45za5gjlEK9SsOkh36WcaJBbYzdkeeBWcNn55wCNN30q2ZKhZ+H+dAavH1g8sN
         T7IlgFMJ7GgCIOjw46VXAQJtsfLyhLD/c6mXnSUrUESTaP8ZIqS+6wTte36ftKkAMpoa
         GV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hqdwyoZf1vpfOIbIS80UeAc68MaSamPymPd5+ezVtws=;
        b=oxcZmd1dcRyq6fZGFgPc/kml1Hpk47/PLjc1KzJe+dfdDwM2WCuSUEM1Mk0c+OxA6a
         f5+96EapXfsdWnLJNfj+gzXEJb0T1kwe6C2mcWiVN8i/M0O/th2ykmcvMkd+GzF7J4ly
         7UznodJvr/twAsPQdhoZyibfiSyx/ae2Yz6Cm2l8yMKCrZa31IdPLTmHA7w+LJCq3qf+
         RyCeh4Ygalj8n32KbNog3tcYB2jz0OOL4wh6KJhVqG9nQNPPpmOJoJORrN+wmGM+DIc3
         wutKQ/kO83aXoQhVA1VUNPjMB7yubAciMH1xMv/pzxl/MdM+0dCrzOszsFoG2gGFntzL
         Qn0A==
X-Gm-Message-State: AOAM530Hd1IKTwE552n8fGkBW/5b18SOrxOAjOJ/QoZvm24LdihiJbME
        fmhX7exLWRkXOdUfdiXCgjzj/Q==
X-Google-Smtp-Source: ABdhPJwN2UYnFCkHe4DY46hN5JwO5uqWLzjxRRf9JoWtHgtih2CapAv2i1LaaRFVWod4Ofy1Aj5RQw==
X-Received: by 2002:a5d:5106:: with SMTP id s6mr5714904wrt.359.1627691036155;
        Fri, 30 Jul 2021 17:23:56 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id x9sm3236011wmj.41.2021.07.30.17.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 17:23:55 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/14] staging: r8188eu: remove ODM_PRINT_ADDR macro definition
Date:   Sat, 31 Jul 2021 01:23:40 +0100
Message-Id: <20210731002353.68479-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731002353.68479-1-phil@philpotter.co.uk>
References: <20210731002353.68479-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ODM_PRINT_ADDR macro definition from include/odm_debug.h, as
it is called from nowhere and is therefore superfluous.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/odm_debug.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm_debug.h b/drivers/staging/r8188eu/include/odm_debug.h
index 171fc5cbf27c..53ab6debb6f3 100644
--- a/drivers/staging/r8188eu/include/odm_debug.h
+++ b/drivers/staging/r8188eu/include/odm_debug.h
@@ -108,19 +108,6 @@
 #define ODM_dbg_exit() { DbgPrint("<== %s\n", __func__); }
 #define ODM_dbg_trace(str) { DbgPrint("%s:%s\n", __func__, str); }
 
-#define ODM_PRINT_ADDR(pDM_Odm, comp, level, title_str, ptr)		\
-	if (((comp) & pDM_Odm->DebugComponents) &&			\
-	    (level <= pDM_Odm->DebugLevel)) {				\
-		int __i;						\
-		u8 *__ptr = (u8 *)ptr;					\
-		DbgPrint("[ODM] ");					\
-		DbgPrint(title_str);					\
-		DbgPrint(" ");						\
-		for (__i = 0; __i < 6; __i++)				\
-			DbgPrint("%02X%s", __ptr[__i], (__i==5)?"":"-");\
-		DbgPrint("\n");						\
-	}
-
 void ODM_InitDebugSetting(struct odm_dm_struct *pDM_Odm);
 
 #endif	/*  __ODM_DBG_H__ */
-- 
2.31.1

