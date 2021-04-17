Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B3B362CA2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 03:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbhDQBL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 21:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhDQBLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 21:11:55 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD96C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 18:11:30 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d124so19402038pfa.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 18:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oFRDKw0dH3PiLiKz6mJo37/a7HDsMiEOCgW3zJ4ySpQ=;
        b=CI/YrdY4BoPfvyDsXCUQr0YtgGQc6ApLTyncG1WvbL5A5F7lcNkgKzLo81sUCQ4TWt
         s/k26P9BKA9G+gkJPeYNc3rQDO981jPCULKxeAWhle4cSa5LqtlFdg5GkxYx9AZsvXPJ
         xCUG6kNm+KDXKVuJYLG0YfNxTJsS9UjO7skVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oFRDKw0dH3PiLiKz6mJo37/a7HDsMiEOCgW3zJ4ySpQ=;
        b=nrMfjGzJe8B/+df99gXOWlMeqvnM12l8/XhHmAAhYMMLyoKCAC3BzI4IzhG0+3VAm6
         yFnH7AdqCaHmEulhV9z7MJEpIexenEX8d10CPw8Nhn9tUmRGENeWTEi/qjxObhNqxrBw
         l41FpmhY5n8WnictT8C2EPAYeFIMTgoAYC9cMLB7GNeKumLrau8+5/4bHzXNiF6UBEp+
         W0gawh077ryKZBaKvhsV2JUYRGRuqrRKTVjvdxydqxXyCepBKTnfv3C31am18iJ7BAE2
         CAGU7rAWMryHexOvm4dhKbSBGvzsS6iJ6YOe7jREOLSzh3VhtXZFprjG8UyCykIz5+uz
         N3oA==
X-Gm-Message-State: AOAM531qKmcKIrOkltNS32bcuzkf2/V8UiY7UkF8P0oyQbW9uRuMdHan
        K+yZfFhQskx0LZkX/e9/vy1zqg==
X-Google-Smtp-Source: ABdhPJxqmXvxD4LBQIPax7OSnpomD/4jNcX4OFrGrMf0MgZTSCaSU8ragurZcjW6leHMWAKc/4BGXA==
X-Received: by 2002:a65:5b85:: with SMTP id i5mr1424835pgr.269.1618621890046;
        Fri, 16 Apr 2021 18:11:30 -0700 (PDT)
Received: from shiro.work (p345188-ipngn200408sizuokaden.shizuoka.ocn.ne.jp. [124.98.97.188])
        by smtp.googlemail.com with ESMTPSA id x17sm2181515pjr.0.2021.04.16.18.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 18:11:29 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, olof@lixom.net, arnd@kernel.org
Cc:     w@1wt.eu, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 0/3] ARM: mstar: Add initial support for M5Stack UnitV2
Date:   Sat, 17 Apr 2021 10:10:12 +0900
Message-Id: <20210417011015.2105280-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds basic support for the soon to be released M5Stack
UnitV2 based on the SigmaStar SSD202D.

With the rest of the commits in my tree the SPI NAND, ethernet, USB etc
should work so the UnitV2 should be fully usable with a mainline-ish
kernel.

Hopefully this will encourage someone else to help with cleaning
up and pushing the commits for these SoCs.

Link: https://m5stack-store.myshopify.com/products/unitv2-ai-camera-gc2145

Daniel Palmer (3):
  dt-bindings: vendor-prefixes: Add vendor prefix for M5Stack
  dt-bindings: arm: mstar: Add compatible for M5Stack UnitV2
  ARM: dts: mstar: Add a dts for M5Stack UnitV2

 .../devicetree/bindings/arm/mstar/mstar.yaml  |  1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 ++
 arch/arm/boot/dts/Makefile                    |  1 +
 .../dts/mstar-infinity2m-ssd202d-unitv2.dts   | 25 +++++++++++++++++++
 4 files changed, 29 insertions(+)
 create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd202d-unitv2.dts

-- 
2.31.0

