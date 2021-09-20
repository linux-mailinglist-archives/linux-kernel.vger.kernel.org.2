Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903444114EF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238713AbhITMyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbhITMyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:54:37 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73477C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 05:53:10 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q11so29377386wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 05:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4q1a6gC+PswwD0+J0CMs3auxtQONFWFvuS/2KQHKStA=;
        b=e1oLy2nRpOW/L1CUFb3fDLyzuY2TdkOMbFaWBe+KkP/DMrOrK55shgVLBnFshcTHmz
         Ociyt1I4VGHETdbxJ2DH2UwaxzZMaqet3hN0o8MwU7Iip/R8iu84bek98GBnrfGPys8m
         BZJlwEejmmCQBAi8RCFQzCoG4n8zGGGFce8qwu4zXV2g/Z3hbCTRyV5gUh5NfmKhVP5a
         Qmqmvi3Wv4/DG5hezEjqwyeHpG7z3eu6AZx2GmDdKDAU7Fgd17/Far3tntk/gor9iSYx
         R1g0tEJj1VcF4stLB1PGxVLWvzxu3ClVkvoR22TgC3m9k0eozx1mrEiF475vYWHGR2sv
         L2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4q1a6gC+PswwD0+J0CMs3auxtQONFWFvuS/2KQHKStA=;
        b=bK3xdbb8kmPfL59E7dStBuN625GbnCaL94iEfiKlryJC5Z3LZ3Qf/+n9695pQqtZD4
         BjRp9FjuArT1jiUYazbshSEW7ynINr+HfY1j2eOKzttqcjGeRNOuflrQr4LCIn4DDA7y
         5u3h8A+ClolE6j8yX5ARCGP+bA2ttRM40s1GiM45Mi0TV3WwlLsCmJ3ClCR6hRDeMe0W
         v4qS65LBPXiYELXIc9Z4AOpnbS3iRM4PypjQ8fdRsyZr4oRXVwdY2sckuP5HFfTX9IEy
         WYmRGozt1rpRYXDhIjS5XDmC06uG+UfqWyEhh+v+LPkSz4PWSxtb5yrakbg1hXbLR0Ei
         Hqvw==
X-Gm-Message-State: AOAM533iIAXWYFO0XnyKVHILtlBa2jTDDz+zFtVyNJqhHDkRD6pc/IbL
        J4nElFFBzcdYML7ewNRhaRq1q3ILW6YDfCx9
X-Google-Smtp-Source: ABdhPJyiXXS2iyJts+E4JFgX1cnshJzO2RRbAbnC7W2egNKe6wx79xqI/0BqGk/Lmpa8aLXYHBUIGw==
X-Received: by 2002:a5d:6ac7:: with SMTP id u7mr17540630wrw.219.1632142388947;
        Mon, 20 Sep 2021 05:53:08 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:aa8a:ef22:59c5:1bf3])
        by smtp.gmail.com with ESMTPSA id j21sm15791643wrd.48.2021.09.20.05.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 05:53:08 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     tony@atomide.com
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/4] ARM: dts: dra7: enable BB2D module
Date:   Mon, 20 Sep 2021 14:53:02 +0200
Message-Id: <20210920125306.12347-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DRA7 & variant SoCs contains a BB2D module which is a Vivante GC320 2D accelerator.

This patchset adds the GPU node and enables it on the DRA7, DRA72 & AM57xx platforms.

This is a follow-up of [1] & [2] but:
- using the vivante,gc bindings only
- using ti,sysc instead of hwmod

[1] https://lore.kernel.org/linux-arm-kernel/20161118024436.13447-1-robertcnelson@gmail.com/
[2] https://lore.kernel.org/linux-arm-kernel/20161118024436.13447-1-robertcnelson@gmail.com/

Gowtham Tammana (4):
  ARM: dts: dra7: add entry for bb2d module
  ARM: dts: dra7-evm: Enable BB2D node
  ARM: dts: dra72-evm-common: Enable BB2D node
  ARM: dts: am57xx-evm: Enable BB2D node

 .../boot/dts/am57xx-beagle-x15-common.dtsi    |  4 ++++
 arch/arm/boot/dts/am57xx-idk-common.dtsi      |  4 ++++
 arch/arm/boot/dts/dra7-evm.dts                |  4 ++++
 arch/arm/boot/dts/dra7.dtsi                   | 20 +++++++++++++++++++
 arch/arm/boot/dts/dra72-evm-common.dtsi       |  4 ++++
 5 files changed, 36 insertions(+)

-- 
2.25.1

