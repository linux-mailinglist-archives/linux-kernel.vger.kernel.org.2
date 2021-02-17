Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F106631E0E1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 21:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhBQUzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 15:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhBQUyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 15:54:45 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF849C061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 12:54:05 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id m6so9231750pfk.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 12:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=G18qHb6dI245kg7JpeGBoyKF9XuljCJD5/T+FtzrDvs=;
        b=g2/wMmTulKzVZh1baBmPMbG7CLV+RDd3yiSeLxw+/El4Ob2sBncU/XFNruf4xhW5gg
         QdCosVbPOaYmkvmwTjQRAOpB7hAU0rcX30njNzn+UzWFmdOZKgxT2nOQpMhQGoW3QJnn
         Dv7G5p32B3CbBRQ53js0yE+t7i74qaqjpRvR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=G18qHb6dI245kg7JpeGBoyKF9XuljCJD5/T+FtzrDvs=;
        b=JJmX5AtwJViKtotJ63qYElJk7ycmC97asHvhkLQ3JLSlj+x6xb1lcASnd1Psa0NODv
         ZW/3dVvjNsB9doBU66U7vls/k48811RcqP5v0rxbcbOAEPjmpwNG3JxnVkEY4E0LOMst
         pYmWLvf6ftrUu1DsWTefxlyprU7WTp7Z4DpYXfWjQjO1okr8tuhELl5a5Kk5BMvdDmib
         lJyQ1bJBiKBmUUGXCYjzbuUGOF+9aaX8Zp9J80dDy4RO7jvZn4qJ6hKXVVyfdSgK6PiZ
         IyH4NPRczbl1TjMHzk2loaaJkrW2Waso6Cvp1SQQziOBK4ojeF3U/ValS1zQGvwa7v/3
         mFRA==
X-Gm-Message-State: AOAM530tbHgL9RaEtKhbDabb7+9e6D/ISyx+iGuGnClzJSKBw+J8+iF7
        25GDmhCSOM1e6PaTQ/cKvBuuiQ==
X-Google-Smtp-Source: ABdhPJyz4y82FcOrr6KSQXf1dBOVHPw9RGGaJJdexwBcq7mkM4oP7fPkmMO57P5FyQwiuAFhEmNplg==
X-Received: by 2002:a63:4922:: with SMTP id w34mr1034906pga.423.1613595245375;
        Wed, 17 Feb 2021 12:54:05 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r5sm3266423pfh.13.2021.02.17.12.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 12:54:04 -0800 (PST)
Date:   Wed, 17 Feb 2021 12:54:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Paul Cercueil <paul@crapouillou.net>,
        wanghongzhe <wanghongzhe@huawei.com>
Subject: [GIT PULL] seccomp updates for v5.12-rc1
Message-ID: <202102171252.B769A2FB@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these two small seccomp updates for v5.12-rc1. This contains a
fix for a build failure that went unnoticed for many years, and a memory
barrier correction.

Thanks!

-Kees

The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

  Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.12-rc1

for you to fetch changes up to a381b70a1cf88e4a2d54f24d59abdcad0ff2dfe6:

  seccomp: Improve performace by optimizing rmb() (2021-02-10 12:40:11 -0800)

----------------------------------------------------------------
seccomp updates for v5.12-rc1

- Fix a non-FILTER build failure for some architectures (Paul Cercueil)
- Improve performance with correct memory barrier (wanghongzhe)

----------------------------------------------------------------
Paul Cercueil (1):
      seccomp: Add missing return in non-void function

wanghongzhe (1):
      seccomp: Improve performace by optimizing rmb()

 kernel/seccomp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
Kees Cook
