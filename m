Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DA9368CD8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 07:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240552AbhDWF73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 01:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhDWF72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 01:59:28 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4A1C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 22:58:51 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so626273pjh.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 22:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WojFyUuBmlCNfO5VcU3mpAXT/QOV485quirzDWuFiHI=;
        b=nEn0d/cITJwCov5cPnJMctSmaLJUrt8L/kVGZa3Mly7ka+SlPVJ9hl5z5Npj6PQ8lm
         CHRZZ1dcQyvoWw0dUVqcLAkJrOb5kJO/cxJQCNA7xsQQi/5Th52yb4YUn0RAoGq3lnAJ
         G+mr9b7dgd2/9zEotik+afdfzYS1OvLXhLluU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WojFyUuBmlCNfO5VcU3mpAXT/QOV485quirzDWuFiHI=;
        b=hU3R6jZjbx1A2nWrJthNipSycKpq6YoBtfg3eSEWvK83Ou4x+YXqwtvH0QS5F42hIb
         sbJ+INfN5Fk4KxMVcVLkfYuBwZfWEKgME0e6KdArZu+9rwsWsPUaZJ7dWxmmLhb3QDMG
         zDVzCB/ljymGTskR5tvhiVdD5eS73Ol4vm9e7/0BLiTw8tZhRfyDKG31zFOIIZzTIng0
         lp8vm6efYnokMcu41B9gkGC62kFy3VUZ08s+qEg+pwwsX1UUG0xVzFjV6pvtw1nvZoBW
         x+6Gr1zhNBPARzUirZMRfHKd+Weiq7lmLbBn+N2VuQh0tjmp1NYJ4m6GZJnCxlYsT3BF
         EMJw==
X-Gm-Message-State: AOAM533cJYnBkvBt/w1DxfNTPQIsCLGudSRjwDwpYoXFu8zvcN7u3/yd
        3qeOmVlYxvrUcgxlZzRQlst2iDBQ3XElsOFR
X-Google-Smtp-Source: ABdhPJwYbk0jpbFk5VmmfOeLYVgcuWObCMUM6VNScD01vj0LdoNVakoEYINA9YdZxs7LcXJ3tQFLag==
X-Received: by 2002:a17:903:244:b029:ec:9666:9fc6 with SMTP id j4-20020a1709030244b02900ec96669fc6mr2176469plh.63.1619157530312;
        Thu, 22 Apr 2021 22:58:50 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:308c:235d:f7a2:53a1])
        by smtp.gmail.com with UTF8SMTPSA id m11sm6254433pjs.34.2021.04.22.22.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 22:58:49 -0700 (PDT)
From:   Eizan Miyamoto <eizan@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     enric.balletbo@collabora.com, chunkuang.hu@kernel.org,
        yong.wu@mediatek.com, Eizan Miyamoto <eizan@chromium.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v1 0/4] Refactor MTK MDP driver into core/components
Date:   Fri, 23 Apr 2021 15:58:37 +1000
Message-Id: <20210423055842.2490679-1-eizan@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an update to
https://patchwork.kernel.org/project/linux-mediatek/list/?series=283075
To address some comments and fixes.

This series has been verified to work on 5.11.

It has been rebased on top of the series
https://patchwork.kernel.org/project/linux-mediatek/list/?series=464873

The first two patches are unchanged from the previous series submission.


Eizan Miyamoto (4):
  mtk-mdp: add driver to probe mdp components
  mtk-mdp: use pm_runtime in MDP component driver
  media: mtk-mdp: don't pm_run_time_get/put for master comp in clock_on
  mtk-mdp: soc: mediatek: register mdp from mmsys

 drivers/media/platform/mtk-mdp/mtk_mdp_comp.c | 191 ++++++++++++++--
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.h |  35 +--
 drivers/media/platform/mtk-mdp/mtk_mdp_core.c | 214 +++++++++++-------
 drivers/media/platform/mtk-mdp/mtk_mdp_core.h |   3 +
 drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c  |   4 +-
 drivers/soc/mediatek/mtk-mmsys.c              |  20 +-
 6 files changed, 345 insertions(+), 122 deletions(-)

-- 
2.31.1.498.g6c1eba8ee3d-goog

