Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442873C1D67
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 04:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhGIC0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 22:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbhGIC0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 22:26:20 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E57EC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 19:23:37 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id k20so1438076pgg.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 19:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v+EpRX0Vvrt/sxvQaLYzDThoftpQT11+CjjVmmHJsPQ=;
        b=gJLwSUixj0oppWCY0qYOf+jJ5N0MAYwYaN0OXz/iZpqNxCNOZIJobLE7kEOvgZh83Q
         Z1Bsw4thmyaGtN9IqzWNPGtuajf76sDwpaHoQACS4z309aS298OMRQ3Jk38pwShDvTsB
         dsf59RphRpyWaeOhXbBkJF2S7t8KfRG8mgx7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v+EpRX0Vvrt/sxvQaLYzDThoftpQT11+CjjVmmHJsPQ=;
        b=FT4CugsIDXiz4AsjurhqMwp3Ybh6B5LctqkEg0QBbexpQxUoue2ACA0sp+SSxN3DIQ
         eX+X/+Fp2joU6CumsdRYLkalv2LxOdTCfjCg538Fg7BeyNWxydxMqjYnC/Nbdr0dL07f
         VgWalZvmYZXEa61x46lcWgDvpG/QC+HVv2aYwq0xWNf98x+SeIMyPA3Y2A+uHm5/HofJ
         ef9w50Eaqkcb73cY2exHZnONLN8Z24gD9CUy8ek+SplGWSK3Z+CVKEpAjHBnEllxhQ6w
         Gn06lV51Mur4dbWpx1G428pV713JOHDNldIPsF9YilXNMCY08t0xGvBhVPrbiYpqAsIO
         b7bA==
X-Gm-Message-State: AOAM530Kiv1kp13Es6LvCaKg6Uwb5odk2Fi+PBQ4MHJDBy56RhjOmbzs
        Z76UQu3ChqmCzmgEFDJdSu/4GxZj3dXoIw==
X-Google-Smtp-Source: ABdhPJxPINrKdc1ApCi7yYTCgm1y1Wps8+Yvwq+AF+aVfmGq/+OZBFtFlp1ODDIBVYVGdA6WjgQV7A==
X-Received: by 2002:a63:d612:: with SMTP id q18mr35353686pgg.77.1625797416524;
        Thu, 08 Jul 2021 19:23:36 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:d956:2966:7910:2bd2])
        by smtp.gmail.com with UTF8SMTPSA id x6sm5147650pgq.67.2021.07.08.19.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 19:23:36 -0700 (PDT)
From:   Eizan Miyamoto <eizan@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     wenst@chromium.org, chunkuang.hu@kernel.org, yong.wu@mediatek.com,
        enric.balletbo@collabora.com, houlong.wei@mediatek.com,
        Eizan Miyamoto <eizan@chromium.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v5 0/8] Refactor MTK MDP driver into core/components
Date:   Fri,  9 Jul 2021 12:23:16 +1000
Message-Id: <20210709022324.1607884-1-eizan@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is an update to
https://patchwork.kernel.org/project/linux-mediatek/list/?series=283075
To address some comments and fixes.

This series has been verified to work on 5.13.


Changes in v5:
- rebase and build-test on 5.13-next @ e2f74b13dbe6

Changes in v4:
- rebase and test on 5.13
- don't depend on https://patchwork.kernel.org/project/linux-mediatek/list/?series=464873

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
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.c | 272 +++++++++++++++--
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.h |  36 +--
 drivers/media/platform/mtk-mdp/mtk_mdp_core.c | 281 ++++++++++++------
 drivers/media/platform/mtk-mdp/mtk_mdp_core.h |   3 +
 drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c  |   4 +-
 drivers/soc/mediatek/mtk-mmsys.c              |  20 +-
 7 files changed, 473 insertions(+), 144 deletions(-)

-- 
2.32.0.93.g670b81a890-goog

