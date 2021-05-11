Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329BC37A125
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhEKHto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhEKHtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:49:43 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34EBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 00:48:36 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n2so19149603wrm.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 00:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0aKhMFos6FwrsrnKu5YWX9McpIt7w3RKLcj0tedb3Yw=;
        b=ppcjXHmVF7ECDjdGn2+rwNT/xNSDY7W2WlUffWO3D1QhXtCgJfi8p6WCcmyp6wX+fZ
         x1eWBDHrPvKsmZHDZ3k2FYxwxS47MFsxecKlETjqEIYa9Xc6lcmvOC+hhrxxBP5rs9kk
         1/SXJmR8QSg61HmKzBkuy63yEV3qyTTi0O3Ky5qnUrMCIvA0ITOJ4BeMF8OxTNaf4R07
         Oe9kanSZhXh7akRYewxj+tg3ryw2p5AHx9A01WJKJP4wNB6QyyV2LwaXvIHrKYjUo499
         QBqQBjkytG+nx9Oqyx/EnkM5GtQJAx1hcwnoFUwZkRWFSsHugY5ojoG83/anneDJDHUE
         zL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0aKhMFos6FwrsrnKu5YWX9McpIt7w3RKLcj0tedb3Yw=;
        b=oo4n1dFM4+Xkrawfg+r1+d2OZUai65NklmntGK/NVkVqy2ehnWsk+juNT3U2ij52yq
         /1Cg51sYGUilcOkLC9BskfsF+sY8Xc6wqHOIGdXHNVv/h+LV95SeCXkFkGtgG8qkY1x9
         F9ROMfvwUsM5sr+REMmH4faTPJhqSAylg0MX4q3Xf1mEPPpVKluxQXMbO1IwhtVPtGH9
         lkrz3bhJ7s82oNEjSxi8YUxueiailuudOZqNlHmtWR4q8FlZe0jCg6fQ27bvuiX+xFD2
         R6S33E0THChAIBgLs/hyVNpW2BYx5FnEIP8gswflxF9KayVoSIZw/Gf8dfd69dvpSZv6
         zDNA==
X-Gm-Message-State: AOAM533MaH3TkQHTNDzywu7bDMA16WES/VHwA+4PDFzEIyo80Rtyyey6
        xOHflxRl8+Is1aQkQVPwlHD37Vpxf3q/IDHQ
X-Google-Smtp-Source: ABdhPJxvk8PMcjaew5j2goslEy2L/b/57GiN7V5OJJTi5n7pDuKRnEMLGQs5PnLQ0zrfKH2aErdXPQ==
X-Received: by 2002:a5d:6e11:: with SMTP id h17mr35388990wrz.331.1620719315466;
        Tue, 11 May 2021 00:48:35 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:ce08:6145:b4e3:5a23])
        by smtp.gmail.com with ESMTPSA id f6sm28371111wru.72.2021.05.11.00.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 00:48:34 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 0/2] ASoC: meson: g12a-toacodec: add support for SM1
Date:   Tue, 11 May 2021 09:48:27 +0200
Message-Id: <20210511074829.4110036-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds Amlogic SM1 support on the TOACODEC driver, first by switching
to regmap fields for some bit fields to avoid code duplication, and then by adding
the corresponding bits & struct for the SM1 changed bits.

Changes since v2 at [2]:
- use raw values instead of defines in REG_FIELD() for g12a_toacodec_match_data

Changes since v1 at [1]:
- switch to regmap field

[1] https://lore.kernel.org/r/20210429170147.3615883-1-narmstrong@baylibre.com
[2] https://lore.kernel.org/r/20210505072607.3815442-1-narmstrong@baylibre.com

Neil Armstrong (2):
  ASoC: meson: g12a-toacodec: use regmap fields to prepare SM1 support
  ASoC: meson: g12a-toacodec: add support for SM1 TOACODEC

 sound/soc/meson/g12a-toacodec.c | 143 +++++++++++++++++++++++++++-----
 1 file changed, 124 insertions(+), 19 deletions(-)

-- 
2.25.1

