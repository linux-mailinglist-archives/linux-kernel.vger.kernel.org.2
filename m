Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B4A440998
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 16:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhJ3Omx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 10:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbhJ3Omu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 10:42:50 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DD5C061570;
        Sat, 30 Oct 2021 07:40:20 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso5128932wmf.0;
        Sat, 30 Oct 2021 07:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OJp/wZiERGVBUU7HIuspGPpojRpXm2e3BfdSR6ZgDTc=;
        b=d5toudcTVdIEVYCVYXWFZjlG/GeMQ4BLjm/uq9/kHYBx/ZXd8GIMr2n/DGTWCGJ+9f
         PzR4W1+x84oIoruGgufXmG91NGKbaj85h94ZMW7tqrO7t+bBkbJQoxI7dd0+0w6Xok2e
         5oj4Wo8+Jm5s8wcu1aK6L6gkKVzLSlK81RPk7V/5oCKLONIygzWkfveHW7E3Ob/e/YIO
         40Ui1GAGSwtz/xsChZ/3pRdJCl3Jews/X05cxlVXXjTTJUzQ9w2J55KLdKj9D1RZ5GKy
         7zuhmxQFW908SyOI22BYyT2fJrx2CgVcMJhh6n2HiEdj+ZzADR+LGEjDZG7kMsa/6WhS
         c3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OJp/wZiERGVBUU7HIuspGPpojRpXm2e3BfdSR6ZgDTc=;
        b=a/KJeNdUX4wHS8MjRustIZ3B3ass6d2BXcdOMoyiDwd8GM70uIuTK2bBCa75RJd68+
         jewnNhp2rj/eXgwADeM3+dI4ncthFvl6x3qYS0GusmkLbMz2/ShcdMGZvIW3mpndelug
         K02SWhUc9qtOEYZXEvIF5Yv77zUa7NGVRWXdQxJeb/x3Xixy1chPx8yU1HBCB5bxmmiR
         c8sUxqzTn2QuGTcJd4LLMMxkr7/6vhyKDUfEhzR33gYTHXbNQ8zn68ZuVxl4Nr8e+tIP
         bLOcwdaVKqtEmB5+WfiqgZHUx7ilJDW7++lneNfd/tQdorbf9KF8mllnjaEyIs7nJbk1
         JJYg==
X-Gm-Message-State: AOAM533yNjmKdb/UCgkmzU+gyGOoqYVlJZu4mN7bzqwD1VuXYXBpeStv
        SXv0MeRXYiIj981f+80sPFg=
X-Google-Smtp-Source: ABdhPJziKvxTucgWl5y9YXjQAT3kxG1nEmAYfSWwkfmBh7bm7FI5+fEy15cyGehOUUzIzYPcRsvIdg==
X-Received: by 2002:a7b:cc11:: with SMTP id f17mr19406047wmh.122.1635604818629;
        Sat, 30 Oct 2021 07:40:18 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id u19sm483602wmm.5.2021.10.30.07.40.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Oct 2021 07:40:18 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, neil@brown.name,
        linux-kernel@vger.kernel.org, john@phrozen.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/4] dt-bindings: clock: mediatek,mt7621-sysc: add '#reset-cells' property
Date:   Sat, 30 Oct 2021 16:40:12 +0200
Message-Id: <20211030144014.26315-3-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211030144014.26315-1-sergio.paracuellos@gmail.com>
References: <20211030144014.26315-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make system controller a reset provider for all the peripherals in the
MT7621 SoC adding '#reset-cells' property.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 .../bindings/clock/mediatek,mt7621-sysc.yaml         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt7621-sysc.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt7621-sysc.yaml
index 915f84efd763..0c0b0ae5e2ac 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt7621-sysc.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt7621-sysc.yaml
@@ -22,6 +22,11 @@ description: |
 
   The clocks are provided inside a system controller node.
 
+  This node is also a reset provider for all the peripherals.
+
+  Reset related bits are defined in:
+  [2]: <include/dt-bindings/reset/mt7621-reset.h>.
+
 properties:
   compatible:
     items:
@@ -37,6 +42,12 @@ properties:
       clocks.
     const: 1
 
+  "#reset-cells":
+    description:
+      The first cell indicates the reset bit within the register, see
+      [2] for available resets.
+    const: 1
+
   ralink,memctl:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -61,6 +72,7 @@ examples:
       compatible = "mediatek,mt7621-sysc", "syscon";
       reg = <0x0 0x100>;
       #clock-cells = <1>;
+      #reset-cells = <1>;
       ralink,memctl = <&memc>;
       clock-output-names = "xtal", "cpu", "bus",
                            "50m", "125m", "150m",
-- 
2.33.0

