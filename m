Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3CB3CAB2C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 21:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244754AbhGOTSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 15:18:03 -0400
Received: from mail-il1-f179.google.com ([209.85.166.179]:45671 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241765AbhGOTCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 15:02:49 -0400
Received: by mail-il1-f179.google.com with SMTP id b6so5935429iln.12;
        Thu, 15 Jul 2021 11:59:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RiqGFZQ7xuhJIftSUoyXu5zNuFIfnG6U5i6WL5zRw7c=;
        b=KlqOQB7kR48yvqat8xY+khh9GFZTDDwLAXjMmpqjsQUmlxAp+Dqq8MDafW0Ayqij0l
         ggJeXfyvbt1jB66j/MB23Ov5H4QBcxJ9zL6wQGzxzldiYgNjB7r/LPhef5TOtIVP/Ei7
         JGbJxSzvwDzFhypeUln69592VF5iiH2kQHTawWrUvrMw9HryVht8Rb+ApdkNB7H5Jxn0
         tpPNe0pufzaPwFHRypbSgL+39yt2Q6es3YY82oBGOl1Y2siCmp1wL3fxodMJYKOITz4u
         TZit5+SqHDvYICr7SvSUkxM5S8xH1ZEMJQZdVXRjuWQZKY9JY3PL8+1UVQBu6f2bx1Hh
         pjTA==
X-Gm-Message-State: AOAM533bMai6HCyvOhpEeMLyjopAPUdcRmxatdpaTGBxneXoDiZBl9Qh
        UzkhR9JklnOhdqw/51FBoANrcQcozA==
X-Google-Smtp-Source: ABdhPJxcoWlh2NzIThIIFpwH8hyJlQ8bztIdSda2U/1fyLTsdcs9FXHEQN+JvTWBmUmuKzvAe/ckbg==
X-Received: by 2002:a92:db4b:: with SMTP id w11mr3755881ilq.297.1626375594912;
        Thu, 15 Jul 2021 11:59:54 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id c19sm3347150ili.62.2021.07.15.11.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 11:59:54 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: dt-bindings: renesas: rsnd: Fix incorrect 'port' regex schema
Date:   Thu, 15 Jul 2021 12:59:52 -0600
Message-Id: <20210715185952.1470138-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A property regex goes under 'patternProperties', not 'properties'
schema. Otherwise, the regex is interpretted as a fixed string.

Fixes: 17c2d247ddd2 ("ASoC: dt-bindings: renesas: rsnd: tidyup properties")
Cc: Mark Brown <broonie@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
I can take this as I have a few other things for -rc2.

 Documentation/devicetree/bindings/sound/renesas,rsnd.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
index ee936d1aa724..c2930d65728e 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
@@ -114,7 +114,7 @@ properties:
 
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
-    properties:
+    patternProperties:
       port(@[0-9a-f]+)?:
         $ref: audio-graph-port.yaml#
         unevaluatedProperties: false
-- 
2.27.0

