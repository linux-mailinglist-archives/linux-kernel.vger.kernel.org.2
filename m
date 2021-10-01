Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA1141E9BF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 11:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353114AbhJAJna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 05:43:30 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:46500
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352872AbhJAJn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 05:43:29 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 89B7F402CE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 09:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633081304;
        bh=hCpMRXvOk2qr7XekeSwTAlezX0sg/HHCf3cdaEa6PNI=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=V+uoDUE4Tys3jJRO5q2Qa+/TQHrreER05Q4dtzhm2vF7Hvi+5VvRdwtjuVUOpxu0U
         I96AR3ETnJ+MUD5E5m5No0jUUSteg8/Ii4KTiBBR3an0a41xLWXC4bZFf503W2Id/a
         rkBjXGCJXU2pfeOUQR/Stoqr0QblX0pYkSIFUYStrL9nGkhq9Xd/IDG9Eo7N+VsD67
         y23CvTZFwLoXxu2jcnsBP/TZu3i7lKHVg6qkasUScy6YXWX19+q+Ge23QHEsqqa8ut
         mAF9tocEvSkyoAB5VZv5hVTmgKYZqVPnOUYH8kb+SrhXF5zTLw4RAA9MEcJYElXFIK
         r21515v5lKzvA==
Received: by mail-lf1-f70.google.com with SMTP id r14-20020ac25c0e000000b003fc149ed50eso8437500lfp.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 02:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hCpMRXvOk2qr7XekeSwTAlezX0sg/HHCf3cdaEa6PNI=;
        b=On5YptS9lEklJNsQnY/O5grRQ6vs5jd8biLJUGjhfWmSuXP3au3uSozpzlgnOCcUWO
         pb7b5PJrCCSZLBWjslRmQHJoC8eE4aS6E0+MZruGkNo/fgRXHYA+4oRUXBtARwyTfgop
         pcvyKcZxOr/ktPMxvNnMaM7/wEJhjJ5rXMIc178GjuKXxZwFZThXi57LdBoX0pKgGI3V
         VanTgtxdYomqkSgT3uefUvQjyAwsMi5HQyDUpEtaLWy+1JTXjbU4o5jC2CQKnQbZN+0e
         cvNiqboi0FbqVxYfbZ/oXyyA2u5NmwbPu3GjY8L8YEuFc0TjtXmTOsUdXvw/w2br2GK/
         ZObA==
X-Gm-Message-State: AOAM530LFnIh8+TPOGcMzTEQle36++7H/xIXxMwuSrvmDl0ewgkHUZVB
        5fCTxrMDBW60CcfAJz/av96TppiHgh9qepUAcBS5/6Bmf/d1iPEhVkhFlrEiAyO+nBQpvD7fKvu
        E54iDCVBmQlRJwhbuq6seKg2lX0n8kwpwlhLYcFeoZg==
X-Received: by 2002:ac2:5b10:: with SMTP id v16mr4303304lfn.331.1633081303912;
        Fri, 01 Oct 2021 02:41:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxx27QWtjCHIBqlzXq+yG8hpF1waFM4KgjEZAEVScGpVqd57scj/Mcll414XykeZPaNgSPJLQ==
X-Received: by 2002:ac2:5b10:: with SMTP id v16mr4303273lfn.331.1633081303584;
        Fri, 01 Oct 2021 02:41:43 -0700 (PDT)
Received: from localhost.localdomain ([193.178.187.25])
        by smtp.gmail.com with ESMTPSA id g29sm673784lfj.212.2021.10.01.02.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 02:41:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 00/10] regulator/mfd/clock: dt-bindings: Samsung S2M and S5M to dtschema
Date:   Fri,  1 Oct 2021 11:40:56 +0200
Message-Id: <20211001094106.52412-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Changes since v1
================
1. Drop DTS patches - applied.
2. Fully remove bindings/regulator/samsung,s5m8767.txt .
3. Minor subject reformatting and few typos in text.


Intro
=====
This patchset converts all devicetree bindings of Samsung S2M and S5M
PMIC devices from txt to dtschema.

