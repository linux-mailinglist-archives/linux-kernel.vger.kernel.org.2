Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7ED142F571
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 16:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240314AbhJOOdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 10:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240258AbhJOOds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 10:33:48 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9BFC061570;
        Fri, 15 Oct 2021 07:31:41 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x192so7586641lff.12;
        Fri, 15 Oct 2021 07:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BOWkhXmRLradAC/GQ4VVcC6Y/gPQpSI6S5P1Mpfnvk8=;
        b=pmwrGi0629rfj6pWJFXZmdRQx60ZnAi+RezuMqoV9xHr0Moh8bpARW9ZsUFfEyEAy+
         xJCN1guTGVbG4ldgdiJKnYfCOJtkEw/BcPhS02+uRpuAkG8+ALUSU0EgLfApGqvjoIC7
         RFOcJMVZtsvKkdmsFFW8zJiKahdSun5IF2BDzPrV7W3uvcdH+2/Cy9o99gjZ/blLOpMh
         D+XqGp/jW6uiSobidR9H2P3P7xK8yiS7MOtgDCvbDe9mQfmozxiq3CLLQle5G9e1BNQf
         jb6/qumiVxrHnvaqVm0fN9p0sLgZbT8Tecsmv4p9WcbWUuQvSMs1atN0bApMvJWpPgr/
         tVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BOWkhXmRLradAC/GQ4VVcC6Y/gPQpSI6S5P1Mpfnvk8=;
        b=hXYP4HehtTFc3vDEuTAG+wnYCeSnFApfBrbB80eRJWKr1YD39qD9la3w9L5f4ID73o
         M85FhCWxLKFE/Z8lNo323gVMe41eO+EaJ5Rr9ehMEYgXW2vKwf/ZgL3hx05KBtnMNHUi
         xXPi8SVdpyjdpbPmVnqS09QIlDcwXq3XN1ie+8gyUAskcGNCqJZJYNf0dZvASwNyFBSe
         PdEIQqOL2aKU+WkYQqHtGPfszlu1J0BvBXfA33Cc3JjEZ2tGMZvSieG+RyqlxRdQdv8S
         CiRb7vWUdjyAm5sVbTnM31+6/1FkvTUQYrp8kW6WFD0JZt4x+f8/ezF2Cnm0GRCAEMte
         M7vQ==
X-Gm-Message-State: AOAM533wZGv6MucObWuapbE8C36hJm9Lp+YGEU9S6Ftxc/VZkIuz8J/h
        6g6MA9UFhYh2hJ+2YXoRtSOKHxr2xos=
X-Google-Smtp-Source: ABdhPJyb7Io5HBfOR1Od1nJE8cceEaoAYKaT4OvEzqEQBBRoD5cqfwoaAwdgJNzZqfJWySJA7xQiIg==
X-Received: by 2002:a2e:7605:: with SMTP id r5mr1552093ljc.301.1634308300111;
        Fri, 15 Oct 2021 07:31:40 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id b18sm616475lji.99.2021.10.15.07.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:31:39 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh@kernel.org>, linux-rockchip@lists.infradead.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: rockchip: i2s-tdm: fix rockchip,cru requirement
Date:   Fri, 15 Oct 2021 16:31:14 +0200
Message-Id: <20211015143115.1445707-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The behaviour described in the bindings is exactly the opposite
of what it should be, so this patch fixes the description and
adjusts the if conditions for adding rockchip,cru to required.

Fixes: 510f1c133aed ("ASoC: dt-bindings: rockchip: add i2s-tdm bindings")
Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 .../devicetree/bindings/sound/rockchip,i2s-tdm.yaml   | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml b/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
index ce3e18b50230..93f5221e9381 100644
--- a/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
+++ b/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
@@ -86,7 +86,7 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
       The phandle of the cru.
-      Required if neither trcm-sync-tx-only nor trcm-sync-rx-only are specified.
+      Required if either trcm-sync-tx-only or trcm-sync-rx-only are specified.
 
   rockchip,grf:
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -147,8 +147,13 @@ required:
 allOf:
   - if:
       properties:
-        rockchip,trcm-sync-tx-only: false
-        rockchip,trcm-sync-rx-only: false
+        rockchip,trcm-sync-tx-only: true
+    then:
+      required:
+        - rockchip,cru
+  - if:
+      properties:
+        rockchip,trcm-sync-rx-only: true
     then:
       required:
         - rockchip,cru
-- 
2.33.0

