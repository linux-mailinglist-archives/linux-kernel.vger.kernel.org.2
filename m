Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41254035E3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 10:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347485AbhIHIHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 04:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbhIHIHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 04:07:10 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5239FC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 01:06:02 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b6so1855594wrh.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 01:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Ht6sNTzoG3aZg1HTrFK3rEHKvbEYGjEXgiRXWIfr9ok=;
        b=vrjIOnVslaHWl/j/NFsmIb77s/BvStgiBT5zsAHo5opSowxbIxbJX0W5tbaqkiPeMN
         zPQZUn/+/MIWaA4SydkybIUK+JE7AadrnsYwjTXOjYXNf3F+fTKYPmUEaf6gFxqbaYRL
         jxISyYE0GhS7O6/1m2/mDlwkUwK9ZheeV3cdT9N4MKl1SvvW/nIN2WnqWvnxERKuHXfp
         0NUaqkyCL2iPZDMnta6msiBIR1uLlX9nYvQ5lxPbf4+Hcjt2rnJ6KclHa+WDiAA9UB37
         YASFUGTqIgoFluRZRXHq/rN8uLrk05DypIKqbHDST4Cdny4UGeP69YEuou7jg1rmorY5
         l3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Ht6sNTzoG3aZg1HTrFK3rEHKvbEYGjEXgiRXWIfr9ok=;
        b=XFCrUWrIgHxJxuWAGr5ADzJ0hhHEGXtygGcenuuPWaXdLsnulDXFkRUYXhG/I3BjPM
         2fzR29D1GFnwgqIYU8wqM5ZeEDvc4kMgtqRpMTfhVfymxUVd4B0LvoM2LPxFt05jZzdI
         U0dJRowjNAnszYuXeOK4chtX4kSDkNpnk6YtNVmJ7UGMqWC+vqcZHFVKEMKTMaaXPify
         uPH/X7kILtOThPdBbMjt22idfw4fu41RCqZYvQ4SbdkbCXMAj0cczb7qocQtRn0lwMAu
         pf3XScjcRGLGOiNzinAY5p8TEGddB6i0rMuobheqdPtVpeSfEkcDC5HEZRr9nRs2pRVS
         3llw==
X-Gm-Message-State: AOAM533bDKGnhbBfDoS7NbQHlwXdg7z75zCb38ehzQzwZDJSAkTHe7fr
        WJitEOim/ga/y5cZh9WbLpewC0G7pw4sfQ==
X-Google-Smtp-Source: ABdhPJxiLXDDLPcZKzqlZR76UZQZLEmbbFP0+vPcrL30AiB7Uuo98Aal8WOCAdt9wa3YL2VEnH4vbQ==
X-Received: by 2002:adf:c54a:: with SMTP id s10mr2489903wrf.405.1631088360485;
        Wed, 08 Sep 2021 01:06:00 -0700 (PDT)
Received: from ?IPv6:2a02:768:2307:40d6::45a? ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id s7sm1358367wra.75.2021.09.08.01.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 01:05:59 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] arch/microblaze patches for 5.15-rc1
Message-ID: <a453ca42-98a8-04ee-0584-673b1e661627@monstr.eu>
Date:   Wed, 8 Sep 2021 10:05:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull this one patch to your tree.

Thanks,
Michal

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.15

for you to fetch changes up to 315511166469a641c1b838eaca6bdd3af5c362c4:

  microblaze: move core-y in arch/microblaze/Makefile to
arch/microblaze/Kbuild (2021-08-25 09:56:10 +0200)

----------------------------------------------------------------
Microblaze patches for 5.15-rc1

- Kbuild clean up

----------------------------------------------------------------
Masahiro Yamada (1):
      microblaze: move core-y in arch/microblaze/Makefile to
arch/microblaze/Kbuild

 arch/microblaze/Kbuild   | 4 ++++
 arch/microblaze/Makefile | 5 -----
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

