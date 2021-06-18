Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C153AC549
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 09:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhFRHye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 03:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbhFRHyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 03:54:32 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D3EC061760
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 00:52:23 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c15so4183942pls.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 00:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TWKeVClJkZsu4I1NG/srDbtbqbk6CdxTWMa8/auvrQI=;
        b=Di3abQbPqjpkNWI3bRYbeAUWNX0ZsMYqIQhd3Nw+i1sVO8GDClkuQiT30M9Ac/KrSI
         DCWoq9PM/rq5tb232t+pqzX+4VQ75LVXZPu5t78ykMALxsvmoBefdVyfeUCMjUk83zAK
         jvntmYbEYV9aLSzod9xcsIV97l3zg6heb8Gxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TWKeVClJkZsu4I1NG/srDbtbqbk6CdxTWMa8/auvrQI=;
        b=C3L2FEEpYtvD5u7jMogv9qkbq0JoOdtcYw/wVz8dK2zub1kOSgOF9slIkZQvjhGijK
         WxP2qgR9wW/lbG3auR9mQAlCuQuWsF4udMsHUGnMeLrzm2DHTLPQ3cXGIC8i7euR4NkW
         /Ixx6Y6KuaRzOhDHW8N3e1XQQm0C/7bfjN2Ui7IvqaicyhlC3armabvC19eYd2J3llJP
         OuUVi82MgCAm2jwKA1GLCaaK9TnAARL6sUtGjz3xkRsGmEfRGvrzurG+/7nhl3qLxfS5
         Fx2aOKE92KMxyzjVTGY7xMqb8QHs+ny9QtaEmn6F+dzPuP133UlF+d23lNiCdC0lgnTn
         qLOw==
X-Gm-Message-State: AOAM532LwUaBvH3IexhN1ha27dHdRmxYQPae7eZPyocjh3NAXvqHhksd
        Eb/Grq8JcEbyEhDVkKgShkObnWZHHwGL/M3n
X-Google-Smtp-Source: ABdhPJwUHDTcPL/rQBD6it7FZK81z/Im0JEmx5fE8SmQkeR3/isJbPHDAXRl7sASTh4NTIXFVcAD3g==
X-Received: by 2002:a17:90a:a592:: with SMTP id b18mr20970932pjq.178.1624002743104;
        Fri, 18 Jun 2021 00:52:23 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:3e8:19ca:3d8a:e112])
        by smtp.gmail.com with UTF8SMTPSA id 194sm6966360pfb.139.2021.06.18.00.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 00:52:22 -0700 (PDT)
From:   Eizan Miyamoto <eizan@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     yong.wu@mediatek.com, houlong.wei@mediatek.com,
        enric.balletbo@collabora.com, chunkuang.hu@kernel.org,
        wenst@chromium.org, Eizan Miyamoto <eizan@chromium.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 0/8] Refactor MTK MDP driver into core/components
Date:   Fri, 18 Jun 2021 17:52:01 +1000
Message-Id: <20210618075209.1157766-1-eizan@chromium.org>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is an update to
https://patchwork.kernel.org/project/linux-mediatek/list/?series=283075
To address some comments and fixes.

This series has been verified to work on 5.12.

It has been rebased on top of the series
https://patchwork.kernel.org/project/linux-mediatek/list/?series=464873


Changes in v3:
- get mdp master from aliases instead of strcmp against of_node->name

Changes in v2:
- rebased onto Linux 5.12
- 100 char line length allowance was utilized in a few places
- Removal of a redundant dev_err() print at the end of
  mtk_mdp_comp_init()
- Instead of printing errors and ignoring them, I've added a patch to
  correctly propagate them.
- Use of C style comments.
- Three additional patches were added to eliminate dependency on the
  mediatek,vpu property inside the mdp_rdma0 device node.

Eizan Miyamoto (8):
  mtk-mdp: add driver to probe mdp components
  mtk-mdp: use pm_runtime in MDP component driver
  media: mtk-mdp: don't pm_run_time_get/put for master comp in clock_on
  mtk-mdp: soc: mediatek: register mdp from mmsys
  media: mtk-mdp: search for vpu node instead of linking it to a
    property
  media: mtk-mdp: propagate errors better in pm_suspend/resume
  media: mtk-mdp: use mdp-rdma0 alias to point to MDP master
  dts: mtk-mdp: remove mediatek,vpu property from primary MDP device

 arch/arm64/boot/dts/mediatek/mt8173.dtsi      |   1 -
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.c | 258 ++++++++++++++--
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.h |  35 +--
 drivers/media/platform/mtk-mdp/mtk_mdp_core.c | 281 ++++++++++++------
 drivers/media/platform/mtk-mdp/mtk_mdp_core.h |   3 +
 drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c  |   4 +-
 drivers/soc/mediatek/mtk-mmsys.c              |  20 +-
 7 files changed, 466 insertions(+), 136 deletions(-)

-- 
2.32.0.288.g62a8d224e6-goog

