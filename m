Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C3236B8EA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbhDZS3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbhDZS3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:29:49 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FCFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:29:07 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id s20so13570664plr.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=+L09WdnHd7OMUNOvW0m1uPWNftuJPLd6aN6+ph9I8d4=;
        b=K1h++3PkbfvgPa5HNzZ3yatNTjfDnEITn27wsG3dON/qR8nU+8HdowF0+chnBERnHX
         WE35xFAbCry3nYFEhrNy33MR+OCnmhPd9sskwG8ZyMif6rp9G2DnYaEYFbTwfAARiwcE
         AN54dVhog8ZRdMIVODTKnBPvEXkzYyebb5TTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+L09WdnHd7OMUNOvW0m1uPWNftuJPLd6aN6+ph9I8d4=;
        b=l5V5UWVrAbont8CnDBnvqqRbI/+ciMRmdeJyXMTb/FI5fCT9lqTgviPksjV4NDJJ1m
         AZv8ahbtvEVyyunlLXmYT/Cdv0hUHONHLYUeLz0p7EMX0yYgEvWZDu1VO/XZpiuK0/ix
         cIxzKz9Y9uiltO7ms3r0c7zUSwYwtdRU2X+eRuVg2klGIZ6hUY8QUqq68VlVDBjbzyaR
         dzPqfDkqvJY7gNOKt2Sst0/j5N9gRJxxQsxgtWg237/SupgSlhRqiY2rkmU/PPnPL3im
         cfCw8gTXPo0iUVbkblyZRiUnSBmtj3fU73nu5Lvw+WluOPTu33Jea0CkBWwvfd44T2fm
         76CA==
X-Gm-Message-State: AOAM5323bXmghzuTkAXuJt/i31A0rFcyDLQp2XpA4QdqRSB4PgqZpGpK
        QLPByU3SPUgZ0vp9b8/1PLVjpQ==
X-Google-Smtp-Source: ABdhPJzEQe2s0o+ab7Fdoy5J42Uy1I52D52kLASDkzd2TRDXe6h4KtI9eVEeFRQyhlWKMdN/fGp+dw==
X-Received: by 2002:a17:90a:7897:: with SMTP id x23mr416387pjk.133.1619461746976;
        Mon, 26 Apr 2021 11:29:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b20sm117325pju.17.2021.04.26.11.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 11:29:06 -0700 (PDT)
Date:   Mon, 26 Apr 2021 11:29:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Cui GaoSheng <cuigaosheng1@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Kenta Tada <Kenta.Tada@sony.com>
Subject: [GIT PULL] seccomp updates for v5.13-rc1
Message-ID: <202104261127.43AC34A519@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these tiny seccomp updates for v5.13-rc1.

Thanks!

-Kees

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.13-rc1

for you to fetch changes up to a3fc712c5b37aec802438fe0de095d7f6f3827a3:

  seccomp: Fix "cacheable" typo in comments (2021-03-30 22:34:30 -0700)

----------------------------------------------------------------
seccomp updates for v5.13-rc1

- Fix "cacheable" typo in comments (Cui GaoSheng)

- Fix CONFIG for /proc/$pid/status Seccomp_filters (Kenta.Tada@sony.com)

----------------------------------------------------------------
Cui GaoSheng (1):
      seccomp: Fix "cacheable" typo in comments

Kenta.Tada@sony.com (1):
      seccomp: Fix CONFIG tests for Seccomp_filters

 fs/proc/array.c  | 2 ++
 init/init_task.c | 2 +-
 kernel/seccomp.c | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

-- 
Kees Cook
