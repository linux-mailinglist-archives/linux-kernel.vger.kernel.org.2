Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E0D39465A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 19:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbhE1RZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 13:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhE1RZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 13:25:15 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E0DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 10:23:39 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ne24-20020a17090b3758b029015f2dafecb0so2904156pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 10:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=U7LDjVeilIpww/IL0BjmlQ/cmmfSwZFyRdCgaKSOKMw=;
        b=Lq0DAQDfDOyVep2CPYmZ/qwZjTN4VLXw3PW+oG15SC49lWJ61TkuDQWDdDxWhFXMVx
         l4yNi+YI2OwzxtJu3lJVQkOPAOOdF3A14QfBl8b/QGLKbYrcot5yv1LjsbSMipN8MCtJ
         f5vVNrMMc4FnY4gL/LBpGnYD8yo0aQxLqyPGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=U7LDjVeilIpww/IL0BjmlQ/cmmfSwZFyRdCgaKSOKMw=;
        b=lxhIn7gdSkJcZaPUI32ZvzQnwok1rQxBXd69JQAEaZcQh2ugxlIRR/jPFjvUEXGfqv
         ML9B4EtqOqzfBjGIBvx80/xHl4ti5+xrJ4V/5HwzDSCor+ONx8yfADPVMJvEDiAROSrI
         BULXzQlhyVHNmYzLBgyZ0Wls+1Vj5m08yg8JLrAzFKtQAYqVUPG8mERz/hpPT1k6/6Zn
         WiVwOJjDq4dGYEHPfyiUPE2/ZlRQLA4NpU9vzA4Z9ycFi4xZ4ErUXzny61RcSBUhybcJ
         m61F3IOJszxK39u/KHVgmx1GWqh8FxwMVNufg4s3CZrlc1qVNEEfqKZeMg9xlU6zxZ74
         9zIg==
X-Gm-Message-State: AOAM532OT4gPTSr5zYR+ikJLGvci45jRMSd5aX3k07sVJo61TkdzMunG
        m2q/BzxOvoLlOWgYHigYEwJ/6A==
X-Google-Smtp-Source: ABdhPJwQBLmdMXQKCbmme7kUxpxg02YFyCKpLARhhKq3QVla0USU2LVc4byyh8D/EtMAWUx8u4xPLQ==
X-Received: by 2002:a17:90a:4205:: with SMTP id o5mr5560769pjg.140.1622222619378;
        Fri, 28 May 2021 10:23:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d15sm1225049pgu.84.2021.05.28.10.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 10:23:38 -0700 (PDT)
Date:   Fri, 28 May 2021 10:23:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Candle Sun <candlesea@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [GIT PULL] Clang feature fixes for v5.13-rc4
Message-ID: <202105281022.40F5443A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these Clang feature fixes for v5.13-rc4. One small fix each
for LTO and CFI.

Thanks!

-Kees

The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:

  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/clang-features-v5.13-rc4

for you to fetch changes up to 24845dcb170e16b3100bd49743687648c71387ae:

  Makefile: LTO: have linker check -Wframe-larger-than (2021-05-24 15:24:34 -0700)

----------------------------------------------------------------
Clang feature fixes for v5.13-rc4

- Correctly pass stack frame size checking under LTO (Nick Desaulniers)

- Avoid CFI mismatches by checking initcall_t types (Marco Elver)

----------------------------------------------------------------
Marco Elver (1):
      init: verify that function is initcall_t at compile-time

Nick Desaulniers (1):
      Makefile: LTO: have linker check -Wframe-larger-than

 Makefile             | 5 +++++
 include/linux/init.h | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
Kees Cook
