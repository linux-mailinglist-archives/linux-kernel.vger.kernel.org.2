Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83398330B97
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhCHKph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbhCHKpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:45:18 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791B8C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 02:45:18 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id a24so4654049plm.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 02:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/pTyVDjFKopMOn0gnz6T1wmQQU1rKBs2MJpuJdbdZfM=;
        b=kf3VuOaLkdhglu2lUqKc/d6Gi6P0vyrrE5mBCnW5RAitA2v8amHMv79uhQDzV3aU5K
         T+I1EjnIY7iU488Wjhctl0EVuBAYEUJeYQXQE7q7D8FjvTnnLyJijip4fh3EIvHU3Q4/
         2oXJCOboDdDqtvZgHC0UDzI/GTJv0l9wjMrFI76lwD9wMtRA+zJJPVWTMYI5Jssu4OuH
         tBC8AqmbF5X99AHRw74R6hDOHYKjZkLsq1swGnDkUhOlXoOShHC8CzHu3t9TPhWZglTg
         dgh70MPI65Nt6Fuq1rw0bYd/QkTzy+nt8wBuxuPENwzknJgZh1/8exECqV1PGmC1N5zm
         SrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/pTyVDjFKopMOn0gnz6T1wmQQU1rKBs2MJpuJdbdZfM=;
        b=j92WkGAgU9rs1qDcCEdF062GNOx6FgWu52YgSNA6bd+PaXO5ZFX5twrNTxbQiH31u7
         h8Eh/Ej857W5iCTff36tI3wPhLWGI48RoKHSSaqPRgcJF7fwS4sKzAxMDjaGVM2lp0U0
         llewYvXmLNcGwW/RTZ/Kkvoi2e0owl2xVioWuezEBW/RMgwRikzED3v1g8/DxUl6qEsv
         1i+OhhqZHhhg9wSp+xOjl1E3Ez2YTBGV0Kg4tLIHu/NDkenfhaawIZ2tZU/PFtVFx0W3
         Oqzhjldhc6lJbP3rOH1BA70aobHFt0kmOVo3bY9KFARttU1lSxJN0F/2JNcP2MOVgIJA
         iqiw==
X-Gm-Message-State: AOAM531fZyehJ2DghACKLThoELIrqUaoGceldL6ZEj/CmvvUaZ9TrCMt
        c+UTyJPfAsUFyvR06+YeDo2goQ==
X-Google-Smtp-Source: ABdhPJz/yarSkPHujAzGLux3X7UyzxPhdN0NzvnvRgjysu/7yoM4sDhcPaMytblnNe0y7I3PfnnVbA==
X-Received: by 2002:a17:902:ed0a:b029:e4:3589:e4f9 with SMTP id b10-20020a170902ed0ab02900e43589e4f9mr20700124pld.36.1615200317978;
        Mon, 08 Mar 2021 02:45:17 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id e63sm1528619pfe.208.2021.03.08.02.45.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Mar 2021 02:45:16 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Michal Simek <michal.simek@xilinx.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        anmar.oueja@linaro.org, Bill Mills <bill.mills@linaro.org>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V10 0/5] dt: Add fdtoverlay rule and statically build unittest
Date:   Mon,  8 Mar 2021 16:15:05 +0530
Message-Id: <cover.1615199908.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset adds a generic rule for applying overlays using fdtoverlay
tool and then updates unittests to get built statically using the same.

V9->V10:
- Add a new patch to allow .dtso files.
- Update 2/5 to be more efficient and also generate symbols for base
  files automatically.
- No need to add lines like DTC_FLAGS_foo_base += -@ in patch 5/5.
- Add Ack by Masahiro for 1/5.

V8->V9:
- Added some comment in patch 3/4 based on Frank's suggestions.

V7->V8:
- Patch 1 is new.
- Platforms need to use dtb-y += foo.dtb instead of overlay-y +=
  foo.dtb.
- Use multi_depend instead of .SECONDEXPANSION.
- Use dtb-y for unittest instead of overlay-y.
- Rename the commented dtb filess in unittest Makefile as .dtbo.
- Improved Makefile code (I am learning a lot every day :)

V6->V7:
- Dropped the first 4 patches, already merged.
- Patch 1/3 is new, suggested by Rob and slightly modified by me.
- Adapt Patch 3/3 to the new rule and name the overlay dtbs as .dtbo.

--
Viresh

Rob Herring (1):
  kbuild: Add generic rule to apply fdtoverlay

Viresh Kumar (4):
  kbuild: Simplify builds with CONFIG_OF_ALL_DTBS
  kbuild: Allow .dtso format for overlay source files
  of: unittest: Create overlay_common.dtsi and testcases_common.dtsi
  of: unittest: Statically apply overlays using fdtoverlay

 drivers/of/unittest-data/Makefile             | 48 ++++++++++
 drivers/of/unittest-data/overlay_base.dts     | 90 +-----------------
 drivers/of/unittest-data/overlay_common.dtsi  | 91 +++++++++++++++++++
 drivers/of/unittest-data/static_base_1.dts    |  4 +
 drivers/of/unittest-data/static_base_2.dts    |  4 +
 drivers/of/unittest-data/testcases.dts        | 23 ++---
 .../of/unittest-data/testcases_common.dtsi    | 19 ++++
 .../of/unittest-data/tests-interrupts.dtsi    | 11 +--
 scripts/Makefile.lib                          | 40 ++++++--
 9 files changed, 218 insertions(+), 112 deletions(-)
 create mode 100644 drivers/of/unittest-data/overlay_common.dtsi
 create mode 100644 drivers/of/unittest-data/static_base_1.dts
 create mode 100644 drivers/of/unittest-data/static_base_2.dts
 create mode 100644 drivers/of/unittest-data/testcases_common.dtsi


base-commit: a38fd8748464831584a19438cbb3082b5a2dab15
-- 
2.25.0.rc1.19.g042ed3e048af

