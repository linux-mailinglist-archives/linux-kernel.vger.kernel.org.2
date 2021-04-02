Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C6F3526AF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 08:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbhDBGpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 02:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhDBGp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 02:45:29 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A34C061788;
        Thu,  1 Apr 2021 23:45:29 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so3887396wml.2;
        Thu, 01 Apr 2021 23:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N0OketV9lb8GEiKVSoEqWRXm1t5uGV+3SZ74BaVyuOE=;
        b=N63iAdEwZoQIdZmDHBbgVXlEl6PYhcURO8sOiQoljSSy37iwlEGlCRr38aQ3bulRrf
         wARegn4Uh7Rd7kvYUJbzbQKZwTqR9vIR3AfJMbMbIwOZpjSmgTamtmcGn228QQVlCYX6
         44Hy+Uh/SVXW0jh82Gy31H69niFyRdgeIZpxtPFzOw8ku8tJ5YIfMV2YyDsy+DwgiOS1
         atl6r5S2fGuS3jQ4Ye5gvPlVyrKC4cUh6GTkBIMk3MrFgrVDMHf5s3rjFx4FmxXwfGiE
         d+CBbzjFyOz81IMzp/+ihv+qJi+gRXPF1CLzCxz6Zb5xEMkxdf1mjup0KKQgAf0P2Gl5
         3mCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N0OketV9lb8GEiKVSoEqWRXm1t5uGV+3SZ74BaVyuOE=;
        b=Leutu5Vb0ASmi+vLY62l2EipRJ295CmzPJKksBm4ELEUb9MjRywDb0d1X7l25kuTfS
         v7jnZuljtjm0f3vCE49FoHBxNnM3TmZpPRREo5ZkJk9IZHDjCxFTHEHkheu5+LLZx/70
         SBn/8tiSDBOkJW7du+BpSbH1Z64+tM/i1FHsaoz4+3IVlLyAamHO1/8I9APBC5v4g6mu
         uAcpwlGHfTQvIJAE7DwLsweUansHFFF0uONTjMbf9OIGZkyuSgywWjd3yPSqvd7az+Se
         Pm7aVi+LLUxh5MWLiNN7VRGXUTzbtw/DeeR9uKbDOFbkeuxfP3jNP/WumOZ6E/1EdL1j
         vd8g==
X-Gm-Message-State: AOAM530crvM22cumJdFrsAI38F5PAf5I3AiaPoi+C561gBWINFE5QHBv
        4bsJ/zM0cgJkoJi2JgzruFA=
X-Google-Smtp-Source: ABdhPJxNhe/ynQ6DvF5atWT5o4I/4nm1EDQkMGphRyJm0p0wLeQd4oscty3feI1aTtGJQrDbiDNb0A==
X-Received: by 2002:a7b:c7c6:: with SMTP id z6mr11159207wmk.156.1617345927841;
        Thu, 01 Apr 2021 23:45:27 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id m17sm13627131wrx.92.2021.04.01.23.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 23:45:27 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 1/3] dt-bindings: arm: amlogic: add MeCool KII/KIII Pro bindings
Date:   Fri,  2 Apr 2021 06:45:19 +0000
Message-Id: <20210402064521.30579-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210402064521.30579-1-christianshewitt@gmail.com>
References: <20210402064521.30579-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the board bindings for the MeCool (Videostrong Technology Co., Ltd)
KII-Pro (S905D) and KIII-Pro (S912) devices.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index d24334e1e166..97fb96266344 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -109,6 +109,7 @@ properties:
               - libretech,aml-s905d-pc
               - phicomm,n1
               - smartlabs,sml5442tw
+              - videostrong,gxl-kii-pro
           - const: amlogic,s905d
           - const: amlogic,meson-gxl
 
@@ -123,6 +124,7 @@ properties:
               - minix,neo-u9h
               - nexbox,a1
               - tronsmart,vega-s96
+              - videostrong,gxm-kiii-pro
               - wetek,core2
           - const: amlogic,s912
           - const: amlogic,meson-gxm
-- 
2.17.1

