Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D19366A69
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 14:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239559AbhDUMGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 08:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239538AbhDUMGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 08:06:12 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739C0C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 05:05:38 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l4so63097992ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 05:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MRPJS1ijITk2FOQ9jFOtPrHo+61HYV+8yTL1dDNYHhg=;
        b=TxH7oAz9J7xB9yjMFVUrNyASbL0yCLVBFWU+m3D5imK63lIlt6ybraK7fS7gQfeC2h
         mNJBEL8Q3lTukmpnbCfm6CA5jUVr+hXjvjcDJAzGoY6lmwxpXIQLWzPpPkuBEne3ijpL
         /iDO8YrxA3JL4OqM+959s1NY+tJVo8FR8Pb9XdqTNV/H+7Tg39Utlwu7bgU1C1y7XcpR
         +P1rXy9ruqD/X01ib84GAlIfbNHIAix/00CnoHSDsZpPTbI8cdY0rA/+w2OAAPfjmJ5E
         2rtojgTPMnRdzsOcNB070nPsOCbZpWIe9g3yDhLyerM16NBgnPqfmwACnM4lnfFB+Mbz
         n6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MRPJS1ijITk2FOQ9jFOtPrHo+61HYV+8yTL1dDNYHhg=;
        b=uBzr/thpGwTwHa3A22qi58uwGBNdmuU/rdr61GCsWd9+RO2f0KL3yU737hEVAs/ff+
         9oVeaIV9ivhUlw/gNRb63Dl3WwDx/+FuYFmnTPN76qY6NK7As/dkJceOzhc9wW21Y1g4
         Yn3yugbFmnk5GozMoe4iIFgwwPEM9RVKxQftFgUjcjn5wF8StQ78sCNlt7BwUhV7KNBh
         5vqOTGvHWOQoytx9KDPtEV0tIpsv8DXg8/AJON03FzHqam4D/Sv4YdV57CqqfrOj0oui
         ppjoHnRCk02e+hmcOAUBiC15YUnSaNmSRdsgpKk62i6g+7f9PEdsBnGa7Z6nQijIxSw9
         1O3g==
X-Gm-Message-State: AOAM533ozvIqZgw6u4PD1GF/TUh2udB8mJTW69wPwGpYXof0r09VxRZZ
        XrnwM+EG5ZTM9Rf4NkQq6fgBYQ==
X-Google-Smtp-Source: ABdhPJx6FaYPXOraxyEEDHilMPM6iOAQV4mxrX/r/fiUVlv7V6Q8gic6ywfauVgc5c1nhG1hfBFUvQ==
X-Received: by 2002:a17:907:294f:: with SMTP id et15mr32179306ejc.14.1619006737133;
        Wed, 21 Apr 2021 05:05:37 -0700 (PDT)
Received: from localhost.localdomain (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id n2sm3151431edi.32.2021.04.21.05.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 05:05:36 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v2 0/5] ASoC: clock provider clean-up
Date:   Wed, 21 Apr 2021 14:05:07 +0200
Message-Id: <20210421120512.413057-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.31.1
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

v1 [0] -> v2:
 * finalize lpass provider move to devm

[0]: https://lore.kernel.org/r/20210410111356.467340-1-jbrunet@baylibre.com

Jerome Brunet (5):
  ASoC: stm32: properly get clk from the provider
  ASoC: wcd934x: use the clock provider API
  ASoC: rt5682: clock driver must use the clock provider API
  ASoC: lpass: use the clock provider API
  ASoC: da7219: properly get clk from the provider

 sound/soc/codecs/da7219.c          |  5 ++++-
 sound/soc/codecs/lpass-va-macro.c  |  7 ++-----
 sound/soc/codecs/lpass-wsa-macro.c | 11 +++--------
 sound/soc/codecs/rt5682.c          |  6 +++---
 sound/soc/codecs/wcd934x.c         |  6 ++++--
 sound/soc/stm/stm32_sai_sub.c      |  5 ++++-
 6 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.31.1

