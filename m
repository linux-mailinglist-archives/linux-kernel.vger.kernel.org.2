Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195324420EC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 20:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhKATiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 15:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhKATiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 15:38:08 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6820AC061764
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 12:35:34 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 5so66899309edw.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 12:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IHx+6RyAT00bbPl2zwH9JrS2kr0JH1+UQLDTyQafWP0=;
        b=KyHC/2sMIjaigeVOlTGEGijkFCjfxxTwxhKSBqFgKNJl8gzl+JgEnm3ZVQRF6GoH6M
         N93vex8ipcoeTJp3V6JdsA42l82+4Zf+2Xedthdz6ZmdGKVSwpMuE422AsiAGgt/WUOM
         xmwtDwGMv9Dz/J9rKlAagS4nZ1evh/kgJTLKFMmgeXDKPDUqLeDCTPcaqSSV5CnkYfo6
         wQ+7TEz+11owwdU922VEC3FuTGzcAK/B1L2ZH21Q3Jl6QySTTiMVgUSNwkDlsvl2U31U
         NTwhWWFcROhYuh5KJmZLQU+hQMbTKY8ZZG1hzQrhS8Q9tYP3KaePClGEYbHTapzvdXmg
         k3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IHx+6RyAT00bbPl2zwH9JrS2kr0JH1+UQLDTyQafWP0=;
        b=vsHIObpMY2OK+F/CuUd19zIt/Ms3IOt2lIs2UZbIRz24iNBG/mTSIZ9d3AUwXU6VhK
         J41DyYmlKMf+RSuhOzSL8ze8a6xPoTVY1QYhlqv8OTqaQ20CHZSWYVbHy5m6p5oH4kon
         mYafWD9BSFmWDq+AJn6VEBJjldeBvYL8aPkgKljS9838FLYx15ufANWbxFHLCInkAYeo
         xIHD14jQY3wof2qPp2Vs7rAUxWpg5cKOOZ/lcrcpFiw16xe/iatsjLdOg/qobgeQGm2H
         CuaLKL+msRXBjzJk/1Rp2q10kWXCR5LFSrhSD8eq7bPoFfLx356vm7e0IWxjccnM7myk
         0E2A==
X-Gm-Message-State: AOAM5319ed1MdCa0FfEhKb6EKiJBqewE1So9gQ5e/iOt4yqI5h95fpW0
        TFRXeMZChXMgl9YwRN0bMgJdrA==
X-Google-Smtp-Source: ABdhPJyYEGncnTnzkLTin5kRwPLyQGpRlYP737W+Tw3n8ODVeVmxndxYj5KOPtogv8tmWGduU4D2QA==
X-Received: by 2002:a17:906:c1c9:: with SMTP id bw9mr38931001ejb.3.1635795332945;
        Mon, 01 Nov 2021 12:35:32 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id kw5sm7164357ejc.110.2021.11.01.12.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 12:35:32 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 0/2] clocksource: exynos_mct: Enable MCT on ARM64
Date:   Mon,  1 Nov 2021 21:35:29 +0200
Message-Id: <20211101193531.15078-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is re-submission of Marek Szyprowski patches, which were sent
earlier [1], but weren't applied for some reason. Those two patches look
helpful and benign:

  - [PATCH 1/2]: cleanup MCT irqs setting up
  - [PATCH 2/2]: enable MCT on ARM64

I'm mostly interested in [PATCH 2/2], which allows one to test MCT on
Exynos850 (architected timer works fine on Exynos850, but it's nice to
have MCT for wakeup and testing too). But cleanup one seems desirable as
well, so sending both.

[PATCH 2/2] commit message was rewritten to provide new reasoning and
background, as original commit message was related to [1] series.

[1] https://patchwork.kernel.org/project/linux-samsung-soc/cover/20181018095708.1527-1-m.szyprowski@samsung.com/

Marek Szyprowski (2):
  clocksource: exynos_mct: Refactor resources allocation
  arm64: platform: Enable Exynos Multi-Core Timer driver

 arch/arm64/Kconfig.platforms     |  1 +
 drivers/clocksource/exynos_mct.c | 50 +++++++++++++++++++-------------
 2 files changed, 31 insertions(+), 20 deletions(-)

-- 
2.30.2

