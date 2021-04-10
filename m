Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B373035ACD3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 13:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbhDJLOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 07:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbhDJLOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 07:14:18 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6304C061762
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 04:14:03 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so6323359wmq.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 04:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wVfLNGwq4Y38Oo6/3eTyuo9TqavVMKjShNNhMd2XCcM=;
        b=mVZHBg2124wRfyiC4uft4HMy/RKEVvF0bqoTYK0qL/LTVrHUs7xyJoaN570NvvNCh1
         mOnj8eim20WQ3YBLpNb08m0SrUAcV0SFaa4eJNNPa3tTh+KnFPPrVa1XBZvnDA6uhR4H
         OrejnliC0WDLA4vMKzMx3OglPMumXbkLBuQ/gP74qsncYAYK8oSxwvcLDRSdFhWN9Se7
         myPl9InbdxGNYf0GYLEUukrmW940Ziu2yGEb2DDHbkju6knJNZmap2Vsi95VU7OZM1EI
         5sFR6j/xM3Fy+kQZVKZ57Ib2Rg5BtQ9jyqUcoFHTR8UNWwokClvajsd4wah2aYZz5vRE
         LJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wVfLNGwq4Y38Oo6/3eTyuo9TqavVMKjShNNhMd2XCcM=;
        b=q3gNIj1FsQiqL8Ra1Oolu++7vD8GkP+VuWOmglIAVoMB5sPI7imuF2nJ6MNsAgB/41
         ZzAotZR8e1uQQo0qDeQfHsqL6r5cEQCZ49ru3gDQxAlH3dw4AjFYQ1HcyM+riatGbyu1
         tlWmgWsVWpzHcdgOwwJAe3pKYieTOsQ6zT8WhkDyg0PdzOvYOBbfKKhIP5/GmoOLlWqn
         svknLJrZIVIqGQPjS9f2CmJLuuxF4pP+lrehLZrjtFQGJGzO1TaFetRwEieOuGQ9Rdw7
         wB3ZAAHWGZ5tW5CYl2bXb4oPspKNjZybC4WNLydm5xPPGojpaX+xXFjiMpJHpROeEBOI
         D39A==
X-Gm-Message-State: AOAM533XrCGi+m8xo1aMgs3yliebZB8KroMKUlDsaQNFPbl8r4M8owxO
        P/T5Z1zKDqeT8UqtMkbdydSpKA==
X-Google-Smtp-Source: ABdhPJzNqvuGbJt/3Dgix3d7sN0jEOCKmD6hp0FcnKi+oBdbyeLb0E/Ks2dP3/zZnFfs7dMH1Dtb9w==
X-Received: by 2002:a1c:6a03:: with SMTP id f3mr17735443wmc.179.1618053242564;
        Sat, 10 Apr 2021 04:14:02 -0700 (PDT)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id s8sm8370117wrn.97.2021.04.10.04.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 04:14:02 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 0/5] ASoC: clock provider clean-up
Date:   Sat, 10 Apr 2021 13:13:51 +0200
Message-Id: <20210410111356.467340-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this patchset it remove the use the clk member of
'struct clk_hw' in ASoC. 'struct clk' is a per-user reference to an actual
clock. In the future, the clk member in 'struct clk_hw' may go away.

The usage of this member by a clock provider usually falls into either of
following categories:
* Mis-usage of the clock consumer API by a clock provider.
* Clock provider also being a user of its own clocks. In this case the
  provider should request a 'struct clk' through the appropriate API
  instead of poking in 'struct clk_hw' internals.

Jerome Brunet (5):
  ASoC: stm32: properly get clk from the provider
  ASoC: wcd934x: use the clock provider API
  ASoC: rt5682: clock driver must use the clock provider API
  ASoC: lpass: use the clock provider API
  ASoC: da7219: properly get clk from the provider

 sound/soc/codecs/da7219.c          | 5 ++++-
 sound/soc/codecs/lpass-va-macro.c  | 2 +-
 sound/soc/codecs/lpass-wsa-macro.c | 9 +++------
 sound/soc/codecs/rt5682.c          | 6 +++---
 sound/soc/codecs/wcd934x.c         | 6 ++++--
 sound/soc/stm/stm32_sai_sub.c      | 5 ++++-
 6 files changed, 19 insertions(+), 14 deletions(-)

-- 
2.30.2

