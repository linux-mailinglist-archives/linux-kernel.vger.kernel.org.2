Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A2130B518
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 03:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhBBCL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 21:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhBBCLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 21:11:16 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C086C0613ED;
        Mon,  1 Feb 2021 18:10:36 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id f16so975609wmq.5;
        Mon, 01 Feb 2021 18:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QAsVvG9i6Xg0y3Z1EJ3mhfNvPnvT0DDgRmi3UPHJgto=;
        b=Phk0EcvRvk4HHkCx+hRegfZmcZPsNNZo/rjwwMEOjNxmqevE2sqjsr+rbtCV2rNLtO
         L7FkZiN04tkLd+UpmaSNwkONP5SBX23WrgfrkiptxFRevfAUfKKGPCkcAATIFzM1z4Qs
         QvB8ZnjXtfJnVX6hzt31treG6xj/vxO+lgHFLOf2c/5qDLe8ASFmm+ZCQUFQ7K+06dhn
         4ylDQ55wTTn/5ze9Q3R2nkde2FZnyVGvmRSal4UR6tkvBI865QgWLt66Gx16Ibm44RDC
         UXu8OpkHLFnywhqxvg2gFGQSrrDWCvap4W5i4yKEDZOjog5+CRtpc9B/ZXbdNi0Unb9K
         n7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QAsVvG9i6Xg0y3Z1EJ3mhfNvPnvT0DDgRmi3UPHJgto=;
        b=IJuYZ8anTvNQV6NhueZmJbM+5RUnoFW5sXTNTaOLdayJEht/GdU4//dGyG5Tscsj4Z
         9xiq9AObLFKlQdHPdWQIpchwwLWCsoNIcpTYMwsRCaT2DXhVoh0NzLg7O6tKa43dC79z
         +ycq3PW9LolEiW86Uqd7zkrkz+HfjYlbLJRmhVagmspcf/Qalw/FAokKt0RUB1p+ecN0
         XQtg+ZI49YzwvYd/loc9Q+VPt5q1zsV3rtmotaXveILB5Dke2e6Qs+pSl3zNNBRJX5da
         QcxWJaziZSuzGOVh0VcmdvFt0sJ6hV+mD7zJSsCb7pKMPX1Mm7J57Bi+SJ8AKCvsqkIA
         7AWA==
X-Gm-Message-State: AOAM533bHl6caA2tw7b5DMlPZx6NpVugmWzy9jCxaPzIE8jDaDCCZTy1
        WyQHs0ErOmSE2sCkoIWTUtg=
X-Google-Smtp-Source: ABdhPJyuhxu1+0MHl3LKp5TEBg8XFBK2divUN/udYoC5kG6bOObvYEfl5y2gmuUd7LHcvp9Dx+R/TA==
X-Received: by 2002:a1c:408a:: with SMTP id n132mr1372051wma.86.1612231834881;
        Mon, 01 Feb 2021 18:10:34 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id u14sm990570wmq.45.2021.02.01.18.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 18:10:34 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Dongjin Kim <tobetter@gmail.com>
Subject: [PATCH v3 4/5] dt-bindings: arm: amlogic: add ODROID-HC4 bindings
Date:   Tue,  2 Feb 2021 02:10:20 +0000
Message-Id: <20210202021021.11068-5-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210202021021.11068-1-christianshewitt@gmail.com>
References: <20210202021021.11068-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the board bindings for the ODROID-HC4 device.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index b21ba8ba23dd..5f6769bf45bd 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -165,6 +165,7 @@ properties:
         items:
           - enum:
               - hardkernel,odroid-c4
+              - hardkernel,odroid-hc4
               - khadas,vim3l
               - seirobotics,sei610
           - const: amlogic,sm1
-- 
2.17.1

