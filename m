Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F62325453
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbhBYRGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhBYREr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:04:47 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E6FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 09:04:05 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id p21so9575804lfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 09:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DOap4yHkmq8CavcY7I4GN8w1SlMHMd4tkxnPryvWXe8=;
        b=hgNtW1+GWpoz6K7hbtSnL7IQqJuU4A23n/pa13h69n5TBX7AIzjMqNemROx2zXyrkM
         CUqAKHgFSDQcY1UT8XsEcbgsysRJJDmLpnsgCouPMFFX8sdMO5x+U5YAqRCRONEpjkCu
         KSE+ALwaFtuaYwI/8SZc+gRWrC7MEhWEqWTB4qV10LyplFUWui7gT8eaarIjBnYpg5ot
         DBNbc2X7/Zu0GHKlxyEG0Qphudd/fJ+2A6d9TZQTa90YxiDxbW9/8bNV/p6wJqFZNxrK
         kh2DGGeXpmvGqkwM9Cqz18/WaCjwsMVHZ9TpwjxD8GtM5tYNFi0tRDS9PQP7AJUIGkfH
         964g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DOap4yHkmq8CavcY7I4GN8w1SlMHMd4tkxnPryvWXe8=;
        b=JYlTRzZME8vCpbVSs0hYZs4PJIHIctY5lWfzN2RI/Iwc6pZH3qwC8LVLO5jneHUXEL
         e4vsY/IyEO3GeTCaHoYFdQhmXqHb3tfGGek5Uwmg0jvJ/3FlTu1ALyMl8Ek+XItMcUX8
         OuZ0HOfZl8xVo1+Fa0a4wdgb7Uag10IXBtzwmE8z35BvhgVG7sP2Wy+OkDRw/FOgfKMw
         u1r+iNl6uztjewu77q9hWWsTP55C+x82V06GzvZedtWjRgurY+bMxGK7Lytv2a11a/cJ
         08y5Y+5CtpK7eRl7rwAOR+AyBKXeo3d5+Z7CcKhRTqyc8nryvozpkHWilJ2x2KGW0Rdk
         tjBA==
X-Gm-Message-State: AOAM530y32VT7giC08nR+HOYKKu4VjT6BPmBxhQn+92yn0pmlqfmMTwM
        6jlbfg/KXKSPPzBSvYkj7yXlMg==
X-Google-Smtp-Source: ABdhPJxvTvVREmUjSS6lpbqvTkeJX4iCimDk0nZyHdbyH/BFA8at+6wvgxayb4JO+PIlU9lZLFijjw==
X-Received: by 2002:a19:7114:: with SMTP id m20mr2297506lfc.570.1614272644253;
        Thu, 25 Feb 2021 09:04:04 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-234.NA.cust.bahnhof.se. [155.4.129.234])
        by smtp.gmail.com with ESMTPSA id b39sm1103749ljf.68.2021.02.25.09.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 09:04:03 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw, Renius Chen <reniuschengl@gmail.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Takao Orito <orito.takao@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] mmc: core: Preparations to support SD UHS-II cards
Date:   Thu, 25 Feb 2021 18:03:48 +0100
Message-Id: <20210225170352.76872-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A series [1] that has been collaborative worked upon by Takahiro Akashi
(Linaro) and Ben Chuang (Genesys Logic) is targeting to add SD UHS-II support
to the mmc subsystem.

Throughout the reviews, we realized that the changes affecting the mmc core to
support the UHS-II interface/protocol might not be entirely straightforward to
implement. Especially, I expressed some concerns about the code that manages
power on/off, initialization and power management of a SD UHS-II card.

Therefore, I have posted this small series to try to help to put some of the
foundation in the mmc core in place. Hopefully this can provide some guidance
and an overall structure, of how I think the code could evolve.

More details are available in the commit messages and through comments in the
code, for each path.

Kind regards
Uffe

[1]
https://lkml.org/lkml/2020/11/5/1472


Ulf Hansson (4):
  mmc: core: Cleanup printing of speed mode at card insertion
  mmc: core: Prepare to support SD UHS-II cards
  mmc: core: Announce successful insertion of an SD UHS-II card
  mmc: core: Extend support for mmc regulators with a vqmmc2

 drivers/mmc/core/Makefile    |   2 +-
 drivers/mmc/core/bus.c       |  38 +++--
 drivers/mmc/core/core.c      |  17 ++-
 drivers/mmc/core/core.h      |   1 +
 drivers/mmc/core/host.h      |   5 +
 drivers/mmc/core/regulator.c |  34 +++++
 drivers/mmc/core/sd_uhs2.c   | 289 +++++++++++++++++++++++++++++++++++
 include/linux/mmc/card.h     |   6 +
 include/linux/mmc/host.h     |  30 ++++
 9 files changed, 404 insertions(+), 18 deletions(-)
 create mode 100644 drivers/mmc/core/sd_uhs2.c

-- 
2.25.1

