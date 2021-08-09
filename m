Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7833E4634
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 15:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbhHINLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 09:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbhHINLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 09:11:13 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326DBC0613D3;
        Mon,  9 Aug 2021 06:10:53 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m28-20020a05600c3b1cb02902b5a8c22575so11321607wms.0;
        Mon, 09 Aug 2021 06:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cZUrp6uTd/Kkvpidj7ZIMSC5Va2ewQdQe0yXXZ1QOd0=;
        b=ap5qig/sIIYaJ1dlO7lbcEgWnjV2iEucXRrV4Uw2weUtO/AXH+uP7qod/Yq+U7BQd6
         8JLxhlJPtAfkFcRTkUebCDHXls50GD6k5HPTfDDwfesCUGLbcR1qewIqnHnN1tYa9yP6
         nr1VxN/JVXi7E5IrIJzqNUqUpGXlyyKHlXRh3M8/JUvRxAn4X4n8DyYMIqevEca1jf19
         CAT9miq3nAfWICJz5kalqzD3IPQufkJLaCGZWBWZbNS+Xdh7dC9cAgWPBLI643xYoZKC
         GEpsH3V0OMghQNV1u4Px7BJ8Qqv0Sm9BiDRTHlhy4qf+3ijxsry4ucoe3lftbeAiIzHk
         BS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cZUrp6uTd/Kkvpidj7ZIMSC5Va2ewQdQe0yXXZ1QOd0=;
        b=sHS6bR8V+TIseFYY3DWCf3JQL1qJ6Msev76EUfZKCeSkacXdiBrEgMMdtAv4Sl8zCS
         XvIuIZF2Peinu88JY/7kGCAuCzGoJRuHplzxyUKFgoC8bgaw+2TflZCLrFxzJqNVkQYM
         2/fz1cu3vyn78Jn5SWssBL8ENhKfMJZsOh+YprClTywfHdCDOwKMRg2AL4vONtYE8HUE
         lVssBOqn+xHxmTKQ9LyVk0ROiDtW+GJCEfNIJwjzSKLtMGdylOgRuab8VJjZqWVYIG7/
         YjevT8jQ/65zSVUhI4M5jwPXpXi9wQhKdf1zE7qzdllbSMNJHnXx5ro8uA/MQf0o6Thl
         9hBw==
X-Gm-Message-State: AOAM530eoOXwofGZwk0bbk47VhxmlCzIqNYCDsaBZ5+BW4cPaN9mjYxv
        Q8RaFDZ62DoH+ccz3Ce3TjE=
X-Google-Smtp-Source: ABdhPJyt+NJ6Xheq1q0KhtiDDQt78Ari3v1incgB6zl1F2i87d0VeAoheqDlPjsJP6wNALJ9zdFQ3g==
X-Received: by 2002:a05:600c:41d3:: with SMTP id t19mr33729061wmh.157.1628514651801;
        Mon, 09 Aug 2021 06:10:51 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id k12sm5276094wrd.75.2021.08.09.06.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 06:10:51 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 0/2] arm64: dts: amlogic: add support for Radxa Zero
Date:   Mon,  9 Aug 2021 13:10:45 +0000
Message-Id: <20210809131047.28047-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the Radxa Zero SBC. The device-tree is loosely
based upon existing support for SEI510 and U200 (also G12A boards)
and has been developed with the 4/32 board configuration.

Christian Hewitt (2):
  dt-bindings: arm: amlogic: add support for Radxa Zero
  arm64: dts: amlogic: add support for Radxa Zero

 .../devicetree/bindings/arm/amlogic.yaml      |   1 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../dts/amlogic/meson-g12a-radxa-zero.dts     | 418 ++++++++++++++++++
 3 files changed, 420 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts

-- 
2.17.1

