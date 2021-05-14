Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B03380BE3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 16:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbhENOeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 10:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbhENOeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 10:34:17 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D273FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 07:33:05 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r12so4637908wrp.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 07:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PjPVZHKFcw/0Kjl3neOnoz2ErhwMmf8NtZZOxTpdu8s=;
        b=N8n7j1UMrkltISPqNfNmaFCoGnD9mDpbzYFFiz5DukTU/MJT58wTxlhpFn/yRIWYni
         bPp/d/LpIoY0IyKync8lVLytAsFXRXOxTkRL/xyN1JVTdYS3+lOQUkY99TeXMkBgNs1T
         /oHMknBIPnCNFlJcTvwmGLr9aX4AOq4wj+YQjQO8ABcAH5/SZ2xfFD0T8kwOGj4XUYpQ
         +BrA4Ju1g9aH2nRpjw7lRXhMmBMToRw5umI3wUdNpdwNJm/4Ysotkxxb5q3kng+VDeOS
         GjI/7H+m8BBrKysHtKJ3xZtCACLo9QtvDs0V5W5mb/XJh/gpkFqxVh1OLV/qlqVgWPSs
         k9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PjPVZHKFcw/0Kjl3neOnoz2ErhwMmf8NtZZOxTpdu8s=;
        b=tPsxm0h/qkpOr21RX5xAUGAjvxCbNcYEEuak9BT74QSgWOdfLf8L79d1EoxJ81iOpB
         FGl+PJWY0TllKsdCB8Q8D1l0PZdlJYf5p8rKbHO1mCn1HxF70AtpimHbOgl2x2wmumBK
         R2WWXt0HzvamODox6MeAxPEWdumtm0zPeUIV3o3VifBBXK6XNXkjSrVF9AMFY250Tgyv
         e7xcdyeKfmV6aVgvFqmi3Eyc7HdI5UClBqBHUvUkFwWGn8GwOe78GKP1gij7PmWxKAjs
         9qYNd24IKPoNlITcMXAf/mso2aFJ6NEf8y/chv3JLiIrrWelbTJuMvE9iSC8+nLnUDed
         AduQ==
X-Gm-Message-State: AOAM532EPyUv8sdskcYPHteHFYJBIkIDudZcHigEAQ4Zr6/WMw9b8l4C
        4lpAHtBJl3UUhmw37x+lMfwKuw==
X-Google-Smtp-Source: ABdhPJy6/TGdhjA/Zzgm3KU8lGiHXBECPm8RKOoEQKk1k3ayM673dArxL41P+kY3aOPDuAv6Kczftg==
X-Received: by 2002:adf:bbc2:: with SMTP id z2mr7181697wrg.127.1621002784504;
        Fri, 14 May 2021 07:33:04 -0700 (PDT)
Received: from localhost.localdomain ([37.173.48.34])
        by smtp.gmail.com with ESMTPSA id v21sm11552036wml.5.2021.05.14.07.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 07:33:03 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 2/3] dt-bindings: arm: amlogic: add Banana PI M5 bindings
Date:   Fri, 14 May 2021 16:32:54 +0200
Message-Id: <20210514143255.3352774-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514143255.3352774-1-narmstrong@baylibre.com>
References: <20210514143255.3352774-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=M0SEFpzXwIE8UCHsgzNMhizzXWIk2IptqJJD3NCqC5E=; m=Tq6MXbuxaNZm9Pbg31ijl2mYxV06fIqGdbAJOoh1/EM=; p=HRqFdlzLeSnVMnr05Eko/xZxgVVTv1235RJRzqjszD0=; g=1687e36ad2573496cc1e8703824d0d5297a2226f
X-Patch-Sig: m=pgp; i=narmstrong@baylibre.com; s=0xA4CFF8AE; b=iQIzBAABCgAdFiEEPVPGJshWBf4d9CyLd9zb2sjISdEFAmCeigoACgkQd9zb2sjISdEOUhAAs7c hJRyOSKM4JJtqwrB77sPnGSeeNHqtGPUngeJYzFgcKIAcea6G5HUS0g8x2GkIrXey0CCe+XyGyR23 oBXF+I/qwT5L1hOlAc2A4UaHGvZfDbmiKklVVuriO3cR3llo4hbPTjOvO+DMxWOnmoDAIDH/O8HCM AuBrfnIyGe5B/Gnxgm6ApoRYciH2A7PMyBrAFFYikfUUTfCbviBgyzrxGckv3WqyEVhMkz9J4X8Ac CEVGIQRiE94L5SutDbxtRbshckRS4mZL/VakaglyXllkiMy+602e1ByltpI+AlTIuBIral58ZWv9U Hz6HniPoJRt30o+NIZmL9dRA6YBZJE2sgJoSgZ3r8BbNGDjYNhT/zgUOUzUZfY/25owYLimTtGmB7 TijFDcZW/wiuM6lHZ1xfmXhfZ8xkOeswSAZb0MG2Cbn0IegAng3opKoFlVMkgQyBXXr7ZDLDUzQMz DCIZZ9TWAWr23Jo1XRVccsg/tSy6+Nr6JUMkfNb6PryooDHlJm7FoXeM2U7w1w5TZ4K518Kn/63Dc ZDO0aml9vmqpfw/nP0zC8LG0wS1hsVqaFLoPamWNMUHE5IGhacE/03lNDya7EpwvXvT3ggs2Ju7+h ytHQGpWcefWgvTc4hYlpWex07xj3ad4JWK5bvfR2g/OW/ZHMDACzdl7/lavT561A=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the Banana PI M5 board.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 5f6769bf45bd..d81a20f66415 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -164,6 +164,7 @@ properties:
       - description: Boards with the Amlogic Meson SM1 S905X3/D3/Y3 SoC
         items:
           - enum:
+              - bananapi,bpi-m5
               - hardkernel,odroid-c4
               - hardkernel,odroid-hc4
               - khadas,vim3l
-- 
2.25.1

