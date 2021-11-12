Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B444E44E4A2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 11:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbhKLKft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 05:35:49 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47748 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234675AbhKLKfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 05:35:48 -0500
Received: from zn.tnic (p200300ec2f10ce005b16e04e289251c2.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:ce00:5b16:e04e:2892:51c2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5914E1EC03AD;
        Fri, 12 Nov 2021 11:32:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636713177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=Fr7aFpqmBCPL12KqyO/5L3/C772ieP/AGoP0sWu/6HE=;
        b=g4FOrO0Mn/U0NIPAo+tTgPwv+pcKi20ldVpACzZJEGhOhcRdwPSccWj/cHzWWd0vUw16p1
        otq74KmMgKjZ9H+AuVH7tpMvA3yf4fFF7p9T9ecK/oknm33fP8Rbr4FF81tp+HeLdw3nvw
        1Iat4/xPA84WNuEmuRxEAmSkVmPF7y0=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/6] x86/cpu: Do some janitorial work
Date:   Fri, 12 Nov 2021 11:32:40 +0100
Message-Id: <20211112103246.7555-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Beef up clearcpuid= so that it supports the strings from /proc/cpuinfo
too and remove a bunch of useless, and, in some cases even downright
dangerous, chicken bits we have added over the years.

Thx.

Borislav Petkov (6):
  x86/cpu: Allow feature bit names from /proc/cpuinfo in clearcpuid=
  x86/cpu: Remove "nosep"
  x86/cpu: Remove CONFIG_X86_SMAP and "nosmap"
  x86/cpu: Remove "nosmep"
  x86/cpu: Remove "noexec"
  x86/cpu: Remove "noclflush"

 .../admin-guide/kernel-parameters.txt         | 28 ++----
 Documentation/x86/cpuinfo.rst                 |  5 +-
 Documentation/x86/x86_64/boot-options.rst     |  9 --
 arch/x86/Kconfig                              | 11 ---
 arch/x86/include/asm/disabled-features.h      |  8 +-
 arch/x86/include/asm/proto.h                  |  1 -
 arch/x86/include/asm/smap.h                   | 24 -----
 arch/x86/kernel/cpu/common.c                  | 88 +++++++++----------
 arch/x86/kernel/setup.c                       | 28 +++++-
 arch/x86/mm/Makefile                          |  3 +-
 arch/x86/mm/init_64.c                         |  1 -
 arch/x86/mm/setup_nx.c                        | 62 -------------
 scripts/Makefile.lib                          |  4 +-
 scripts/link-vmlinux.sh                       |  6 +-
 .../arch/x86/include/asm/disabled-features.h  |  8 +-
 15 files changed, 83 insertions(+), 203 deletions(-)
 delete mode 100644 arch/x86/mm/setup_nx.c

-- 
2.29.2

