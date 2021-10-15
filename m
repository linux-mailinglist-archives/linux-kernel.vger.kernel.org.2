Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B042D42F852
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241416AbhJOQh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241331AbhJOQhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:37:24 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1267FC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:35:18 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id g2so2991390wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ii0Rcd1OZY6A9ngAd7PfH7oobRIoZ+iXSEW5dgc0Nk=;
        b=UAkFY1k6VH0Y86E6yqm+bItm1aM0dLrGTPRKFDeiZJkjKFFId39ODi0QYihmhNmlIN
         zLJJJYvo5tB0LYFrDLsCWWiuPIqe5BSBqKJ0JMTJhaSqbKrp6l/LybW9bA06Z1vQ3286
         DYohQsT2DlW55FWGdA50w6I/JfaJqvkubQpCPjFOwP3jdEdGe8KeGqW3yNIrVUYwJ7SK
         gRNe88KZNZZQ1JfhihfNkBliXLRzDb6ZGWSpWLJGyUNRAOfOMsg37HxQo2XnP2PhwxNI
         WPryKdwC4nu0BOF7JbKUaook+R7Ve9/WDxNqf7qXoN9k1+mNLvHrcfwOEYqlmk0C+otq
         oy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ii0Rcd1OZY6A9ngAd7PfH7oobRIoZ+iXSEW5dgc0Nk=;
        b=WHk67uKkuip+20Eu91EhwGcDMnyrtq68tb6wdljunuTe/B/Tx0my3qA69fuTsyuRN2
         j7mF/sU6FX/TH336IgwOUhvPCyDn4imTATYXle006jgPN/eb1iF/lruRvuGwY3Q3epIF
         kbdp1VfKwM6bMwkSG8Da1i8dMuTTZeYaUafHs7wXYoX+HIQ5kMiZVrNbY1Ji0D3WLv5u
         RNz2XSz0s/bE6u0TJA2ojuwXCwCn6/aqmMUyCoIbbtTQlG/Wjubt8bsx2nMnupzzBJSz
         lsMmGr/43v4T4o+37PGaLGGff4HiHk+RBK+7A5KjHorWWzv5m7vawvOkcntBRXxCmTZ2
         JGqA==
X-Gm-Message-State: AOAM531xE1W7VA7sRB2XwlGNwpKDHGZP+OFVIasreeRmHo29Sp2jcDcg
        boWAsrz/IsCHbVbRZQCS7xs=
X-Google-Smtp-Source: ABdhPJz2vmkpyoZjJPYupCHQ2k9dP5U4ZrDYyRLaJDSnPBl5j5vzQSQnDkc3adfriwmQBptpHfVoCA==
X-Received: by 2002:a7b:cf24:: with SMTP id m4mr27305167wmg.83.1634315716732;
        Fri, 15 Oct 2021 09:35:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ad78])
        by smtp.gmail.com with ESMTPSA id c17sm5489593wrq.4.2021.10.15.09.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 09:35:16 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/7] staging: r8188eu: remove ODM_SingleDualAntennaDefaultSetting()
Date:   Fri, 15 Oct 2021 18:35:02 +0200
Message-Id: <20211015163507.9091-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211015163507.9091-1-straube.linux@gmail.com>
References: <20211015163507.9091-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ODM_SingleDualAntennaDefaultSetting() is not used,
remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c     | 11 -----------
 drivers/staging/r8188eu/include/odm.h |  2 --
 2 files changed, 13 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 627213392795..030bc7bd9905 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -1190,14 +1190,3 @@ u32 ConvertTo_dB(u32 Value)
 
 	return dB;
 }
-
-/*  Description: */
-/* 	Set Single/Dual Antenna default setting for products that do not do detection in advance. */
-/*  Added by Joseph, 2012.03.22 */
-void ODM_SingleDualAntennaDefaultSetting(struct odm_dm_struct *pDM_Odm)
-{
-	struct sw_ant_switch *pDM_SWAT_Table = &pDM_Odm->DM_SWAT_Table;
-
-	pDM_SWAT_Table->ANTA_ON = true;
-	pDM_SWAT_Table->ANTB_ON = true;
-}
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 435626f05fd2..21e08a9f8bf8 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -907,6 +907,4 @@ void ODM_CmnInfoUpdate(struct odm_dm_struct *pDM_Odm, u32 CmnInfo, u64 Value);
 void ODM_AntselStatistics_88C(struct odm_dm_struct *pDM_Odm, u8 MacId,
 			      u32 PWDBAll, bool isCCKrate);
 
-void ODM_SingleDualAntennaDefaultSetting(struct odm_dm_struct *pDM_Odm);
-
 #endif
-- 
2.33.0

