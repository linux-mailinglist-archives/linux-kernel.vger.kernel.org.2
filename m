Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8D93E8CA9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 10:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbhHKI5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 04:57:00 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:46772
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234568AbhHKI47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 04:56:59 -0400
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id D22503F242
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 08:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628672194;
        bh=AkfNVRo7hHf9V8Un9aQjkE6FARkV1KO6bGOPkL8pwsg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=id8JtcjH3xJFhY+hcsRjXJkV21xaGm30LVc8zvQvR6rT8FdqfQY/viIcmmA5wVMXt
         NwM9NpGOaZsy2oU3Iv97v7PDo1feZ0ouPacw7QEQFOHQl+Cln2JN77jfacEzvbloTP
         PfD0ZoMttc2oBd10tHuA+n0CW3mJ5cnxRn1hjoKB2/jE6Ioi3uTE4WrQ+2mGRcp/YX
         WpIItxI5gyImZSh0XAIY1bNZZa/+C2YskHSchSdu3Ty0iSM/4Cm9KhaTIlAIfhWgyB
         2rkVKLbUBEnx3LbiTldX18litXjk35i3p2YPATiRmXbkAUnMlNNk6tJHzWk9NLbh9k
         +F3OAO7W9FZKA==
Received: by mail-ej1-f70.google.com with SMTP id h17-20020a1709070b11b02905b5ced62193so421042ejl.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 01:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AkfNVRo7hHf9V8Un9aQjkE6FARkV1KO6bGOPkL8pwsg=;
        b=ltG1HLKt/fyQhi+HVRrqHGIG4IHwRUW4ji6L3n6CsF2vRr+l5QLNkjhe3j8X83uD5j
         1+BmCL4+2cwG89nnkeZrz45yzZiLL6D3VzCdCwcwYQNpbESvSCUIOaTUCUPkqXURxi3H
         Ggr2KL14t5PaM768RevwzeP+Za/AYONg2CkAjB6K2JtD+qyzwgcbLknhM+DW3hs4Tm9H
         MzKksfB9n/C+KVqrmycmzgegY4Bf8ahLg9QF/6k0B1nIwbxH4Xsu1OyAkQ0tiRoeQ/sx
         1Z//4wcP9QZ4nbscNO+n3eMuC7Lztn+L9aWVg23NTc2m7tYoUgnsUJE+xRWFMGbNDvuN
         xidQ==
X-Gm-Message-State: AOAM531eTZ+r9NDpec7DtlZij6cDKWHt2A1Dwgbt1gBUnm5qzyNgqeAm
        n5kOAZd3Zs5gZV4KcIrCzaVhWR9TizpaCiY13+/fIR6Rql57D7LtVImg9VxSblbMQ7WwwE13jQk
        myiFRq6PrXhN4xJYPf4/bNyVYYwnygQ2CI7Jl95cgrA==
X-Received: by 2002:a05:6402:d49:: with SMTP id ec9mr10099877edb.333.1628672194555;
        Wed, 11 Aug 2021 01:56:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLaINYImBffGAxkeivDUKOJNEzYPQrtsNvBTAbFcoUG0Xlm7TBEfwmQhiR9WGSnXf07gHdDg==
X-Received: by 2002:a05:6402:d49:: with SMTP id ec9mr10099869edb.333.1628672194408;
        Wed, 11 Aug 2021 01:56:34 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id x4sm7834003ejb.106.2021.08.11.01.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 01:56:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 1/2] ARM: dts: samsung: DT for v5.15
Date:   Wed, 11 Aug 2021 10:51:27 +0200
Message-Id: <20210811085128.30103-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-5.15

for you to fetch changes up to 6cad6db75231a18f25dc7d610d5a0683160ac545:

  ARM: dts: exynos: add CPU topology to Exynos5422 (2021-08-05 09:24:04 +0200)

----------------------------------------------------------------
Samsung DTS ARM changes for v5.15

Add CPU topology to all Exynos DTSI files.

----------------------------------------------------------------
Krzysztof Kozlowski (7):
      ARM: dts: exynos: add CPU topology to Exynos3250
      ARM: dts: exynos: add CPU topology to Exynos4210
      ARM: dts: exynos: add CPU topology to Exynos4412
      ARM: dts: exynos: add CPU topology to Exynos5250
      ARM: dts: exynos: add CPU topology to Exynos5260
      ARM: dts: exynos: add CPU topology to Exynos5420
      ARM: dts: exynos: add CPU topology to Exynos5422

 arch/arm/boot/dts/exynos3250.dtsi      | 11 ++++++++++
 arch/arm/boot/dts/exynos4210.dtsi      | 11 ++++++++++
 arch/arm/boot/dts/exynos4412.dtsi      | 17 +++++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi      | 11 ++++++++++
 arch/arm/boot/dts/exynos5260.dtsi      | 38 ++++++++++++++++++++++++++++------
 arch/arm/boot/dts/exynos5420-cpus.dtsi | 32 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5422-cpus.dtsi | 32 ++++++++++++++++++++++++++++
 7 files changed, 146 insertions(+), 6 deletions(-)
