Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B9B32BBA1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239265AbhCCMqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842518AbhCCIGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:06:16 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE14C061221;
        Wed,  3 Mar 2021 00:05:35 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id i14so3655379pjz.4;
        Wed, 03 Mar 2021 00:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OpNip1o55xuc4+Ky8l8FusR3lVTvYhTkKkWI9EvaqAw=;
        b=T+sKaAaljryNd3jnFXNHELdiJqxLNqxDaQQvAEtlig9sXHZ/av4Gw2YH0J35N+O/uO
         1IrdMH2vw1ON6C3TrqIFKvoViUd6WSiBlI0hMqr2rCnbXOmRvhyuq6u0rXIwW560sAv+
         arGPYVBlF5LTHfz4RrfJRHQjmSvfHXFxfZumPRaDxvabNGMQ4xuEbxdRmIRLHi2M8k5L
         8+f7wa0Ne6XhaBnktqzRMnU2HrnE59fIlzgP/DRUmcLZ4DA7RZqhuv900IWu+oAMGM4q
         CxDxGENFfNhD71kRBOZV+SA7tivL/ufHhHDs5mezWlIN3YB05ltZufcxS1TAiJcp7ElY
         09fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OpNip1o55xuc4+Ky8l8FusR3lVTvYhTkKkWI9EvaqAw=;
        b=IToLe2WRz+EJfk+ozIzXcJDeLiQ9E8AKVyZ8T0EH1Arx9k+LMoCKdeUhLbr7AbA+WZ
         5g4TTfhWrz+NTJykcVd57/s+vkSykiwgnfcGJw0uBiHyd1K/vWQ77TpUpdHy8LcMm0xW
         4w9g/0O+C6IzZv+R1Mn+rLVdB6Hor6TU+YdtUPdrsDBXZ+W9YlZfwwotRoEQU/fj2eg3
         Ku489uksN/55aGwqjm+tNfP0ibUfufN1DVM6miLBWc0UAWtmTB/ybEg6S2oKoy654XU6
         wy1Nip75Y3/tTl0qG0FU3Vie+PPMEcHYbHQX4ZI/PGWZW1Gy4Wr81TUFgAU+4DTnogm0
         6aeg==
X-Gm-Message-State: AOAM530cMuS+AEwXpmUvPbntH46N6Csr3EyL5/S2mzsfm51UF2hzKk6x
        lfYVoJACviuKZIYvdP9kLag=
X-Google-Smtp-Source: ABdhPJz5uYU1qMhU1ENUTLOyBKzlItHVFfCY9cebR94CVCa8qO3wdMQLchWHBv0tC8Q6k+fHx2ACww==
X-Received: by 2002:a17:90a:4f85:: with SMTP id q5mr8681244pjh.215.1614758734958;
        Wed, 03 Mar 2021 00:05:34 -0800 (PST)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id h6sm22260887pfv.84.2021.03.03.00.05.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Mar 2021 00:05:34 -0800 (PST)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH 4/8] dt-bindings: pinctrl: stm32: Add stm32h750 pinctrl
Date:   Wed,  3 Mar 2021 16:05:13 +0800
Message-Id: <1614758717-18223-5-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
References: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
index 72877544ca78..59f33cbe8f48 100644
--- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
@@ -24,6 +24,7 @@ properties:
       - st,stm32f746-pinctrl
       - st,stm32f769-pinctrl
       - st,stm32h743-pinctrl
+      - st,stm32h750-pinctrl
       - st,stm32mp157-pinctrl
       - st,stm32mp157-z-pinctrl
 
-- 
2.7.4

