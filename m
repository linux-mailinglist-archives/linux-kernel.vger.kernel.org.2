Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7971A40FEDA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 19:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240567AbhIQRxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 13:53:12 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:44252
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232912AbhIQRxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 13:53:11 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D89A2402CF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 17:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631901107;
        bh=MMF2iWv4kcxI3pzDDiyV/HVjAyM5xI6kvs1LvzNHODk=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=AO502w7SMhi7l4wKKmK/tbdzUdkJ6zv40nNbVLyvpOt8Ak9wh6GIJby8hiUZ6FwlE
         /nmIAqcH5lsBoj155XhQlpe1G/GwjfsZn5e6NPOuZDficszXge4Sj4CtJQqLNEpdMI
         nQVlJzcWdDQLOvWZfhl4emLvS6uwyzvRvRXGIYDimN2EcY0ObgZlGhfxj9XPaiZdUw
         kYThOXL4WBwkymZ7/zFnl0sIgvSOo2UzhK9JTLT5fE1XDEjHLJPblBsAfgJcfE7tN1
         vHfoqJNh3d4b5zIhM7n7LPu7H40FDNBNgyMteLdQmwjsPmsFXSYIhHUJC2p10DCOlc
         PpMjs/yLAQsZg==
Received: by mail-ed1-f71.google.com with SMTP id z6-20020a50cd06000000b003d2c2e38f1fso9781559edi.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 10:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MMF2iWv4kcxI3pzDDiyV/HVjAyM5xI6kvs1LvzNHODk=;
        b=NE9JZcfsH825/0UOCWPqNczIT4T4L+qxp10III8Gv6vcGLFYvo6rI2HwSMaf/2z//S
         QkeVJ82cuBgUyLkWz2DqlgXg4eHjpGmGqwvR1TQA/5S27gYRK11Kefg+1FoCjeI0rxfk
         h0UnYcMC5SCx+TDSqwPlHzfANbympxx+N52poduJqJJkXelyp+5v2fTMKGTSqhnHC2i3
         rg3bi9KyUcFItoJCq4tuAZXMZfwmWFwN4glsgMXxLljm+f5GkP9Jpp7pUblFaA10Gtxt
         cDFvZy2iYgLxiuiyst/CGAUpkFP329YwJeqKW0UvcPQrIggxVPjZuaAK/6K8w5Ne2gc4
         uu2Q==
X-Gm-Message-State: AOAM531Pu2v+ab143HaGp32aKdpWVUMhHmz1a5/0kvnpUaKQ64CChCZA
        x/M3hir3foGPlloFP/4gC43R1iTTBcZS2PSV6zKP55IbFlscnSJniC6YtAM6G9ftV6/i9eX0PUv
        XVPWnEY0dzEOTaR2BXahhjJ6JtXzt0F/5HZPFrKAMuQ==
X-Received: by 2002:a17:906:a18f:: with SMTP id s15mr14093621ejy.269.1631901107484;
        Fri, 17 Sep 2021 10:51:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSIzcpv+tMyR6TNvX1deHw1+0dUu13dndrvmjG4VR4paQlLXKULMAl5QGjqAySEq52fFnZcA==
X-Received: by 2002:a17:906:a18f:: with SMTP id s15mr14093598ejy.269.1631901107301;
        Fri, 17 Sep 2021 10:51:47 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id l11sm2951345edv.67.2021.09.17.10.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 10:51:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH 0/2] soc: samsung: be a module!
Date:   Fri, 17 Sep 2021 19:51:32 +0200
Message-Id: <20210917175134.252882-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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


Krzysztof Kozlowski (2):
  soc: export soc_device_to_device symbol
  soc: samsung: exynos-chipid: convert to a module

 drivers/base/soc.c                   |  1 +
 drivers/soc/samsung/Kconfig          |  3 ++-
 drivers/soc/samsung/Makefile         |  3 ++-
 drivers/soc/samsung/exynos-chipid.c  | 11 ++++++++++-
 drivers/soc/samsung/exynos5422-asv.c |  1 +
 5 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.30.2

