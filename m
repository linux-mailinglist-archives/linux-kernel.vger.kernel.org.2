Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07753FBC6B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 20:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238645AbhH3S26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 14:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238280AbhH3S2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 14:28:51 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80B5C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 11:27:57 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id v123so12858548pfb.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 11:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Mz42W/Lx43y6CcuCJpr6nNW2Lf79xV+Oh1YYCpvYFXY=;
        b=jHyLx/jQQd0/go0ng9MmCROtCBvWRW1jJWRWt+5N4mZNdw08Art/r5RXbTKYhW02Pr
         gFozWUjOdbvKOLi18vnhwKFINft1ClPa8tq2Z/AxacTNomYgirniezgc3vwvrZqMp3zU
         HyARwx0oVGh80z/g7HDmifIWMmVsdHG6hDM5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Mz42W/Lx43y6CcuCJpr6nNW2Lf79xV+Oh1YYCpvYFXY=;
        b=um9cGfdz9TXEJc5GeOA4T3XtYmR0KYpemvFdU/Vyz5WN9WDUzkvPxy+OLfNMld6k+r
         HiRkJrwSqVJmG1/lifGrz9QiFN7haVGw+k4+ql4EHLkwh5lkmQtUOgsCo5k96Dycnyst
         PTYGBcJ1kKXF+VVoWGs883Sr5wn22/FEFvcbxuH3mUbVqR1gF3+As0aHizjCvwNdZsCZ
         JdSo+wdV6uv+vnAC0YD7jopJVV4i+yUMj9vyYPU2L2VqEDtrIHoERN0OvCQ4podjuAIq
         MbQ2d50Lj07l1rd4AAhuuMweQLovwZuqIrCq3gLa5NZmjUHmyC7KhiVkWMr6ZHlUJWr7
         fgjg==
X-Gm-Message-State: AOAM532HULub/00OHUu09SNlNO7L7tsMl+RtgkRVY5j8IRS+MmsPujQ3
        j/TPm7TRtYUe/sDqKD3XLzdOKg==
X-Google-Smtp-Source: ABdhPJxxZJQIBMc6Dsq5ghhAjnvEVvZ5nNMfDKrV02lD/0HepnMIzBryoTQXACy/mPtWNDY4mhBYeg==
X-Received: by 2002:aa7:80d1:0:b029:399:ce3a:d617 with SMTP id a17-20020aa780d10000b0290399ce3ad617mr24408847pfn.16.1630348077240;
        Mon, 30 Aug 2021 11:27:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t23sm177071pjs.16.2021.08.30.11.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 11:27:56 -0700 (PDT)
Date:   Mon, 30 Aug 2021 11:27:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux@googlegroups.com, glider@google.com,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [GIT PULL] hardening updates for v5.15-rc1
Message-ID: <202108301127.836C1F4D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these hardening updates for v5.15-rc1.

Thanks!

-Kees

The following changes since commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c:

  Linux 5.14-rc2 (2021-07-18 14:13:49 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v5.15-rc1

for you to fetch changes up to a8fc576d4af2f23a87a586424252df97f0ad0b06:

  lib/test_stackinit: Add assigned initializers (2021-08-22 00:21:36 -0700)

----------------------------------------------------------------
hardening updates for v5.15-rc1

- Expand lib/test_stackinit to include more initialization styles

- Improve Kconfig for CLang's auto-var-init feature

- Introduce support for GCC's zero-call-used-regs feature

----------------------------------------------------------------
Kees Cook (5):
      hardening: Introduce CONFIG_ZERO_CALL_USED_REGS
      hardening: Clarify Kconfig text for auto-var-init
      lib/test_stackinit: Fix static initializer test
      lib/test_stackinit: Allow building stand-alone
      lib/test_stackinit: Add assigned initializers

 Makefile                   |   5 +
 lib/test_stackinit.c       | 253 +++++++++++++++++++++++++++++++++------------
 security/Kconfig.hardening |  71 +++++++++----
 3 files changed, 242 insertions(+), 87 deletions(-)

-- 
Kees Cook
