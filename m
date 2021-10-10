Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCC7427FA7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 09:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhJJHUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 03:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhJJHUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 03:20:21 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A74FC061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 00:18:23 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r7so44373630wrc.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 00:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ircsRGiSRRDI5vvTT/PYNTjvV8p5MX9cyk5yss2d11M=;
        b=mRV1EPIDOcWgi0ZDOfVMxd+VAqx5nw6cxQgaAoXTRBd0FIGA9mnt+5SIYAhejtfZCr
         pfspAqx9qtIXRQTXHm01Pndlv3O9OXvtwktCVMMaYIouFz6eL902LeYzGz5VBUNig4kZ
         PFbs58PpaUYjrTZPYaCTuE/G0kQD2aCj6q2xgL/zuNobHASXYY0NiG4hOEUXSW2x2H6H
         aGhIpWJFfEJ2fhYwA1kGm6e8pEbRpW9NwO6HNKrVkAhzRXUGWmUR0fecsiMcwJG8pVId
         eeulCiEQquGk3JRwnzcTANMzOk/zwuJnQ69/qDFurk9O31OoWHFAMcUv0yN9W2TSQ/rK
         wRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ircsRGiSRRDI5vvTT/PYNTjvV8p5MX9cyk5yss2d11M=;
        b=eKAsMaxBo1q6qyLuwe4inCJ1JRoGU+l/vsTUsD04yv6xvc+E3zFOxIWggNLIJSNbpU
         aofK4o8p7lBBaYhbcRpxINdBFEyErw1OgVPrxflQXxE6mYFDos/0USEc+gkwAVONb2OO
         xVEUmXGs5Bndq9NzwBr7ABfk4/9539YOy5eN/JZiAG20cksUZhaA2bDBXKA0RuLUOkon
         k55IGkWJEUWdUj5lNDNeQc/1mTIMBNjHfOlrCOs9iiIiXoNBIxaxCwB9i7syaPzYZY+D
         1r540r3iKB1T7ka+CrBH7jx1xTJvgx4mTbc/KIUhwJAB2fJGk1EVjlWk2UZ/4h+NLlNQ
         onJg==
X-Gm-Message-State: AOAM533a5+7FIxEP/gnsqcEmwvXp1HosYLQQIkeegAtwtWndpYNIXO7T
        T23shIK79z+s31ml+zTT4bdCReqCapI=
X-Google-Smtp-Source: ABdhPJweOswcCJDMYDuEl0xsle+Ew2RuPx8ZRdW1YZ8M6RpUDbLmdzUmpEsY2CiRm/5fQXWfxpHHPw==
X-Received: by 2002:a05:6000:1042:: with SMTP id c2mr9783493wrx.272.1633850301699;
        Sun, 10 Oct 2021 00:18:21 -0700 (PDT)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id m4sm17473305wml.28.2021.10.10.00.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 00:18:21 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] bus: sun50i-de2: Adjust printing error message
Date:   Sun, 10 Oct 2021 09:18:12 +0200
Message-Id: <20211010071812.145178-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SRAM driver often returns -EPROBE_DEFER and thus this bus driver often
prints error message, even if it probes successfully later. This is
confusing for users and they often think that something is wrong.

Use dev_err_probe() helper for printing error message. It handles
-EPROBE_DEFER automatically.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/bus/sun50i-de2.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/sun50i-de2.c b/drivers/bus/sun50i-de2.c
index 672518741f86..414f29cdedf0 100644
--- a/drivers/bus/sun50i-de2.c
+++ b/drivers/bus/sun50i-de2.c
@@ -15,10 +15,9 @@ static int sun50i_de2_bus_probe(struct platform_device *pdev)
 	int ret;
 
 	ret = sunxi_sram_claim(&pdev->dev);
-	if (ret) {
-		dev_err(&pdev->dev, "Error couldn't map SRAM to device\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Couldn't map SRAM to device\n");
 
 	of_platform_populate(np, NULL, NULL, &pdev->dev);
 
-- 
2.33.0

