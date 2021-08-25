Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994873F6DB8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 05:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbhHYDiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 23:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhHYDiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 23:38:07 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4823DC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 20:37:22 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id t42so17542523pfg.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 20:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rD0o67j/laHpe4aDVsl8MDb/cWf8HZLes0zv9r5sgOQ=;
        b=C0XXUfq05Vk2o6FVLtiGfBsmlwFanOstvcjgB+89t26LIUhwwgGZVVJuecHjz62T4J
         gQqxdpixoFdWbL3Mpmwv3/oN3UIUKL6hZv4MChJV2tsm+pwRZ/p+tWMsZ2tkTlvge6Px
         qWA7mZjE4xu6xEhNqf4DBQzWBbuPrPLFluJ7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rD0o67j/laHpe4aDVsl8MDb/cWf8HZLes0zv9r5sgOQ=;
        b=fPFBbt5augJZTs+JCCXG/7WBVWXmcvFnwN1vK7cForWb2rCSZQpi+S/rwXl+jtFY0J
         ED9lbcznpCzSGejyK0t5KaMV6r8JkLNF1E5DZWcupT0pBNNSnToh4cCs/BJN1uZvkK3O
         3i8cZlIDn1I51VZUtoEloVsRedZpe3P2zaKN3ho9wAeJzM4dLziVOysCpubf0+rY94RR
         2QXWWfe5lwrydNY9WTG1ZVo4q4yrFqdnwiF/beQTQBbwE17yl/RZxd6j4gLLvleOXwW+
         wrDh/1L7Fcf8E2GClDNQuFZm5mBSrm2Pu+545RUNB74pcrkoDxTKcomV05rqVsHnnX7A
         NyBg==
X-Gm-Message-State: AOAM530H2q2dxF9P1LqUlzv0KxuIOTJAsd4FQFatXi4lEYcU1UKURS3R
        3kJxCd6qUQKC64YVUt7mmxpeiQ==
X-Google-Smtp-Source: ABdhPJzwbcWBlXI82NOEE2KsqW6Q82aJPm9zRsXnknAE16aMI/brVUvUZFOAzmWHosV/cOUzj/Um4g==
X-Received: by 2002:a63:87c3:: with SMTP id i186mr5700076pge.242.1629862641871;
        Tue, 24 Aug 2021 20:37:21 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:629f:4b05:2c88:776d])
        by smtp.gmail.com with ESMTPSA id l10sm3902149pgn.22.2021.08.24.20.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 20:37:21 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] regulator: vctrl: Avoid lockdep warning in enable/disable ops
Date:   Wed, 25 Aug 2021 11:37:02 +0800
Message-Id: <20210825033704.3307263-1-wenst@chromium.org>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a couple fixes for vctrl-regulator. This driver is only used
RK3399-based Chromebooks.

Patch one fixes a misuse of the regulator API, which was found while
tracing the code to fix the lockdep warning.

Patch two fixes a lockdep warning and actual (not easy to reproduce)
deadlock.

Please have a look. The are no dependencies between the two patches.


Additionally, I believe it would make sense to implement the voltage
stepping feature for all regulators in the core. Then we could move
away from vctrl-regulator. Right now it is only done for coupled
regulators.


Regards
ChenYu


Chen-Yu Tsai (2):
  regulator: vctrl: Use locked regulator_get_voltage in probe path
  regulator: vctrl: Avoid lockdep warning in enable/disable ops

 drivers/regulator/vctrl-regulator.c | 73 +++++++++++++++++------------
 1 file changed, 43 insertions(+), 30 deletions(-)

-- 
2.33.0.rc2.250.ged5fa647cd-goog

