Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D04F3381A2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 00:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhCKXlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 18:41:22 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:35625 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhCKXlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 18:41:00 -0500
Received: by mail-io1-f47.google.com with SMTP id g27so23861109iox.2;
        Thu, 11 Mar 2021 15:41:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4IFH0kTzeJg7A+iDC79WbeQk0xgfuMdi+7gcFmh2QEY=;
        b=hTJEecHH25NaLwey6b5sRqTBh/FRdP1238JLiBhl10tBx/vZV15/UcZK2359DkgSJl
         ejIy270BjXT2EGEh0VmgTusY4eFC7Agms1xNdvB0rowm6lwtnJ5t2rOBCuw5ajJ7QMEJ
         0EWz31DDBebj7SWFP/y/kewwLkPnM68BsXuSuWWDiCFqf39kjYTjQbu/+pC5Ixjew9Oy
         rU6KMfIuJaVx/oNSMphEh2CIQHHJkK5c5mgmCMpJoKWUWBQPT2/vJFhJr2oOr6qakb1j
         w85YPT4vPw1pA2whFfGDx0R3H5A5I/8aKM10rPoq04bnBaPZ0wcp6rcg+SVGSU8EeOh0
         dEOw==
X-Gm-Message-State: AOAM530Plih6bM93gRCVZRskgZ9KDBd8cCIxk2M8NmdciHxkAiGANyS7
        y3Fp9BGlZmtJrYAfiaTzXG4imqU6+g==
X-Google-Smtp-Source: ABdhPJwmJHUYmsW9PwM0xgZG/Iwb0eQRDgOcXhhwLpuheItXUTEktHP4fXHEOhhtx5XwpzsBXUB3gA==
X-Received: by 2002:a6b:d318:: with SMTP id s24mr8240183iob.89.1615506059863;
        Thu, 11 Mar 2021 15:40:59 -0800 (PST)
Received: from xps15.herring.priv ([64.188.179.253])
        by smtp.googlemail.com with ESMTPSA id q20sm33139ilj.56.2021.03.11.15.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 15:40:59 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Conor Culhane <conor.culhane@silvaco.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i3c@lists.infradead.org
Subject: [PATCH] dt-bindings: i3c: Fix silvaco,i3c-master-v1 compatible string
Date:   Thu, 11 Mar 2021 16:40:56 -0700
Message-Id: <20210311234056.1588751-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The example for the Silvaco I3C master doesn't match the schema's
compatible string. Fix it.

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Conor Culhane <conor.culhane@silvaco.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
index adb5165505aa..62f3ca66274f 100644
--- a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
@@ -49,7 +49,7 @@ additionalProperties: true
 examples:
   - |
     i3c-master@a0000000 {
-        compatible = "silvaco,i3c-master";
+        compatible = "silvaco,i3c-master-v1";
         clocks = <&zynqmp_clk 71>, <&fclk>, <&sclk>;
         clock-names = "pclk", "fast_clk", "slow_clk";
         interrupt-parent = <&gic>;
-- 
2.27.0

