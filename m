Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A4A410FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 09:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbhITHRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 03:17:22 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:53718
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234688AbhITHRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 03:17:21 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C996B3F31B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 07:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632122149;
        bh=Wx09CSLf2BUcoT4i99Nl9tot/C6qmojAMi1r7QcpgsQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=WgS+j3vLepsQeEYgd/ndtsoxByu0sh1k7ZwuDPhCg8qhcrX//ay57X+uy+NGHYLZq
         4XLdSiC/vDv1O6ZmkZONLFNrjd2Sr96Z4ZqK79FPSV5sxhD0A+641UH4RO6DD7Bomx
         arMXgOM7+LEaL3SLacObmukHQVe9Dpp3xSc614IBEnGhQv3lQovrvoWGskvD9C6r6Z
         +NARQLDfmMIz7f9KFpmO+BIMtcetJ4hNTTuN0ccfoXdBaUoolWW3kui3tkTYgX5VDu
         mM9dsNN+AA6RFeHZ2GAnLT5M6iDLgoAU9gdhNb34ApudDXVQ26us1VTTc/JHcwANL+
         qNbvuUOl11JPw==
Received: by mail-wm1-f70.google.com with SMTP id x10-20020a7bc76a000000b002f8cba3fd65so5418184wmk.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 00:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wx09CSLf2BUcoT4i99Nl9tot/C6qmojAMi1r7QcpgsQ=;
        b=XgHv/uFzuvikANtg32rJ6BxDNGwMiwiJ78ONSnzxfGMIv/CtErfIB3MwneqzQgUCLw
         dT99fVh9b0ft61+LI9T79m6DhBia7nD3pavGvD24TyaOFmzupJ1ooQCC8rrOwtf0ISHs
         0d+FqkdBXY1Rpfte52/xgyJh3VW6J3sfhtDLNXIAI/uArCKm5oOLO1Z0e7P3NiPsC624
         pDaqHLUM1QwQxG2RSaBGtMEXRE34RxiBOf8f/lN5vYrMFkgA+mBl0BSeVlERfWlEVptQ
         Z+aF4KGXCV/tlxboytmPDLTTPQ2dcZRkeFYCDcmupLHM+eSRfD74CP4dHYGZt7/H7LdF
         gSwA==
X-Gm-Message-State: AOAM5328+wHOajFdocmm8FvMQlmFWfPvyosJFeKMKufNDgYKDFxZA7j3
        FVrV+D2W0408EAGbl9rf9juhBx/IYIRE7Q1XuAPTUNJWTlVACNHF/dkp0tIpoxYR8koXYGIyFsz
        KNWxVid726kpDgTeNKdpyga9CihxU5vSoXnKnThlJ2A==
X-Received: by 2002:a1c:7e55:: with SMTP id z82mr262565wmc.95.1632122149364;
        Mon, 20 Sep 2021 00:15:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+/JWO4KawW9KMTN5QacKUh4LzdTsDtHGOI8eupCw/ohf4m9JVuD9eePbgGFUp8uXDjI5x6g==
X-Received: by 2002:a1c:7e55:: with SMTP id z82mr262553wmc.95.1632122149216;
        Mon, 20 Sep 2021 00:15:49 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id x5sm17456153wmk.32.2021.09.20.00.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 00:15:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 0/3] devfreq: exynos-ppmu: conform to dt naming convention
Date:   Mon, 20 Sep 2021 09:15:37 +0200
Message-Id: <20210920071540.38337-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My previous patch 3/3 (ARM: dts: exynos: align PPMU event node names
with dtschema) caused issues reported by Marek [1].

Tested on Exynos5422. Testing on Exynso5433 board would be very useful.

Changes since v1:
1. New patches 1/3 and 2/3.
2. Patch 3/3: rename event-name to match node name.

[1] https://lore.kernel.org/linux-samsung-soc/0212a402-1490-0f8f-005e-32bb6f636a13@canonical.com/T/#m570c0257204af553fe11f9122551311beb56c15e

Best regards,
Krzysztof


Krzysztof Kozlowski (3):
  devfreq: exynos-ppmu: use node names with hyphens
  devfreq: exynos-ppmu: simplify parsing event-type from DT
  ARM: dts: exynos: align PPMU event node names with dtschema

 arch/arm/boot/dts/exynos5420.dtsi   | 16 ++++++++--------
 drivers/devfreq/event/exynos-ppmu.c | 12 +++++++-----
 2 files changed, 15 insertions(+), 13 deletions(-)

-- 
2.30.2

