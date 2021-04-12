Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3496535C2E0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244252AbhDLJv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243548AbhDLJmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:42:25 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9B0C061374
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:39:34 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id w7-20020a1cdf070000b0290125f388fb34so5790512wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w1BnG+IENM4qvrGt9ztIqEmR2ezH1D5tkiZdEencp0c=;
        b=NDC4fFT+scz5EapADelZyfCl195sOOv2zwhoQ7BzUsreOAT5gl9FUXPVafJeb8KFEa
         RlPUeT5uW4WhE6OFY12guQS1IyIzcWkywAtXk4TagSimQUiX17NgHp1rBiUtlqxnuYJ+
         bHqR2fmTaAcpw9d/M7Y/8H5cvOpBhYovJnQVE0HfKiyR6zqdxEdfMZBxW1PZJAiWQQnb
         PWpqFJVji72qnuCyvG1reW8Dkob+9H8ZQsj5DbMR4lIrz93/9Qthv+I3DXrknc0J6qwD
         AECk8CYfRPH+/s0Y9AguuIG7RNv7Aq0ClpZ/jfAzLS8pqY8h14nWDfbHM5qvdT/qvE4B
         FGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w1BnG+IENM4qvrGt9ztIqEmR2ezH1D5tkiZdEencp0c=;
        b=iEoqrVLTHeV6F4dxja6u4yOs0R+gSAvySAOc7zFMUMx6Yr/7oMMH1taJj/UbFBr+Ah
         zkJv6bCNjqt4Ib44NilZeICqEQQShqNddwO1uerEboNRLfr2ZQZUtI7iNPMJzd7bvRZ4
         4VfJbnhz7s9OD/cTUWft/IVaJYZs4ujl3hxEKb5jEuQcAdU35ZI3pTC01QlYlCg7o0np
         Vo5xQys/dnIo4rW1QKuLE/xWtSK1kDGmXl/7T87gFRBTL3AU7UGgTh0cKMlLBSoFrfQ6
         u/UdFYEoTrwMcLV+puxmRvWyuYKrikZMN6dgqRFv8YT5/ku4DUSYjWonB8H2C5DpLwuA
         NCIQ==
X-Gm-Message-State: AOAM532KysDLX5M7npJxtdU74rZoF6AI79tLNXvXJfJGz0VTZGp4+K6q
        GZwTLRj+23vkk2eZAu8sSqON6A==
X-Google-Smtp-Source: ABdhPJzb8zquyRlhr97rmCN1MNzd5KVvMYgqyH3tT3JQ6U4D10kioViIzexWKJVu3EQa2ZFNYH9qzg==
X-Received: by 2002:a05:600c:4d91:: with SMTP id v17mr4377091wmp.28.1618220373362;
        Mon, 12 Apr 2021 02:39:33 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:4c21:b00e:ff79:bf20])
        by smtp.gmail.com with ESMTPSA id r22sm14405902wmh.11.2021.04.12.02.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 02:39:32 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        matthias.bgg@gmail.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 0/5] mediatek: hdmi: add MT8167 configuration
Date:   Mon, 12 Apr 2021 11:39:23 +0200
Message-Id: <20210412093928.3321194-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT8167 SoC have a hard limit on the maximal supported HDMI TMDS clock,
and is not validated and supported for HDMI modes out of HDMI CEA modes.

To achieve this:
- switch the mediatek HDMI bindings to YAML
- add the MT8167 compatible
- add a boolean to discard the non-CEA modes
- add a value to specify mac TMDS supported clock
- add a conf entry for the MT8167 compatible

Neil Armstrong (5):
  dt-bindings: display: mediatek,hdmi: Convert to use graph schema
  dt-bindings: mediatek: add mt8167 to hdmi, hdmi-ddc and cec bindings
  gpu/drm: mediatek: hdmi: add check for CEA modes only
  gpu/drm: mediatek: hdmi: add optional limit on maximal HDMI mode clock
  gpu/drm: mediatek: hdmi: add MT8167 configuration

 .../display/mediatek/mediatek,cec.yaml        |  52 +++++++
 .../display/mediatek/mediatek,hdmi-ddc.yaml   |  58 ++++++++
 .../display/mediatek/mediatek,hdmi.txt        | 136 ------------------
 .../display/mediatek/mediatek,hdmi.yaml       | 132 +++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_hdmi.c           |  17 +++
 5 files changed, 259 insertions(+), 136 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,cec.yaml
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi-ddc.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.txt
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml

-- 
2.25.1

