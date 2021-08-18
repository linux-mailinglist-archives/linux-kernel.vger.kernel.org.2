Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633113EF728
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 03:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237362AbhHRBHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 21:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbhHRBHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 21:07:44 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB11C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 18:07:09 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id s3so1898785ljp.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 18:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=No1ueEPq13uKyGqP0e28JzryE/lBIDaao/VGD9U1Tfo=;
        b=OlTYb1XQwh15N2yA6ZBIWwIiJIx/kZhBbsbCc5iPCB8+u2SuLEIf4xSrwIKojocvoO
         HrAdE3RumNFOC8DeVNFaiTn/elj5yD9O+Gl2fo3NAVKyKm02KvxlDxf+YpY23+WQyymE
         EoLQ+GGhuR+BFEMYD+MBznfi0+t/pKrCdStTmNL63owb9IVTXNW5CiYdWlwKr3ErjxsT
         os9uZ4XmFFSaDLgt9zsfJMVDPFH6VvYXYRO4pfWPeyY14kTW2J+dneAH0Ap4I/HR0pYJ
         WIDLTnhB3DHMZkRqnniznKZhLGX3omLdLZ8hNzervtwE7ypr+wT992ebHBgLUDVbDsml
         eNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=No1ueEPq13uKyGqP0e28JzryE/lBIDaao/VGD9U1Tfo=;
        b=Y4sUmqMUHhlK3JP/+1k0LIuILhsRUvxpuzOjQHPgZz3ehhj7S1+lEOgOsgaQgilp5i
         tCc+1+NRMUTiA0RFFazcTEIbVWi2ovM+y2lg2hPjUa3Gvxz4v7JA+ZOO5qk9YT1baRy5
         F0nd+X1ElIstDknTG4PGRiTHccHqNiM6Dufo9EE7R8gatkwO2yzwKlfZt5RCtGMmoDbw
         sRh/2lJRnf6yiK3Qev+avmluMwu57ywbndyHoSyy0JoHlhdyeO/I0mmhRTA/Z4d4V81k
         jXb8ITrKcYGRuiE3TmjV80ua0i+w3xi5W7T7tqj7qx34ql/L0h2+vyAkvYF7UxLfZ9ef
         3Saw==
X-Gm-Message-State: AOAM530MdM41tB5RMC0iDgaTkO6wLGzLuX3KqLB+j0sjeMkLC77C0Vfv
        78Uj4SdkatLCuLqs0lar2b8=
X-Google-Smtp-Source: ABdhPJxJ0f8M0TON9cAH1rASqjGV0jYrBib6o6ptZhvjqR+FY4flUIoGvINCAR3wRc55ugQozp2XSw==
X-Received: by 2002:a2e:a4ba:: with SMTP id g26mr5505544ljm.254.1629248828068;
        Tue, 17 Aug 2021 18:07:08 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id j4sm400245ljh.120.2021.08.17.18.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 18:07:07 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Christoph Hellwig <hch@lst.de>
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: [PATCH v3 0/3] fs/ntfs3: Use kernel alloc wrappers and fix warnings
Date:   Wed, 18 Aug 2021 04:06:46 +0300
Message-Id: <20210818010649.412912-1-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ntfs3 driver there is allocation made like this ntfs_malloc().
Patch 2/3 will converter these to kernel ones like kmalloc(). After I
did this then checkpatch raise warnings about array allocations so I
fix these in patch 3/3.

I also notice when I made patch that there is broken utf8 char so I
wanted first fix that because it raised some warning in my editor and
did not want to "break" patch 2/3. So patch 1/3 address that. I did
try to apply this and it seem to work without issues.

v2:
 - Add patch 1/3 because I found broken utf8 char in source file
 - Add another patch 3/3 which will fix allocation warnings
 - Rewrite some of commit message from first patch
v3:
 - Patch series didn't have X/X numbers
 - Cover letter didn't have fs/ntfs3 in it
 - One kmalloc was converted to kcalloc insted of kmalloc_array
 	Thanks Joe Perches

Kari Argillander (3):
  fs/ntfs3: Fix one none utf8 char in source file
  fs/ntfs3: Do not use driver own alloc wrappers
  fs/ntfs3: Use kcalloc/kmalloc_array over kzalloc/kmalloc

 fs/ntfs3/attrib.c   |   6 +-
 fs/ntfs3/attrlist.c |  10 +--
 fs/ntfs3/bitmap.c   |   8 +--
 fs/ntfs3/debug.h    |   7 --
 fs/ntfs3/file.c     |   4 +-
 fs/ntfs3/frecord.c  |  28 ++++----
 fs/ntfs3/fslog.c    | 172 ++++++++++++++++++++++----------------------
 fs/ntfs3/fsntfs.c   |   8 +--
 fs/ntfs3/index.c    |  54 +++++++-------
 fs/ntfs3/inode.c    |  10 +--
 fs/ntfs3/lznt.c     |   4 +-
 fs/ntfs3/ntfs_fs.h  |  18 ++---
 fs/ntfs3/record.c   |   8 +--
 fs/ntfs3/run.c      |   8 +--
 fs/ntfs3/super.c    |  20 +++---
 fs/ntfs3/xattr.c    |  18 ++---
 16 files changed, 188 insertions(+), 195 deletions(-)

-- 
2.25.1

