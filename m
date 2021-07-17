Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3856C3CC6CE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 01:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhGQXdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 19:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhGQXdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 19:33:35 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947DBC061762
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 16:30:37 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a13so16476783wrf.10
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 16:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xkxt3iyAxj9INcBajX2r0UFT3eJBxPbJGH4oT44k7Og=;
        b=SAfsJgdoPyUlpznyaSaNDTFpbFaFj1VabR+V2sdUgYQ5C1H8XBtVe04b7Gd9Pfg0EA
         +gStx9xSXOcy5PSjpYCedpJ1VFpMGgBh68Vm6od5GKHgcuESVYNn5Zn77CMGZ4CiEviq
         88IC9Utlk1kMKhh3FtgbkB1h745NEg22Ia3dnFqVnj0j7FUJgWQQ4Ueht5zshIj5f+jH
         w22Yu4PRuvKeUBFC/58JM8Zsz7zF7SfeQfQQffp1bzscJxixJrYVBpATbrR5OcW7j/4e
         o0zpuF/1KpLlxcubbKjTYMNv1xLQn0taZGS4jgGlbcYWzh17FhtqQLC9giJrFU6X3g/X
         q7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xkxt3iyAxj9INcBajX2r0UFT3eJBxPbJGH4oT44k7Og=;
        b=PzeXyorsc/Cog0JNvj64tzxNH80MV6UilioSNDuEHlHA/nbB3QYWUsFD6YvMZzh0k7
         aiFXT8HRkbCG1J1pwbAGAqJQXUVOpoPfBmEE1fN5/dvjyp/VTv5PNXGpYjJJ+YgRF3EG
         Kndu/GpVNz5GK+4/9pS+tlCHyaCttC8bls4/PTDqXJ2869YMS0paL3rudHjvleq1aPFB
         ymBqnhIX3U19g2JzXfOpC8EbwgWfToZRa9TJoTsEqEqYFqgHa2lp/B9c9oOCqwGI1aZO
         dy76p2OwrMYMZd/ePoyd2iwkotcLUk79TF2dUgS1i00XEWOi/Gc6Hg/6/mO3ZT5j7Oip
         gFbA==
X-Gm-Message-State: AOAM532rA2u4y77AZ8SOzWQrOFBqxi/11oTu89nbycIGKb3luiFClgtH
        kZ1QplT6EVGm5IMU4BkVZvI=
X-Google-Smtp-Source: ABdhPJx2vG1xT5/8TvIJ+TR25Q4Vj07jSRMGfdJ+EoASteOiqg/fOSx5EnSSjjdB9bEVeKwIxcL4oA==
X-Received: by 2002:a5d:6389:: with SMTP id p9mr21798564wru.1.1626564636046;
        Sat, 17 Jul 2021 16:30:36 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-7602-4e00-f22f-74ff-fe21-0725.c22.pool.telefonica.de. [2a01:c22:7602:4e00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id q19sm14824051wmq.38.2021.07.17.16.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 16:30:35 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/2] Meson8/Meson8b: sound card support
Date:   Sun, 18 Jul 2021 01:30:28 +0200
Message-Id: <20210717233030.331273-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the AIU audio controller for Meson8 and Meson8b. The
AIU audio controller has been found to work fine with out-of-tree
patches for HDMI audio (over I2S). SPDIF output also works (tested with
a scope).
Endless Mini (EC-100) has an RT5640 audio codec. The driver for this
codec can be selected since commit 08c56cab302a05 ("ASoC: rt5640: Make
codec selectable"), which is part of Linux 5.14-rc1. While support is
not perfect (due to us lacking proper support for configuring
GPIO_BSD_EN) audio output still works fine.

This series is based on my bugfix patch "ARM: dts: meson8: Use a
higher default GPU clock frequency" from [0]

Changes since v1 at [1]:
- added sound-name-prefix = "AIU"; to the first patch to make it
  identical to what we have in meson-gx.dtsi
- drop audio-routing property from the sound card in the second patch
  as it doesn't appear to be needed


[0] https://patchwork.kernel.org/project/linux-amlogic/patch/20210711214023.2163565-1-martin.blumenstingl@googlemail.com/
[1] https://patchwork.kernel.org/project/linux-amlogic/cover/20210713231103.2994354-1-martin.blumenstingl@googlemail.com/


Martin Blumenstingl (2):
  ARM: dts: meson: Add the AIU audio controller
  ARM: dts: meson8b: ec100: wire up the RT5640 audio codec

 arch/arm/boot/dts/meson.dtsi        | 12 ++++++
 arch/arm/boot/dts/meson8.dtsi       | 63 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/meson8b-ec100.dts | 44 ++++++++++++++++++++
 arch/arm/boot/dts/meson8b.dtsi      | 63 +++++++++++++++++++++++++++++
 4 files changed, 182 insertions(+)

-- 
2.32.0

