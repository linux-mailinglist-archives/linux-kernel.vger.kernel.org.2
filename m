Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB883105B9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 08:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhBEHTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 02:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbhBEHTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 02:19:19 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5BFC061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 23:18:39 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id o63so3919745pgo.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 23:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZPvlIT0HoqfzZ/kPoc529sp4UTquUpxTHygdzOzpf6k=;
        b=h5bCogGGi7kKVjxcIMg4MtTIPxABpO83xNsg3cS18Ysfjkgf3YP4g0i/WfSRE/swuo
         GKdATqNb65ipswcMkc7mrODTQcUPPcPgUAkT7IPBdhFzk/pzwouO/L3WnV5Dd58xUosv
         sjTmUS/N5RvxHotu9O+ra3mIwOWYPx2WKtPGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZPvlIT0HoqfzZ/kPoc529sp4UTquUpxTHygdzOzpf6k=;
        b=cELTTmqPa41Roy7mgzY20awN60KF+M0vOFsDec516VVIb6ygY8/gkufd0dvhhUssMo
         XAnDUe69bipMwCk+/pC4QDnnG8V7LDNG5gQt36EcAqnrYkseYm6MSEihyiG4YQESMi3G
         p8HqujyerOV4JIrAjFmMP9RoQqccLRWVFB1ktudNTjAbpllG+Ol1g8+FBOeamOxGfV0B
         9RlhPJ+kTfK0jn5VjXbJYmk6o2dsI/RavHxlOJHwzw6JdGOBz2sWXwpeTJguMAKeT8cc
         DodJOIQm+hJBq2SEvRKQwPOD7ia+CHGhK4RHHNwJKeVcRafo14RpyA8rWH1OPdqhE9SA
         vgQw==
X-Gm-Message-State: AOAM5322YQg4xSVmkCzB6ZwuwplcjSdXjFP8cbSfD5PY54Xf6Pvf+Vhm
        Dcmhnk/n+1BHbx8KXfMi32IpOQ==
X-Google-Smtp-Source: ABdhPJwt6ELkujlzDtiBO5NFLk+8rtHdnqs2ggIxilA4kdYsoyGvhf/+SwXS3b7NARo3AkRtwa28lA==
X-Received: by 2002:a65:6152:: with SMTP id o18mr3112704pgv.392.1612509519160;
        Thu, 04 Feb 2021 23:18:39 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:ed70:6d43:9c6a:2e22])
        by smtp.gmail.com with ESMTPSA id oa10sm6292028pjb.45.2021.02.04.23.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 23:18:38 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>, linux-mediatek@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] support gce on mt8192 platform
Date:   Fri,  5 Feb 2021 15:18:30 +0800
Message-Id: <20210205071833.2707243-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change since v2:
- add controy_by_sw for mt8192

Change since v1:
- move out shift jump patch
- remove useless patch

Yongqiang Niu (3):
  dt-binding: gce: add gce header file for mt8192
  arm64: dts: mt8192: add gce node
  mailbox: cmdq: add mt8192 support

 .../devicetree/bindings/mailbox/mtk-gce.txt   |   7 +-
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      |  10 +
 drivers/mailbox/mtk-cmdq-mailbox.c            |  10 +
 include/dt-bindings/gce/mt8192-gce.h          | 419 ++++++++++++++++++
 4 files changed, 443 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/gce/mt8192-gce.h

-- 
2.30.0.365.g02bc693789-goog

