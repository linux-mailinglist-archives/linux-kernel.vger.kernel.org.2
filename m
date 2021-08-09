Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A953E4636
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 15:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbhHINLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 09:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbhHINLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 09:11:15 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DACEC0613D3;
        Mon,  9 Aug 2021 06:10:55 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n11so10575487wmd.2;
        Mon, 09 Aug 2021 06:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ail8+T+/FwVUA7gWn+lZm4pSQKQ3OOV0PrkoWmQeTKk=;
        b=Yk74tAmK+MQaHIVZnM/rt+4N+/EaJRfFMGegydONTpq/lpH97+J2kbgpeg+zIl8uZN
         6QGOiwVXKDS3k1JmIE3wlp/aUiIVdIz7CgWn2ccHUaKpa6hdIZySGw/MM5zCzUlB8omR
         /bPx6GAHWmGF6auTeeQYppAlkioJ0lK4lXM5l4E/iImIRW2NjiwfquvPbGNVZrbEV4N6
         AAVG5tsU6+ZTSugSUSl8hf4/7uvl7hAuuQaZUVm5RFw97/TAwmXuq0Vaul0QtlvhKJk0
         i6M5e4mbjTJ+D6XCeR8qQudruXlWXVHUayluY5U7HevFbbgn0/80DtPQSjt0B92OVvl4
         zWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ail8+T+/FwVUA7gWn+lZm4pSQKQ3OOV0PrkoWmQeTKk=;
        b=pCX9NTGhBxK23A1Xwo5vyluVWx5CxQW0jSolexwlQ3up8sl6MxBYRPgHfjETwmKw09
         BmvBvDsRCj/cHi0aKHgOZbknl6xy6y9yqfI8EbHnsGDIz3GKXNaHG44TaoVZeH8U3gKw
         wOaCddXcDfiGgPJHu4LvZJvv1kCWp7cEHtvE8kGTAeGlmuitsixLAYw30HseQJXDdpBd
         dLjAeTi1+buOvuo5ySP1oCFR9IdYX9KKyU8nTCATHt1f7Q9xZTnnYf+9I3sz0T0e5Xb8
         OCgADKgDyPpUq6YAhX1w19Md5kg9uZHqWqieMj1UQj/XynFl+nknHbL8/XqRmnwnvIeK
         JQjQ==
X-Gm-Message-State: AOAM531UXXDeS4mduasdHFGUbMliW70ql3niwUOQ5zb6X5UF80pJODbb
        jaylFXNHvBpHZKYAkLsyitY=
X-Google-Smtp-Source: ABdhPJw/6i5Fh/BkV/Aca+Dj51H7NmI6IoVGRRNCoafm/uOoZjOmpTfzPSDQFaMKh8LfMLoiipY05Q==
X-Received: by 2002:a1c:6245:: with SMTP id w66mr33640271wmb.143.1628514653724;
        Mon, 09 Aug 2021 06:10:53 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id k12sm5276094wrd.75.2021.08.09.06.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 06:10:53 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 1/2] dt-bindings: arm: amlogic: add support for Radxa Zero
Date:   Mon,  9 Aug 2021 13:10:46 +0000
Message-Id: <20210809131047.28047-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210809131047.28047-1-christianshewitt@gmail.com>
References: <20210809131047.28047-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Radxa Zero is a small form-factor SBC with an Amlogic S905Y2 chip.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 6423377710ee..67dccdd9a5a4 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -141,6 +141,7 @@ properties:
           - enum:
               - amediatech,x96-max
               - amlogic,u200
+              - radxa,zero
               - seirobotics,sei510
           - const: amlogic,g12a
 
-- 
2.17.1

