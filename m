Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B60E33284E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 15:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhCIOQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 09:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbhCIOPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 09:15:38 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A471DC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 06:15:37 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id 7so15930574wrz.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 06:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=edjmsvTbiBGyAA1eKIb4COjGcbGBPS+75xg700Bbb9k=;
        b=X//NLVhIAdcbeOgoTBSqEzOS6xAs/LrLYRCs0Iz3aE+2RlVsk/ZmS0RkLWbHASlHXw
         lA1WEwlrcvJz4Mo6Xz1Qf8O2rPXg5suJYTTZWZhwf6JwKWDb9M1kxVQ1q722/7PdC83B
         rSQwb13ezL6pBecUL1R3KuBd8YPj/oX4p+BnUZ5FyDHlInhvgedjwVX4sNJDbDi1x8ch
         T067BcNYNiyibRD57kC2o17RsXETeMG749GHfsgCDHmy86fCa6CrpjtAkGzLgTeC75Cy
         vnI5hBHrVdO8uBQ3GMfisN27f23T213RQ/67DMXymXpvATdNv5E1aNni7cdSD2nBd+tT
         yWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=edjmsvTbiBGyAA1eKIb4COjGcbGBPS+75xg700Bbb9k=;
        b=MVkXpmDQYeFfgljNMPxLCkltwuzOCsbI4iKSeKt2zaOfM7vpQRsC+zPdjEO9LewDnz
         Bq2SH5hSyQ0WiVvpAJqbpR1tIOrhYdgMdVBJNfIZpz7O6iKQyP8m/qJ1Jr9X7Z+fP0WR
         hLHzEVF5hE35DMKVSOLv5HxPkM3LKpYhM5or7TGD+RGzVwYZkL7fH6bdYlGkLyaJNSux
         PKf1nzqhaeIkXQhTEv9Esu6rhPJXKEBZsvlYAT6R2lbNKhYWE6LpnqwXYwlULPYtCZa8
         cqjFl6eLaLRJ33Z14NGPiQLDVEcrAP5OGb9NPrckYark1yKIJEkMpmpOvrrVJHt2Ba1f
         8Ang==
X-Gm-Message-State: AOAM531s+xMjBU5tFjUfN9CTJONN0kOB9NG6COxs5Z72H+L7gO1lqfme
        aV8Jhs4GG3+KLHM8/1RFuXVwAA==
X-Google-Smtp-Source: ABdhPJz1cWrPVW9Z3/nXVPR7xY9H4HbgV6Q4s9PxMLKYFCCBtBbFPDvVRO5YZ2OgdD2jk/P/4CGWJA==
X-Received: by 2002:adf:ff8c:: with SMTP id j12mr28335588wrr.297.1615299336486;
        Tue, 09 Mar 2021 06:15:36 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id u20sm28007579wru.6.2021.03.09.06.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 06:15:36 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 4/5] ASoC: dt-bindings: wsa881x: add bindings for port mapping
Date:   Tue,  9 Mar 2021 14:15:13 +0000
Message-Id: <20210309141514.24744-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210309141514.24744-1-srinivas.kandagatla@linaro.org>
References: <20210309141514.24744-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WSA881x SoundWire device ports are statically assigned to master ports
at design time. So add bindings required to specify these mappings!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,wsa881x.yaml          | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml b/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
index ea44d03e58ca..48bc72304b90 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
@@ -26,6 +26,13 @@ properties:
     description: GPIO spec for Powerdown/Shutdown line to use
     maxItems: 1
 
+  qcom,port-mapping:
+    description: |
+      Specifies static port mapping between slave and master ports.
+      In the order of slave port index.
+    maxItems: 4
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
   '#thermal-sensor-cells':
     const: 0
 
@@ -54,6 +61,7 @@ examples:
             powerdown-gpios = <&wcdpinctrl 2 0>;
             #thermal-sensor-cells = <0>;
             #sound-dai-cells = <0>;
+            qcom-port-mapping = <1 2 3 7>;
         };
 
         speaker@0,2 {
@@ -62,6 +70,7 @@ examples:
             powerdown-gpios = <&wcdpinctrl 2 0>;
             #thermal-sensor-cells = <0>;
             #sound-dai-cells = <0>;
+            qcom-port-mapping = <4 5 6 8>;
         };
     };
 
-- 
2.21.0

