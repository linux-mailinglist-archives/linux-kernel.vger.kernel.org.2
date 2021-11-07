Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969D24475FC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 22:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhKGVGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 16:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhKGVGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 16:06:20 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6A6C061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 13:03:37 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id q126so9469295pgq.13
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 13:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=vpk/9gC3ocHn4ZTx9Y5Ns4605yfWLspw1UZYKZ4qbL4=;
        b=oMI6VJNmaZJ1HkQKmEHBT9BGd2Dqedm9yaQgSgVnyAKQNv2huPXwRpeExh+aI9xGOM
         FJ63v5dsBaOfQZ+8BXzuJhyEg0Wc9uzridCk61nk3LS/SBoGXFEA+nx38K3WwgAC0tRw
         nCQCwv53FDyv7Hg3YMplCLA3rYEiTzEUx3Mjtzhrn/CRFZ6f9rkA5T0gCOP4Sa0pOE+2
         +XCZGIVnUJ6UQfwa5dkC7W9j0gr/WJ9w0EfxTFOhjLWKRBcfnjRqpzF0Jrc/qhvWg9zg
         aDwu7Pvlwl27DVWPlDrWJbJC2OEFBE8DNXG+mOS+1oDkv3L9piSw2iwbPuC0DHZvk8f+
         LCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=vpk/9gC3ocHn4ZTx9Y5Ns4605yfWLspw1UZYKZ4qbL4=;
        b=fcs0AA6XOU9apnMVKD5IZ/l7fUHKVzhP5yDM9Oxux2YB085hJIf2reJydnyKA0mdv4
         MxklV716PCgmEwvu54uxB8cr7w91FdsJbzn7IJM4SC7vGqCnELKxEbjErihK/SWbqsXL
         7GIFzuBJFKk0xSZYsdO5NHxTXL88F5i9TuuRHmJ+m8URwyRpBM+GjbXLAjjp7XCvo1oX
         wIy1kE+ft8J9KFIiikd7c0tZx9bUxvGZjJD0cSXXJG/RI3lorW14hVz8ct9SRH59URG5
         qk9iKtolWp+J4FSM72AKoBTD/S72jPWVUBlVfwKJht3gF9KGfjXinCATtAaQ+ThOWWWr
         6Huw==
X-Gm-Message-State: AOAM532NxY64oK1LFGe6h81i/bR9y7KEzjHuO7m1XZ30dIcvIV16XaHR
        Oaq6p0TrRIXjoHsEWfGUGl14k+Pwd7E=
X-Google-Smtp-Source: ABdhPJxLQw6JYOQ8wahFwNjT7FlHw3ALHyOamMCkSiss3eLK5K2w/lJsKT0jrTRPhXTWnQNR+ozp4w==
X-Received: by 2002:a05:6a00:21c4:b0:475:e532:3d18 with SMTP id t4-20020a056a0021c400b00475e5323d18mr76873799pfj.40.1636319016634;
        Sun, 07 Nov 2021 13:03:36 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id f19sm13703390pfc.72.2021.11.07.13.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 13:03:35 -0800 (PST)
Date:   Mon, 8 Nov 2021 06:03:34 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OpenRISC updates for 5.16
Message-ID: <YYg/JpmfY9/Z8qO1@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider for pull,

The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:

  Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)

are available in the Git repository at:

  git://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 27dff9a9c247d4e38d82c2e7234914cfe8499294:

  openrisc: fix SMP tlb flush NULL pointer dereference (2021-11-03 20:48:29 +0900)

----------------------------------------------------------------
OpenRISC updates for 5.16

This includes 2 minor cleanups, plus a bug fix for OpenRISC TLB flush
code that allows the the SMP kernel to boot again.

----------------------------------------------------------------
Denis Kirjanov (1):
      openrisc: signal: remove unused DEBUG_SIG macro

Randy Dunlap (1):
      openrisc: time: don't mark comment as kernel-doc

Stafford Horne (1):
      openrisc: fix SMP tlb flush NULL pointer dereference

 arch/openrisc/kernel/dma.c    | 4 ++--
 arch/openrisc/kernel/signal.c | 2 --
 arch/openrisc/kernel/smp.c    | 6 ++++--
 arch/openrisc/kernel/time.c   | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)
