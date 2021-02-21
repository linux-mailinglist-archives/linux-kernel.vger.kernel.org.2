Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A2C320B6F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 16:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhBUPdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 10:33:15 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:54050 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhBUPdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 10:33:05 -0500
Received: from grover.flets-west.jp (softbank126026090165.bbtec.net [126.26.90.165]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 11LFPXLH002478;
        Mon, 22 Feb 2021 00:25:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 11LFPXLH002478
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1613921134;
        bh=BpSvNChKiVnLgw+LcmYaO/tWVZloQb+Ml+194wpU6LA=;
        h=From:To:Cc:Subject:Date:From;
        b=Z8iVhXT6WqegRIO9yrCfgFFVhp5ssUJBnL3MaLuC/X5RKpVAwhvmTCNX8Y/q7dqen
         5I7LpUMMiabcPv9dp0xJIxR8RSz0XERlw1eW375qlS6gxtTKOZvSVvsH8p56WmQCEu
         k+Jv60bHUESh55NUhfFWGThw5Ipo1Q2yFKAUc2WuugBq6HitWC4YQux8HqF72ebe0a
         7Gwsgvf91vWpxgm7aWw30X4vZomn4xOkScFPIlyZCGB7bVI4e4XEb7fDtoehumlCE4
         CCxqrcdQIqaO5PKiJPWFJlw9z0+KGNJYDwwl7Px6XwW9IRjkgtNWtQQZZ09ZQJlEDf
         9QaICeu+EyrEQ==
X-Nifty-SrcIP: [126.26.90.165]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Harry Wei <harryxiyou@gmail.com>, Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] doc: use KCFLAGS instead of EXTRA_CFLAGS to pass flags from command line
Date:   Mon, 22 Feb 2021 00:25:24 +0900
Message-Id: <20210221152524.197693-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You should use KCFLAGS to pass additional compiler flags from the
command line. Using EXTRA_CFLAGS is wrong.

EXTRA_CFLAGS is supposed to specify flags applied only to the current
Makefile (and now deprecated in favor of ccflags-y).

It is still used in arch/mips/kvm/Makefile (and possibly in external
modules too). Passing EXTRA_CFLAGS from the command line overwrites
it and breaks the build.

I also fixed drivers/gpu/drm/tilcdc/Makefile because commit 816175dd1fd7
("drivers/gpu/drm/tilcdc: Makefile, only -Werror when no -W* in
EXTRA_CFLAGS") was based on the same misunderstanding.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Documentation/process/4.Coding.rst                            | 2 +-
 Documentation/process/submit-checklist.rst                    | 2 +-
 Documentation/translations/it_IT/process/4.Coding.rst         | 2 +-
 Documentation/translations/it_IT/process/submit-checklist.rst | 2 +-
 Documentation/translations/zh_CN/process/4.Coding.rst         | 2 +-
 drivers/gpu/drm/tilcdc/Makefile                               | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/process/4.Coding.rst b/Documentation/process/4.Coding.rst
index 0825dc496f22..1f0d81f44e14 100644
--- a/Documentation/process/4.Coding.rst
+++ b/Documentation/process/4.Coding.rst
@@ -242,7 +242,7 @@ and try to avoid "fixes" which make the warning go away without addressing
 its cause.
 
 Note that not all compiler warnings are enabled by default.  Build the
-kernel with "make EXTRA_CFLAGS=-W" to get the full set.
+kernel with "make KCFLAGS=-W" to get the full set.
 
 The kernel provides several configuration options which turn on debugging
 features; most of these are found in the "kernel hacking" submenu.  Several
diff --git a/Documentation/process/submit-checklist.rst b/Documentation/process/submit-checklist.rst
index 230ee42f872f..cfc23492b9ea 100644
--- a/Documentation/process/submit-checklist.rst
+++ b/Documentation/process/submit-checklist.rst
@@ -98,7 +98,7 @@ and elsewhere regarding submitting Linux kernel patches.
     injection might be appropriate.
 
 21) Newly-added code has been compiled with ``gcc -W`` (use
-    ``make EXTRA_CFLAGS=-W``).  This will generate lots of noise, but is good
+    ``make KCFLAGS=-W``).  This will generate lots of noise, but is good
     for finding bugs like "warning: comparison between signed and unsigned".
 
 22) Tested after it has been merged into the -mm patchset to make sure
diff --git a/Documentation/translations/it_IT/process/4.Coding.rst b/Documentation/translations/it_IT/process/4.Coding.rst
index a5e36aa60448..8012fe9497ae 100644
--- a/Documentation/translations/it_IT/process/4.Coding.rst
+++ b/Documentation/translations/it_IT/process/4.Coding.rst
@@ -256,7 +256,7 @@ e cercate di evitare le "riparazioni" che fan sparire l'avvertimento senza
 però averne trovato la causa.
 
 Tenete a mente che non tutti gli avvertimenti sono disabilitati di default.
-Costruite il kernel con "make EXTRA_CFLAGS=-W" per ottenerli tutti.
+Costruite il kernel con "make KCFLAGS=-W" per ottenerli tutti.
 
 Il kernel fornisce differenti opzioni che abilitano funzionalità di debugging;
 molti di queste sono trovano all'interno del sotto menu "kernel hacking".
diff --git a/Documentation/translations/it_IT/process/submit-checklist.rst b/Documentation/translations/it_IT/process/submit-checklist.rst
index 3e575502690f..614fc17d9086 100644
--- a/Documentation/translations/it_IT/process/submit-checklist.rst
+++ b/Documentation/translations/it_IT/process/submit-checklist.rst
@@ -104,7 +104,7 @@ sottomissione delle patch, in particolare
     l'iniezione di fallimenti specifici per il sottosistema.
 
 22) Il nuovo codice è stato compilato con ``gcc -W`` (usate
-    ``make EXTRA_CFLAGS=-W``).  Questo genererà molti avvisi, ma è ottimo
+    ``make KCFLAGS=-W``).  Questo genererà molti avvisi, ma è ottimo
     per scovare bachi come  "warning: comparison between signed and unsigned".
 
 23) La patch è stata verificata dopo essere stata inclusa nella serie di patch
diff --git a/Documentation/translations/zh_CN/process/4.Coding.rst b/Documentation/translations/zh_CN/process/4.Coding.rst
index 959a06ba025c..66cd8ee07606 100644
--- a/Documentation/translations/zh_CN/process/4.Coding.rst
+++ b/Documentation/translations/zh_CN/process/4.Coding.rst
@@ -165,7 +165,7 @@ Linus对这个问题给出了最佳答案:
 通常，这些警告都指向真正的问题。提交以供审阅的代码通常不会产生任何编译器警告。
 在消除警告时，注意了解真正的原因，并尽量避免“修复”，使警告消失而不解决其原因。
 
-请注意，并非所有编译器警告都默认启用。使用“make EXTRA_CFLAGS=-W”构建内核以
+请注意，并非所有编译器警告都默认启用。使用“make KCFLAGS=-W”构建内核以
 获得完整集合。
 
 内核提供了几个配置选项，可以打开调试功能；大多数配置选项位于“kernel hacking”
diff --git a/drivers/gpu/drm/tilcdc/Makefile b/drivers/gpu/drm/tilcdc/Makefile
index 662bf3a348c9..f5190477de72 100644
--- a/drivers/gpu/drm/tilcdc/Makefile
+++ b/drivers/gpu/drm/tilcdc/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ifeq (, $(findstring -W,$(EXTRA_CFLAGS)))
+ifeq (, $(findstring -W,$(KCFLAGS)))
 	ccflags-y += -Werror
 endif
 
-- 
2.27.0

