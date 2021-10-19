Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5552C4336C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbhJSNTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhJSNTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:19:45 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F0CC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:17:32 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w19so12775722edd.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CLwoj+6JAPRwJLN1t16G8nJ5cVwOPwSD+DoR9oMRdGo=;
        b=Ce0pB2XnJ+pcLL2gsKKvP2WllA50+0p0z3nSPDgL9rRvVDr8GuCEUScOxoISc0JDtD
         JUH39WNcf1/ctHX4+13bPoaRYo/g4I9asCanwyGT6LQ9b/qSX2VupzM0frUUGpsF2id+
         QjU0BPt1HYGVOlWpRkUn88bxkitUEmJcgOH2r3Ih41zGKXsNRf1R7FVn3qAJ0m9Zy14n
         HM7RF1ItY3IA6dLByqKKm9B0sHIxxaIoLCW6lxpIKPbSsV/a1LWO2Jak0F0zYksHBKC8
         uRpQDUabBmOpgeybcjgNQgCmd+Vg+JxsxshiulhhxU8NDb38LC685Do9unfetNZCr3nn
         6JFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CLwoj+6JAPRwJLN1t16G8nJ5cVwOPwSD+DoR9oMRdGo=;
        b=12dI5vmYHQi8yWW8bTVFNsZ11gEoNC/3HRABSm7jF0lKa0IwbxI9fZZgPd4VFk76Q4
         YjJZ/uwQ9Djfm2igMg9PvmW1qyJnAgTlGWfRE/X64okGiTr1SV/Lx25WlStFQINMZ72G
         2ql/Beg3WAnqExXqq+z3r+OusWI+oWgr7iY0ovUTzOYXQqei9K/5c7EIa6P7886aVs3B
         rfe1TdGpdUvO86OhQftqS6FCmoKEuo+of+HiyoTgaH2OGYLpYnTECYxbcJWzbzhBaM7U
         6rUs9olSRyLzLbSASrERIhtb+xANWkcnN9o5FauB+BDGvYcaZGixIUf/aq91kPCSqKbS
         l7/g==
X-Gm-Message-State: AOAM533oT0suAVpR/u+ewve+9RO/sfexuLBppc5WkXy/R1h3DER1IwAc
        9aRQgZ09+7eGX0L8bn17Sj3C8A==
X-Google-Smtp-Source: ABdhPJz6hO1n6bf4YP3H5z8nwduKJpChBhWhubdocyUag2dkgE+qTnSevm5Ng34/Uat60/YIGTgWQg==
X-Received: by 2002:a05:6402:cb2:: with SMTP id cn18mr51008114edb.249.1634649446707;
        Tue, 19 Oct 2021 06:17:26 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id d22sm10490086ejj.47.2021.10.19.06.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 06:17:26 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-rtc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] rtc: s3c: S3C driver improvements
Date:   Tue, 19 Oct 2021 16:17:20 +0300
Message-Id: <20211019131724.3109-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on Exynos850 support (where this driver works fine in its
current state), I've stumbled upon some minor issue. This is the effort
to fix those. [PATCH 1/4] was already sent as a separate submission, but
Alexandre Belloni asked me to set time range while at it. This is done
in this series, in [PATCH 2/4]. So first two patches are basically
moving S3C RTC driver to newer API usage. And last two patches fixing
some error message which I noticed when doing the very first boot of my
board (when RTC registers are not initialized with S3C driver yet).
Patches 1/4 and 3/4 don't introduce any functional changes, only doing
some refactoring and cleaning up.

Sam Protsenko (4):
  rtc: s3c: Remove usage of devm_rtc_device_register()
  rtc: s3c: Add time range
  rtc: s3c: Extract read/write IO into separate functions
  rtc: s3c: Fix RTC read on first boot

 drivers/rtc/rtc-s3c.c | 137 +++++++++++++++++++++++++++++-------------
 1 file changed, 96 insertions(+), 41 deletions(-)

-- 
2.30.2

