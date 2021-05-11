Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2036B37A700
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 14:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhEKMrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 08:47:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51370 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbhEKMrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 08:47:02 -0400
Received: from mail-pj1-f69.google.com ([209.85.216.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lgRln-0003GD-5S
        for linux-kernel@vger.kernel.org; Tue, 11 May 2021 12:45:55 +0000
Received: by mail-pj1-f69.google.com with SMTP id gf19-20020a17090ac7d3b0290155e8c1b68eso1466804pjb.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 05:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PrBBhJGbjsmhZDFF8O0bml8Qz0d11xqc/seGdEasPHw=;
        b=EaTgzNPzqH9Y1Ilkw1BoUIWslo+px/TaUHf2lqNTg3NTCQ6hPs99COayIzVupIbKWY
         kRBylpayg66JxzTvr2K9Bfd7xfDGISjezAxz5mt6FxYm2ngMy/y6GUIfrVMJUfS4PotM
         zlypb4m/ZZMDtqv93TsSvN3l6CQHiw/0jfRCqYR1496KDV8fHD8VfPiCOdLeTofxbj1u
         5jgaP3QUIIf7mq2kYIRs6T7BckcRjRetHV6lcfdEu/LCsWiJ8AmMqMKqIP8TTzyPTarY
         FnAeKy8ZjyBgJugMCcjvTxjKFEfWUoYBpUuVHd5JjKibW4sebno4KH74APbZvKvDNJ0n
         phBQ==
X-Gm-Message-State: AOAM533kjHSECBqa49fe5JVOYjeBv3SQgXwxLQSYq3RzbRZc0t3xxjJ1
        TrqztTJlnwLoCxRKJLWVDI1lPfJLaOXmctmISdIzUNycqiOjODiKjvalyeduOyNm6lEXvH5iaZD
        2SW2cHf0OnmwPvDS7VipwzZBD9J37vAtyktzrf3vSLw==
X-Received: by 2002:a67:bc5:: with SMTP id 188mr23940526vsl.50.1620736845800;
        Tue, 11 May 2021 05:40:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpsSzE8+yaLV7z21WTm61RVHBgd5GIuSd1bUacFjdwJg53yKaDkNu4i27PfGrQ9TJS39xBtQ==
X-Received: by 2002:a67:bc5:: with SMTP id 188mr23940505vsl.50.1620736845580;
        Tue, 11 May 2021 05:40:45 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.2])
        by smtp.gmail.com with ESMTPSA id t18sm2204204vke.3.2021.05.11.05.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 05:40:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] ARM: dts: exynos: enable PMIC wakeup from suspend on Itop Core
Date:   Tue, 11 May 2021 08:40:35 -0400
Message-Id: <162073682206.13221.757844834039243258.b4-ty@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420164943.11152-1-krzysztof.kozlowski@canonical.com>
References: <20210420164943.11152-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2021 18:49:33 +0200, Krzysztof Kozlowski wrote:
> The RTC on S5M8767 PMIC can wakeup the system from suspend to RAM.
> Add a generic property for this.

Applied, thanks!

[01/11] ARM: dts: exynos: enable PMIC wakeup from suspend on Itop Core
        commit: a1972739c01612adee6bb0a0306ea29be0bb4955
[02/11] ARM: dts: exynos: enable PMIC wakeup from suspend on Origen4412
        commit: 765210e19859fcd83dad26441a5c499c0fe27e28
[03/11] ARM: dts: exynos: enable PMIC wakeup from suspend on Arndale
        commit: 0272619bde229386edf9f1358470e265628d1653
[04/11] ARM: dts: exynos: enable PMIC wakeup from suspend on Odroid XU
        commit: 760ebb8a2529f92f772424c7ddc385a07a9e90a0
[05/11] ARM: dts: exynos: enable PMIC wakeup from suspend on Midas
        commit: 7f23ea1265c3dc2cd5824f67498078fa23ede782
[06/11] ARM: dts: exynos: enable PMIC wakeup from suspend on Odroid X/U3
        commit: 1178f7127a4679db9b70eb16737627f764d7a9c5
[07/11] ARM: dts: exynos: enable PMIC wakeup from suspend on P4 Note
        commit: 9614ae53753003e7a4ecf800db3da189c0f0acd5
[08/11] ARM: dts: exynos: enable PMIC wakeup from suspend on Arndale Octa
        commit: 1d4203b1fa02fca97ca97484f2a43da187112ad1
[09/11] ARM: dts: exynos: enable PMIC wakeup from suspend on SMDK5420
        commit: a145cc05cb2ccbdde2621c91c7d56c3435d3a125
[10/11] ARM: dts: exynos: enable PMIC wakeup from suspend on Odroid XU3/XU4 family
        commit: e4c9b60b271ce428d97577502be9393bdc46dd94
[11/11] arm64: dts: exynos: enable PMIC wakeup from suspend on TM2
        commit: d3f713e6b3ccb1bf8306aaff8b11fd30844db0cf

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
