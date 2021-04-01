Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE5D3521C5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbhDAVjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbhDAVjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:39:22 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E678AC0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 14:39:20 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h25so2417180pgm.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 14:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=JbYGPXM9MppFzzOc6a75EzwhFrSHPR8Nkt7+cyvmtv8=;
        b=Sokv0wMxDS3iavZIDASWRIUD5WNqDzVXlijmdv4G+E60ODbaUUYMCZCAEqFLjvaf2p
         GBaP0hFnf/JPb2YHjs1ucIqwcVQihfme4baNH31ZVYdz2A6Q1Qd8Yvo1YDru84hHNd73
         HwNBzRJQlBYelwYhcTSOe6Lg4cwOsJMp1ME58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=JbYGPXM9MppFzzOc6a75EzwhFrSHPR8Nkt7+cyvmtv8=;
        b=HA1lxZS9Hv9dMXaYkjGl64F7iTKpkozxEoULBUQzYoANzuIwniJEA5fC4tCECe7ZZc
         weCdAdQSngRqRr/ZXIEXE9jy86tk2zz6xcheqii/ooqBpIZDVdnTmVROTkrT0WEbSTOp
         ZcEFs/OkgbinKoejLMQF7YLRn7CZ26kzN1CxLB2nB+ByKlGfytC3IwO7CtNgbmYHc/SI
         I6U/Q6xiis7tglKllCFGEyiyNZQwsZT+7XprzIu5LVUMZkZlbilDwt9q/n5V1I0XV5MS
         IGxILS/GTi5rKx17U2a/qrQa1Qb36zifB6tzJcxmctFWwua8GnAfHftM5kxrayyA2CFK
         84NQ==
X-Gm-Message-State: AOAM5321SLjUm6ZrxMcn/IUoDZWwvfYbtO7O6s38G3CuoKY4IlyfBYwK
        uk0x7IMRsHrytNTSixiUQ6o9Cg==
X-Google-Smtp-Source: ABdhPJzBWyABUBUyBM9ZRntLbXqge5hAucOVDKV+ejvKekDASN/D5KYmevZSagIgPE6eN7oPLZcuMA==
X-Received: by 2002:a62:5ac4:0:b029:22e:e8de:eaba with SMTP id o187-20020a625ac40000b029022ee8deeabamr9357545pfb.4.1617313160524;
        Thu, 01 Apr 2021 14:39:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v25sm6244669pfn.51.2021.04.01.14.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 14:39:19 -0700 (PDT)
Date:   Thu, 1 Apr 2021 14:39:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [GIT PULL] LTO fix for v5.12-rc6
Message-ID: <202104011435.78CF22D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this LTO fix for v5.12-rc6. It seems that there is a bug in
ld.bfd when doing module section merging. As explicit merging is only
needed for LTO, the work-around is to only do it under LTO, leaving the
original section layout choices alone under normal builds.

Thanks!

-Kees

The following changes since commit a5e13c6df0e41702d2b2c77c8ad41677ebb065b3:

  Linux 5.12-rc5 (2021-03-28 15:48:16 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/lto-v5.12-rc6

for you to fetch changes up to 6a3193cdd5e5b96ac65f04ee42555c216da332af:

  kbuild: lto: Merge module sections if and only if CONFIG_LTO_CLANG is enabled (2021-04-01 14:15:59 -0700)

----------------------------------------------------------------
LTO fix for v5.12-rc6

- Only perform explicit module section merges under LTO (Sean Christopherson)

----------------------------------------------------------------
Sean Christopherson (1):
      kbuild: lto: Merge module sections if and only if CONFIG_LTO_CLANG is enabled

 scripts/module.lds.S | 2 ++
 1 file changed, 2 insertions(+)

-- 
Kees Cook
