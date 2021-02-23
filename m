Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140B1322C27
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 15:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhBWOXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 09:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbhBWOXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 09:23:09 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BD5C061786
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 06:22:29 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id do6so34840312ejc.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 06:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=5YMjePgrPXCWV7JyRq/B0YaMEmuYhDj7fLMq7dLn6hw=;
        b=MmKSgczDgxMUMC/KRtKvF+op/Y/nVvVIBmT6Wf5uaVNEPpnmylKWy6fJsHgdB+RwLh
         5+3Bd1ChlF1pN52/lzuQBVy083G6ZQ1ynwv8pFLuhZt20ITQN9VxlEuISPIhV6kn4PWw
         Fr4vi1DHlV7+6u+OCR5ebgdNJVxA5pTUuqk79n5srStzsVTc4wxUrweKUyLo/0WANydp
         zefUrhTAXHD57msjdDmpiw1gRpHDwCV/Y279CzCGZXpYnGQKxEmQHaz2+v3lsKCFLUNT
         bT1WMHrM89D3WLCLEel/F7DVHryOkd3s2SHSYUgz7/17+t4LvujMWzCv1xkWwHOjLdd2
         fGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=5YMjePgrPXCWV7JyRq/B0YaMEmuYhDj7fLMq7dLn6hw=;
        b=cy+0rwVkRFkNc3Cc6zpqvsa86b6pZf2nhO740UUm8TCUmeCAMUkVf5ERmJ6SOKRJPo
         iAXkP+6VBfbBwpdF/w/sfS8rW75JO1bDWKNWcCQg/o01qJkBCMyb/RKqfoN00uFotv7m
         Qs/B95RDIWA67rae4iOYyEw5vsrAqZu/YjVIBXsdXzwieM9idrYh6qnVLUBbo/m2X2dH
         RK0Lqj07A7u3kTqs7GF2Zmac2Nv2cAhZoa2fvT8HCBBZ9NFFbWJZfplEzPUVKz/PdcbE
         eD3NUQACKt9xb9rOgml/xQUBRmiZSu8buIFmCeTPc6aUFT7sduHRGDULRBa6wl/pp8pL
         obFQ==
X-Gm-Message-State: AOAM5326pxJWICUESOtT2hPLsSapQ1k53H2bbyWN1kft4dlsH3HYjknM
        Lcxp9/s2yltLVk+2yziVRvh3OaXL+g/f0Nft
X-Google-Smtp-Source: ABdhPJzrakjyj6Hxvzq4oDjHdnVi8Zhfuq35xzGB+3C3bfP5nw3dmTDMG3dP7tXnY2IV/Wq+8FYdmw==
X-Received: by 2002:a17:906:753:: with SMTP id z19mr25953055ejb.15.1614090147857;
        Tue, 23 Feb 2021 06:22:27 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id g2sm12784610ejk.108.2021.02.23.06.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 06:22:27 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] arch/microblaze patches for 5.12-rc1
Message-ID: <e90de819-ecb0-cb69-3a05-f75df0edb4fb@monstr.eu>
Date:   Tue, 23 Feb 2021 15:22:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull these 3 patches to your tree.

Thanks,
Michal

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.12

for you to fetch changes up to 48783be427c70a377c83a17d045eee98c90220da:

  microblaze: Fix built-in DTB alignment to be 8-byte aligned
(2021-02-16 07:43:36 +0100)

----------------------------------------------------------------
Microblaze patches for 5.12-rc1

- Fix DTB alignment
- Remove < GCC 4 support
- Remove TRACING_SUPPORT selection

----------------------------------------------------------------
Geert Uytterhoeven (1):
      microblaze: Remove support for gcc < 4

Masahiro Yamada (1):
      microblaze: do not select TRACING_SUPPORT directly

Rob Herring (1):
      microblaze: Fix built-in DTB alignment to be 8-byte aligned

 arch/microblaze/Kconfig              |  1 -
 arch/microblaze/kernel/module.c      | 26 --------------------------
 arch/microblaze/kernel/vmlinux.lds.S |  2 +-
 3 files changed, 1 insertion(+), 28 deletions(-)

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

