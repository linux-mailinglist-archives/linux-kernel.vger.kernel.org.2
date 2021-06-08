Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670D439FD80
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbhFHRXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhFHRXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:23:21 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4880DC061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 10:21:16 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x73so16231297pfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 10:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Gy5gyIqm3jSbKugL4sOoQm3uZIvo/xly9w4VyDwdJm8=;
        b=V0l98w1MsAcAPuaxrmx1kfNm7AZJX9RRAse1UHAgkPdYJNxLyqtI05V70jssldbdYQ
         8j8BCUq60+6sfakvv6C/GCsPrEV7pnoqSTUBzqROfn+3zU4uHiW0Vl7qe5KsCYcjRTxi
         lA8vctI2RsptQLwSMpLV7qHv8Q9RvsbUB+g7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Gy5gyIqm3jSbKugL4sOoQm3uZIvo/xly9w4VyDwdJm8=;
        b=NgzZmPHncgW9ETbUX1VbldAbxNanQkuqgEIvrJifeZqKmOnFfXRun1EmbvffafBivJ
         hsBzKavfoRJWGgh/zWzCsNK09QpxacpaEBDYOjc33Y5PFyKXtXOpsU+m/Qj42RRQWncM
         +/p58R+uk+Y0pPy0TQXvcI8qckz/LdKlupGqZEO0C9YZKj/eIM0D1Cq4CyCZrxtqzgD/
         BydrKdTcyC/N3xmeT1rtYdYEZ8rAen83/q3xGDy/t3AIDPMezFL9KxE5GrTUxh4AiuUv
         yOfgjicBPlc6AoifDy46XHM9Css37+jMh9DsUc5zS3lklZtkQJJG6aosDQOPOvaFzd91
         oiwg==
X-Gm-Message-State: AOAM532SoXXdokDICzz48xlvHQ96Cr36jXha2uoqimU1CklSRHKXq42x
        1x725twDq2mJ5utvAnhEWFE3+A==
X-Google-Smtp-Source: ABdhPJwWwUIhaS9L4emAUvEK9b4yNAi7TKMvmPtabSKU8EBeBCDKyF5LWFqVshNO+1yp1/KiEQBSdQ==
X-Received: by 2002:a62:1942:0:b029:2e9:debd:d8b1 with SMTP id 63-20020a6219420000b02902e9debdd8b1mr967561pfz.9.1623172875024;
        Tue, 08 Jun 2021 10:21:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g18sm11167314pfi.199.2021.06.08.10.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:21:14 -0700 (PDT)
Date:   Tue, 8 Jun 2021 10:21:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [GIT PULL] orphan section fixes for v5.13-rc6
Message-ID: <202106081019.A88177D6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these orphan sections fixes for v5.13-rc6. These two corner
case fixes have been in -next for about a week.

Thanks!

-Kees

The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:

  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/orphans-v5.13-rc6

for you to fetch changes up to d4c6399900364facd84c9e35ce1540b6046c345f:

  vmlinux.lds.h: Avoid orphan section with !SMP (2021-06-02 12:43:55 -0700)

----------------------------------------------------------------
orphan section fixes for v5.13-rc6

- Avoid orphan section in ARM cpuidle (Arnd Bergmann)

- Avoid orphan section with !SMP (Nathan Chancellor)

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: cpuidle: Avoid orphan section warning

Nathan Chancellor (1):
      vmlinux.lds.h: Avoid orphan section with !SMP

 arch/arm/include/asm/cpuidle.h    | 5 +++--
 include/asm-generic/vmlinux.lds.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
Kees Cook
