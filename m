Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599A5401FB7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245756AbhIFS2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244520AbhIFS0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:26:30 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924CBC061796
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:25:25 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id me10so14935338ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TwtcbicrqVzcOBpKF8LIDrbovh6REX7OM2xtMOK5yVY=;
        b=jDb/h7ghQCK43z70Ev4VgXoRTdDVYwtu0CpDR0aCDvDB8SoM2xnsuK00Qln4GeYz7v
         sNp3C1pSjWfrF+/PLzHp8griqDmQ4M4ZBt+rj1/AKbchVW8VWTuS4fp19TIqQLCoDFTu
         rnyxoISVu2iUHsej4Nbbs3p/0cOi7GIe5qg6aj2r/ELRWmRGHvphe6+hbsR5zFQiurGi
         X2ahN6EM/GAhfv4BFy8fBXZxzAyA8V5yhUMzsodXxd/IMgWdybg4lIYFl1i0kLlW4F7+
         kuc2lWoSNUrmETwBY9XEvXhDHybo932ZgLQVLJjqW7x0Zqz5qmLLiTW7SE2gkvcqV4if
         sZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TwtcbicrqVzcOBpKF8LIDrbovh6REX7OM2xtMOK5yVY=;
        b=Tifgq4OuiVKNqhrtlQg2R+fyZnwnYU54nBd5KDLWHQ8PNVfHB55l/T+8JaMhYDF6eF
         JR+zERXrTOJaOCBvBmO0wZSF/AJdHjD/TjsuQ6MR1PrDEglgUdMZrb9DZakMTr69kH2S
         clwdyv/CbU2N9busPB3yzYWT6UOqGHRb80gXPjVpzhoHV74MnINTKMDp+GCAZ9oSfnaX
         1/f1hljSkHN5zMC0UT0+4/VgkWIf1CSeJnp41/u4hnbyNw4NRk8rkCLjKwizqXB1IbD/
         fg48FzDUWKuUlzfj0Rjs2LGMu7jkIf/E1JVnqDZuMEKogErh4fv+NH9em03rYtG9KNk4
         33SQ==
X-Gm-Message-State: AOAM531itnR3PSanZBNLdzuXTUnMnOHpXptpXOL1vxLSEtIvOoctSMxx
        6TadrJzPcCgcRackrwSDdIw=
X-Google-Smtp-Source: ABdhPJwOWjqmk4L1tJeTF6OZOQp2AT1m485iGOMTWvKX5OVXGmDA4kTvJ+Tkrd/I7awVnxY3ppybjw==
X-Received: by 2002:a17:906:6717:: with SMTP id a23mr14435832ejp.358.1630952724125;
        Mon, 06 Sep 2021 11:25:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id s25sm4284492ejq.17.2021.09.06.11.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:25:23 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 31/40] staging: r8188eu: remove useless assignment
Date:   Mon,  6 Sep 2021 20:24:29 +0200
Message-Id: <20210906182438.5417-32-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906182438.5417-1-straube.linux@gmail.com>
References: <20210906182438.5417-1-straube.linux@gmail.com>
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

