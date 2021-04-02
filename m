Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E633526B0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 08:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhDBGph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 02:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhDBGpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 02:45:30 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFF5C0613E6;
        Thu,  1 Apr 2021 23:45:27 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e18so3881819wrt.6;
        Thu, 01 Apr 2021 23:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZeHJob2v/K/CaMbyyAWcKJg79Pbk2BJVjHV0z+90W88=;
        b=Ca/t4hzjjq66+TKHWGZebJNSM9ZFmjugKYb+ufEu1KBPOmGgMRor4xIJ/HP4TGuzQH
         tpb1O09F4TQ+4P9Iv2H5vKHIRWeSMB+QU0w4UtsS3aAA2ji5fWJBAiv3RR6sqdhUb35U
         NhFbc9BSdDZX5WQPZPxbmY8tyhrOxj5lOxY2kH7O5i3Slp887MYk2UAXZbKO831vkVL2
         BU+IBcLMWI15Rfy4Dmk1wTy3lnJqh13JpE94AaGWaS0HyygrsLLTpH2WsKeYdhFLCNuL
         AsTtlUnf0xU8XBL9wyaYNLAxnhscDulUq1kaKe6t3OdIuQ3FN2agf61yIb1lCwfS55OD
         nPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZeHJob2v/K/CaMbyyAWcKJg79Pbk2BJVjHV0z+90W88=;
        b=kajMr/TD1fhFDy4xir3Y5hzbxX1p/PZt29I/aMUM5TiJ83C7BFhHcQUJgH7cEFwno+
         IgKFCThKJ0czAE2mbY1LnZAHyW1A/V782vLUYaSt74xg1Wg0r1KhD6KxBnxOlAn18ON2
         z/a5D2ErSSLYWN2ncKaKSoP4jwJB2QnEVd06OsyFq2VDsrP6niWYQe4Pm8rCm9tOrocq
         f6f7S43w2mX8MYyBIurrvFqNAOP/j/SNWaYv0w89AKG8WvhLMhvsksHzZqfHymkVNaw3
         OMoQ0EO8nWlc7CohgeEEjdTXeWCiJISW0dK0yhEkseSKa6apYZGlXaDUtO/A4AgVlyb7
         4GyA==
X-Gm-Message-State: AOAM530zg/TznUOAl0nwvyqJUw4xgUkHRLEkogZGpPOWuSucJENgXqWy
        CGQo9SlgNgflEVjwlUonrW1+UlNzfdc=
X-Google-Smtp-Source: ABdhPJyYCI8e9Fk+PhwRSOIztpbdqLiUeyuSef8CcdwTahd9XaEWvsGbxrngaMYYo+9iKVTZOJIPvQ==
X-Received: by 2002:adf:f144:: with SMTP id y4mr13901438wro.408.1617345926043;
        Thu, 01 Apr 2021 23:45:26 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id m17sm13627131wrx.92.2021.04.01.23.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 23:45:25 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 0/3] arm64: dts: meson: add support for MeCool KII-Pro/KIII-Pro
Date:   Fri,  2 Apr 2021 06:45:18 +0000
Message-Id: <20210402064521.30579-1-christianshewitt@gmail.com>
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

Changes since v1:

- Rebased on khilman/v5.13/dt64
- Add ack on bindings from Rob
- Add reviewed-by(s) from Neil

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

