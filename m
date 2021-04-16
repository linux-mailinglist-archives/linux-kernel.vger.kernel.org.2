Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8A3361EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 13:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242895AbhDPLml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 07:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbhDPLmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 07:42:40 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568C2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 04:42:14 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so14023561wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 04:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=RqeDHYhlAcvllDP4xVqPrU3oml8HMb6czu+VQ+dnWvM=;
        b=UZZbl3Qst23Soe4om5Xy9cfTwnoMrsqVtoEwQPanhP7Unyrc9ez+ISj/O7Dx431CpS
         5ZtiTKa1VI0fqfQ29cR5zgs2ZCn1VqeO5/La0LLA+T9ZQWu/0Ti4rRszzDU6dqQsNa2w
         Ns+LqYbdCuiQ1uY/YyvN8r7JifkHeWf6qD8hQ+BAXnCiEm/raKPks9+YT92Bkd9fg+OU
         3iqnSao0Jxk3oVgq/ohI7DWI42UsunQxzcwu5jYPCVeALXNgw03oa0G3FxT7Vig1bnYg
         H4sL1Ys0TseQQVK8I84FCUdldxXQgpIgAfN43KrDrK3WfHFfE5VRdrrhXy8q5XuKo9MQ
         IbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RqeDHYhlAcvllDP4xVqPrU3oml8HMb6czu+VQ+dnWvM=;
        b=K0JQUE2/8+Pu0A7lZCi9VoQVxAqQ0UGCNFXqWEf3RBQLFHwjOd49o4fx/Hj677DqzX
         rdtOrLCz0SzCqdSHP34SlreCnIfClvHDR7XdyjBml/tbnQmp045au3ioh8Rqj3uZAgwQ
         7ehQlcl+Iw88wmTEAqWd5HfgXisYDD4/nXGac6GaHr5OVkBjMvuRZI7go+AiBIliWTnn
         MbOljtWBAZDagnQAE8+cGWZb+Uya7MyZ+gublhh2bHlsqeU4lEAcV2dWL90mTuaHeuLK
         yqLMAHsln/q1mW8ZmGJdtFJqTIPTGTR5lymlc2ttAtH2xvrr2A5lTBviTmjXpPdMfD0P
         7cGA==
X-Gm-Message-State: AOAM531yTgg9Rx4f7gXe5/7mBQiqlXv5havs9oHPP9FZROp3/ahPDenV
        30qK68Y2zEACRjgS/hvNNdoMHw==
X-Google-Smtp-Source: ABdhPJwvYouxivuSp3FlW9k1rcnDL/5eaF9iyAcew57Gw1z/fayEP0oopjyFa+wCxafAdtMC4Hn3vg==
X-Received: by 2002:a1c:9d85:: with SMTP id g127mr7692902wme.62.1618573333104;
        Fri, 16 Apr 2021 04:42:13 -0700 (PDT)
Received: from localhost.localdomain ([163.172.76.58])
        by smtp.googlemail.com with ESMTPSA id b22sm7421934wmj.39.2021.04.16.04.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 04:42:12 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] MAINTAINERS: gemini: add missing dts pattern
Date:   Fri, 16 Apr 2021 11:42:05 +0000
Message-Id: <20210416114205.16469-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MAINTAINERS entry for cortina/gemini miss all dts of this platform.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f64a75945b06..927fa29f05ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1816,6 +1816,7 @@ F:	Documentation/devicetree/bindings/arm/gemini.txt
 F:	Documentation/devicetree/bindings/net/cortina,gemini-ethernet.txt
 F:	Documentation/devicetree/bindings/pinctrl/cortina,gemini-pinctrl.txt
 F:	Documentation/devicetree/bindings/rtc/faraday,ftrtc010.txt
+F:	arch/arm/boot/dts/gemini*
 F:	arch/arm/mach-gemini/
 F:	drivers/net/ethernet/cortina/
 F:	drivers/pinctrl/pinctrl-gemini.c
-- 
2.26.3

