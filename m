Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1C7369D41
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 01:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbhDWXXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 19:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhDWXX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 19:23:27 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A55C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 16:22:48 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ja3so207040ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 16:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9KdCYVYjsxm43pdzjAW7S0Q2+F1LcWUUXR0r+zmo39s=;
        b=e3t/dADON64hxvBTxTkoSr3n+kMdchKnreD351DeJmixuumfC7fIkQSUbls7LMo8Ds
         7nADt0soBN11Td+VpBE8KUqzbkifFvV0cdfJ6OnHLLbxCDnV8KuU1VruL1PcMjrn2mRt
         6RkZJu5o1mUNUGh4GFb0m26TsBsqoyAjSYv0bmE13zeCjVb98qVCjX/bFRIRmQ2TZsqk
         OLyTxfQIsV4Ys5DLujQfjIPLekO2nsOTlVAu8Z21jdI493Nk/mfjVustBiVCpx8x2QsT
         jza1EFUhLL7hi+sl+ZoqTZ21Z60xLm51AlHXKET0RuN+8VzyuGy3Csh8GVKlmgUcrpcN
         94MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9KdCYVYjsxm43pdzjAW7S0Q2+F1LcWUUXR0r+zmo39s=;
        b=BaqbIpBGy6I2q3YbXeuLyKvofTF/jIrHRbxuMtNb22A6tMmk9qMyaQpbgfPYemPAZm
         0jOJh41WOyGQzfwSL4bDljcAlEjcufeye0dAbUJKyY0d0v8yotS6poyH+dUh9NSZ+v8d
         LV4sz5hKl4AmLjRNsfnUSLHjA7nI7aDGV1eRimbpgzLdLOgebL5PMdZknABl523V39zr
         eYJrz1keo6SUeTGZuwyCSg5TZxOtN+tMie6KfWAciry3avb4ncoA80Ty3HbALz2Mwo/N
         ky5w3IW981dFGI9Iwi6SF/4HXo7c+9f9jkO2VPjgAntupgpzzN9ChwIV2dbA3vauMJTt
         bcUw==
X-Gm-Message-State: AOAM5304/3dpvM+yn6ANv/1gLh6hCLkOD8QFmG4vBBEjjp1L+mlOpo9C
        UalY81Q2xk8FuDcGx3YUibJCR1n+d4dGHI1JquhdOJHjmBTFEA==
X-Google-Smtp-Source: ABdhPJyRYx8qR/OoKBcHt47tR0XtriE/q6Xr5yh5O4DmKN830KcuvaeeFVJPK4RVxsSfReNGrQ95KPpulby28bOjrro=
X-Received: by 2002:a17:906:f285:: with SMTP id gu5mr6736919ejb.226.1619220167200;
 Fri, 23 Apr 2021 16:22:47 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 24 Apr 2021 01:22:36 +0200
Message-ID: <CACRpkdY6g7eoqyJ-OHijbR_Gw2W7uoNF5Z6+-at5OBvaH9_kqw@mail.gmail.com>
Subject: [GIT PULL] final pin control fixes for v5.12
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

some late pin control fixes, would have been in the main pull request
normally but hey I got lucky and we got another week to polish up v5.12
so here we go.

One driver fix and one making the core debugfs work.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit e49d033bddf5b565044e2abe4241353959bc9120:

  Linux 5.12-rc6 (2021-04-04 14:15:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.12-3

for you to fetch changes up to 482715ff0601c836152b792f06c353464d826b9b:

  pinctrl: core: Show pin numbers for the controllers with base = 0
(2021-04-22 02:13:42 +0200)

----------------------------------------------------------------
Late pin control fixes for v5.12:

- Fix the number of pins in the community of the Intel
  Lewisburg SoC.

- Show pin numbers for controllers with base = 0 in the
  new debugfs feature.

----------------------------------------------------------------
Andy Shevchenko (1):
      pinctrl: core: Show pin numbers for the controllers with base = 0

Linus Walleij (1):
      Merge tag 'intel-pinctrl-v5.12-4' of
gitolite.kernel.org:pub/scm/linux/kernel/git/pinctrl/intel into fixes

Yuanyuan Zhong (1):
      pinctrl: lewisburg: Update number of pins in community

 drivers/pinctrl/core.c                    | 14 ++++++++------
 drivers/pinctrl/intel/pinctrl-lewisburg.c |  6 +++---
 2 files changed, 11 insertions(+), 9 deletions(-)
