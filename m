Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B03341C0A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 13:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhCSMOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 08:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhCSMOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 08:14:08 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C20C06174A;
        Fri, 19 Mar 2021 05:14:07 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id hq27so9340902ejc.9;
        Fri, 19 Mar 2021 05:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gc/dWQUQmNiJPL4ALRbixu7cFOoE030UiO2hdvOrrII=;
        b=PPXjhI9jYl3wouVE/52pLKcp9jYp7iczbPbDPiMv7wqrv2sRFl4GRo5RIVa4+lqNy2
         5nSQLOOU5h6aZyI0rRXU7hrcms6V6cht2wq63sWvqtja7iGW6DmeuxFzhkHkf27cXzjo
         Zr/5lNi3EUpC4z1Mm7TH7B3UsP7lA0sauk3kt0d3piBFn03b6gqpIH96VA421TuoRnYY
         5X9jH7wX+TDTVpUu17zmDmFUiScUyQcqAmxFiEyp7zl65r7A1/Py4lJss4EZr2OLKHkv
         GtK0QpUDZNFfG7Mnl4lrgtYmO9oNS3vTZqcuaK0VqF1LgQBWitcAfyowpj06/j+L/D5m
         h/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gc/dWQUQmNiJPL4ALRbixu7cFOoE030UiO2hdvOrrII=;
        b=PhAcL7aY6kbAK5GHCFQOGoIawpqLWPhLCegYzwcA0g6LSS+DtWVGY8AKyXPIlXBenI
         khohJIJOGJuUlTAlymDFdURgOTMC84kBpc+Fcqb6i7ws5cdbFOcAlEuaWnLwSv/YdAFX
         eG04q7QxK+bpdbfMiox/JIJEPAQDYsu5f1IZF7tCB1OgKUZnB8Qf4i82asHyicLGzsrH
         9ds9dnSDQLVse5v8KMOUkAh7UhJP8K/xYKGmiRRT7XXbR7P39u6MVVbIdRNE7YJoQqMa
         OZUjPNamY9PeSsif9xYjQTI667bEW8S/piZVNFlEowEOHIYyClFeY0aKI/SL+RNN8GfG
         jv/Q==
X-Gm-Message-State: AOAM532q6fHUvonsfVADz0BgXS4ooggJGJbm6sT2K+2wvp/pEuqBStTd
        dbKStXB4r8guNzzpX4ZfITI=
X-Google-Smtp-Source: ABdhPJyrocf55LD95x+WQHI6g2R+A7QGw1Czxhn1zYwBIb+Mf0wFoUGIjRkievLz1GxGNJ4QvAVYiA==
X-Received: by 2002:a17:907:75c7:: with SMTP id jl7mr4091090ejc.191.1616156046373;
        Fri, 19 Mar 2021 05:14:06 -0700 (PDT)
Received: from localhost.localdomain (ip5f5bec5d.dynamic.kabel-deutschland.de. [95.91.236.93])
        by smtp.gmail.com with ESMTPSA id q2sm919353eje.24.2021.03.19.05.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 05:14:06 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     rric@kernel.org, ulf.hansson@linaro.org, linus.walleij@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     beanhuo@micron.com
Subject: [PATCH v1 0/2] wo minor changes for Cavium MMC host driver
Date:   Fri, 19 Mar 2021 13:13:55 +0100
Message-Id: <20210319121357.255176-1-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>


Bean Huo (2):
  mmc: cavium: Use '"%s...", __func__' to print function name
  mmc: cavium: Remove redundant if-statement checkup

 drivers/mmc/host/cavium.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
2.25.1

