Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CD0314098
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbhBHUgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbhBHTRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:17:53 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A340C06178A;
        Mon,  8 Feb 2021 11:17:13 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id y15so13816443ilj.11;
        Mon, 08 Feb 2021 11:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JeycJMVrT1Dsbk9XtCwjyUvDzF/dcIodjFIrjeRF9Uw=;
        b=j5xqL69DpZ9yPEm4gQOwSpBh2g5smaE9P2MPnP62rEWZEHts61LsIe6SFn3sG3qtfs
         PSaANvdV5epXdO7HiH01tzIBK7qJDojZ3UmYVCYcmsV5HFyM31F5KHSy1xmL2qCMF84T
         W+lb2Sx28TQ48v9om0X9Ik3YO+2/XB9FojBHit1x2SVl4YPBXVyGdmkqyoRSzf42j3XP
         CtuiuzZ8F6YfRoa1homosSqsngcHVEldPdPHCCNV7lJdMs/avY801gGEzhkAEuybX/ib
         TGE6xVpSl4hR1ClnnfAO3DBj1TtrkS5VcNeu6UhlVmrMo5YWf9DaqiqUrCUzSL/CDDDj
         Ge0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JeycJMVrT1Dsbk9XtCwjyUvDzF/dcIodjFIrjeRF9Uw=;
        b=JAYo8hJF0Xlch47Q7Ka5AfiiJwZ4F4Zwby1xXHWTBF/Kll8+o0LRTIXBFDkT3CBenn
         Yg9jxRgpO9NiOx/SzigSqM6672c+8Hle49TObF7Iv5E8xjcRM+ArSqilUAOIaZZwMH7Q
         KOytLmfilye6FNd+UKc2s0uCU/Bkp609+2GUxrRt5TyDNB6WtB9Gf1LKw3hxyLcVDON0
         DkFl8ZcVfUnJChMqTUQ1k5BEYePULaCrtMd5CZ9trL+67/F+iPfs7LlZvtU03DOJbjfw
         tpN6nySwMORjZtFhOPkKL2T8vsqaSRZpPj+2U0SgqXeE7ql1niDHAk+M33Jia2IwcT0Z
         gwFQ==
X-Gm-Message-State: AOAM532vH5GB9wI4g/9sa6WTa+A7mRwE4LnpCxwVBMjr5nqweK6fJLNn
        IOXf7on9blQHg03IXe+IAAc=
X-Google-Smtp-Source: ABdhPJwd2VKq6K3S7zfgm6zF0SnaIRJ8zrSyJR3bE1Y72wItD6hLqv+XlHFG52YX4wJIR2g1SOPtWw==
X-Received: by 2002:a92:c248:: with SMTP id k8mr17387977ilo.141.1612811832591;
        Mon, 08 Feb 2021 11:17:12 -0800 (PST)
Received: from localhost.localdomain (tunnel525895-pt.tunnel.tserv15.lax1.ipv6.he.net. [2001:470:c:1200::2])
        by smtp.googlemail.com with ESMTPSA id j25sm9429645iog.27.2021.02.08.11.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 11:17:11 -0800 (PST)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Tianling Shen <cnsztl@gmail.com>,
        Emmanuel Vadot <manu@freebsd.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        David Bauer <mail@david-bauer.net>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Marty Jones <mj8263788@gmail.com>,
        Jensen Huang <jensenhuang@friendlyarm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: Add doc for FriendlyARM NanoPi R4S
Date:   Tue,  9 Feb 2021 03:16:45 +0800
Message-Id: <20210208191646.6511-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding documentation for the FriendlyARM NanoPi R4S.

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index ef4544ad6f82..b85ebf2c8d52 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -133,6 +133,7 @@ properties:
               - friendlyarm,nanopc-t4
               - friendlyarm,nanopi-m4
               - friendlyarm,nanopi-neo4
+              - friendlyarm,nanopi-r4s
           - const: rockchip,rk3399
 
       - description: GeekBuying GeekBox
-- 
2.17.1

