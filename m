Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3005F44B9EC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 02:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhKJBZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 20:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhKJBZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 20:25:41 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0E5C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 17:22:55 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so392445pjl.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 17:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HAv9f1iLhDmsnrrCKVtiLE42tkSUT43wkvQCu0XMYW8=;
        b=RhdKrGHcwd4f/gFqVn2qpIRbuQi3OjjKFNGpcMcnBxPLFB+2KFJzoZmJyAofTzyMOq
         zc2u7rJ2vGzMpOUP+EjEOH+bXs6axp3zgEF4rJRGHCUH0ROwgv74xgB3sl77KX64UDJw
         R5PaJBZXNSpK25amuq/NfcqBol2PG8+uEpPIlRYZgnlVkLoiQL+vZisTDwc+Q/E45EV3
         BccWWu+LDSNo8hfYLO6sIX4dZtF8b3xoVNliy+tkj5gBkCFCzwE17tfAkGBrHsU019+i
         xyfSri6XCynCraBZaqScyD1blyXJrqA7A0t0Dj0NbIeHN6jJQApOc3nWoqOTl43B86cj
         LkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HAv9f1iLhDmsnrrCKVtiLE42tkSUT43wkvQCu0XMYW8=;
        b=L8s6KZWHOuBBlkifnGyONWZMDc87h/dVwoueauFLHGSEZqU/dHjvvqTB/5IiGpWoaq
         LXhng1rD8Ta6DUV0UFT+EQFyfDIgd95y3NJHWrCx3b0a2qR6oORNY65VKfijldVcgCut
         1F1hN1SkAYhEnx9ZJ1rUOQYZ3cNVG1bmK0KH3Ldt6iVOEFF1zfdblEp5Mw51nYekxW1L
         rw2ZEIsXjO/Rd1OQO+eFmvQuh8s8ca4UfsjC9fMW0I4rlLzMkIE0CxbvYDgrGvE293Ua
         FOF4xRmS/ct9pms+TBfCn7hLLyOCcTPxI/XMC7I+aKmy8OPMju/FqVTXHmcojx7pITG1
         5O7w==
X-Gm-Message-State: AOAM530gvFv39SoC0UcUYJCgiDGM2jgxKNBBdubykSmoph4zqacrdugg
        x/tfmpvsWonqfZBcIonTR1S4KGgW6y8=
X-Google-Smtp-Source: ABdhPJxjJ66nGGgFcEV2cebo02ye7n+fmfGjZIdLtq6pik5cOQ++Cx/8ai5I3r1T+Ro0rFKFmiR6fg==
X-Received: by 2002:a17:90a:6b0d:: with SMTP id v13mr12412700pjj.138.1636507374535;
        Tue, 09 Nov 2021 17:22:54 -0800 (PST)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:362:8fd3:5950:cf6d])
        by smtp.gmail.com with ESMTPSA id h2sm3614037pjk.44.2021.11.09.17.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 17:22:54 -0800 (PST)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: [PATCH 0/2] jump_label: add __static_key macro
Date:   Tue,  9 Nov 2021 17:09:04 -0800
Message-Id: <20211110010906.1923210-1-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

First patch removes uses of open coded 
__ro_after_init DEFINE_STATIC_KEY_FALSE(XXX)

Second patch adds __static_key macro to put static_key away
for CONFIG_JUMP_LABEL=y builds.

Eric Dumazet (2):
  jump_label: use DEFINE_STATIC_KEY_FALSE_RO() where possible
  jump_label: refine placement of static_keys

 arch/arm/crypto/chacha-glue.c        |  2 +-
 arch/arm/crypto/curve25519-glue.c    |  2 +-
 arch/arm/crypto/ghash-ce-glue.c      |  2 +-
 arch/arm/crypto/poly1305-glue.c      |  2 +-
 arch/arm64/crypto/chacha-neon-glue.c |  2 +-
 arch/arm64/crypto/poly1305-glue.c    |  2 +-
 arch/powerpc/mm/book3s64/slb.c       |  2 +-
 arch/riscv/kernel/cpufeature.c       |  2 +-
 arch/x86/crypto/aesni-intel_glue.c   |  4 ++--
 arch/x86/crypto/blake2s-glue.c       |  4 ++--
 arch/x86/crypto/chacha_glue.c        |  6 +++---
 arch/x86/crypto/curve25519-x86_64.c  |  2 +-
 arch/x86/crypto/poly1305_glue.c      |  6 +++---
 arch/x86/kvm/lapic.c                 |  4 ++--
 arch/x86/kvm/x86.c                   |  2 +-
 crypto/aegis128-core.c               |  2 +-
 include/linux/jump_label.h           | 25 +++++++++++++++++--------
 kernel/events/core.c                 |  2 +-
 kernel/sched/fair.c                  |  2 +-
 net/core/dev.c                       |  8 ++++----
 net/netfilter/core.c                 |  2 +-
 net/netfilter/x_tables.c             |  2 +-
 22 files changed, 48 insertions(+), 39 deletions(-)

-- 
2.34.0.rc0.344.g81b53c2807-goog

