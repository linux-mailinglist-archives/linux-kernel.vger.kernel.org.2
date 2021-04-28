Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008FB36DDD3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 19:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241487AbhD1RFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 13:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241452AbhD1RFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 13:05:17 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85C5C06138D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 10:04:29 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y62so11539035pfg.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 10:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gt4pb5bT5mW/MToENIuo4Jt8VqUlSnyGRgKvmw6yKp0=;
        b=ZBABP32kAKUkL73RzLrs/VZTLUwl6tRRR4kreJjVivIQnqrLTx++PGkZdghCv6A51h
         i5wfgs4sj08UJWCJZAhmuB1UPJXH2+qBGrDT9VrYMuWAyEi9ipQ4WYYmOIrBtCW1JSTT
         xZT0g/d1wPha/HFRrZyfSi4R5Ae53TxzQP2kU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gt4pb5bT5mW/MToENIuo4Jt8VqUlSnyGRgKvmw6yKp0=;
        b=ZtrfJl+VsbxTbiqZZI9D3+X4A1iSzsvQk2/m9Zn+YdcvVhfMGkJ92TNOT3LibKMacj
         I7uITZw7R25iAUx+tDe2zC38WnPHOdX0W3Rmg7z6quQZjgJifZShHxmH1ZyILjnAPu0g
         OD2622HRdPtwNV8Gt6bJdhkd1Su8WoNDRYhWbnbmvo4acyy9ej+zEJvb5HcuR8Ttpabx
         DjTWzsyITSSoyNMOM/ivT+tMnJYIaF2S0euq9jKSOHdlLbZ+MFOMTlgW2P0zJXAPOU0r
         BWkqkE7Y/h/qhbvxJTywkj/FYHFFNzwGJYSH5w+cD33rlRcpPH4mdsDMGt/8GjxHPfVW
         PpOQ==
X-Gm-Message-State: AOAM532yGrLqyinIJRdDdUUdfOuu1JhefEIaXdUK/MwbIAtEalevfRFr
        UjiMiRXHI60/MSh3onSIkH5wqTOs+fRWWQ==
X-Google-Smtp-Source: ABdhPJxmrYhCyqvJ9YcpCKMIp11Js7eA8QUCI7vGyyUeKC4ER8oO8PiDoUeETkQrLQ/8pN+UBHWhJg==
X-Received: by 2002:aa7:92cb:0:b029:1f1:542f:2b2b with SMTP id k11-20020aa792cb0000b02901f1542f2b2bmr28418795pfa.31.1619629469280;
        Wed, 28 Apr 2021 10:04:29 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1faf:c32e:8742:d913])
        by smtp.gmail.com with ESMTPSA id c8sm244351pfp.160.2021.04.28.10.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 10:04:28 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v5 4/4] arm64: dts: mt8183: Add panel rotation
Date:   Thu, 29 Apr 2021 01:04:16 +0800
Message-Id: <20210428170416.1027484-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210428170416.1027484-1-hsinyi@chromium.org>
References: <20210428170416.1027484-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

krane, kakadu, and kodama boards have a default panel rotation.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index ff56bcfa3370..793cc9501337 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -263,6 +263,7 @@ panel: panel@0 {
 		avee-supply = <&ppvarp_lcd>;
 		pp1800-supply = <&pp1800_lcd>;
 		backlight = <&backlight_lcd0>;
+		rotation = <270>;
 		port {
 			panel_in: endpoint {
 				remote-endpoint = <&dsi_out>;
-- 
2.31.1.498.g6c1eba8ee3d-goog

