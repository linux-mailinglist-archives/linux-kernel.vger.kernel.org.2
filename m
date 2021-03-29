Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E54134D445
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhC2PsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 11:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhC2PsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:48:00 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A8DC061574;
        Mon, 29 Mar 2021 08:48:00 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so6915391wmj.2;
        Mon, 29 Mar 2021 08:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PUSTRl8mQTF4xVmOy5MvVS/tUAWi6N4QqKrYUsHXAcQ=;
        b=SwYNslT4lMw6mV5mSelCU6WjkKcYLUK2yVIAz2XyPDx7xqKwefVqlNBXbQbaWMz+RM
         2+nCHRPQijlGzdzBz8GWpP/CtT3qkstHNFo3PHTqm92f6KR0n2FJ7QFPKqmqXVhtbyaI
         v5FCym8CaNgUEpUC1MF02zzCiBUZWbBcvnLsN2+TdUzOJ8lpd2k66zG/2za8Pet9xkCm
         xYyO3PFTUn1fllellqIsyvzJITFbUBd5qkf1TfZG6j4xBpR/6Ot+DytAGFgxBKUuI2R2
         Zn/VEbseS/gRMo956nlWJzk8OTmHKa98Ri8rGk9p0EQd1ESYKG4bVbZOEmuAM+CQxFlQ
         UNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PUSTRl8mQTF4xVmOy5MvVS/tUAWi6N4QqKrYUsHXAcQ=;
        b=J6J6A9kvXybjIbZ3ySlrMRXtiNSeZ7l9NB1wa2mCiHX3m4I1541/uL15vS44Y9IE5M
         dMnpPiY/BA1Xdtf9r4BhJaEoyAcLz7OoiwgjrL8b+OuNymK49ORwuabg6mZAgUinF7EM
         +PRFE7IdP0sjKOrM85XW7w73zv071/i/NDOgUmxP4Wmoo1shw+y/ayy8lNqwvhJG75/3
         8dT0TrcMMNyyefSLFU+Fe8ly1jZK1ZMvLIxvxB76adVZ982o/nmmgnywRY9quzj6bipG
         huwEB2U4f1YUF02EqOfK/bEWO4T/kAJm73zBnKVt649DzlBdhgka8wI5zYS5UJ4UGcKx
         35TA==
X-Gm-Message-State: AOAM533QcoFIaF5V0aj95DYnSShbqpPpBd46FVF+K8emBYN/iHLymjxP
        SDADLmPM2ocxHi2V/doVds0=
X-Google-Smtp-Source: ABdhPJylCNRMxIPd1v/0cuu0IT7zY7iPYYqsbP6tfLVsvlgWvSTUjOR45j04hdnISf2uAJbuyZdWnw==
X-Received: by 2002:a1c:ac02:: with SMTP id v2mr25472774wme.111.1617032879404;
        Mon, 29 Mar 2021 08:47:59 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id b131sm24987323wmb.34.2021.03.29.08.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 08:47:59 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Drazen Spio <drazsp@gmail.com>
Subject: [PATCH 1/3] dt-bindings: arm: amlogic: add MeCool KII/KIII Pro bindings
Date:   Mon, 29 Mar 2021 15:47:51 +0000
Message-Id: <20210329154753.30074-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329154753.30074-1-christianshewitt@gmail.com>
References: <20210329154753.30074-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the board bindings for the MeCool (Videostrong Technology Co., Ltd)
KII-Pro (S905D) and KIII-Pro (S912) devices.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
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

