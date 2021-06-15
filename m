Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6363A8C60
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 01:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhFOXV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 19:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhFOXV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 19:21:59 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C14EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 16:19:53 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id l184so369619pgd.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 16:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=QJotxHm5FEFUgjDuPehIgKL0ImSRi44Zxdu36+ePGFg=;
        b=IqjtESMbWwTeCkn5kgZLerD4E5KmwWJUryDvNaScP+gigzJeTwE2ciWkvnDbjb8SCh
         tq0cj2NbsX6FJcxWog/d0WUTcA/ZYZlMYW27Id92dlCkAfn0SJshKSGDZi7WwtEmv9Hz
         my7Xb5Yp87/JeJSZh9MA44AVWXYgib/GRCXD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=QJotxHm5FEFUgjDuPehIgKL0ImSRi44Zxdu36+ePGFg=;
        b=gK61wrWHfL32RcJ02FB7hRR2eoa8R3hEKKPSvrij9xhYpDB15pPrMSWAHoYtcaX2KT
         a4t9ttSF0TFHGeyPXzmqIhoutI0ldFuRu7SwdMAGg4T35ZprCR2P1chKW4wVIJyeUDL7
         iC+zU+sg9BTt+HepFM6vYkOPtji+8wAA1aYkHC2ZNvezBrFL1Dw2jVLEgKF3+HqP/NmV
         ZgTI98v8GaEnzd6sZYpdMJE5OAKelxiD3gYpsv1hZFyL4PeDU5dtDME71WKvXHKcAjag
         vtPo7T2OQ3yrEs1VWko8dLrF4eQ+tuMp+JCp4ADbqqwRDX6OqDHeMHLsXCh6ePfZNAnp
         3s3g==
X-Gm-Message-State: AOAM530XaY42RxZXC1+vTfyvNiu7lzJhXlj6FaA/c/XRpr0kSKI4H94A
        rjLyb21N+MG4TxTGyCM4Bujz0w==
X-Google-Smtp-Source: ABdhPJz/TPpK9tLVCWa5LVkxT+qmY+sF9l2ccBTgf1m3vXm2FzrJuUd5NA1BQ9gmuWUfmXcSJRw1FQ==
X-Received: by 2002:a63:ba18:: with SMTP id k24mr1892467pgf.65.1623799192849;
        Tue, 15 Jun 2021 16:19:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w123sm192875pfb.109.2021.06.15.16.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 16:19:51 -0700 (PDT)
Date:   Tue, 15 Jun 2021 16:19:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tor Vic <torvic9@mailbox.org>
Subject: [GIT PULL] Clang features fix for v5.13-rc7
Message-ID: <202106151615.A5467A03C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this additional Clang feature fix for v5.13-rc7. It seems
Clang has been scrubbing through the missing LTO IR flags for Clang 13,
and the last of these "only with LTO" flags is fixed now. I've asked
that they please consider making these changes in a less "break all the
Clang kernel builds" kind of way in the future. :P

Thanks!

-Kees

The following changes since commit 2398ce80152aae33b9501ef54452e09e8e8d4262:

  x86, lto: Pass -stack-alignment only on LLD < 13.0.0 (2021-06-11 10:33:45 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/clang-features-v5.13-rc7

for you to fetch changes up to 0236526d76b87c1dc2cbe3eb31ae29be5b0ca151:

  Makefile: lto: Pass -warn-stack-size only on LLD < 13.0.0 (2021-06-14 14:52:38 -0700)

----------------------------------------------------------------
Clang feature fix for v5.13-rc7

- The "-warn-stack-size" option under LTO has moved in Clang 13 (Tor Vic)

----------------------------------------------------------------
Tor Vic (1):
      Makefile: lto: Pass -warn-stack-size only on LLD < 13.0.0

 Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
Kees Cook
