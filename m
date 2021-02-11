Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECF53183BE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 03:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhBKCwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 21:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhBKCwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 21:52:37 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C426C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 18:51:57 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id f16so3333202qke.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 18:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=o822Lr199HQGCnayt8C72QUcHqAHTU2Ztu3EEpAsGPY=;
        b=fa08nbzA3vctIkHyeNEUqu3Qwwj9o9ZRYC7Z4sVBBgi31CyJCwYUuFVLvb6LxCCdXz
         v/tHYrfC0qQII6+Wx9XMhZySwGhYPrbW2kCV1w8/K8rRe+M9YnQOumzxhAx+lJ5R0O0H
         bTk9C/FNElMWoku8E4bGA6EzzmWSF+vORyewPoV5jshnPTU4janDEd1ZKKZ4h1nwySlM
         q0NqMJ1idIQhyPFR/Atc5rZOABJ2DHlifbZjQBBvnaR4UhznwO01Cc0MuP31ZNKRR9Ze
         LdvcMUMnz+5KUCGJOQaBY3z1bTsNd6xsJFGRkX+vYxOpHcZA14UydO6zYxNYTzN/Txcv
         VxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=o822Lr199HQGCnayt8C72QUcHqAHTU2Ztu3EEpAsGPY=;
        b=nYg/29uxRKFBC2zcylklY+139xO+0D0hX+BRh8BRwz4dp+m+7wjFBJC4hStsYKJ93U
         jI1yCuiYJHuF+pF6c2/QsUW/kpmjPam/0WXOESXGAc6NKYeJM5ZKj2ZkuoY5Qqq79XKI
         uvKhJNmIOWbcpOEpJONva9QHwYEim9atV4XCozYWo9vFm3lasg3D0j+tUbRLAUxlnoNL
         Pz66I/8+H8S2eke+MsGmVWV9K9QLIAYZFKOkljyvOEIIe/d6U1NH1XrL0xIL3UjX5XB7
         fikDgB2M6G6UjZ8M60e5SEojQIcYeoL5llJyhNmSmJeBWp6fS7MM1VwpWcaf5tNuoEwW
         lRFw==
X-Gm-Message-State: AOAM533pEyg0ATsRCxtgfcagzNXyeN29oFRylWe4QDRGdjDDeRir0dbq
        ysr1mPnvC24ZdKiABv2F+odnOdhlRPBpWUrmWzk=
X-Google-Smtp-Source: ABdhPJzG54RwknIuYyHp7RUfDIKFcQO2oqp+MpWu4DtUyHb8ecmPiIhS9avh4ybC/NfnfcI3/1P+9s/jNDhtsxqUqtw=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:1dc:8608:b4eb:4dd0])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6214:bce:: with SMTP id
 ff14mr5647814qvb.26.1613011916720; Wed, 10 Feb 2021 18:51:56 -0800 (PST)
Date:   Wed, 10 Feb 2021 18:51:47 -0800
Message-Id: <20210211025149.3544593-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v5 0/2] ARM: kprobes: asm warning fixes and UAL conversion
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     clang-built-linux@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Smith <peter.smith@arm.com>,
        Renato Golin <rengolin@systemcall.eu>,
        David Spickett <david.spickett@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang's integrated assembler only supports UAL and rejects instructions
that are UNPREDICTABLE; KernelCI has been warning about those for awhile
now when using GAS (GCC or Clang) for allmodconfig builds.

Changes V4 -> V5:
* Make patch into series.
* Fix the UNPREDICTABLE warnings first.
* Add .syntax unified to fix the GCC build failure reported by 0day bot.
Changes V3 -> V4:
* use __inst_arm for movs based on resolution of
  https://reviews.llvm.org/D95586.
Changes V2 -> V3:
* drop changes to test-thumb.c. That file is mutually exclusive with
  test-arm.c based on CONFIG_THUMB2_KERNEL. LLVM requires more fixes for
  .w suffixes for thumb2 mode.
Changes V1 -> V2:
* Fix additonal swpvsb case in test-arm.c when __LINUX_ARM_ARCH__ < 6,
  reported by Arnd.
* Fix arch/arm/probes/kprobes/test-thumb.c, reported by Arnd.
* Modify the oneline to note I'm modifying test-*.c.

Nick Desaulniers (2):
  ARM: kprobes: fix UNPREDICTABLE warnings
  ARM: kprobes: rewrite test-arm.c in UAL

 arch/arm/probes/kprobes/test-arm.c  | 294 ++++++++++++++--------------
 arch/arm/probes/kprobes/test-core.h |   1 +
 2 files changed, 148 insertions(+), 147 deletions(-)

-- 
2.30.0.478.g8a0d178c01-goog

