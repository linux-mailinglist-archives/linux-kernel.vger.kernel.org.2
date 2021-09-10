Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA76407402
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 01:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbhIJXms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 19:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbhIJXmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 19:42:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B09DC061756
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 16:41:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v66-20020a25abc8000000b0059ef57c3386so4630119ybi.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 16:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VVycRjqCyikLXTyX3XiEITjrwGSxvaGodk5mb1ImPSQ=;
        b=TNefXA90HT5t+VMamelxf6ZHaaT4VEiDPuE4ok/wJdOVi2p7mfbzTb3UQsp6+n4HNc
         8qDXPfrluytEVS/lE313LPM84ytsmEQiMU9PSFidxoNyVsUWmMDcZA4RX7j60A9rcGar
         qKxsqnSNmiSrVzE+latG8iyRLiIZ+psw4g4wS4aU/Y4xcoJF+BmA8A+b4q+1j8VEKImh
         tVIGXc7eQVBuq3r9nUbJRp+vqZ8VFAqglLV+gkPriKYf5GlwPHePlQOq7qMWPNmUF5wR
         UrN02r/0ErpYovsTA/4ggsmVb0UoLOpFK5wNV5u6Eg0CYZBZR58heukDYJqE/A5owWOr
         6K4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VVycRjqCyikLXTyX3XiEITjrwGSxvaGodk5mb1ImPSQ=;
        b=XP0tmRhiwBU5zHlo9VHE50KcpyuFH8gD5jJooju3jZd3znZ8vgFG/HDAB0Gr6OiIf3
         tgdD05FOt9B3yVDwTW9LHMPtLOQD4y1MFJmHBSJ8YuoM53XX/7TG7oElNU9UivakYYYV
         pdXdHfI6ZfxHK2tPbQyFeiwULqO8pg7Le4VcTyDNpafjRXKqtCC+qwYItR3zWr2+LnMa
         y9Oxp7qV/UJTa/+1Ig/zgjlbIhcM5g8nLetupnn1DIcAldni/1ICmd8cO+cdxN5VrP6k
         kf5sY+lV9cH6UEAC2JIt4DyxUHI8EMaxd7vjI/vmSe5pHsKHgS2t2t1uN9AnIj83VioT
         Mrlw==
X-Gm-Message-State: AOAM532wBGtn1DhcqI4K7umybni+rMc/Y/m7zV6wXuYXi1KOUbV5+usM
        IrjjlbDqJSZqROz5+MkJm/sNjEqWYQUxpBjHniM=
X-Google-Smtp-Source: ABdhPJxlcL8orqv7m/N8sZDNsSIELfbF5/uenPTSopNYlQYm+J7Nucv0KZGfgFLv6kluTLoDYkCfKiomtq8RqAlLP34=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:2b76:71d3:b5fb:3734])
 (user=ndesaulniers job=sendgmr) by 2002:a25:5b45:: with SMTP id
 p66mr332465ybb.273.1631317270573; Fri, 10 Sep 2021 16:41:10 -0700 (PDT)
Date:   Fri, 10 Sep 2021 16:40:45 -0700
In-Reply-To: <20210910234047.1019925-1-ndesaulniers@google.com>
Message-Id: <20210910234047.1019925-9-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210910234047.1019925-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 08/10] Makefile: drop GCC < 5 -fno-var-tracking-assignments workaround
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that GCC 5.1 is the minimally supported version, we can drop this
workaround for older versions of GCC.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Makefile | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Makefile b/Makefile
index 2d1e491f7737..f9ef07f573e0 100644
--- a/Makefile
+++ b/Makefile
@@ -849,12 +849,6 @@ endif
 
 DEBUG_CFLAGS	:=
 
-# Workaround for GCC versions < 5.0
-# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=61801
-ifdef CONFIG_CC_IS_GCC
-DEBUG_CFLAGS	+= $(call cc-ifversion, -lt, 0500, $(call cc-option, -fno-var-tracking-assignments))
-endif
-
 ifdef CONFIG_DEBUG_INFO
 
 ifdef CONFIG_DEBUG_INFO_SPLIT
-- 
2.33.0.309.g3052b89438-goog

