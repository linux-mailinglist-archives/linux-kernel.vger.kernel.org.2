Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3AA3CCBAF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 02:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbhGSAUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 20:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbhGSAUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 20:20:35 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAF9C061762;
        Sun, 18 Jul 2021 17:17:37 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 37so17361158pgq.0;
        Sun, 18 Jul 2021 17:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xKHTc9yNHDPtjYjnEVTpSB6WymMSFLcHaJXp0d+G5KU=;
        b=CyclXjJXwPzCrFFtbc1DGmLC10POQbDDlwBpwKsixBTkQoAXHydB4Lw+LL1IcY2RrC
         xLYhQ0td895wTInaV0x9Q3BVitpNfK2z9vM8eEvT7Q2APYni0DYwAcDpvZhGLe2281W5
         Liq5SNEj8JYJTlU/KY4eyrcq7fhWuJTsjwdITBsempO3McTvzx82+RJ0AGNBdSu4Vmb8
         GXDFhV477R8uiMLMFOOzra7jxKtr8wm35FBsm299/Fi2od7YQ091DQJ9G+3b7YbJGFET
         S0Dtsnf3v+JAFPv2eKID5DMfUB3mburKKAWr3fOUusylIGrb1XvUK1YoQgwhMmy6Utww
         cNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xKHTc9yNHDPtjYjnEVTpSB6WymMSFLcHaJXp0d+G5KU=;
        b=YCCqyQAE365QjBfQNMhY4KKsgO5UDt4LbLtKnK78+X+sdWkDxarGB828vKQEOLaSR0
         YLF08xOoz9A05vOKppz8AEftXZSiPpnl5ALDcwlPvEz6bRpUWwPFYzDsKpfYXE1qTmBz
         Y4cDBvgrd/axLTPCCm6rp0Y2sCdtq02SJkeOzh9cUqppmmuS6kukfFtTMgiLv1417S1k
         LlYjzGKNLczMM4N4iAU+HDcxW4jlj2YJVel4z5gN5YfT5VYNl/d9JVkwWbrJKA/1VZ3t
         mDdMAQerbOM0TTp2COQ+EBM0CbFfqalheXrc5T5Gt4EHPFgU9EZHneH1yh5G758rATmh
         wJMA==
X-Gm-Message-State: AOAM533oNo4j5JwvfF+DuHZRELjJnh+zRKGDVeB4zQeA90M2o29yHN3P
        46BKUuOIE7F1djAzqvaO7AY=
X-Google-Smtp-Source: ABdhPJxQfE0nSyd9L3tgN+7nCE4/1nAhzcu/nYonExJ4G9xGVWcU8m5Amt9zOIdLlOtncSsh5nexVw==
X-Received: by 2002:a63:190b:: with SMTP id z11mr22290718pgl.320.1626653856452;
        Sun, 18 Jul 2021 17:17:36 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id x7sm1059847pfn.70.2021.07.18.17.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 17:17:35 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 0/4] ARM: dts: aspeed: Enable ADC for wedge100 BMC
Date:   Sun, 18 Jul 2021 17:17:20 -0700
Message-Id: <20210719001724.6410-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

The patch series enables ADC for Facebook Wedge100 BMC platform.

Patch #1 enables ADC in Facebook AST2400 common dtsi because ADC is used
on all the Facebook AST2400 Network BMC platforms.

Patch #2 removes the redundant ADC entry from Wedge40 dts.

Patch #3 removes the redundant ADC entry from Galaxy100 dts.

Patch #4 enables the ADC voltage sensoring channels in Wedge100 dts.

Tao Ren (4):
  ARM: dts: aspeed: Enable ADC in Facebook AST2400 common dtsi
  ARM: dts: aspeed: wedge40: Remove redundant ADC device
  ARM: dts: aspeed: galaxy100: Remove redundant ADC device
  ARM: dts: aspeed: wedge100: Enable ADC channels

 arch/arm/boot/dts/aspeed-bmc-facebook-galaxy100.dts   | 4 ----
 arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts    | 5 +++++
 arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts     | 4 ----
 arch/arm/boot/dts/ast2400-facebook-netbmc-common.dtsi | 4 ++++
 4 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.17.1

