Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6787E4329E6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 00:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbhJRWyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 18:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhJRWyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 18:54:41 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08394C06161C;
        Mon, 18 Oct 2021 15:52:30 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 77so16828181qkh.6;
        Mon, 18 Oct 2021 15:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pTwNmZooOeOdog1xCjDMl0qLSkOmdnMEB9kSUbzvyVs=;
        b=Zoz+Q0vYszO7sH0Yrp65kSLPqwo9JHflXpR1b4XuZ/vsyU0myPO4VQf50U4wXXRJQS
         9or1TigHVAFAa7/Lv3SyVKSb7xsf/mp6BbFAhVKCk0R+8c9UHC/ZSaBlsydVgIPPr4Ix
         g7dP4ttnHIJ+rqRPC+LRDGPFcDrfLTB5xmBLga8vf4V0OLZW5r40cNDNyi/L4Dsr97OO
         QzrTQ6PlsxXEmUZqlqujKZdR6oUaeJYqjEL+nk3GnoRWTsIekFc1WSRVsRAVDTMAyk8G
         9qEaxl1FbP4eomidgZq689KCZS6e1T6XwCtjzdgZr1ZSDXaa1+ZioeptCnP8B/WSUVkM
         pk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=pTwNmZooOeOdog1xCjDMl0qLSkOmdnMEB9kSUbzvyVs=;
        b=4R6Q2dXq/6+kBN+TNEqzClL5o8TQsUhFXMfiGWABX4nWgEoAhgHefQz2ff+xTW6PTE
         isJybtjXpt2TbPM1t+1fnAR3d7CbKrle8XVlUsjzpwpIChrm24zFg8L5Xufzl+78tvUO
         jlXZbyllmoGqR1ifeRH7awBZI1GzazLD/CXJL0gi5R66uPW6iXFEU4Tkx5a0DFAuXYcf
         d6E/y4RRzi5HYg92KgAsz8r541O/mQ5+ZNGD+303eV5jjligFD7FEBBnt5UpxC+ZXUPh
         d1lzk6/syDdfUDNBgS1bTE/6OPM/s5+vblHf5uhN5RP8bpjfdVvTL3llfOKCA9U87G02
         O6Qg==
X-Gm-Message-State: AOAM533gouxD0CBRXi7C/zFbucJL/x9OKGdRRlzO5HaaCdAF/ZObQhMU
        TZDPAirLu5DTBPUG6SUil7g=
X-Google-Smtp-Source: ABdhPJxtsDkfoWenXcOFnFkU/MqbHgiaIl+m8yn79DSvhrEDh5pY6S6ubzzvj5Q24dWaIrwe3bmIWg==
X-Received: by 2002:a37:a050:: with SMTP id j77mr25074253qke.337.1634597548350;
        Mon, 18 Oct 2021 15:52:28 -0700 (PDT)
Received: from localhost.localdomain ([67.8.38.84])
        by smtp.gmail.com with ESMTPSA id o130sm6951089qke.123.2021.10.18.15.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 15:52:28 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     sam@ravnborg.org, thierry.reding@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2] dt-bindings: panel-simple-dsi: add Tianma TL057FVXP01
Date:   Mon, 18 Oct 2021 18:52:21 -0400
Message-Id: <20211018225221.25330-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the bindings for the Tianma TL057FVXP01 DSI panel,
found on the Motorola Moto G6.

v2:
Fixed accidental whitespace deletion.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 .../devicetree/bindings/display/panel/panel-simple-dsi.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
index fbd71669248f..92a702d141e1 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
@@ -55,6 +55,8 @@ properties:
       - samsung,sofef00
         # Shangai Top Display Optoelectronics 7" TL070WSH30 1024x600 TFT LCD panel
       - tdo,tl070wsh30
+        # Tianma Micro-electronics TL057FVXP01 5.7" 2160x1080 LCD panel
+      - tianma,tl057fvxp01
 
   reg:
     maxItems: 1
-- 
2.30.2

