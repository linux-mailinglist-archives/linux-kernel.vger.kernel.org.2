Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425A0386B83
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 22:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbhEQUiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 16:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbhEQUix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 16:38:53 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048CAC061573;
        Mon, 17 May 2021 13:37:34 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so272953wmk.1;
        Mon, 17 May 2021 13:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+YZN/nHJaoReN5vhe533pLv6vKy4vqgUNAkyLEs9sLo=;
        b=jjenZUqlCFz/sLLao6aG/itHV1VYOXxPhhc7xgDn6CX7UYKhbwzM730BGr+DKogXVi
         nVUR5DrJG2P8I7jnUEz4sfy5Xj/RKiKhjzgCVWVsgRR3BgYZGtlkLcU9KM7oqsghabYn
         2uNGzBUUXHVkw14oyw6EwBZFG42oy7VgqkZ6BJMSmrfY974jFcoTMah8TDycfhiispfc
         cbGDPiT5PoE5toQprnMBu8NBI3Hy6XvBque87467+VIzZ45zmLqRXIk3byBZed9zhMJf
         yNsD7MdX2ocZYEvPoh/xGtE5B5NHtkp3OXu8a7yIqBL4CImTgaWpbxkHTsOZJJJ4Qs3q
         Ke9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+YZN/nHJaoReN5vhe533pLv6vKy4vqgUNAkyLEs9sLo=;
        b=piXh7VV9TruwwJGGNkqefFGhJZ/sHejdWrNnXrjRBEzMO70+MP/dpJ/qfhGKR6e/TD
         /rhfvGWKv53Lja/e9iNJYqDnf8/uAciHLNyfqtoefOFB5sGLXxZ0PmkIKxeN5Kd21JzU
         xaR6NG9j3uJQxiF5V3KtuYh1z71Y4tkHOecxXPEzW5THU6CaArLHS7SEtGjjJmWdZlD5
         NggPBUfgUVHZySHQAN8BzCuePzZqpoYPEuR09CX2ODK4ULUzJH5ZA8p3v41ECXzPgEgl
         QmPWRdzNaQhqNjl2Ft0BN7vtmnlC+Zx/GQoeNpWDm9fcWTtSCLxTpFFiUkjEPaBOdMz0
         RhTQ==
X-Gm-Message-State: AOAM5307aKgCnx9jlcV8hoc947CM0oNoYDgWXjSnEAybWbdMPBHrLqIJ
        rFvmwvxitpFWD9f3ihP1DY0=
X-Google-Smtp-Source: ABdhPJy6FKIWz8G7P++u7Qjzv7lGUSLH6Lp6ETi9oO7cHcCRGve9UsOhcCp/PIlvDnjG3uwp9T9BiA==
X-Received: by 2002:a05:600c:354b:: with SMTP id i11mr1360944wmq.102.1621283853624;
        Mon, 17 May 2021 13:37:33 -0700 (PDT)
Received: from localhost.localdomain (p200300f1371adf00428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:371a:df00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id p6sm3840448wma.4.2021.05.17.13.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 13:37:33 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        jbrunet@baylibre.com, linux-clk@vger.kernel.org
Cc:     khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1 0/3] clk: meson: rounding for fast clocks on 32-bit SoCs
Date:   Mon, 17 May 2021 22:37:21 +0200
Message-Id: <20210517203724.1006254-1-martin.blumenstingl@googlemail.com>
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

I am sending this as RFC to start a discussion whether:
- this is a good way to solve it?
- what are the alternatives?
- getting some feedback on areas that need to be improved


As always: any feedback is welcome!


Thank you!
Martin


Martin Blumenstingl (3):
  clk: divider: Add re-usable determine_rate implementations
  clk: meson: regmap: switch to determine_rate for the dividers
  clk: meson: pll: switch to determine_rate for the PLL ops

 drivers/clk/clk-divider.c      | 39 +++++++++++++++++++++++++++++++++-
 drivers/clk/meson/clk-pll.c    | 26 +++++++++++++----------
 drivers/clk/meson/clk-regmap.c | 19 ++++++++---------
 include/linux/clk-provider.h   |  6 ++++++
 4 files changed, 68 insertions(+), 22 deletions(-)

-- 
2.31.1

