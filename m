Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608FC309AC7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 07:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhAaF5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 00:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhAaFyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 00:54:07 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4327AC061574;
        Sat, 30 Jan 2021 21:54:09 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id 7so13044327wrz.0;
        Sat, 30 Jan 2021 21:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9xOUKO2XKFLeSm4wVIMXSdkTxiy8OHddK5mDTptdxKU=;
        b=dxkzYiMp801McdHLu1MsonH5EYX8KzHXFk7auYDDT+ryDywmt3errJ9f5axkprzfTf
         Z1uu03yij64OMAYtYqjAAiuKzxPdR3XuTrUi3f7kCJB1/XgM2LpyknsllkWx6i8P1nx1
         4OSqKDLTG2QFaT8KMQOAIU60cctFtqQij+N3SJ38BI47xcjqCSOBHrBKb5jSQBsTesdh
         5TrU/PfnbdhhfRQEDn+1w9fIa32mx6F0WBWCYwmcrCJn4PzGOZBaTuNk5sCqEThCqkgv
         aeG7qMTuXfRe5N9H3m0wcCLF3NDbT4ubBbGCw8+QJII2PVuiR3RL5XXLmOAH1MSfNpei
         K3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9xOUKO2XKFLeSm4wVIMXSdkTxiy8OHddK5mDTptdxKU=;
        b=GQg/S3u/Af6AfljWX22e7CsujC8ChO23peNWzMOwCKBS0rXAs2fhxzvvPY5bEWk7x1
         cJG/EMrHXyZc785c2AGn0QSXGUFIz7d297CejvDnXn4m+DaMpZ4LHufqxZkYUa6c7Vsj
         djLQNanuqr6OlKs26Uzt79JxGRRqtdKIAvHo7zhf10MY1x/4EzO26PLcGqIPk1EU60da
         Xw2435PIKdaur1URmLzIqQHAynhD9p09VkakZi3XMRRFgulEzl3NZWm2KbeSQ94CYJ+A
         EaxfUbNjCUtLf3RQPrcjMgzIjE74RK8VUnGmUJ9ofe+T8tu86dp+miqWoEOf5OYO2qRR
         JI+A==
X-Gm-Message-State: AOAM531Bj0Ubrbo0noY08Vab2YuoJ9tby5aYlAIXnZy4R41LrbntwfFi
        JztwlF5opPOvpVIa3A0b/D4=
X-Google-Smtp-Source: ABdhPJxBWJvaAvprZz1rIkpOu+w3hZTIBWB0/Z5CmPM0I/Zm/D/fCvZV+rEBQsXq8eEd3Wo2nKcE+Q==
X-Received: by 2002:a5d:52c5:: with SMTP id r5mr12023981wrv.208.1612072445883;
        Sat, 30 Jan 2021 21:54:05 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id c9sm20056589wrw.76.2021.01.30.21.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 21:54:05 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Dongjin Kim <tobetter@gmail.com>
Subject: [PATCH v2 1/5] dt-bindings: arm: amlogic: sort SM1 bindings
Date:   Sun, 31 Jan 2021 05:53:54 +0000
Message-Id: <20210131055358.21293-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210131055358.21293-1-christianshewitt@gmail.com>
References: <20210131055358.21293-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort the bindings before adding new SM1 devices.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 6bef60ddda64..b21ba8ba23dd 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -164,9 +164,9 @@ properties:
       - description: Boards with the Amlogic Meson SM1 S905X3/D3/Y3 SoC
         items:
           - enum:
-              - seirobotics,sei610
-              - khadas,vim3l
               - hardkernel,odroid-c4
+              - khadas,vim3l
+              - seirobotics,sei610
           - const: amlogic,sm1
 
       - description: Boards with the Amlogic Meson A1 A113L SoC
-- 
2.17.1

