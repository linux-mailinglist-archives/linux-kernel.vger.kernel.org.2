Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6211E3F5B79
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 11:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbhHXJ6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 05:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbhHXJ52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 05:57:28 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76FAC061757;
        Tue, 24 Aug 2021 02:56:44 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id n11so1564440edv.11;
        Tue, 24 Aug 2021 02:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZHjIuwbjXpPZGfV2+SVrqgdjS+2JAKYK34q2xPh0xA=;
        b=OCSo8cTz5kPszOIvYXG7Mtg2XJ1KtNM7nfb3KCxWGsEm11UxovUvk4/f4Qhu7Vtuuw
         5rhr/nk9+6OrhTFyAQOnJLXk0oqP9Nkl5a1Erv26U6vYAuZY+uN0yMD+B6IwTgdAMb6y
         tQJN1ScA69w3BgwBzlBW9T0/7GiALm2yzYbgqzIf/zNRbxWpOBVTmwr6pL+vi12Lz4lV
         G8JfGzY+28fz4UzNzoqeUeqXeiRjVj/OLU3W3vS1KoPGZ7xCqFC3EBnzK7d5tHVdq2jK
         zMAvtP7LTqgMD0RzJ0r0f13w5sT3EzzaAljvK6MMLfYrslzitT4B8ZGNSYeEoC/Te9kw
         K1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZHjIuwbjXpPZGfV2+SVrqgdjS+2JAKYK34q2xPh0xA=;
        b=QcqZUdmhXeXYtHb4HQ8slU6xjunUDosgVk6MZq1anvIDYVx+exXqFwTcHUzqsrsxG4
         gFzGnRR9htNraAwoj8FsI49Q0VLVuc5guL8+xA7cUe0qacFfcZOg3BxUZjQSR2XIUDPe
         nGwoFsKKW4kvy3ZYJzNKKgimiaQ8xQIFGFeTg0e+WuqHsSC9NfByV+cpsIbwstPyxGXq
         UnmMSJj0ohKoCzjTHQNt2htY2PYKJ5XG+947JgxEoB12EajRqrnqB7xbyEAkEcXlygJv
         xghYFI9Va6leY0k49An/Fm5hxz00t1WKrdmdPfvGN0wTNtl7d5QG2O1JepUc5YZTGbSJ
         cXsw==
X-Gm-Message-State: AOAM532DKiMCSbqIFSHhwNKO0t0psfIGifasoT6G0WaQXX0GUmszYCOj
        L0+fBbL6Xvqbw4FcvprYbiw=
X-Google-Smtp-Source: ABdhPJyRfq9VETKCteTsYN0ZD/x7BGT+N4SffLf3FhsdSt/ExfCu5fEo/8NZupdgJ7twVTTfLy27+Q==
X-Received: by 2002:a05:6402:3589:: with SMTP id y9mr42483656edc.247.1629799003531;
        Tue, 24 Aug 2021 02:56:43 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id ne22sm7832761ejc.113.2021.08.24.02.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 02:56:42 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: timer: remove rockchip,rk3066-timer compatible string from rockchip,rk-timer.yaml
Date:   Tue, 24 Aug 2021 11:56:37 +0200
Message-Id: <20210824095637.2547-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rockchip rk3066 timers have a different register layout then rk3288
with only a 32 vs 64 bits timer channel. The timers in rk3066a.dtsi have
"snps,dw-apb-timer" as compatible string, so remove the
"rockchip,rk3066-timer" from rockchip,rk-timer.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
index e26ecb589..5d157d87d 100644
--- a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
@@ -18,7 +18,6 @@ properties:
           - enum:
               - rockchip,rv1108-timer
               - rockchip,rk3036-timer
-              - rockchip,rk3066-timer
               - rockchip,rk3188-timer
               - rockchip,rk3228-timer
               - rockchip,rk3229-timer
-- 
2.20.1

