Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD5C42EC61
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbhJOIcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbhJOIcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:32:06 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E35C061755
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 01:30:00 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ec8so35061616edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 01:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yywf8uxmCXs+eHVnojLOdXO3w73p4tPODGryjkUOC2E=;
        b=l4sgEo7cC46MhO+PI0YeFQne/haReZBLw0/wy6m2pDFVB3+E5ctsPNrDdkeXEPCAIf
         s4qyVnvX7o++rRkDEuviJmTtYx4crxtzpHUqAYze6yLMGaZpuB2t+Dvy7T6UTC368Cu2
         V8aW2d/L8DVIkhjuK1SeADaWD6IzrO8rqHWmNbenRsSZK+lpC4trfWbo7JeTr2lwZmmT
         dV4nYcFRRFAnJAmnWI1awDpvQkiSzfUeL8XFemU57J4IMg/5SqfW+VOeP18B90DK7zl7
         XgjUlOAK2vEW1yYvM7OWdEWRUo4d2j+R062a+/6HNb4ckgsq6coY2VR1+ICcNeawwEJo
         Uh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=yywf8uxmCXs+eHVnojLOdXO3w73p4tPODGryjkUOC2E=;
        b=kIJSUv0wSUFjp55nT4JHZxrSZ6QmEH0mVpRFs0DP2KQZ+5/+kFn9DnkOR1bGuayiq/
         6U8zLXtPXiDqC8bo/HbxETmfTdAlN01/VDXvokS9NWHnHsrCJpijeHL2uwIiethu8oFX
         G9HXpU58iA6RL+wfrHERC57mYLBS0pQJnQ1lcvjJG47iUZoxsM5obxR5lK3jogWr00q8
         wr/haAiZB/p6StDe48RyfbqAUK4/5/4S4ob83PiizNiI/Z7TMDrYsBivDjf+DSWEHjGi
         mp9n9VFtzqVkMfCbuOvbSIrj/2yYF3MS4BZt2Wkc1X11jjQpXmXFyesQO6Svdh1Khl0+
         /feA==
X-Gm-Message-State: AOAM5332UXVTYCUXZ40QRJwNAso+tmdz4kQUFXWpmHhK/L18hUaYt0lc
        FYqVIneAOQMz6eJqCgsSZoVqbb1XFzU=
X-Google-Smtp-Source: ABdhPJxry4jiBqbpg/NGImCQluSCFaGyDDT/dLeUU1nPcjHfB+LumB8PhvFLsQ4R4CK37LErl3vv9Q==
X-Received: by 2002:a50:9e85:: with SMTP id a5mr12888588edf.148.1634286598841;
        Fri, 15 Oct 2021 01:29:58 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id j21sm3944973edr.64.2021.10.15.01.29.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Oct 2021 01:29:58 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH] dt-bindings: gpio: zynq: Add power-domains
Date:   Fri, 15 Oct 2021 10:29:57 +0200
Message-Id: <655523d7bf9658eb0b8e49a06c8b79a04052e5d5.1634286595.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe optional power-domain property to fix dts_check warnings.
The similar change was done by commit 8c0aa567146b ("dt-bindings: gpio:
fsl-imx-gpio: Add power-domains").

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 Documentation/devicetree/bindings/gpio/gpio-zynq.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-zynq.yaml b/Documentation/devicetree/bindings/gpio/gpio-zynq.yaml
index 980f92ad9eba..da95b951c23e 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-zynq.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-zynq.yaml
@@ -36,6 +36,9 @@ properties:
   clocks:
     maxItems: 1
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.33.1

