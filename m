Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A4732B76B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350572AbhCCLIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbhCCBTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 20:19:52 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DC7C06178C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 17:18:35 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id i4-20020a17090a7184b02900bfb60fbc6bso2052437pjk.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 17:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=kXt6NLWYAtxjmaKltDyJ+JjbjnCRS/rdW1UW9kwADMw=;
        b=G4GhP8aE1MSGVxUtRsQH5m2qOK113mkeWakDJRuxCbBmaFfrAPfKadkxA9zz9XQWYb
         mluCznbmnm3lv72Xcbpz+O98iXon64s87YubMVoCx0ttSFiXsNqFTPpagn6WnMz2cQ4f
         PsVgn3QgBpRIP1oqK9cKuYVxzZM8Fgx3qA6rI3IVmvW5VSFB/LxIfBtJqjpltS2Gc+Vf
         XHR4Kw1nw+9lZxkv8xW4ZuqvCKcxPmfrIeqZAKpXBR2zXvKidFESnczSwia4cm1rF0k0
         iOYHHUO9XZ/p4RsQQLvqjzMC3n99wdf66jHhTCmD6H6ERwM/RSJ0/JRUg92Q1mZ393z6
         ob8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=kXt6NLWYAtxjmaKltDyJ+JjbjnCRS/rdW1UW9kwADMw=;
        b=S6vuIISpTjOJJPsFZs/XNS/3NFDHv1VwQjmYzvrhq955CFCNQk15HFNHdt4DijAoHI
         6FG7T6T5i1Q7MrQ6r7W2iExQAa/aZQ1IW7nz+Nry1XqZdyObHjdQgyJIaQ1/YH0dc6xH
         9COUcNV9xdi3BYPqe/yHO9xwOQW2bo6GjPjt2FpySru9dTnvP+JG3Q9QyOcf/FVZUyUd
         S58qXeO8ktTV+RAHe75g4Yr1vtRyD3xaVglCao4fcjH48/QNHd7lKZMRBw8BVjWXBh5j
         X76APX8QZ1KMX4wAScel+FlvhD2xJM52sHcTAkQSF0hjvMGsGYuh6orecx7U+MUikkB5
         dZcQ==
X-Gm-Message-State: AOAM532EoGNPGNKdvtWkufeGjIqcmPS3o26KgOFTFL+2ozVavk2fF/W8
        Bd/8t6Lgzs6wxQhRpqqyNEbQDoaxQzXuRw==
X-Google-Smtp-Source: ABdhPJx6DgLXmVHJCZ3qvgXKB6yqTWeR1zYzjMm63qfrfbLO0bAV+X6jso/m1s9np59/16w8v8P7kQ==
X-Received: by 2002:a17:90a:7847:: with SMTP id y7mr7395837pjl.65.1614734314344;
        Tue, 02 Mar 2021 17:18:34 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id r16sm22271841pfh.168.2021.03.02.17.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 17:18:33 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Misc 5.12 fixes
Message-ID: <df3ee602-3690-2464-6651-a66e8cded633@kernel.dk>
Date:   Tue, 2 Mar 2021 18:18:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Two misc fixes that don't belong in other branches:

- Fix a regression with ia64 signals, introduced by the
  TIF_NOTIFY_SIGNAL change in 5.11.

- Fix the current swapfile regression from this merge window.

Please pull!


The following changes since commit 7a7fd0de4a9804299793e564a555a49c1fc924cb:

  Merge branch 'kmap-conversion-for-5.12' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux (2021-03-01 11:24:18 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/misc-5.12-2021-03-02

for you to fetch changes up to caf6912f3f4af7232340d500a4a2008f81b93f14:

  swap: fix swapfile read/write offset (2021-03-02 17:25:46 -0700)

----------------------------------------------------------------
misc-5.12-2021-03-02

----------------------------------------------------------------
Jens Axboe (2):
      ia64: don't call handle_signal() unless there's actually a signal queued
      swap: fix swapfile read/write offset

 arch/ia64/kernel/signal.c |  3 ++-
 include/linux/swap.h      |  1 +
 mm/page_io.c              |  5 -----
 mm/swapfile.c             | 13 +++++++++++++
 4 files changed, 16 insertions(+), 6 deletions(-)

-- 
Jens Axboe

