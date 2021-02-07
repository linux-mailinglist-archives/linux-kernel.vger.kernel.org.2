Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F123126F9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 19:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhBGSwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 13:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhBGSwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 13:52:35 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725D6C061756;
        Sun,  7 Feb 2021 10:51:55 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id j5so12734485iog.11;
        Sun, 07 Feb 2021 10:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C1b2/ijDZ9H0sKDfYhenHE6daVwDApyvYHnzhcgt0pg=;
        b=MFQXikcjPXIAShI40vHiklo9q+lVC0Iwi/7VO/SRnnaj+2RgNifeW95GGqO9S/masX
         7nzjkGK0+i2IxWpTimWX40wehq8pZygPGf/YslAQprZLjcRnUDsR4CmYS+xvG3AJA27R
         KfNqGIreA9oSHup0+GVNc86I5fbHZZfnWMJFEmPVInYl/5Mijtwf+fBMdxa1IW+yNTQ5
         wleXjsGXdDp6STCIlab1VTKOXA6fRoGjEvkWcD+GObgatttllLX1d9gv/Oe30WIvxNcq
         NXJlSyHpxPiPoDKn7zTE5oYJOqFa6dVSRrUE82E8M4iMuxTiA6Us+A1vXQSrZU5cimw2
         zkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C1b2/ijDZ9H0sKDfYhenHE6daVwDApyvYHnzhcgt0pg=;
        b=rpb2tz3b4N6jYz3kyFMysy6DCGfmVxyHLD+xeD/id2ABHI8dTk1koRiS9RHdmcZXh1
         uq7iA6cvgnjJ6ahtYaIeGA5QuYJfQpjGfoji3OZsLFyrbeiIaB5QrcuhfWohuwyzucay
         cCl0q5A2zGJPwn26ePuyBP6sdRqYCtXRrhGkWD5t5fn7HbsJ9GOu4xm4ZwT2ajPhSAwY
         MB3Bub3ZVgxVKNHU/Xt0OQ0CJAsJy1fhT27W1CRcMQqYRtWKiIlaT1hlLn9WFgd4vmMP
         sHyYxSYSbuun2nM5YpKc5zn0OVQjs3GCe7lIhPhU/eQeBRA25thbJUQYFLe0Qy1I2t0N
         LXOA==
X-Gm-Message-State: AOAM5329dIKi5Xdgg5a+DkrdWiH8BtjtU0irVRLbVuIl3WsUp+OLGBAK
        UJv5vHP2eZx9JJOdFH9KhPSrJi9z+9CseA==
X-Google-Smtp-Source: ABdhPJzUaVyGsmNps3Ljb3GSgCk1I0HkgSOXlRivc5lvf5P3IDbfkpVcqVRKrUVS7MMNk7rY0QePMg==
X-Received: by 2002:a02:cd25:: with SMTP id h5mr14124991jaq.31.1612723914694;
        Sun, 07 Feb 2021 10:51:54 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:a6b4:a5d5:60b9:fff0])
        by smtp.gmail.com with ESMTPSA id e1sm7942738iol.31.2021.02.07.10.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 10:51:54 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/2] dt-bindings: clk: versaclock5: Add optional load capacitance property
Date:   Sun,  7 Feb 2021 12:51:38 -0600
Message-Id: <20210207185140.3653350-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two registers which can set the load capacitance for
XTAL1 and XTAL2. These are optional registers when using an
external crystal.  Since XTAL1 and XTAL2 will set to the same value,
update the binding to support a single property called
xtal-load-femtofarads.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V3:  No Change
V2:  No Change

A couple people suggested that I not use the $ref, but without it,
the bindings check failed with errors.

diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
index 2ac1131fd922..c268debe5b8d 100644
--- a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
+++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
@@ -59,6 +59,12 @@ properties:
     minItems: 1
     maxItems: 2
 
+  idt,xtal-load-femtofarads:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 9000
+    maximum: 22760
+    description: Optional load capacitor for XTAL1 and XTAL2
+
 patternProperties:
   "^OUT[1-4]$":
     type: object
-- 
2.25.1

