Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD189402447
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 09:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbhIGH15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 03:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbhIGH1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 03:27:55 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40B0C061757
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 00:26:49 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id n27so17837875eja.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 00:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=IWZdd34mYgIPewtgc5tJtV8hbSTMXe/opG3OPllHdhA=;
        b=aJL5RU3be4VNEvtQHHggMa3w2xhD6DUNln6TqrlWmXjHBx3Y+tTRHAjqf38TcAkkYs
         d3Puy2cd/AOoPSHdM00SuqgtqIXakD0rR8HKBvXcniWIGnNiiWxzFdVRPkA8AgOGbAQl
         JCE4LB8XhxSK+77L1zooc6EEqGYRFhSrZUwQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=IWZdd34mYgIPewtgc5tJtV8hbSTMXe/opG3OPllHdhA=;
        b=Cv5BVjk5RH0mOty0hzX8H2sTlP9v4rFm+cOCyQRcv8T8Nt37ruMLsNH031N6ga5xxP
         ZkIFyupQSEOr/fREph/a8VaasilfiteGqFertibNII19sSjLouUoRnGcI4v4TpjIbRuD
         L5ZlP10d/ppgJWZ2qpsBFmwCwIevUn2g+/dcZN0g7wkmRzeQyrkqVn9mmslUYXLQahS5
         3+XIryZysM094yMNlVagpIgyqKyKmvTXWIFXI5VKIvPJ7fmypw+XQ6JDL0Md7zETS5MG
         Ms83DPrWUQMTetHws8RGlewSjhtwoRjOPRR2ljq3VyFnIKHznv8Z7IBEN5HlA07c/B36
         x31Q==
X-Gm-Message-State: AOAM533upOVYcf72maPxL/tEZ1rJ2E6HInnEGxeUHJElICiMmr1Tukop
        ixrNLv+EvKplOI0VzE9lCEFS0shgX283eg==
X-Google-Smtp-Source: ABdhPJx9aaD2luS3+7Z2YZO5jby4bcPmlEONqstwpExgmeqfKB0+0p41yoEhopszjtcse2ss1fxsHQ==
X-Received: by 2002:a17:906:608e:: with SMTP id t14mr17228650ejj.441.1630999608158;
        Tue, 07 Sep 2021 00:26:48 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-16.catv.broadband.hu. [86.101.169.16])
        by smtp.gmail.com with ESMTPSA id c10sm5071451eje.37.2021.09.07.00.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 00:26:47 -0700 (PDT)
Date:   Tue, 7 Sep 2021 09:26:45 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse update for 5.15
Message-ID: <YTcUNWiS2+m705i7@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.15

- Allow mounting an active fuse device.  Previously the fuse device would
  always be mounted during initialization, and sharing a fuse superblock
  was only possible through mount or namespace cloning

- Fix data flushing in syncfs (virtiofs only)

- Fix data flushing in copy_file_range()

- Fix a possible deadlock in atomic O_TRUNC

- Misc fixes and cleanups

The recent commit dates for the two head commits are due to a trival bug
fix being folded in.

Thanks,
Miklos

---
Miklos Szeredi (9):
      fuse: fix use after free in fuse_read_interrupt()
      fuse: name fs_context consistently
      fuse: move option checking into fuse_fill_super()
      fuse: move fget() to fuse_get_tree()
      fuse: allow sharing existing sb
      fuse: truncate pagecache on atomic_o_trunc
      fuse: flush extending writes
      fuse: wait for writepages in syncfs
      fuse: remove unused arg in fuse_write_file_get()

---
 fs/fuse/control.c   |  10 +--
 fs/fuse/dev.c       |   4 +-
 fs/fuse/file.c      |  45 ++++++++----
 fs/fuse/fuse_i.h    |  20 ++++++
 fs/fuse/inode.c     | 203 ++++++++++++++++++++++++++++++++++++++--------------
 fs/fuse/virtio_fs.c |  12 ++--
 6 files changed, 214 insertions(+), 80 deletions(-)
