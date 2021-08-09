Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDD43E4709
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 16:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbhHIOAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 10:00:46 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:53136
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234512AbhHIOAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:00:45 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 60BE840662
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 14:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628517624;
        bh=PXrJ+BbgGTXejs85MxNsHQpcGJv4nzL8+I3ykkzFz/Y=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=UItA6TtFhztj5GcV5g8jP6Do8rXQoP2xe090xFv9d+pRvdhlN2fH4eOaOKK9gyo5W
         9mtp1wbjLKnCdZ5uKP7PtODpDDCPC9jvwfWzLc8cXvoywfKnF/esAiq6QuTSxe3e1C
         ouv83DiPthm3Rq5Calrk0OkFsPW3ca7b04MrYpW7cKLCdCzMYJmlI3ay7JtLyg3HrP
         uXGsraL8FMV7ojHf7YakFLvfxGsKT1GLIhfBJlplpMUXRbb3dly0GsYamVfm3t3VwM
         oBkZgYz1NzJOf1Z22folkEQMq5Q7+ITaw6XiYEWdeWuxLb/trelGmIPckejjIkJwkO
         lwZh/DPKJYsYw==
Received: by mail-ed1-f71.google.com with SMTP id c16-20020aa7d6100000b02903bc4c2a387bso4449897edr.21
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 07:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PXrJ+BbgGTXejs85MxNsHQpcGJv4nzL8+I3ykkzFz/Y=;
        b=IrEWjsCjJ/xUThbsHPLxjouDRyAM+TBHWTvZ8YZGYtgZIgOmAXDf4ZBVw1FunGcH4r
         JUGyDYZVcH/42M3JHrCW7NCV2Qv2hlMkL0WM2I8bAnhJFLCtg67yxZi8kGi9lI1T4Zx4
         UnmEQwGG18NolaWlCH4Ubp0qGtrZW+n7MPGrzMFVHxL3MF3sg/algrBtoVDzmQ0m9BtE
         KTjRdXs/a2Em14EeajNXxeM3F8tX6H+hCRTH0lq6x6QICGu5yDzza4Me+u+Du8YDD40I
         MgHQLaG3zkS60czvwlckZxgX/8STZaiOyFh8ul7YAlY1duf16SOOjxpChzaigJROZaT2
         ZLDw==
X-Gm-Message-State: AOAM531VISTqRRqCdL87Nnm+WFwz+UcSpLtV2TaPnNrtys2X8IiT1Kp3
        iEe2/LsjBPbdzdH2/bqMSaYwoWuPM/YQKVsIHNbzLX6/H5dxZXtLPvlnxntWFRwzu2wB3tAgxFt
        ASKSAsDYRfObjaDRf8vlMEYIo1HS1S90I+DkP3uyieg==
X-Received: by 2002:aa7:c6d0:: with SMTP id b16mr30047981eds.257.1628517624122;
        Mon, 09 Aug 2021 07:00:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy733K83FCEVxUSDiFu+sAff4YqEjYwxphl7rHUYA+ge65yYWoTdLNweov2T/r4nxposORUTw==
X-Received: by 2002:aa7:c6d0:: with SMTP id b16mr30047953eds.257.1628517623881;
        Mon, 09 Aug 2021 07:00:23 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id b17sm7909686edd.27.2021.08.09.07.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 07:00:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] dt-bindings: clock: samsung: convert AudSS to dtschema
Date:   Mon,  9 Aug 2021 15:59:39 +0200
Message-Id: <20210809135942.100744-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Rebased on on previous series:
https://lore.kernel.org/linux-samsung-soc/20210809120544.56596-1-krzysztof.kozlowski@canonical.com/T/#t
It affects only the maintainers file change (context-dependency).

Best regards,
Krzysztof


Krzysztof Kozlowski (3):
  dt-bindings: clock: samsung: convert Exynos AudSS to dtschema
  dt-bindings: clock: samsung: convert S5Pv210 AudSS to dtschema
  MAINTAINERS: clock: include S3C and S5P in Samsung SoC clock entry

 .../bindings/clock/clk-exynos-audss.txt       | 103 ------------------
 .../bindings/clock/clk-s5pv210-audss.txt      |  53 ---------
 .../clock/samsung,exynos-audss-clock.yaml     |  79 ++++++++++++++
 .../clock/samsung,s5pv210-audss-clock.yaml    |  75 +++++++++++++
 MAINTAINERS                                   |   3 +
 5 files changed, 157 insertions(+), 156 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/clk-exynos-audss.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/clk-s5pv210-audss.txt
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos-audss-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,s5pv210-audss-clock.yaml

-- 
2.30.2

