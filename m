Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321AF396FBA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbhFAJDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 05:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhFAJD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:03:29 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1128CC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 02:01:48 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id l2so5950148wrw.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 02:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H9dfP/HQ1yF3ZJ5TmUZw5lMApDC92t3a+q6kUys8fVY=;
        b=idd+HJfKG+Zdo73JZhpgtRchcqEUFfQmMYU0z4oybPZ8/oViz64390Z8g5s+agS81w
         dxIrJWwTv9FF89gTnkI8H4FlbjP2od26UXcSNdYiz7WGpeXYhIss4zbwCsNnP9qINbwT
         AH/V3CdaLJE3BaCPIGYvkHa0fgNoufSw+hoh4KTgEKmdPIy4UII1ixRvXd5qBP/ZopUg
         5Pmb4ZMqgtSNS5DwLOAyutsSsCQchuLz2vMimHDwbBv5lrRg8k2moMrxzySrFByfcrno
         e+ocZ2IlOM20NQIR5u2Sm1pu3HGN1H9tZcYmjn38xx9x+E37fra3nrA6pHCYWzpiHjOK
         mRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H9dfP/HQ1yF3ZJ5TmUZw5lMApDC92t3a+q6kUys8fVY=;
        b=JcMwBQ2HQ8uP4fgrIUjr+8LXFhkctdsul7LARIjCgM4mpTfV8fsJc17RGlBiG6Vb30
         rhIhB0JPaesCV9Y9DTuHIsUehNi4umIe5dmPddsmDFty4HmG1tkuupzzbxqsXzFrF7NB
         u2Jdm12A0CEDgsDR1AQNtLdksa1p/K/TxojvTyHmj8CYtwY4wFGtLl4amfVvd3VXwt7o
         m4rl58gyG1YHeIRmZaDsLhtE2h03m/9rt5epX1T25WQeF/3Mxl3oPTFRJbMcCHNjIQd7
         faQN5R8Dr62hHNXoSKzil7rmaEhAUBU+844nMffKcswC3kmC1VxmcyD5BXecKcyA05/7
         blcQ==
X-Gm-Message-State: AOAM533LX4QY2j2HLMug127tq7zIip1hYipBknmMw95Zzn8tQwbEyxMZ
        UfPd6YGprqPKPIpfbQD/tImhLA==
X-Google-Smtp-Source: ABdhPJyWNee91rlrkyHrxtfHXXaevKWNzRZgcWNhOc33JucXy/8qbsNzfmrRfeJYp19DawtZCKY68A==
X-Received: by 2002:a05:6000:110b:: with SMTP id z11mr25954364wrw.278.1622538106584;
        Tue, 01 Jun 2021 02:01:46 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:a3a:d001:6a80:207a])
        by smtp.gmail.com with ESMTPSA id e17sm2668199wre.79.2021.06.01.02.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 02:01:46 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tobetter@gmail.com, Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/6] arm64: dts: meson-sm1-odroid: various fixes for C4/HC4
Date:   Tue,  1 Jun 2021 11:01:34 +0200
Message-Id: <20210601090140.261768-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=868; h=from:subject; bh=8nRsuZr86WQw9AoOI6YGZLPKyM3EFdInWfYap1old7E=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBgtfc4xme7MUjlZMeepvitfBk1HtzgR5Ve22CmQFZS HX6gqHSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYLX3OAAKCRB33NvayMhJ0RgnD/ 9jz6aefNbz7RrYSBAtjO8VmDQtqWVPTsv04LmUfz0RKR+qApk7q1qOmZyDIVR8jIP4wMv3+/gfL/IY lb+Q477lR7V1nrQLV+1TUEGefQHvwD4o5j3jnoYiY/Gv3b4B8fiip9Lwnn7wyOyOldivuPQAWd4AV3 Ys/fRL1ULy7+ueo8YkiSgMe75NgRr0qsaE+Q4hvcuVyxwk+jfa1xtVJrAZCGgEyHYmZsMx1ICeCcwz cdH2C5TOGv16vMmD2iDhFODagexGtEmo4Hpb0sPasgk9vBZmbOKGqUbsZef9mgTHxAu3QDkyq/fkg8 BUhWt3n+2Wk68beJEWRFapq/tqfMzDbzcSmlHEbtOPG++E+OWVAMQy8Uv1Ucjop+VwTHaZR2BJqMXr 0Uh3/+t8Ql+1YBnbYaXh5BffNWUz1lFiO8YbpF775EplXCse6xWvnNPQX2Ovaff9skhu0YCf2BXkhN 1lEhzA8y1FadbssTF3v3wtd68oeTxRCytgl7I1VB/+HFC46Pw/FEvvWowMVXX21hMq5Fw4R4nRCohM Mg/NlFvtf5FEFxeNU6XxR/G/GAIP0A3T4oyLwA3eEJIn2hgRUnVkuphjg4jT9/+6S09wTBdMhG09Ol I8nICBPmVtpG4uAx5zevSVJyzOFgD8UACwcxH419FeSWhQcQJolslyISxUAQ==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a collection of fixes/small additions to Odroid-C4 & Odroid-HC4 concerning
regulators handling, USB and SPI NOR Flash of HC4.

Christian Hewitt (1):
  arm64: dts: meson-sm1-odroid-hc4: add spifc node to ODROID-HC4

Neil Armstrong (5):
  arm64: dts: meson-sm1-odroid: add missing enable gpio and supply for
    tf_io regulator
  arm64: dts: meson-sm1-odroid: set tf_io regulator gpio as open source
  arm64: dts: meson-sm1-odroid-c4: fix hub_5v regulator gpio
  arm64: dts: meson-sm1-odroid-hc4: disable unused USB PHY0
  arm64: dts: meson-sm1-odroid-hc4: add regulators controlled by GPIOH_8

 .../boot/dts/amlogic/meson-sm1-odroid-c4.dts  |  2 +-
 .../boot/dts/amlogic/meson-sm1-odroid-hc4.dts | 53 ++++++++++++++++++-
 .../boot/dts/amlogic/meson-sm1-odroid.dtsi    |  7 ++-
 3 files changed, 58 insertions(+), 4 deletions(-)

-- 
2.25.1

