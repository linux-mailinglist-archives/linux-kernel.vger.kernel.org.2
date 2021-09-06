Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FD840203F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 21:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343938AbhIFTGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 15:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343610AbhIFTER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 15:04:17 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91478C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:03:09 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id jg16so15155904ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 12:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TwtcbicrqVzcOBpKF8LIDrbovh6REX7OM2xtMOK5yVY=;
        b=OyLQzHK3JgBRyB9+COmigSykd2tQ8sKimgm7NaGKG2Sijc+slNXGdj2ZK5/KzGf2TS
         Mo2RHg1HbD9QP96oCWMQJ9G/YjPb8H/NfT1Qax+yEoCZOosu8BWEnPul3xiPJ0IxlWY4
         zz4HgtFK3+1UUbYkmXOKM/dAEJ0GbHRQU2Ae35jC4V4wSRSLeUXxq21y/tG3HKXaZcp0
         bmhqsgIXVYuGgRLPiX70xhQA/IaxKuRDhIhy2Q4/FvQkYWc0dkcJRwUHiWTmtPCQjBNt
         b45AtLQEqAdxvbs2AtIrAcwISjTvw8G3oDgWbKnalPmwaArO0Z34ASQFexDS8AgjHdFh
         9+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TwtcbicrqVzcOBpKF8LIDrbovh6REX7OM2xtMOK5yVY=;
        b=fzD+1Nw/ZG6RdcDV4V307Mq7C1fFX/kz0AxgfNpfVT2UTgd+w1EMmbkR1kEyUhfaPg
         7OUS9N5a+EA6XbqQEnGiskobvxRM8bOA2NeyhC+3E9jjJKzpamByR93kkA4poFBKCutM
         reVc601cjuNMKukeBJBY1Aet+hskgqI6D/MUww22ngk2zx3aglNPEw8s0SHGEg+re2mI
         Dzc3+l7dmRMwaOrrutqX1zL/iRWNuI1b4MshMk1nB33kZa6CLuNR/twnRKOrpXz9M3P+
         MqgvWB6JRqnfR/twYr69/bHdFZQ28WyPxQOv4TX2hiMvOOfrYV3yrwCoLtvi7cc26ytc
         shHg==
X-Gm-Message-State: AOAM530p83ZVSg+HM0dmxEcC1M2pQBDr3svPmgVwpLoll7gQM83AmLsv
        PX8aMBjFbTbAVxoq7rP4KJc=
X-Google-Smtp-Source: ABdhPJxnCGGYTxLXKxgRw/ESB1IVe0JNCooQAQ5II1cSJ0dXub0qnuov20nZ7eEvN42r5ggy9D3WFw==
X-Received: by 2002:a17:906:2642:: with SMTP id i2mr14900238ejc.323.1630954988245;
        Mon, 06 Sep 2021 12:03:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id k15sm4372018ejb.92.2021.09.06.12.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 12:03:07 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 31/40] staging: r8188eu: remove useless assignment
Date:   Mon,  6 Sep 2021 21:02:14 +0200
Message-Id: <20210906190223.11396-32-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906190223.11396-1-straube.linux@gmail.com>
References: <20210906190223.11396-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local variable badworden is set to a new value immediately after
an assignment. Remove the useless assignment and initialization.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index eb30a6fcd8d0..33d4e534f05e 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1438,10 +1438,9 @@ static bool hal_EfusePgPacketWrite1ByteHeader(struct adapter *pAdapter, u8 efuse
 static bool hal_EfusePgPacketWriteData(struct adapter *pAdapter, u8 efuseType, u16 *pAddr, struct pgpkt *pTargetPkt, bool bPseudoTest)
 {
 	u16	efuse_addr = *pAddr;
-	u8 badworden = 0;
+	u8 badworden;
 	u32	PgWriteSuccess = 0;
 
-	badworden = 0x0f;
 	badworden = rtl8188e_Efuse_WordEnableDataWrite(pAdapter, efuse_addr + 1, pTargetPkt->word_en, pTargetPkt->data, bPseudoTest);
 	if (badworden == 0x0F) {
 		/*  write ok */
-- 
2.33.0

