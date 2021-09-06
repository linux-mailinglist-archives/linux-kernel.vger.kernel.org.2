Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B5A40200A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245181AbhIFS4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245010AbhIFSzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:55:32 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F1CC0617AD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:54:26 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ia27so15055694ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TwtcbicrqVzcOBpKF8LIDrbovh6REX7OM2xtMOK5yVY=;
        b=AImbGSYKsaLtOmL8z5N81kKZ5eebW/IOgSRJcAu5W1/txu83E5L2yrJvgvux/D7nEV
         D4ePPv+pobdOPIRJy6Wv4JvDDv10v+wWaW21Mr3x+tBAh3BwhxQLDmDlEXYx3fzfwU9/
         qU3aGA3QxdKH/aDlghMTzcN4smx0MEHF9OP7PURIm+YhBTn6r7snERPtjV3zXgGf6chl
         I2vTXEjDL6QIFe6wJU269onjXg3tWXAUH45SShfGiveLN/40juy99eMG6mPs87RDmVDy
         kRZUr5irilc0dAx0bWnC/F2rYZE/2foB7YlCYKXCd5iegat68wf+ghppIQaWodLYT3p7
         g4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TwtcbicrqVzcOBpKF8LIDrbovh6REX7OM2xtMOK5yVY=;
        b=HBwzu8vvEgM8QrBSpP/vHic77Fgh9B6ZSFbzzF8C51ip8k2HVVfTTkZvkJ7pAGAkMg
         43uDyXQi3v6TYmxHUwZXv9JqwB9GNrp1wlyW5nZ+TQLlNFFsjtji+c/tKTyh1JaAhj8s
         aOxxXxgwqrrKxSKH3I46LkkxEiK3732jMDkXQ4OhNVci1Y46kjeme73N8YPR8n7KbfgE
         79esKPyNPZaFeChoF0NQWbJWZGpDZ/RIppD4SoKHNsVaWWUk5aY3nkRw4WhcMj22IP/i
         Z71cyfGkTFeYV6eyRb4GwoK6TgjVGOmn5cWVQm34g1M4Uk9NqMQ+isu/CicdBx0viRHy
         McRw==
X-Gm-Message-State: AOAM530jdgsZWM8N7i3K+bayD7YGMc8RctYoHWYS/2BGRefTIOuPEgk4
        yFPgB9YP9RxqJ2ystzFL+CQ=
X-Google-Smtp-Source: ABdhPJwOaE8IXHPcNpnFC/c+qLlcy/a8NYr45InQL1O0Njp9cqKD/qsDiZ4tEcu0J8xUgk9h3cqQOg==
X-Received: by 2002:a17:906:d7ab:: with SMTP id pk11mr15116922ejb.563.1630954465396;
        Mon, 06 Sep 2021 11:54:25 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id kk2sm4329128ejc.114.2021.09.06.11.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:54:25 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 31/40] staging: r8188eu: remove useless assignment
Date:   Mon,  6 Sep 2021 20:53:18 +0200
Message-Id: <20210906185327.10326-32-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906185327.10326-1-straube.linux@gmail.com>
References: <20210906185327.10326-1-straube.linux@gmail.com>
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

