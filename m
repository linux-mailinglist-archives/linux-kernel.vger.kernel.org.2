Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2372E308610
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 07:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhA2Gwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 01:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbhA2Gw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 01:52:26 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCCBC06174A;
        Thu, 28 Jan 2021 22:51:46 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q7so7693222wre.13;
        Thu, 28 Jan 2021 22:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=slrEcS4a9ViM3/EhojYQnDYLHNridO9O3Av2lfzzgZk=;
        b=MWqBJ4L8ME/baSgjmqjvV2y7ks1cjglqfwf3iP3eOEuCR+kBuOBSR3PthXYZD5Nrev
         34wvNGLlza4nocai6q26PNT1Tu759jrYdmuVprLow5Cjg/UFwuSc3SOmDDb3KZY1efS+
         Ex9KOi4v62ZWkE6XFYEuWDDwnJHqxNwTUiNcbNEn+B/9Xn8sYSCbp12fREPsNu593FE0
         z28Zyt/RJqHLFZJ0BZyrAYP0WPTe2T3mteE+5mUFalMh4wGBkNAsIkW0TNnWWJOWNccg
         z1PS+wMTjzI7W9ygpAjK1xSOzXv7dy+vHd/wahduCm+Ke2TmJPbZtBCKnBT2zHi7mlHH
         gM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=slrEcS4a9ViM3/EhojYQnDYLHNridO9O3Av2lfzzgZk=;
        b=nneFC1rbakkjfdQrAUvc4z7ASbAt0r8bJ8eE2lJwGwjHAuF21S3BAfBKwMW4LT2YHk
         XCiUAoQYqmLMlq5JzDE8a7iZLGDxOuoggPI8ZRgvtNPRJLskuAMuM6xVCMkb14gbeFJ3
         bsyZsoEf/a/nt5VqSZh2lxeI2SFrfC3D08be+Cc+s/6FfZ5T1M1XWu7+04sfv7/YoSXv
         9bfa4zFNZKQvPibtdjgn0EL8Bp3OGORPD98yxvMLodMxm0JDmdsyNxAZ39zHhBnvD5Wr
         0BzbnlGgeD3BVv0fctZZP1XJN88fnxAsgSU7O8rY4jksE8FFxJzuqjkOiFQA4kA6JwnN
         4Jyg==
X-Gm-Message-State: AOAM533bjfsCkmaUJ3vKniRdZBkUcxlt+0bXzz0bOCbu19zDqI5rcJAN
        UCmMYje5iOkDVsEIEXdY6O0=
X-Google-Smtp-Source: ABdhPJwkqX6JTwQ/Vh7ywI/tR4QczyXk9/dyQD1TALk/eWfPvmSPu75LpDOtsf3f2QN0XetHz7z/jg==
X-Received: by 2002:a5d:6691:: with SMTP id l17mr2783563wru.372.1611903104739;
        Thu, 28 Jan 2021 22:51:44 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id b7sm11501236wrs.50.2021.01.28.22.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 22:51:44 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Dongjin Kim <tobetter@gmail.com>
Subject: [PATCH 1/5] dt-bindings: arm: amlogic: sort SM1 bindings
Date:   Fri, 29 Jan 2021 06:51:33 +0000
Message-Id: <20210129065137.5473-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210129065137.5473-1-christianshewitt@gmail.com>
References: <20210129065137.5473-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort the bindings before adding new SM1 devices.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
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

