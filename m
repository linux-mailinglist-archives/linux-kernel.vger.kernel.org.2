Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4145C3DC1F2
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 02:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbhGaAYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 20:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbhGaAYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 20:24:11 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDD3C0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:24:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b11so8008897wrx.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FFK35TeNRCpJMMYpkUlLwh47HmF6IKjwmwo/sLbCW6w=;
        b=Lcg6BS7xI8uhI3Hfr1t1Z/fJuTqnIkWoXPP6ShMFwd9Sa5lAcskHPByd8V3usudexi
         pD15J5QVnQnw7tZAyWYjjXbDhqI9ptabQYGwn3ukbZaLc2D/M9fAgNwfabeK1y8GwUZ/
         oowYho3n9yodsGvi1uTjqngydqY4jqTRlNICZvIJWgWC3oizO2LE8PtPgxaiWj2c+sNB
         17a2x+vVdqtrIdFV5asjJ3aBhliiscyT4bxru3QO7SS5uVvt3b+0Wm6CIII7RLP4VhTQ
         opjCbJn8e7tdtv0MqZEe0kSnNW3tLa3Jn/h+ZVJdqnJ8Sa5oqrEWLmSREjU916DXZ+dx
         EDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FFK35TeNRCpJMMYpkUlLwh47HmF6IKjwmwo/sLbCW6w=;
        b=mZ4xtQ3I8H1SQ7DX53Gu94lDVVQmHfMVtXAiaBpsSoPzLBJJ8EdYAQguTqpnM+AqxS
         I/sN2U/LLmqMkoVnb8f0++mX8JQNjRiyMo9xnFUIpE5DFGtRivWsDcoTe/gA6jP21JgT
         KgC3ce/XxgOS4rjXaYLzlrPQvXNmdUHrRLkLD1jstG7AggeKomwR7EgaG6FX727GXaA5
         kABocYavxEBikPyCHtHfI6qLRFqBLri5TmJNn2i2k9+E0fNiV9A7m82d3L/gzmCXBOOB
         UHdKUOiTs6jBO3ePH5tU1vn7QMFABMmpbDGb7dqxT7hKwFtxBb3uLDwk9lTbNbviJHGN
         lTGQ==
X-Gm-Message-State: AOAM531jXa70Tjr2BlU7z9e4ZqV/nT9N6VwoCecrufsGc2E302D8nLHS
        7CXd6z6SVYKrMFbFAoNrAJP9Mw==
X-Google-Smtp-Source: ABdhPJzTaUA1lm0JfchlHpP/OENTOhTIcZW5LRPh9cFpvrS+a4KHUCzMVYWJXahOlz9VQ3djsw1r2g==
X-Received: by 2002:adf:ef85:: with SMTP id d5mr5861323wro.372.1627691044950;
        Fri, 30 Jul 2021 17:24:04 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id x9sm3236011wmj.41.2021.07.30.17.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 17:24:04 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/14] staging: r8188eu: remove DbgPrint and RT_PRINTK macro definitions
Date:   Sat, 31 Jul 2021 01:23:52 +0100
Message-Id: <20210731002353.68479-14-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731002353.68479-1-phil@philpotter.co.uk>
References: <20210731002353.68479-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove DbgPrint and RT_PRINTK macro definitions from include/odm_debug.h,
as they are called from nowhere and are therefore superfluous. Also
remove comment in core/rtw_xmit.c referring to DbgPrint so that future
confusion is prevented.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_xmit.c     | 1 -
 drivers/staging/r8188eu/include/odm_debug.h | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 7ecffadcb61f..c87ecf59b232 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -670,7 +670,6 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 				rtw_secmicsetkey(&micdata, psecuritypriv->dot118021XGrptxmickey[psecuritypriv->dot118021XGrpKeyid].skey);
 			} else {
 				if (!memcmp(&stainfo->dot11tkiptxmickey.skey[0], null_key, 16)) {
-					/* DbgPrint("\nxmitframe_addmic:stainfo->dot11tkiptxmickey == 0\n"); */
 					/* rtw_msleep_os(10); */
 					return _FAIL;
 				}
diff --git a/drivers/staging/r8188eu/include/odm_debug.h b/drivers/staging/r8188eu/include/odm_debug.h
index 38b07664b07c..c71d890ac552 100644
--- a/drivers/staging/r8188eu/include/odm_debug.h
+++ b/drivers/staging/r8188eu/include/odm_debug.h
@@ -64,10 +64,6 @@
 #define ODM_COMP_INIT					BIT31
 
 /*------------------------Export Marco Definition---------------------------*/
-#define DbgPrint	pr_info
-#define RT_PRINTK(fmt, args...)				\
-	DbgPrint( "%s(): " fmt, __func__, ## args);
-
 void ODM_InitDebugSetting(struct odm_dm_struct *pDM_Odm);
 
 #endif	/*  __ODM_DBG_H__ */
-- 
2.31.1

