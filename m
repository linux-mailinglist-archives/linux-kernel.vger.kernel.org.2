Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807B3396434
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 17:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhEaPun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 11:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbhEaO1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 10:27:38 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4681FC08E90B
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 06:47:00 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id z4so5247367plg.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 06:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vJMi78mWq5HtlB9ulTeayHA8zLqcXh/C4DEKGpxzKBs=;
        b=tOQcg02H2G99bgAhpIXY4UA4Uxk3AvlreiKnqu2WJXRRuaLDQX9qpJ0527Clrakkls
         fw9QrHLm6U0vWl7dK/tbGP477df8dt/y9mGRnsHcTh9jwJJ6E6dEe6KGLGIMZTYWrUtv
         evIsBSNG/SVHFuaQiurGW3Om65552fCExZ/LqZNs2xafD1WNBXLiPyfppOxuYwiamC8j
         P/yIxdtuS11mFA9abzsxwIUtxHCog6xf5tWIUieN/IBbk2Hu0PmNxvSHYLRAUR76gyqf
         AzNZ4foUkt+cmR4Tb/If/WVnTik/e9tZoVoP2QeET+tsrCoE3MkGEmkS4PsHeXwLJ2Sz
         6vcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vJMi78mWq5HtlB9ulTeayHA8zLqcXh/C4DEKGpxzKBs=;
        b=ifeEg9nD9clPKEpbejag301zofXQEIWq3CCzyf2KuW+m3gs7ul9a+ZrnYGH0aAEM6Q
         ZinbqPJBEczNb9D3xPxNVsWTPob1z76hc6fTPpgid5I148stHR44+UcdY9Ai6nrZseG9
         cw/Sx4/DTIx27ykenJCB/itAfN/Qgla01vN+mD3KEVcDNpCrxQKWlPXd18pCxoRbBcuT
         0sz2ij9Xw1uQ8751bJFaMOqhP/hmUp3nCDXM/K+pDCbuwSYtlJCvhmkB/awCLBG0ix5B
         ZKDikyKTJL2b6xqEdSLzns6Ji0NqAPKOuqOrmW6gE19nansq7zh7vB6SlN32H8fEr7jg
         UeHA==
X-Gm-Message-State: AOAM533itS6YMC6uvCHOV5FjvFehKfqEwArPALbau4vnUUqiNH3B7rBw
        QI8iGaf+IzVcTzWtuiZw7udqXQFLfw2+
X-Google-Smtp-Source: ABdhPJwz7ahaRAzjNH/I54t0SlMWfy5SJoD/YLCA10mESWScv0fwZ5XZbyaLSrXlauiw4+5Qy2xcgA==
X-Received: by 2002:a17:902:728e:b029:101:c3b7:a47f with SMTP id d14-20020a170902728eb0290101c3b7a47fmr12962198pll.21.1622468819856;
        Mon, 31 May 2021 06:46:59 -0700 (PDT)
Received: from localhost ([2405:6581:5360:1800:7285:c2ff:fec2:8f97])
        by smtp.gmail.com with ESMTPSA id t7sm11087433pjr.29.2021.05.31.06.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 06:46:59 -0700 (PDT)
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH] dt-bindings: hwmon: Fix typo in TI ADS7828 bindings
Date:   Mon, 31 May 2021 22:46:55 +0900
Message-Id: <20210531134655.720462-1-iwamatsu@nigauri.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in example for DT binding, changed from 'comatible'
to 'compatible'.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 Documentation/devicetree/bindings/hwmon/ti,ads7828.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,ads7828.yaml b/Documentation/devicetree/bindings/hwmon/ti,ads7828.yaml
index 33ee575bb09da1..926be9a29044b2 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,ads7828.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,ads7828.yaml
@@ -49,7 +49,7 @@ examples:
         #size-cells = <0>;
 
         adc@48 {
-            comatible = "ti,ads7828";
+            compatible = "ti,ads7828";
             reg = <0x48>;
             vref-supply = <&vref>;
             ti,differential-input;
-- 
2.30.0

