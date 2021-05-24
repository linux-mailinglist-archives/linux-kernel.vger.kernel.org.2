Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A8938E435
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 12:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbhEXKjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 06:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbhEXKjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 06:39:16 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A12C061574;
        Mon, 24 May 2021 03:37:48 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id s6so31281549edu.10;
        Mon, 24 May 2021 03:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yM3g27MTcN+1fkL6tqTGZDpmJiATWPK1JGlSl5Sc8kk=;
        b=G+f9++7xXxQcJLSEzdH6NpXF3TNWNQw6drAatX9YSB2jHZobP97kBKK0SfXVPDbwh2
         UzV6kbzxstJKg3AmS6NqQGhRch8Fab+7g/wPTeoNhlVB6IVAM35oeB2asr1zkGvrFMfn
         7MXkYhveIKVjWACHRl75N1YLbTUyFftlkxDcypFBmSmNVQ1SzfJy7UgS+YxVNJZ+6RhH
         r11Zo/nJH0ghm9bWip3K2HmFfTPKPKHBFlOrvHk0kCRpb43DwZQJfhz84zkgP9wKRaJR
         JHxAsbgrc1Fx/Il1sAJxuaNIIyvbkCMsqpw0Mf8MRhIagfnjPzt+LeafJ6WfvYu3LH4Y
         vx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yM3g27MTcN+1fkL6tqTGZDpmJiATWPK1JGlSl5Sc8kk=;
        b=WWP7YqZt07Ywgc6/9B5er2kOtkYgqg5lgOfsOpJ20oYP8PrjgU0yAqOfFuCV0/YXie
         YCs8QRLLXCUTJB6mtpfHOf2b9Qu6MpGFtRgX3tpROiW1o2WAlGnJIJEcI3VCsTzUkQ60
         m1dGbCwIk9485iD6MQR1ZZx8Cgbp0x48U5hkRs2lAgr+XiOpZ0zKwUyjIILjUD5xWt9g
         Wnpyq5sd1n14XULgVPX9ekXSghsK/8jeuiGeCAXmg80hS/IiDE94Q7Ve0s2xc4GzOlFE
         QUsSNvs0xKaR1w/gdyA2+6/xJ/o+7FGfT/rUzcEYUL7rkItrw5JsJPhcOClGFeMGT3pT
         PmnQ==
X-Gm-Message-State: AOAM531vTfXGkVLAdyZ5lbGydj7t7o6hyhB4lpdn/jDKaCHjCrdhAG3/
        Tb20aTzs/kPj+u14d8oZXFA=
X-Google-Smtp-Source: ABdhPJyyzLozFM4BKK5sAQA70oWdkP63q8tTbSOhZxfxvUduzsEJsTs/J8MBcLkMTJgjv/LEa88a3w==
X-Received: by 2002:aa7:d786:: with SMTP id s6mr24643204edq.239.1621852667363;
        Mon, 24 May 2021 03:37:47 -0700 (PDT)
Received: from localhost.localdomain (p200300f1370a3a00f22f74fffe210725.dip0.t-ipconnect.de. [2003:f1:370a:3a00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id r15sm2616418edm.61.2021.05.24.03.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 03:37:47 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        jbrunet@baylibre.com, linux-clk@vger.kernel.org
Cc:     khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/3] clk: meson: rounding for fast clocks on 32-bit SoCs
Date:   Mon, 24 May 2021 12:37:30 +0200
Message-Id: <20210524103733.554878-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the 32-bit Amlogic Meson8/8b/8m2 SoCs we run into a problem with the
fast HDMI PLL and it's OD (post-dividers). This clock tree can run at
up to approx. 3GHz.
This however causes a problem, because these rates require BIT(31) to
be usable. Unfortunately this is not the case with clk_ops.round_rate
on 32-bit systems. BIT(31) is reserved for the sign (+ or -).

clk_ops.determine_rate does not suffer from this limitation. It uses
an int to signal any errors and can then take all availble 32 bits for
the clock rate.

Changes since v1 from [0]:
- reworked the first patch so the the existing
  divider_{ro_}round_rate_parent implementations are using the new
  divider_{ro_}determine_rate implementations to avoid code duplication
  (thanks Jerome for the suggestion)
- added a patch to switch the default clk_divider_{ro_}ops to use
  .determine_rate instead of .round_rate as suggested by Jerome
  (thanks)
- dropped a patch for the Meson PLL ops as these are independent from
  the divider patches and Jerome has applied that one directly (thanks)
- added Jerome's Reviewed-by to the meson clk-regmap patch (thanks!)
- dropped the RFC prefix



[0] https://patchwork.kernel.org/project/linux-clk/cover/20210517203724.1006254-1-martin.blumenstingl@googlemail.com/


Martin Blumenstingl (3):
  clk: divider: Add re-usable determine_rate implementations
  clk: divider: Switch from .round_rate to .determine_rate by default
  clk: meson: regmap: switch to determine_rate for the dividers

 drivers/clk/clk-divider.c      | 93 +++++++++++++++++++++++++---------
 drivers/clk/meson/clk-regmap.c | 19 ++++---
 include/linux/clk-provider.h   |  6 +++
 3 files changed, 85 insertions(+), 33 deletions(-)

-- 
2.31.1

