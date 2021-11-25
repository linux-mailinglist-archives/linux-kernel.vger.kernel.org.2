Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1044D45D5BD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 08:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbhKYHxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 02:53:47 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:47380
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236341AbhKYHvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 02:51:46 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 04AAD3F1D7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 07:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637826515;
        bh=nDiYTORIhCmTcIZFOH/2usjtHzZYDziIu23Zdg/+Lbw=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=mqwdX3Gj5u/Gu8NAiy3CpIs91enSiss1ajdlmLjG8qo4sY6RfRH78nSQU2yErNfdi
         dljhp51ZE6yUbhPqUO01BvZ3K+Ra8pHsWuTvLmXi+p3oLLp6Xj/3KdmvbWX1g3M7cT
         CEf2BAWLS0TS7fGv8CIbEMfab15jaC/eWyi0ocbY+FeUMHEHk17m8qsRZJ7RQZG42i
         MjbZkx2NyQoezfe/xBey82ozVOXgb1jawR6jKjAdwOx9ifNNACH2KY9VbYPbZpcSuS
         vxVaLyQ4aCAsuo7lR0lE6WZq/lSse5ezljnHkLwR6AzC3YK1qWlEvG6u3an5iBKB+H
         +S1ZoJX3wxi8g==
Received: by mail-wm1-f71.google.com with SMTP id 138-20020a1c0090000000b00338bb803204so2760017wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 23:48:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nDiYTORIhCmTcIZFOH/2usjtHzZYDziIu23Zdg/+Lbw=;
        b=VqUEdozQA//J3k1t8RTxjNCDiDjSsu842vLD0TCkXHLIlNT+VG4HWFR4g5UKCCjlQq
         FMuwduJZvCT6+adLoOekRAZpRDktKenJAHz7MGrikAG5ULeSK0mN5N+SICLQiiafwuLi
         cNPufJh9WpTZ20HGjd0RrTmiRVpRJzbMMXOdN05LwcBQMWhnertqb+p1iLzTOXNwZtU1
         bimhmr8RR9Lb5KYrqV/lV9aLSUdnsiWCvlREa30hqRaOJCCm5s4vEw2MSvwWTm4IIoR3
         KqYcilvP4TFTFEDD9LkXAf0Emr3Rt5BBbYKK96tPFW9PeSLMybUz1UIgwhpeBI0v2cma
         etIw==
X-Gm-Message-State: AOAM530bnLs8hqmv3UjIjliW5tBPkERQX7LtVLPIBAP0Cw3GKbJTWEmA
        hzOXGC8M7dHnhbyGrDcmi5/KaWAkEk4zgEaZKHmRswMHJzv8foFOp21zmVOjy4QDXdhHaUuSwVw
        iODlXHcqcUuTt9zkPM9vVVL2jTTGl1PXDkroE+Izlqw==
X-Received: by 2002:a1c:80c6:: with SMTP id b189mr5004636wmd.40.1637826514717;
        Wed, 24 Nov 2021 23:48:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJykVEfdmg1lTA/thq9Kt1uoUGcDwlCkPesNsB5fAR0U1yBNntrVQZGlbxSG9t3RzeAfy0x9Kw==
X-Received: by 2002:a1c:80c6:: with SMTP id b189mr5004617wmd.40.1637826514580;
        Wed, 24 Nov 2021 23:48:34 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id o3sm8087937wms.10.2021.11.24.23.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 23:48:34 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] mfd/regulator: dt-bindings: max77686: convert to dtschema
Date:   Thu, 25 Nov 2021 08:48:24 +0100
Message-Id: <20211125074826.7947-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Convert Maxim MAX77686 bindings to dtschema.  The MFD patch (2/2)
depends on regulator, so this should go via one tree.

Changes since v2:
1. Rebased.

Best regards,
Krzysztof

Krzysztof Kozlowski (2):
  regulator: dt-bindings: maxim,max77686: convert to dtschema
  dt-bindings: mfd: maxim,max77686: convert to dtschema

 .../devicetree/bindings/mfd/max77686.txt      |  26 ----
 .../bindings/mfd/maxim,max77686.yaml          | 132 ++++++++++++++++++
 .../bindings/regulator/max77686.txt           |  71 ----------
 .../bindings/regulator/maxim,max77686.yaml    |  83 +++++++++++
 MAINTAINERS                                   |   2 +-
 5 files changed, 216 insertions(+), 98 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/max77686.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77686.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/max77686.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77686.yaml

-- 
2.32.0

