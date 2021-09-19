Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E64410AE7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 11:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbhISJcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 05:32:47 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:36354
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237507AbhISJcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 05:32:46 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E22603F4B9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 09:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632043880;
        bh=Zlzk0L+jJUx03F0UWBN9FUh9Hi4wSYcrxBZrYue21xY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=LfHTCY+r7KvngarlW3ov6gMM3gwyvQpOQvAw6BSV4WXJBs7tKz61DoLopfB1fc8Oz
         eE43CBnCaYlsaOygCM4otIigS0CmSqu6QQXUc/E2tAf+KtqG8QZG7RNu4qLCHpZpAo
         K9unJ43vm1lFSxDt7l9flE3/GmnPrXjid2dkqhDcIjCA7EB00CYCB6HTByHWTgv3kb
         edrpcWAmI3TgwoX6fEFcB9Jxbqo2XLhDZ7MAodJGjKAtNafYj39u78Q9e1kVvlNObu
         5VH6rdkpXj2mvXIVxrFh4qLR0K+J8897NOHSBTBFC0sgyz9F4W2LeiC+87GkZQwZiX
         eDirt7kc+l1/A==
Received: by mail-ed1-f72.google.com with SMTP id b7-20020a50e787000000b003d59cb1a923so12199580edn.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 02:31:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zlzk0L+jJUx03F0UWBN9FUh9Hi4wSYcrxBZrYue21xY=;
        b=iRAQz0T3SFXnbwDb2jiHJU1k9yix8TzuLxPwZVa9aDT5kip5FtKRUAy7CMljDStZZd
         CwcdepwxlTj0WiOx6sfZSg2q2z6N/xzDcsbmUOZDHMiLnRKZh/tQl0bQxATU1UCrXA3G
         lf1tiXPTqwCPIJF8vR1QNBI6fPTH5x7t9n7rWJdJwVCbBG2mQcjiWGiGlklgaU5mwcPB
         NrCOH5iphlaRO2an9oDeLr8pRS//gUpzVYvdDyHEloP8Uw5pGon23Ef7yMd3djtpczCM
         4+nWXewZkauW6OhtfA8kAK39UdJnbw9GGORtWGUrlu6at4o8wsOjPlhKzD1J62xWT/KY
         6Mwg==
X-Gm-Message-State: AOAM530uJQh7sg5HFsipBRVYe6xA/DPeS2+SfetNuIK8I+Ov3Pu15Frs
        P1tmQWZxYxi+Tr4G4GjH6D6oE2FpVV6NmMz5UodsnM5SKlz5ZoA5D9bzD3Ia9pLa65WZbfN6W2H
        PJg4Xd1oOoN2IHyWWYZ0z9EC1V4fkGPtNIZfbAmQueQ==
X-Received: by 2002:a17:906:eb56:: with SMTP id mc22mr21317138ejb.542.1632043880367;
        Sun, 19 Sep 2021 02:31:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwA57zHEYeEhvGZbVieFxmBitOGTy7AjxQG0k0Zag5Vv7d7dTv4Kz8JFMwEnzRS1C5FpIrGrg==
X-Received: by 2002:a17:906:eb56:: with SMTP id mc22mr21317115ejb.542.1632043880176;
        Sun, 19 Sep 2021 02:31:20 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id p24sm514111edq.27.2021.09.19.02.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 02:31:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH v2 0/3] soc: samsung: exynos-chipid: be a module!
Date:   Sun, 19 Sep 2021 11:31:11 +0200
Message-Id: <20210919093114.35987-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v1
================
1. Drop patch 1/2 - exporting soc_device_to_device
2. Add new patches: 1/3 and 3/3.

Question
========

A question - what is the convention for naming modules: underscores '_' or
hyphens '-'?

The C-unit file already uses a hyphen "exynos-chipid.c", so I could
create a module named:
1. exynos_chipid
2. soc-exynos-chipid
3. exynos-chip-id

The Linux device name is "exynos-chipid".

Best regards,
Krzysztof


Krzysztof Kozlowski (3):
  soc: samsung: exynos-chipid: avoid soc_device_to_device()
  soc: samsung: exynos-chipid: convert to a module
  soc: samsung: exynos-chipid: do not enforce built-in

 arch/arm/mach-exynos/Kconfig         |  1 -
 drivers/soc/samsung/Kconfig          |  4 +++-
 drivers/soc/samsung/Makefile         |  3 ++-
 drivers/soc/samsung/exynos-chipid.c  | 14 +++++++++++---
 drivers/soc/samsung/exynos5422-asv.c |  1 +
 5 files changed, 17 insertions(+), 6 deletions(-)

-- 
2.30.2

