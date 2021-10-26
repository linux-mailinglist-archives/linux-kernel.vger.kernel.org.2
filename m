Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A41843BD7D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 00:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240150AbhJZW54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 18:57:56 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:37685 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbhJZW5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 18:57:53 -0400
Received: by mail-ot1-f46.google.com with SMTP id b4-20020a9d7544000000b00552ab826e3aso934455otl.4;
        Tue, 26 Oct 2021 15:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hagADLdvTw2LM7IAXZdQV2X3tFBOTE0t1gIOkr2O5XE=;
        b=Wu26EqRrcxf+l6cPRqotjsv8kricPJ4C/de6g7zPRsOGV47/uakO0Sxpty4R3XlSeO
         mmHNCyADUBWMaX9zt/UnhNI3HVmk7mWnYrcFn95js120mqYGew5ioUtA0FvVgvIyht2Z
         /Z/WhEr3ZW6Tdl0nsRRDM/APy6ruMSqTWwvZO9x9H81Hjzn6QDuPfuRu2b2ebEQ37T4c
         2Dgnrewk3Y4XVJWDPXR60Grr1BFMpCz4mZzg+DTpj/zIQ3+ia+iQ+IRpyipafudYm9IS
         u1AQwnUKr1uPfyBuZekDUyifFYOWrNwaeymPvYWEMhnBMQXSM/d1RpyBY0+SjDAIpnyf
         BvCg==
X-Gm-Message-State: AOAM530lQUEUIcjrjFqi6SEpp+qwONfNa2bf1SCSdjq7Cbpl2Vmo3tfR
        vhnxMQB+n+1WWnoapw5siVbVi2PUFQ==
X-Google-Smtp-Source: ABdhPJxL+AO0LeFj449/TFvLfkMMu5fcN1LlprNts2zpCv1wk4MJO9KdU9G7U7Tvigc8q3G1Wb1RIw==
X-Received: by 2002:a05:6830:108e:: with SMTP id y14mr21581977oto.68.1635288928742;
        Tue, 26 Oct 2021 15:55:28 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id e59sm5069748ote.14.2021.10.26.15.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 15:55:28 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH] of/unittest: Disable new dtc node_name_vs_property_name and interrupt_map warnings
Date:   Tue, 26 Oct 2021 17:55:27 -0500
Message-Id: <20211026225527.3460520-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unittest dtbs have various intentional errors which cause warnings.
With the latest dtc sync to v1.6.1-19-g0a3a9d3449c8, we need to disable
some new checks: node_name_vs_property_name and interrupt_map warnings.

These warnings are also generated for static_base_1.dtb, so let's just
disable the problematic warnings for all unittest dtbs instead of just
testcases.dtb.

Fixes: e76187b9792e ("scripts/dtc: Update to upstream version v1.6.1-19-g0a3a9d3449c8")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/unittest-data/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
index a5d2d9254b2c..7e1a25ad4e5c 100644
--- a/drivers/of/unittest-data/Makefile
+++ b/drivers/of/unittest-data/Makefile
@@ -37,7 +37,9 @@ DTC_FLAGS_overlay_base += -@
 DTC_FLAGS_testcases += -@
 
 # suppress warnings about intentional errors
-DTC_FLAGS_testcases += -Wno-interrupts_property
+DTC_FLAGS += -Wno-interrupts_property \
+	-Wno-node_name_vs_property_name \
+	-Wno-interrupt_map
 
 # Apply overlays statically with fdtoverlay.  This is a build time test that
 # the overlays can be applied successfully by fdtoverlay.  This does not
-- 
2.32.0

