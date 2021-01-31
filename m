Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65773309AC3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 06:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhAaF5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 00:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhAaFyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 00:54:11 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D621EC0613D6;
        Sat, 30 Jan 2021 21:54:13 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id f16so9885957wmq.5;
        Sat, 30 Jan 2021 21:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QAsVvG9i6Xg0y3Z1EJ3mhfNvPnvT0DDgRmi3UPHJgto=;
        b=ECjYqOsB+yrIwbGLgOp+Kcyz4GS7vXGyNHkTT0dl3f0kyBGEAVK3Z1bJ2ZGAXrIYm3
         fLcO7VP4mLQAzpBwOADr0LbD1XZwWgY1wdf0xHAp9xUR9WIiQtYRnyvarHWgPgYg2WRc
         8g7zxHJDP/ZN07rH3Pas+51uA5dEuFiPVISukJKzXFYj4Lo20mOW9OMDTvXLrmpZRzQ5
         QAE4TPOddEFyWJUYCuaQKcMMxpq3P4qjhWe+Wz+tMpl1jQjpqrESKtgRqBPAQLd29hun
         xlCCcj0L3nkySy0f+UzvW2z+M8R1bE+m1YRRwtOdmt36hCYOTL/qVa/i54qntWO2wI7F
         Kx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QAsVvG9i6Xg0y3Z1EJ3mhfNvPnvT0DDgRmi3UPHJgto=;
        b=Oe17igibXjdfCUNOa6goLLVZ04cE+GHGtBJ6f1P+IORANlCJ6CagrKfbY4btHdAsVd
         TLGNKeNwdauEmFcT/mk9X2Crq5dolMIehLwTWpP8TK1rKZaAbdPsrhszLXHJOAsBFL8S
         KC0ThWgArhSO1qbVLC4QVYgizl/j/8/PMKJUZy7uBuzQ11Wgix1ecvVgJ8L3EY57uj1n
         QlWazgmQWNRZ4y/GPmzsXdYrm5IzXGxU3hf27C8W8z47R0Xv3slrJxM1r1yGAnmZnOI4
         NIDXheMpc36Fq4O4moCpufE7eOoyGodPy96Buslmx3CE9P6DQQb9d0EJL4WPssW0UYxG
         UtUA==
X-Gm-Message-State: AOAM532o15Gg7rM+mytfXH2THkpU/wgsW8Q5/KsAYzOWNBfQyae512uN
        aSeoBrfVgJeRgToZpaMNfWI=
X-Google-Smtp-Source: ABdhPJwWXbPh9fkyuGb93DRW28LPJu935ZFMYZYyUs6colIcWMqtGClGI1egUBBOQ+8/GL2wV0Gn8Q==
X-Received: by 2002:a7b:c355:: with SMTP id l21mr10148876wmj.61.1612072452678;
        Sat, 30 Jan 2021 21:54:12 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id c9sm20056589wrw.76.2021.01.30.21.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 21:54:12 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Dongjin Kim <tobetter@gmail.com>
Subject: [PATCH v2 4/5] dt-bindings: arm: amlogic: add ODROID-HC4 bindings
Date:   Sun, 31 Jan 2021 05:53:57 +0000
Message-Id: <20210131055358.21293-5-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210131055358.21293-1-christianshewitt@gmail.com>
References: <20210131055358.21293-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the board bindings for the ODROID-HC4 device.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index b21ba8ba23dd..5f6769bf45bd 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -165,6 +165,7 @@ properties:
         items:
           - enum:
               - hardkernel,odroid-c4
+              - hardkernel,odroid-hc4
               - khadas,vim3l
               - seirobotics,sei610
           - const: amlogic,sm1
-- 
2.17.1

