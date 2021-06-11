Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74163A488E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhFKSYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:24:48 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:44985 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhFKSYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:24:47 -0400
Received: by mail-pj1-f47.google.com with SMTP id h12-20020a17090aa88cb029016400fd8ad8so6454495pjq.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Y5HubmkdgNbgZiIuuGUMBO31SNKOfhZHc4vhWT4WTcQ=;
        b=DjGNuLrtshev1p8rEdpEEkDv39oVgmVHDqWP2zODIeHI6mOIFrbI2L0c6On9n88PWk
         LTycRr+19eBdrc1kWnQTgXQ5uUCRbclbNQIzoVbV5gIl/5Kyo+shR17UJfyGRD/cVbmy
         0Rc2FI+8gj/3twwJifk9zeNKBr0OaoZjOlq7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Y5HubmkdgNbgZiIuuGUMBO31SNKOfhZHc4vhWT4WTcQ=;
        b=WpaV3AwFKF8nPI9O4/iWulOk4HVuD2TPmUdEOJIP4gEntN9LMHrOklRtE31INIqMb4
         t/VQtgaGmsUk4E1ORlIVwJEfm/6T1FywZXScn1mB5h5YYewZEH91HJWih7bSYRBLw73G
         kZAkEMKT119oUgp+gfyQaC2QKG+1SKAxRE3cGQNnJyoGaejSUpo9WWP9Qe2LXue0yt8Y
         XRavtf+linAu+tO203N9qx5QZFxnBRcd3qZk1efMf04di8wEHKuPLzD2a2KqwjO8bPSb
         2lXTBZJz8lJQoAkvMISiJhUNu08W7ZcJahEmCIDnEyViktOygEkuni72M0VY3g59bBkC
         /L5Q==
X-Gm-Message-State: AOAM531K/SDn6DQPZzliqS9J2HAFf3G8ZXrcyQDLFVmFacc/ME0BXxeK
        7hUTD+jHZbjHd3uoR7acctWAfA==
X-Google-Smtp-Source: ABdhPJwa2ldyUBEiR7sLKSoZqOhKc0X+TEovcHDkOIjw7bk7QmasSWeBG79RT46ygI6Rza6Bg0t1mQ==
X-Received: by 2002:a17:90a:aa98:: with SMTP id l24mr5767919pjq.156.1623435696216;
        Fri, 11 Jun 2021 11:21:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g141sm5842561pfb.210.2021.06.11.11.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 11:21:35 -0700 (PDT)
Date:   Fri, 11 Jun 2021 11:21:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tor Vic <torvic9@mailbox.org>
Subject: [GIT PULL] clang-features fix for v5.13-rc6
Message-ID: <202106111119.60F7B8C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this clang-features fix for v5.13-rc6. Clang 13 fixed some
IR behavior for LTO, but this broke work-arounds used in the kernel.

Thanks!

-Kees

The following changes since commit 06af8679449d4ed282df13191fc52d5ba28ec536:

  coredump: Limit what can interrupt coredumps (2021-06-10 14:02:29 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/clang-features-v5.13-rc6

for you to fetch changes up to 2398ce80152aae33b9501ef54452e09e8e8d4262:

  x86, lto: Pass -stack-alignment only on LLD < 13.0.0 (2021-06-11 10:33:45 -0700)

----------------------------------------------------------------
Clang feature fix for v5.13-rc6

- Handle changes to needed LTO flags in Clang 13 (Tor Vic)

----------------------------------------------------------------
Tor Vic (1):
      x86, lto: Pass -stack-alignment only on LLD < 13.0.0

 arch/x86/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
Kees Cook