It includes also two fixes because later conversion depends on it
(contextually).


Merging/dependencies
====================
1. Regulator related binding changes depend on first two commits (the
   fixes), because of context.
2. The mfd bindings depend on clock and regulator bindings.

The fixes and bindings changes (patches 1-10) should go via the same
tree.  For example regulator or mfd tree.  I propose the regulator tree,
since it will have also one driver change (the fix, first commit).


Overview of devices
===================
Essentially all Samsung S2M and S5M PMICs are very similar devices. They
provide the same functionality: regulators, RTC, 2 or 3 clocks and main
power management (e.g. power cut to SoC).

The differences are mostly in registers layout and number of regulators.

The drivers are built around one common part, mfd/sec-core.c, and share
some drivers between devices:
1. MFD sec-core for all devices,
1. one clock driver for most of devices,
2. one RTC driver for all devices,
3. three regulator drivers.

The regulator drivers were implementing slightly different features,
therefore one regulator binding for all devices does not make much
sense.  However the clock device binding can be shared.

The final dtschema bindings try to implement this - share only the clock
bindings.

Best regards,
Krzysztof

Krzysztof Kozlowski (10):
  regulator: s5m8767: do not use reset value as DVS voltage if GPIO DVS
    is disabled
  regulator: dt-bindings: samsung,s5m8767: correct
    s5m8767,pmic-buck-default-dvs-idx property
  dt-bindings: clock: samsung,s2mps11: convert to dtschema
  regulator: dt-bindings: samsung,s2m: convert to dtschema
  regulator: dt-bindings: samsung,s2mpa01: convert to dtschema
  regulator: dt-bindings: samsung,s5m8767: convert to dtschema
  dt-bindings: mfd: samsung,s2mps11: convert to dtschema
  dt-bindings: mfd: samsung,s2mpa01: convert to dtschema
  dt-bindings: mfd: samsung,s5m8767: convert to dtschema
  dt-bindings: mfd: samsung,s5m8767: document buck and LDO supplies

 .../bindings/clock/samsung,s2mps11.txt        |  49 ---
 .../bindings/clock/samsung,s2mps11.yaml       |  45 +++
 .../bindings/mfd/samsung,s2mpa01.yaml         |  91 ++++++
 .../bindings/mfd/samsung,s2mps11.yaml         | 267 +++++++++++++++
 .../bindings/mfd/samsung,s5m8767.yaml         | 307 ++++++++++++++++++
 .../bindings/mfd/samsung,sec-core.txt         |  86 -----
 .../bindings/regulator/samsung,s2mpa01.txt    |  79 -----
 .../bindings/regulator/samsung,s2mpa01.yaml   |  69 ++++
 .../bindings/regulator/samsung,s2mps11.txt    | 102 ------
 .../bindings/regulator/samsung,s2mps11.yaml   |  52 +++
 .../bindings/regulator/samsung,s2mps13.yaml   |  52 +++
 .../bindings/regulator/samsung,s2mps14.yaml   |  52 +++
 .../bindings/regulator/samsung,s2mps15.yaml   |  52 +++
 .../bindings/regulator/samsung,s2mpu02.yaml   |  52 +++
 .../bindings/regulator/samsung,s5m8767.txt    | 145 ---------
 .../bindings/regulator/samsung,s5m8767.yaml   |  83 +++++
 MAINTAINERS                                   |   9 +-
 drivers/regulator/s5m8767.c                   |  21 +-
 18 files changed, 1136 insertions(+), 477 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/samsung,s2mps11.txt
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,s2mps11.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/samsung,s2mpa01.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/samsung,sec-core.txt
 delete mode 100644 Documentation/devicetree/bindings/regulator/samsung,s2mpa01.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/samsung,s2mpa01.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/samsung,s2mps11.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/samsung,s2mps11.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/samsung,s2mps13.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/samsung,s2mps14.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/samsung,s2mps15.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/samsung,s2mpu02.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/samsung,s5m8767.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/samsung,s5m8767.yaml

-- 
2.30.2

