Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066B73DF8EE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 02:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbhHDAYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 20:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbhHDAYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 20:24:35 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB80C06175F;
        Tue,  3 Aug 2021 17:24:06 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id l4so613098ljq.4;
        Tue, 03 Aug 2021 17:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=77hJXrhsOlvF6oe1Gy/71bngx7Swibl7zjXjn7JDTb4=;
        b=JKx+MBWxiihe0VyvwO2KJ02kWA24USSLP6Lf0xQkBfrFzcD6UjAjmd/PShVKY/+i3i
         dQIfkTSsxM5pZ4XVFHXB4uXxOPppzIAYtsgCMxGaHlcvQUzE3SsZXI7/qj/K7JzP8UeH
         Ikes47fkfeMGbhKUge4EkPPp5DdE+NVF+ex9d4bQneTjqQX3ZQytntalT1+lOTjQ8aw6
         jxlu9UH0LPotB7YiM6Hrg7v1kQg7HFdo4SKevxrq+diJLm4+3HG/V0VbZ4OQoHuoK16B
         uwFgxZTcFn9D60CSoZpxxpoxLyT20olqeglsDc2NbijVk0yxHJ4e1/qzD+KmqYNvPOMy
         ++4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=77hJXrhsOlvF6oe1Gy/71bngx7Swibl7zjXjn7JDTb4=;
        b=JgHDdK63bCma/uO7krrNEPlWTtnBstQtU2gPMfNE9Z52vsPxcpq4youk0GVCEhCm//
         zM33n/etwe4Ih0hggB/2JLduZQjth44IbxrWG6XVcub3k4lbdqDslhOkQuooB/6mQrEE
         yD16mzQVETDdINNokzT/+al1Dz+g1jjF+pOA683mzHdP/aiYuIuoi1C7zbZGQoYhguTe
         vIt/vOU3JaP9oq8idPGysRsfNZ/eUP9UtWkL/CM82gLA5hSCaDf0i3X8j9BFMd3aRb2O
         XWYwXO+lWaXr/DMlmTyNFHup5jfJAsIlz7hpEwP+SNnFdw+2hGPCcp+jzGFLQbIhsxmu
         s0yA==
X-Gm-Message-State: AOAM5336eNQHL3Gw2u/1cfoGL3uEtyRSP1qAP3OQV9G75Rcba1hVYA1Q
        rpJSRQVm8tkvK4DpNSiQa9U=
X-Google-Smtp-Source: ABdhPJx8vAHnHn8j6mTOZSPuL5Ok/oPPKPH0gf8Oj/0TKnGxPILQq3oI3ns9YhFnj/fDDoKOY1iuYg==
X-Received: by 2002:a2e:888f:: with SMTP id k15mr16397989lji.326.1628036644702;
        Tue, 03 Aug 2021 17:24:04 -0700 (PDT)
Received: from akaWolf-PC.. (broadband-5-228-138-51.ip.moscow.rt.ru. [5.228.138.51])
        by smtp.gmail.com with ESMTPSA id t17sm40992ljk.102.2021.08.03.17.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 17:24:04 -0700 (PDT)
From:   Artjom Vejsel <akawolf0@gmail.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, akawolf0@gmail.com
Subject: [PATCH v4 0/3] add Gopher 2b LCD panel
Date:   Wed,  4 Aug 2021 03:23:50 +0300
Message-Id: <20210804002353.76385-1-akawolf0@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Gopher 2b LCD panel is used in Gopher 2b handhelds.
It's simple panel with NewVision NV3047 driver,
but SPI lines are not connected.
It has no specific name, since it's unique to that handhelds.
lot name at AliExpress: 4.3 inch 40PIN TFT LCD Screen COG
NV3047 Drive IC 480(RGB)*272 No Touch 24Bit RGB Interface

Changelog:
v2: remove .num_modes
v3: sort QiShenglong vendor prefix,
	sort qishenglong_gopher2b_lcd_panel_modes struct
v4: rename lcd-panel to lcd

Artjom Vejsel (3):
  dt-bindings: Add QiShenglong vendor prefix
  dt-bindings: Add DT bindings for QiShenglong Gopher 2b panel
  drm/panel-simple: add Gopher 2b LCD panel

 .../bindings/display/panel/panel-simple.yaml  |  2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 drivers/gpu/drm/panel/panel-simple.c          | 43 +++++++++++++++++++
 3 files changed, 47 insertions(+)

--
2.32.0
