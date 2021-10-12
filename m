Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2C9429D17
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 07:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhJLF1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 01:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbhJLF1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 01:27:33 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC4EC06161C;
        Mon, 11 Oct 2021 22:25:32 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r18so76407512edv.12;
        Mon, 11 Oct 2021 22:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xevjtM57f4KsibCMyluFkgFqyP8cUqEzryJuVyfMQ+Q=;
        b=ZacfD9y5vIXLRS06xjCB+MNrjs1HeUPLJIQcgusV98iEnmYaWYs+SV7M+5ROEBqksd
         YYcumrOdxjqpfA47lXfD25slG9nhjIWUD4wbZivJ5lpl6q1jYcJPkvkR/n7Ggp4DpGDY
         QcBoriuJQQ2QLxFOl2KlDahKsyNESeAd6ChMYTrTr6RbSJDiSyzbDwhyRAyH0pLEEDT0
         p6lnUbmYvm2uIjsaI9ADzVn6jmpVlLdbez/PnD7JlE9H72NaHd580VBZIAO4bNdBpPU4
         m94uVlb5hKXDJdU1wGce0Y0LMOP4L+gOY4PVoKvYtfEy7NFuvuSDowGYEU7QGuhIP4S4
         OTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xevjtM57f4KsibCMyluFkgFqyP8cUqEzryJuVyfMQ+Q=;
        b=487No97s2bznpSkFSvv1ioPs2tQMLPyT3b0xIgPx8bGGIwEHulxDbqWZ2vbTygBESi
         O8HnKy9i77+hQ8xFRxC5RIwRiFuUoRDgO9+Iw3eKuIzlfFY5dWgUWl6OCAKMXB+M9PO5
         dJTbG+aCTiZjHLL4BuF3YdA1DFY56kyvkWN2q3YQgP1VhYwE/lgvQgQaEDD4HSyuGTKM
         /x9guSplxAiYli+SrXk7PvHcBGYiDDo01GCoc+xjSZ9hCC339gwDC9rvM/xtIHKTIWgg
         qQSZVvcNm4DWRr5Zxb74tLlVRsE4HUfmzdM6ONwDxhX++qz9Tm87RLCg9hMbWMM7r0pZ
         MlRw==
X-Gm-Message-State: AOAM5309q9Y61K7ZCQN8/OY4Ue8dED6fAfGl7UnieNSl3qU7g3pB+zM+
        FG/v1cXG9fDvWlmoac6BNWfcU4UAsAZksQ==
X-Google-Smtp-Source: ABdhPJyjbXuo//xn+mq8mM/JHOk3C4ps2eVqud8QcsZpSFChnXGOixgzZiT/iDwXZVxybf8OSvFCag==
X-Received: by 2002:a05:6402:4256:: with SMTP id g22mr47208664edb.399.1634016330756;
        Mon, 11 Oct 2021 22:25:30 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id r22sm4323321ejd.109.2021.10.11.22.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 22:25:30 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 2/3] arm64: dts: meson-gxbb-wetek: fix missing GPIO binding
Date:   Tue, 12 Oct 2021 05:25:21 +0000
Message-Id: <20211012052522.30873-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211012052522.30873-1-christianshewitt@gmail.com>
References: <20211012052522.30873-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The absence of this binding appears to be harmless in Linux but it breaks
Ethernet support in mainline u-boot. So add the binding (which is present
in all other u-boot supported GXBB device-trees).

Fixes: fb72c03e0e32 ("ARM64: dts: meson-gxbb-wetek: add a wetek specific dtsi to cleanup hub and play2")

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
index 8e2af986ceba..a4d34398da35 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include "meson-gxbb.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	aliases {
-- 
2.17.1

