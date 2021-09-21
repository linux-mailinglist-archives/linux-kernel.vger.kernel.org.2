Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B948412F38
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 09:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhIUHTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 03:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbhIUHTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 03:19:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76E1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:18:10 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id i23so36269764wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YGEAbHXSaoOeSKdNUKSp2eDYtuE34vb7kZvCNCg8WS0=;
        b=sh8yMuDbDOGoxzO4ADI0dGLvuU735gfVv5A15gwgb7x87zmV/oPf3DLR4Qpw+yc+R6
         3YD9KmSeCB74S7Vlm1P4MsvWG4zrDSqp4NUiNTfh/FvhZzLfeVgTUeFlRsVH9dktUcIB
         BDyxMD654sBYoOo93aMIGyEAM3H1gwp2Evt+KDAycCh8NSSjOsnU8XRnQ2JW1SzcRhhC
         BXU2tLDvW0TcvdDjMAQz8iQibd7+cXmtmpviuKqw49lywbiGll8djnkgpR6GdW4gXDMc
         PDbUokAXjWtNBdnh9lNxO0gxtdbJWqzSnJh/JSVdQw2F0kQ2sDAFfZJf/zFCm5ybUJLR
         PNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YGEAbHXSaoOeSKdNUKSp2eDYtuE34vb7kZvCNCg8WS0=;
        b=5ebtdpcdxi9LeS4a/ymheQX6492JEY6TXb8pGCOVke2xUknuMqBmCVados5N8RAvSC
         ZV3RgdkVtWQWuko2oH4co2wWj380ExY//TNUobdJOUD1kfS5sUKsqKOgXe5Ph3pH28IY
         FU8njC8Ylq/cIF41CFHOySoZOBmi5OQURZvFK7bygfvFfs8fTVdkwo7NSR6Pl7cwYlCU
         lEzpaUZCub9eI6+pRUtrUcyWDY3ZasbxzYymLpLqZbBtVxRkzBQR5SY0Qx3rIlPX8wth
         T61CTTDxLlAhI6nfdJvtsaEyO4tfUXkk7sTRHdMZtMd8Db8+C5oasD8YqeNDfvm7Qc3g
         TOIA==
X-Gm-Message-State: AOAM532iwvU8oTzaqVhuGcFTFX5hH4QvZo7satD+q1leYcPiSzgcJaNo
        v4aEiGmM+sHVKTI0L5vnZR2F0w==
X-Google-Smtp-Source: ABdhPJwLKYS+Orv3H6DcPfO7ccXZ7yofYe1iBGfAMWonW7ouj8YancroCtZRVfWUkd3W8gGe5ERJ1A==
X-Received: by 2002:a05:6000:1379:: with SMTP id q25mr32495090wrz.280.1632208689229;
        Tue, 21 Sep 2021 00:18:09 -0700 (PDT)
Received: from localhost.localdomain (i16-les01-ntr-213-44-230-108.sfr.lns.abo.bbox.fr. [213.44.230.108])
        by smtp.gmail.com with ESMTPSA id w9sm1786918wmc.19.2021.09.21.00.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 00:18:08 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     tony@atomide.com
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 0/1] ARM: dts: dra7: enable BB2D module
Date:   Tue, 21 Sep 2021 09:18:06 +0200
Message-Id: <20210921071807.30978-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DRA7 & variant SoCs contains a BB2D module which is a Vivante GC320 2D accelerator.

This patchset adds the GPU node and enables it by default.

This is a follow-up of [1] & [2] but:
- using the vivante,gc bindings only
- using ti,sysc instead of hwmod

Changes since v1 at [3]:
- removed status property of bb2d node
- removed enable patches for different platforms
- fixed bb2d size format

[1] https://lore.kernel.org/linux-arm-kernel/20161118024436.13447-1-robertcnelson@gmail.com/
[2] https://lore.kernel.org/linux-arm-kernel/20161118024436.13447-1-robertcnelson@gmail.com/
[3] https://lore.kernel.org/r/20210920125306.12347-1-narmstrong@baylibre.com

Gowtham Tammana (1):
  ARM: dts: dra7: add entry for bb2d module

 arch/arm/boot/dts/dra7.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

-- 
2.25.1

