Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7415843FD5A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 15:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhJ2Nam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 09:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbhJ2Nal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 09:30:41 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F60C061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 06:28:12 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id t11so6807891plq.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 06:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=TfnZr21wO2x4C8A4NaAvF/FsdJBBEUzdG7E98MYZoI8=;
        b=Reb/pVqzhYpse/uOgNi08BNakaWVCa75boxbAxAG+/61M1qs7qGT16Rlyk0n83YbRO
         WNhjeK75/IJMPnPFq3G4XnufATsdesbB79xKYxfGsL0jDyZl8gRha+7Tm3W7LvnDC7Oh
         IHDwRBEvVlu1DcNkEgrPhE7n6bJDRuo8a1QKakoTgsb19pzbZbjYDGh52Ui85ZFtOBho
         +qQfR7UrX8mnmQfn/V1y0G/SPXcDR3s2n1Oksa7amrggc3FIvzYldVzroXY2I04xL8Y7
         BFWgIHtcAy+eFi2i41avdGYDWNn6Oemk0ZIKdT8M3MdeKD7wTN0GmexNzDDtm5uNouke
         CbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TfnZr21wO2x4C8A4NaAvF/FsdJBBEUzdG7E98MYZoI8=;
        b=AD9WYlDCn1nUPi1T85DFxesM/vDkue629ruSUAwUiw79EY91UiNhsFXfdZzPlNbUeR
         wm9M1hQ17ZP944Ys7fhD2I/RYnUwO2Dl6UKtvFcjxbbhu+po19GVaYzs5LVdfAHNdtec
         euQ4EZBisql5VO1QpHyQZz7tPJuTWw3ZDDyuFHoZ/Ou2VNSG/GQOBljQLU6IE2MbR8wU
         kbkxlc8FAxP0dp9DfS5wCiWFhBpRDgm747rZRXGLWTyNeagRefeuoi+3lFV5zBJW9WCB
         L1s+IGcLzI2kRTWj+3fZyyIDxHAydMD1zz3TaM2yOHuw4HdXdBYy47TlEeMEzlzla/zY
         INHQ==
X-Gm-Message-State: AOAM53117QI27dmST3H7rtQg5wuPRys5B/mnUcZJZ/JKEj5uYm6MQlcv
        0rfG0xkjSeSC35YcEUflmvsTr50okObntw==
X-Google-Smtp-Source: ABdhPJzpIDSdJ7tFZHsaJV/UnX31CAH8okR4ywXV4lx3l8k2NZnVWOFKGgJnnPDPphkQQCCmYPLgvw==
X-Received: by 2002:a17:90b:4ac1:: with SMTP id mh1mr11550427pjb.144.1635514092420;
        Fri, 29 Oct 2021 06:28:12 -0700 (PDT)
Received: from localhost.localdomain ([103.16.71.115])
        by smtp.googlemail.com with ESMTPSA id on13sm6435952pjb.23.2021.10.29.06.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 06:28:11 -0700 (PDT)
From:   Ajith P V <ajithpv.linux@gmail.com>
To:     TheSven73@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Ajith P V <ajithpv.linux@gmail.com>
Subject: [PATCH] staging: fieldbus: anybus: reframe comment to avoid warning
Date:   Fri, 29 Oct 2021 18:57:00 +0530
Message-Id: <20211029132700.8552-1-ajithpv.linux@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

host.c file comment produce warning with checkpatch as below:
WARNING: Possible repeated word: 'interrupt'
Reframe the comment into bullet points or steps avoid this warning.

Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
---
 drivers/staging/fieldbus/anybuss/host.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/fieldbus/anybuss/host.c b/drivers/staging/fieldbus/anybuss/host.c
index 8a75f6642c78..a344410e48fe 100644
--- a/drivers/staging/fieldbus/anybuss/host.c
+++ b/drivers/staging/fieldbus/anybuss/host.c
@@ -1318,11 +1318,11 @@ anybuss_host_common_probe(struct device *dev,
 	}
 	/*
 	 * startup sequence:
-	 *   perform dummy IND_AB read to prevent false 'init done' irq
+	 *   a) perform dummy IND_AB read to prevent false 'init done' irq
 	 *     (already done by test_dpram() above)
-	 *   release reset
-	 *   wait for first interrupt
-	 *   interrupt came in: ready to go !
+	 *   b) release reset
+	 *   c) wait for first interrupt
+	 *   d) interrupt came in: ready to go !
 	 */
 	reset_deassert(cd);
 	if (!wait_for_completion_timeout(&cd->card_boot, TIMEOUT)) {
-- 
2.17.1

