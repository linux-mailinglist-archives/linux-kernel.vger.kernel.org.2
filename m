Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DE04282D8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 19:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhJJSAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 14:00:43 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:34054
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231134AbhJJSAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 14:00:41 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C12E03F324
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 17:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633888721;
        bh=rKgAfJ12hcF8DFHLqF0Uys+r8EW0o0/y+bAD3IeB/jg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=a7C5ewQC0cUHfoWAlclgqjpTh3c9Gqg340O8gOsaz9S1hyPsPxZ3JNoao3xNmJXQi
         Ik9bLE10zCz8p7MW3L67MwHXkzY78h1zCm5w7ehkPQGHvSBcMJJVN3dJxoD1rkpDFH
         xOR8ScoXZNrxjyWRzKH4/vyWMY7ImsBLTYc7WsdPfd+Iq4QPX69xrBhjQ6dsB4WTVr
         Larb+fg/hIr746fDjiZdFzjJ2Bz8iapJzdL5cSe6W8Z5CO34iCF8VQJKYQ5u/qPriv
         Nx5MSfcXoi8ytoasjhDc2VDiTKFFfaeGfhEmFr633J9wmBf2orDrlql8qF5ZRMyksl
         6CdHWe3jFW9rQ==
Received: by mail-ed1-f71.google.com with SMTP id c8-20020a50d648000000b003daa53c7518so13681048edj.21
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 10:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rKgAfJ12hcF8DFHLqF0Uys+r8EW0o0/y+bAD3IeB/jg=;
        b=nEQDbIePIqWyVylW5ibKrh2QZG7Ffu/YzMrfSrzvM9gp1Jnaqvq4oiBKJ6UU1c1SN0
         FxpH7uk5aQfdb/T676vaHQcwrKXG+lgahXGuKcGHMYgrexhxL0AOrdQtTWNpiDd3tVg9
         P1OCqROdVKR+oq+VaakmO7LR2C9oVysww4Czpm8aOBIkmB01a8oI9m/OGZ/UBRVTje4a
         jVlz9Qokt1OX4hUciVcylU4oFgraUJgQY1qGpPLqgMIECLHCfElF+IfrjCiS25WG1yEH
         W+G6Sj5ar+6GZnTpevYb0+r/3UprZdNIhNI7EnpzSKWpuh+ueqpcsfaxIb1xgC4WIiNI
         ctJg==
X-Gm-Message-State: AOAM531B+p87EPtox8nTmyKWdzXJ9QIXuu/5TejRrnT3gKZRxb1E3Jgn
        jUzHhxzSwAajwCtVF8I/Jz9oLNIrsf7P9po1OLgrse02x4ITd2eNf0tqRouN4caFSvRFyrDoXP6
        p4oHsgjWz8k14jmmfxYksxcTcnGG20EuYoVya60v+0w==
X-Received: by 2002:a17:906:9b46:: with SMTP id ep6mr19750389ejc.226.1633888721433;
        Sun, 10 Oct 2021 10:58:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1MgPOzxF07OexmASNsOYS3ctHTEtd/77o+u4QWFFDgfbBbWBc3P/wIao7oselGzuUMsiqAw==
X-Received: by 2002:a17:906:9b46:: with SMTP id ep6mr19750372ejc.226.1633888721285;
        Sun, 10 Oct 2021 10:58:41 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id au26sm2347948ejc.53.2021.10.10.10.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 10:58:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 2/3] memory: mediatek for v5.16
Date:   Sun, 10 Oct 2021 19:58:35 +0200
Message-Id: <20211010175836.13302-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211010175836.13302-1-krzysztof.kozlowski@canonical.com>
References: <20211010175836.13302-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A topic branch specific to Mediatek.

Best regards,
Krzysztof


The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-mtk-5.16

for you to fetch changes up to 93403ede5aa4edeec2c63541b185d9c4fc9ae1e4:

  MAINTAINERS: Add entry for MediaTek SMI (2021-09-22 08:43:09 +0200)

----------------------------------------------------------------
Memory controller drivers for v5.14 - Mediatek

Add MT8195 support to the Mediatek SMI memory controller driver.  This
brings also several cleanups and minor enhancements before adding actual
new device support.

----------------------------------------------------------------
Yong Wu (13):
      dt-bindings: memory: mediatek: Add mt8195 smi binding
      dt-bindings: memory: mediatek: Add mt8195 smi sub common
      memory: mtk-smi: Use clk_bulk clock ops
      memory: mtk-smi: Rename smi_gen to smi_type
      memory: mtk-smi: Adjust some code position
      memory: mtk-smi: Add error handle for smi_probe
      memory: mtk-smi: Add device link for smi-sub-common
      memory: mtk-smi: Add clocks for smi-sub-common
      memory: mtk-smi: Use devm_platform_ioremap_resource
      memory: mtk-smi: mt8195: Add smi support
      memory: mtk-smi: mt8195: Add initial setting for smi-common
      memory: mtk-smi: mt8195: Add initial setting for smi-larb
      MAINTAINERS: Add entry for MediaTek SMI

 .../memory-controllers/mediatek,smi-common.yaml    |  34 +-
 .../memory-controllers/mediatek,smi-larb.yaml      |   3 +
 MAINTAINERS                                        |   8 +
 drivers/memory/mtk-smi.c                           | 596 ++++++++++++---------
 4 files changed, 393 insertions(+), 248 deletions(-)
