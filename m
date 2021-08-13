Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F233EB52C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 14:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240297AbhHMMUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 08:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240247AbhHMMUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 08:20:34 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13947C0617AD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 05:20:08 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id a5so11693914plh.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 05:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YCtFiQGzSSD0WFlLn3y5kRxY45lpqdiAdKef9EbWCKk=;
        b=LmhgmB1aSkYNmHUQ7x4C0CJPEJsYjcxTYKjpTJzPXflVtai+MVevIpvUyeY8I0bQN8
         zxRJSp7jmxNf9vgol2DLBA5Evn3qtTVQdotTXcS0wIVVmDuRsigeTnAdUvcRnhzp2t3S
         v2q5vEv9HEP0DHWfSBHhrvOKbj5TFYVeaTAKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YCtFiQGzSSD0WFlLn3y5kRxY45lpqdiAdKef9EbWCKk=;
        b=ljK4Hs+5nbzIZG+JmzPC0XR0/CUeNdi0TP12F3gxGy/mMir5RXRVSzi2wqwT7mlFrG
         DrOjoD3Gpc/SNXodv6rp6viQ+yA6N4pmoybPKI8ODp9m5xigVYxneY1R6UIAbHMxUbmh
         GNW3o85OJ5E33dKL+L2fmyN+UonTB2WPhjJMWEVdbe2Co6/u/Kn5mxJ/ZO2axrJ/MRoI
         tqfHWX1QLqAsRh8u1Fz0xFxjBTBdYvdDsiwFL+C0eZOP2u3UaSWjPThbuyI2hjIjdolU
         N9oLOje7GfuDjhEY95N5MBg5W/cu93l5LBVVTd8kalze09nEDxycriSK4PUDu2WVc10Q
         IE3w==
X-Gm-Message-State: AOAM532cTpSFUTNbqXWpU6yT/uaJe7DJnpHq4QQj3LxV80zMHPtDVVtc
        q3ER5tKCpX/iPVoHMrECx47RJg==
X-Google-Smtp-Source: ABdhPJxi7siu4n9mjrZKiMUTXiVwqus2x1w6B4njNKyABlCL9wXM3/vTwkJchlcU2oExzMAR/5Ajaw==
X-Received: by 2002:a17:902:9303:b029:12c:29c:43f9 with SMTP id bc3-20020a1709029303b029012c029c43f9mr1806527plb.5.1628857207649;
        Fri, 13 Aug 2021 05:20:07 -0700 (PDT)
Received: from kansho.tok.corp.google.com ([2401:fa00:8f:203:5293:be68:a318:ba36])
        by smtp.gmail.com with ESMTPSA id v15sm2181680pff.105.2021.08.13.05.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 05:20:07 -0700 (PDT)
From:   Kansho Nishida <kansho@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Eddie Huang <eddie.huang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Kansho Nishida <kansho@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 0/1] dt-bindings: mediatek: update audio binding documentation
Date:   Fri, 13 Aug 2021 21:19:56 +0900
Message-Id: <20210813121957.3089816-1-kansho@chromium.org>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Matthias,

Thank you for your merging! This patch updates the binding description.

Regards,
Kansho



Kansho Nishida (1):
  dt-bindings: mediatek: update audio binding documentation

 .../devicetree/bindings/arm/mediatek/mediatek,audsys.txt      | 4 ++--
 arch/arm64/boot/dts/mediatek/mt7622.dtsi                      | 4 ++--
 arch/arm64/boot/dts/mediatek/mt8183.dtsi                      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.33.0.rc1.237.g0d66db33f3-goog

