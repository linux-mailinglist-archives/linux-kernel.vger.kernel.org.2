Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FE432F6BF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 00:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhCEXpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 18:45:15 -0500
Received: from smtpcmd02102.aruba.it ([62.149.158.102]:38075 "EHLO
        smtpcmd15177.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229616AbhCEXoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 18:44:38 -0500
Received: from ubuntu.localdomain ([146.241.168.111])
        by Aruba Outgoing Smtp  with ESMTPSA
        id IK7Ql1dnx4WhhIK7YloTHf; Sat, 06 Mar 2021 00:44:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1614987877; bh=zj5wFkwnUKvak0MvXjjnMADm8KGpQzx1i5yM6cUK7Cc=;
        h=From:To:Subject:Date:MIME-Version;
        b=ncXC41Jkh6TuUFjwSp4T3txWcsyJVbcTR1nSM/+n09P5+LTAVFEx2Y5dum090ecnt
         tSErK9VLpjc6APhdGqFENPeV5/bRsrRaigblLD2O+DI9AwAtOGWyxCGkPgmtmpU8Qk
         KL3nQ1fvTMOh3LIr6sgbmjM4a9fJw37YZ9sEtLqdLJImrMdGgiQZSqAhkePQZA/89h
         gH/of2Jr4F/1Labws24wsrLQza6V8dw0zCT9N+OkywploEqg+08dwXd0phci8y0/Yo
         4IjOWKsredLVjI4WDuG/m1k6ETuGqwAXJH4IF6jeGjKCPTHAl6l7BdXE4z+AQ8e6Wj
         tBIINLIsyGl3A==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Daniel Palmer <daniel@0x0f.com>, allen <allen.chen@ite.com.tw>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH v2 1/9] dt-bindings: Add Jenson Display vendor prefix
Date:   Sat,  6 Mar 2021 00:44:18 +0100
Message-Id: <20210305234427.572114-2-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305234427.572114-1-giulio.benetti@benettiengineering.com>
References: <20210305225444.GA792026@robh.at.kernel.org>
 <20210305234427.572114-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfNaWtsmNG+JI9yJvugQwlq9YmKZ7R8gEHN0u/bg2tlOBXnw2mMjpbbIrzNkQj2hOIDKIvQU1O8f0mr43HSBDpcPa9C+3iycUdyJgA7oq88Wuo0XOwn6U
 sXl65bWcDQzZY18+SL8yEP8PL4JPpi7BGlLXC+H0gVBvlQb9Zp+KjEDNHoSq+Ew6gIh4FNjOzvxGZpK7S/HS1gqE6SfPWSARPBaNR0dsk7m0ZBCDCuEjBgnV
 4O1+QVj+wDIZjJ0kveGePMlplFHRrMeFQFxk0zfWtbzfI+ox3ziKK4pTZHyWrDvl5NgK904sr17ZOz9vrxflo8Le96KEJ13mHx7NA+zhe0Plh9fyMZp9oxXV
 yYF1ZDHAv2A67VB56ISuGZqEMHbpuanwUDcNgkpr0DvtK5UfY9/QS91qZjwiDDd7U8QVJ264jdCcAoOOc7hbmM1wZO4NFyFa/1DECwErs/FeV9xV3qoJJ0Wm
 Rw5Pc5QHJnARdOe9aT58e/KNXjKdTMl2FWhMQVTEN+ceKOnCGGhwP9Q0mXisRlEjWqeUaR89Afzy2DO3oRsfoh8P9ck9ijQ6gkcQ0MRYpmZQBPxqTOncoAM8
 +uF/Jm/N7QNHpHMLp85/Xzw1UnEljq8ur/irLQvrAJsjjRtYP/4CW5sJykolpnU6EPlVDVVNdpCxW6MDJ9C28OMQOK8TZoYXSZIiNC73hqtTGC7hu7S4ijlp
 vj8+dy7gyOoL6+gWUwCwzyNhHG8xEzgcAjSqroHNgt7BjsBn1qRBJg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giulio Benetti <giulio.benetti@micronovasrl.com>

Update Documentation/devicetree/bindings/vendor-prefixes.yaml to
include "jenson" as a vendor prefix for "Jenson Display".
Company website: http://www.jensondisplay.com/

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index f6064d84a424..a1312637d6ff 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -553,6 +553,8 @@ patternProperties:
     description: Japan Display Inc.
   "^jedec,.*":
     description: JEDEC Solid State Technology Association
+  "^jenson,.*":
+    description: Jenson Display
   "^jesurun,.*":
     description: Shenzhen Jesurun Electronics Business Dept.
   "^jianda,.*":
-- 
2.25.1

