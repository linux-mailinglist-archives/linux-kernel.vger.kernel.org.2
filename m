Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914453EE571
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 06:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237623AbhHQESV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 00:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhHQEST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 00:18:19 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055D3C061764;
        Mon, 16 Aug 2021 21:17:47 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso4120303pjy.5;
        Mon, 16 Aug 2021 21:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WrPbB+5M+oz2QlTFFMfglVQ9FsfsETR7zFLPhL/v+Rw=;
        b=IzBlfkAauUlpDjMMtmgcL56b6rzVxn983ktKVXmYuw5WA14jv7Sz8mZ/wFC9eFLio6
         0hZIlKatszcNOgM4pGyPfzFaXs0fp34CVSWt2/eK+ZH2faDbDZdHxWQaYcUIW/eOxYVH
         ZWYdGMYMk5lvmGKGk8GVbrNfwKhDNBxGSNGNUQrnGjaEhPkOEQrY33HBAUjKvDFKx7E5
         Fuuw3Fk2yRdwQdKT60q4LRuhnT0OM09vM2/4JxFhA2m6ksE5Tk4V0aOVPdEmb1k7D9A3
         NMAt+3T7xNAA0hmmmJ+VEe+WBt22c4IYYthiV0Xc2t2XIvwKjj/KSlelK4IUkv2eJXEm
         7wZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WrPbB+5M+oz2QlTFFMfglVQ9FsfsETR7zFLPhL/v+Rw=;
        b=KMl0I0T5j94jvRZMhOeAG7ES47bAOjyMUYjPIYCKi2NkTfkXjZ0QTZ3KnlE/oxz9x2
         zycUdzG4mRwBp7/2lwsAyj4uIkWrLD3kI/Hao4PxtTbkCnUm1qOCj8B+dCAh6kmz1iSm
         x6bvl+tl1G05IDMW6nFleNK8CDSWl3bkT1xptNhwFt95D9Ngyb8Hyt21RXUv19faNw/F
         bi7q8C1yGDU/mU6h46+fIiKBzcmprZsclx4H9aPEETyDdxhrCjS22N7IlrBIywWs/HLR
         inK9CbNQI1DjPbEUT/phkZASkdFFFTiWVQRwSrSjLBbqOUJw9xKwSYyio7J4TkfnVQeY
         SAIw==
X-Gm-Message-State: AOAM531XXqgd2UQeZl7AgAMRUs+AodMSbqQn02NVgW1UeCJld3+FW6HB
        593b424kT1/IKphNDWLBPEc=
X-Google-Smtp-Source: ABdhPJwY6Z5H8ETjkybmV0OLdsKQHAgPwHpXa9txzJwJRXyWQbn3jyZ/VpzTqUkwJTiyNEcNhD5F3w==
X-Received: by 2002:a05:6a00:24c1:b0:3e2:1171:34dd with SMTP id d1-20020a056a0024c100b003e2117134ddmr1619553pfv.27.1629173866630;
        Mon, 16 Aug 2021 21:17:46 -0700 (PDT)
Received: from archl-on1.. ([103.51.72.143])
        by smtp.gmail.com with ESMTPSA id g11sm705676pfo.166.2021.08.16.21.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 21:17:46 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Matt Corallo <oc2udbzfd@mattcorallo.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        Brian Kim <brian.kim@hardkernel.com>
Subject: [PATCHv3 2/6] ARM: dts: meson8b: odroidc1: Set usb power source to always on
Date:   Tue, 17 Aug 2021 09:45:36 +0530
Message-Id: <20210817041548.1276-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817041548.1276-1-linux.amoon@gmail.com>
References: <20210817041548.1276-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set P5V0 and vcc_3v3 power source to USB to always on
so that regulator should not enter in suspend state.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
New patch in this series.
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 30ec6a7f20c7..5e5953152452 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -65,6 +65,7 @@ p5v0: regulator-p5v0 {
 		regulator-name = "P5V0";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
 	};
 
 	tflash_vdd: regulator-tflash_vdd {
@@ -136,6 +137,7 @@ vcc_3v3: regulator-vcc-3v3 {
 		regulator-name = "VCC3V3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
 		vin-supply = <&p5v0>;
 	};
 
-- 
2.32.0

