Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B028F3E98E7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 21:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhHKTg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 15:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhHKTg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 15:36:58 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EB8C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 12:36:34 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id oa17so5220237pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 12:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=1hc1ss7UZ2vRByOSjdL0G1JcDylvgMzQfjGPucb80iM=;
        b=U1jfD0I0J5xYqfX2dD3I/J9EG0MNLgtSkR9rHUxGD8YzlZ6X7RG+nStTlmH5Naifoq
         H6C3cWoR1gZgCrZ/SH5kO4MlHW7xyOpvccpeeppkg/LOr5SWnHTvo/U95P/RvSh3htvs
         lADKBrxV3CPnVkZYSvYRi5SoqJzzgj8wyjrBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=1hc1ss7UZ2vRByOSjdL0G1JcDylvgMzQfjGPucb80iM=;
        b=evpMMuSlY4Frc/lIYE4sqbjC2cWZo9Ot3R6BNPtWthR/cjFFDA+6SfM2Yp/LtXl86W
         +iZdhxUqkdY8vKJCZlX/KPXlVOZWr6BArr4ByrVvhZoov3N7SWpaALetPbcnIc3veFh3
         GrmiuSsnCTNGVoT8HsTs9suDFnfK6QurgxUY98WnzkW7cpkPKqWI8Um6tTYrWz0WU5qw
         +FAekDjycFmilMRMfy4uSXAABvTR3VSGncOK1uqVB8wtEDpf8QClzpgn2sh2Vr4ZrIwr
         rz//iLWYJ662eBcTRjx2Ia2rQQIWIPz6HDvQDZnanNzQ9/kPOO8qCEcV5C29lojo/S/P
         Y9vQ==
X-Gm-Message-State: AOAM5326JiLaux4D3fenU4Tk3hI+T+8EqDcaqPYg7Wx1s1nyjdzGXNoo
        GTINr0gVLFpH9xYkYlnB83/5ZA==
X-Google-Smtp-Source: ABdhPJyZfiE7eF5hyyREYwtWdMAk1jFUm1504ToLOdu8oAGC62+iqLck2zB90kx4jfMMKq/xjLMOxw==
X-Received: by 2002:a17:90a:ba8e:: with SMTP id t14mr182216pjr.176.1628710593717;
        Wed, 11 Aug 2021 12:36:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e4sm286978pgt.22.2021.08.11.12.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 12:36:33 -0700 (PDT)
Date:   Wed, 11 Aug 2021 12:36:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [GIT PULL] orphan sections fix for v5.14-rc6
Message-ID: <202108111236.CF876AFAA@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this orphan sections fix for v5.14-rc6.

Thanks!

-Kees

The following changes since commit 36a21d51725af2ce0700c6ebcb6b9594aac658a6:

  Linux 5.14-rc5 (2021-08-08 13:49:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/orphans-v5.14-rc6

for you to fetch changes up to 848378812e40152abe9b9baf58ce2004f76fb988:

  vmlinux.lds.h: Handle clang's module.{c,d}tor sections (2021-08-11 12:19:58 -0700)

----------------------------------------------------------------
orphans fix for v5.14-rc6

- Handle changes to Clang's Sanitizer section layout (Nathan Chancellor)

----------------------------------------------------------------
Nathan Chancellor (1):
      vmlinux.lds.h: Handle clang's module.{c,d}tor sections

 include/asm-generic/vmlinux.lds.h | 1 +
 1 file changed, 1 insertion(+)

-- 
Kees Cook
