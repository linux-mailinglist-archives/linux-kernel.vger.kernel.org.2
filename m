Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E9734D444
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhC2PsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 11:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbhC2Pr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:47:59 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB98C061574;
        Mon, 29 Mar 2021 08:47:58 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b9so13327866wrt.8;
        Mon, 29 Mar 2021 08:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Qih3TtMHQJLAXNG5X3gxadti71q6KlG7tdechBjfyGU=;
        b=cFhvG5IwuGl4H4NE2yJmORHRAmmmgxRDFtVc8PQUf9wUwHYK1OUXlqAVyJFWX6QAbI
         ULyxl8sPBIdyT6XTDdemJ0jEl+TznffN5mvH+tKdjI1stKx57AG47XgHFqBt7jlTvs6i
         2Kx1KTlao8qc/OKGAkI0tsMzFrnjPWy815Zwyk/tV2MiaKTe/zY680fH/gijUSm+Zk68
         14K/3OKh0OeadWbCWVwNpiyaud4P4liQPRAKRQzuUqrA4G0FueMQPKPlNI1xNIe0/t61
         eja39RcO+OMvXBn0OoAc6cqH8P3/ipsaz/Uok5YRsiKoP9KT692UJcbsboPbdOk2lOgT
         qFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Qih3TtMHQJLAXNG5X3gxadti71q6KlG7tdechBjfyGU=;
        b=pS3kAYKwVH+wv/Y798F1vxv3I4eaZQwrdj5THCiwhwCzkVg5TGR9Y0wJ2o/BIH1xUV
         BRwEer3zX0AYBoamZ/eCqHJxtKwS60caIXaGRSId3KtYsNugQsSkN+woRn6ovVekkJ3E
         Ry36EDmW+Y2uhpccd2Elfx9uy0wb0O46TlGrRmev1N+Yrwax442ge2w9kD1NBXFja6OD
         KEi1ubH5lzM70xhcJgOLW007qFuiAZBzn84XvK3CTW9QhT4VuTsAdCaqGMgI5sdIf/ti
         xHEDaeq0rv1AGhKnQGafStA8FBo81AwLVXRp+VVLqjLLmeX8dgdikUv64mKAeqpML8kE
         rlbw==
X-Gm-Message-State: AOAM532w+IMDO7MC0QHmm4HIhGA6GLLvYK1fTn2RrKyP0CbHs34UI20L
        /SoJzPrpvVl4C02NAQeYNsg=
X-Google-Smtp-Source: ABdhPJxIauCgVfivl0+YJXVppDpW+s3lOtd68GaioqwWVWUWe+zQWVqp5ZMIUwzMoBnHbYBTC71nmg==
X-Received: by 2002:a5d:65cd:: with SMTP id e13mr29848822wrw.334.1617032877429;
        Mon, 29 Mar 2021 08:47:57 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id b131sm24987323wmb.34.2021.03.29.08.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 08:47:56 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Drazen Spio <drazsp@gmail.com>
Subject: [PATCH 0/3] arm64: dts: meson: add support for MeCool KII-Pro/KIII-Pro
Date:   Mon, 29 Mar 2021 15:47:50 +0000
Message-Id: <20210329154753.30074-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the MeCool (Videostrong) KII Pro (GXL)
and KIII Pro (GXM) Android STB devices. These are quite popular due
to the embedded multi-standard tuner card (which is sadly not-yet
supported in the kernel). Both devices closely follow the Amlogic
reference designs with keys/buttons/LED details taken from known-
working vendor kernel device-trees.

Testing was made by Drazen Spio via the LibreELEC forums [0] as I
don't own either device. Since dts files were added to LibreELEC
nightly test images I've seen the number of active installs grow
without reported issues.

[0] https://forum.libreelec.tv/thread/23590-nightbuild-on-mecool-kiii-pro/

Christian Hewitt (3):
  dt-bindings: arm: amlogic: add MeCool KII/KIII Pro bindings
  arm64: dts: meson: add initial device-tree for MeCool KII Pro
  arm64: dts: meson: add initial device-tree for MeCool KIII Pro

 .../devicetree/bindings/arm/amlogic.yaml      |   2 +
 arch/arm64/boot/dts/amlogic/Makefile          |   2 +
 .../meson-gxl-s905d-mecool-kii-pro.dts        |  86 +++++++++++++
 .../dts/amlogic/meson-gxm-mecool-kiii-pro.dts | 113 ++++++++++++++++++
 4 files changed, 203 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-mecool-kii-pro.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-mecool-kiii-pro.dts

-- 
2.17.1

