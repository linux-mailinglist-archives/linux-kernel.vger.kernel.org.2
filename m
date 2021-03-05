Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAFD32F667
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 00:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhCEXJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 18:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhCEXJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 18:09:38 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047D0C06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 15:09:38 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id h4so2352313pgf.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 15:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=8+PpfN+B8xrbm5UY4sbmeWDIpxKk8pPbBk+YCoSPs0c=;
        b=KydYvF8U1MonpSyETreBpcwuSzGahT1viYhEAJLpxZ9LKhzCW2qbLvbk4afSerYpSv
         XAGnEdo1NO5U0/SmAevZ167pwA9CzOWLj7KxvAnKfEofn+u0j7BNUB9I0PE2ecR4VhAS
         5oszGaAytztqdq72ErQxLwhq8M5uvUOznfZI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=8+PpfN+B8xrbm5UY4sbmeWDIpxKk8pPbBk+YCoSPs0c=;
        b=apTFZZyRkDD/c0VcnPBAjcWdKCXAshFx80TufzQ/UkCULEimjuva6DVXI7LcIjTW1S
         7JeCYuf+gTShMbUqGk/I1DnZqF/wBEWfXP1hGaVB/O9daJYKBYyqmzlC9Hzc9jh/2Pbc
         TGWr+R520yJXWQgwC79O35RMlhvhBU341DZ5A4k8FvUm6ztqAJjlLusbZiTH6UEtjpop
         8DwRXC3GOuqLzJqyzlo+pJ75gj///eWJQ3J8FfP212jw1b6RxJj1MgnICu3eLL241YGq
         rLPoTRBj9jGiol8UqvOMtRM1de40dcoGauiHWjiN3VTFKcAqem3Cv1M/12mvavyLAtZn
         iqvg==
X-Gm-Message-State: AOAM530um7VjKWLCEZVn0c63LCthcuA+SyMae98Ktb4uHuNIt85DgtA7
        LYrT9/gynN/dy0YZ1D9fCO2lsA==
X-Google-Smtp-Source: ABdhPJzu4YVmWFwrcCiAdQWAZqgrYYXS1bAFy6ViM0v6HQrs6/uyOXBN9U9Ys4FD+RPSFQMQExRP/w==
X-Received: by 2002:aa7:8e51:0:b029:1ed:2928:18ff with SMTP id d17-20020aa78e510000b02901ed292818ffmr10851342pfr.76.1614985777598;
        Fri, 05 Mar 2021 15:09:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p8sm3426289pff.79.2021.03.05.15.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 15:09:36 -0800 (PST)
Date:   Fri, 5 Mar 2021 15:09:35 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        syzbot <syzbot+d0cf0ad6513e9a1da5df@syzkaller.appspotmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [GIT PULL] pstore fixes for v5.12-rc2
Message-ID: <202103051509.D5DDF1D0@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these small pstore fixes for v5.12-rc2.

Thanks!

-Kees

The following changes since commit 19d8e9149c27b689c6224f5c84b96a159342195a:

  pstore: Fix typo in compression option name (2021-02-18 12:27:49 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.12-rc2

for you to fetch changes up to 7db688e99c0f770ae73e0f1f3fb67f9b64266445:

  pstore/ram: Rate-limit "uncorrectable error in header" message (2021-03-02 11:52:31 -0800)

----------------------------------------------------------------
pstore fixes for v5.12-rc2

- Rate-limit ECC warnings (Dmitry Osipenko)

- Fix error path check for NULL (Tetsuo Handa)

----------------------------------------------------------------
Dmitry Osipenko (1):
      pstore/ram: Rate-limit "uncorrectable error in header" message

Tetsuo Handa (1):
      pstore: Fix warning in pstore_kill_sb()

 fs/pstore/inode.c    | 2 +-
 fs/pstore/ram_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
Kees Cook
