Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF355325860
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 22:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbhBYVG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 16:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234962AbhBYUyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:54:54 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E262C06121E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:53:54 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id jx13so780541pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=bjIHdni2K5n1Z4jRhYXSP4Vl1PlKk59Pq/thwE2NYoc=;
        b=OhMhVZyXgA0i3KB/2jH/nfAUcFzozCDx82iGOD3ULBMQIoJa3H7RnDf4oAOG/igILr
         +ahJfNDQqgBofPAgtegC8u8+VVDaLgRUjXHOZwAlT4lyrmjJYm/Nn19dCHgdsoiXT/7l
         3Si5F9cBWzFcgFCNyCFe2Gysc2CPNvDteAoeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=bjIHdni2K5n1Z4jRhYXSP4Vl1PlKk59Pq/thwE2NYoc=;
        b=UrUniOLdHeLByUFOBpNJXYa9bx99OMfypAm7RiQ1JTRKnJGBaRbI3LJ+iiJOY4uad/
         NoFABywdbKF6S6EmcT4vOAihNSsqkBH4+ZPvWdTQyc5aHdbH350BcNxspG9D+fTBszaR
         9vwolNhNYvhTmGm3eXs6uFI0j8qIhZKeMANRbLMXG/MrhhnfdSdUxn1UklrVxyRKHMb4
         Ft0Ztx8aerOR+lxjmacPa1aobrMDHxxD6c1y3AR2MFNtnD37RSw70s9JO70U56KOKGut
         EWtMC0GFIwZuEof+SlLJ6g5JVCI0efoGSWyflM3U6dKLLK5GmfYBjoyZmulP5HqKqqhP
         J2MA==
X-Gm-Message-State: AOAM530gba7Q3h1LdyiopOavk+V+cNoSAqwtW15F/5FdS+wSJoqcxBdm
        48qSODgmsrP2q7ixm3BeRvUcGQ==
X-Google-Smtp-Source: ABdhPJw5ErGR9jm8qpbdl4kDnZW6wg8B/Ffu60D6GYhU2ChBC7i9mgLfMnJBzJRxVtdbZnUJyYuVSg==
X-Received: by 2002:a17:902:6a88:b029:e3:cd8a:3a92 with SMTP id n8-20020a1709026a88b02900e3cd8a3a92mr4662523plk.22.1614286434015;
        Thu, 25 Feb 2021 12:53:54 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o129sm6748797pgo.27.2021.02.25.12.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 12:53:53 -0800 (PST)
Date:   Thu, 25 Feb 2021 12:53:52 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [GIT PULL] clang-lto fixes for v5.12-rc1
Message-ID: <202102251252.C5A522755@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these clang-lto fixes for v5.12-rc1. This gets parisc
building again and moves LTO artifact caching cleanup from the
"distclean" build target to "clean".

Thanks!

-Kees

The following changes since commit 5e95325fbbbdea96de91e7bdb05fe95a3031e37d:

  kbuild: lto: force rebuilds when switching CONFIG_LTO (2021-02-23 14:10:44 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/clang-lto-v5.12-rc1-fix1

for you to fetch changes up to 4c7858b9001c85aacf86a74b3a68aa384bc33760:

  kbuild: Move .thinlto-cache removal to 'make clean' (2021-02-25 12:21:06 -0800)

----------------------------------------------------------------
clang-lto fixes for v5.12-rc1

- Fix parisc build for ftrace vs mcount (Sami Tolvanen)
- Move .thinlto-cache remove to "clean" from "distclean" (Masahiro Yamada)

----------------------------------------------------------------
Masahiro Yamada (1):
      kbuild: Move .thinlto-cache removal to 'make clean'

Sami Tolvanen (1):
      parisc: select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY

 Makefile            | 4 ++--
 arch/parisc/Kconfig | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
Kees Cook
