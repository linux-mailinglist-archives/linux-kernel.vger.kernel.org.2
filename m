Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641B132588F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 22:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbhBYVWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 16:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhBYVWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 16:22:14 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7387CC06178A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:21:07 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id m6so4487177pfk.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=aUPwe+Lv0Pq7eZxAaR9IsrePidXsf2TeRT20oO29XfI=;
        b=O9x83ny5HO659WN4fq+cowhIq1b4k2okPKMSiTXx2LL71zwUmmhO0laveLn0GfiivS
         mdzxUPdKfH8DXSz8sJAn9MrvejAjstWgLGxoj1c9IOfwVn1JWbumBI53+vSNZjachqdx
         XWmTHx8glsl4dFx2lipCUWoAMT+tjy9ac4Oz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=aUPwe+Lv0Pq7eZxAaR9IsrePidXsf2TeRT20oO29XfI=;
        b=cHsoIy7rIDxGRsPcKUSlXy4WW/OgMjDqH9hWLsH6UXybAchzS1GWjC8IvWuQmRmrgP
         C7WmRyAHAS535rdzY406e2PXeBzrGw4mqlRTRimHF2ZizmwSZfaNX2XenjeuIpcT7HRe
         mQp+p5Rd4dQNB+1L3A5grEwTAk30jAjzgw7cQHz4xmSog4z6ID56cGu7xyA9LtfUx2/h
         PiPQqaotbcIkYbNeLBv4zpF+kkC2bTmilidZjS6l9LqWOt1B5htYEkoJo3JyGAkGKxMa
         MOT5PzvwyIsAYtF7aZWWq4lzM+X7rR8OOhEHXsHPBYJ89BrHGysWoPjatUDeanLCvg9t
         x8Qw==
X-Gm-Message-State: AOAM531Llo47AkUTU/r2A+5yIXYXhiWJvheHa4Po/1AV1nvwKot+G1M2
        DuIniQEfkgETeYbeGCl4zCcFLA==
X-Google-Smtp-Source: ABdhPJwJAwE/DfDPk/7zI6HLI5FTdq5yxvMelGd+cytRtUanJ7m9sG46gkbT/QeQTY3OFy0PWXc7MA==
X-Received: by 2002:a63:cb52:: with SMTP id m18mr4781086pgi.358.1614288067035;
        Thu, 25 Feb 2021 13:21:07 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b3sm6708840pjh.22.2021.02.25.13.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 13:21:06 -0800 (PST)
Date:   Thu, 25 Feb 2021 13:21:05 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [GIT PULL] orphan-handling fix for v5.12-rc1
Message-ID: <202102251318.22C44170@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this small orphan-handling fix for v5.12-rc1. Another case
of bogus .eh_frame emission was noticed under CONFIG_GCOV_KERNEL=y.

Thanks!

-Kees

The following changes since commit f40ddce88593482919761f74910f42f4b84c004b:

  Linux 5.11 (2021-02-14 14:32:24 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/orphan-handling-v5.12-rc1

for you to fetch changes up to f5b6a74d9c08b19740ca056876bf6584acdba582:

  vmlinux.lds.h: Define SANTIZER_DISCARDS with CONFIG_GCOV_KERNEL=y (2021-02-25 13:15:25 -0800)

----------------------------------------------------------------
orphan-handling fix for v5.12-rc1

- Define SANTIZER_DISCARDS with CONFIG_GCOV_KERNEL=y (Nathan Chancellor)

----------------------------------------------------------------
Nathan Chancellor (1):
      vmlinux.lds.h: Define SANTIZER_DISCARDS with CONFIG_GCOV_KERNEL=y

 include/asm-generic/vmlinux.lds.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
Kees Cook
