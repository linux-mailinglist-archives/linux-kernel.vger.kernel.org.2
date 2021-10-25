Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069754391BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhJYIxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbhJYIx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:53:29 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0267CC061745;
        Mon, 25 Oct 2021 01:51:08 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r2so10213103pgl.10;
        Mon, 25 Oct 2021 01:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=r21X5ADW0WlJHmSicl9xy7PcAUT0+LrXxeiJShv+0ng=;
        b=pHL+ZgfxUV119tjBOMgg1P7U3VLBbIgEZz7n0cuL4yKX61leTCTD0n6VszCTgkAbKI
         BpxtmAhDxnn/wVhgZdnBv3z/sDOeASnPTIQOfGJMOgH/FCcbZAI8iO7AOUbVyR/l0oAy
         ceufvvsw4YdJi3P6TZVxUsikdTsfVs3tj61ZvTihgcZfO9BuOZ2bxZ/YaTwSvALZqeII
         ijN8GrsxOBqab61T1suYoXJcB1mp051xfLlZcGsvZ0X4MHPO2yDLNP0LXA2KC1k/CrUE
         A+YyjsfIw8BWHYMvSSNFXJMKLfMDm8fLgGAs7trXdhIEWnjRfxU66lhG9q5uDKwEsToE
         SUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r21X5ADW0WlJHmSicl9xy7PcAUT0+LrXxeiJShv+0ng=;
        b=1TqQLykfZf+5AOEx6uWqDL1zJ64uAxTFGCX3EW8vLjhk4583Km1xRSSIEeV0QP5jun
         xuID2n0crpt0ltm2Ag5f5fEQPPXWak1qsQqUJowsGHl9OEraKNjcnOJm8/0sjnvrk38Y
         7rz1LARu2Qd5OSOWUp4dcGvuhWCupx5z8TxtKI1XaAQNvXt0C3nnkk4IDAGsElvQBrpe
         Aian+t6wfXNDOhJxTb/iHLT0MHhQ2wqJnQZWlAbKOJqORbwSktp0cXmidOQmyoRsGLtU
         uQ4Q3cEuW5HfvtnSqy12oqKIVwIm9t8PpnSxgGlbS2djPijUzMbnJDrjBTdvPmC6C+DM
         JUpg==
X-Gm-Message-State: AOAM531UyrzBC+esvskvl9nGMddW5wIy0dz2oeIsmCReaC+S9Xx5TDw5
        BWLHa90GoByOH7CsT8MhX7si3VYmCdI=
X-Google-Smtp-Source: ABdhPJyRok74CvRp7i3r6GKNP3crvuaGdzO3k0T8wYo5y5ZDcuGTNQyyHUEjwnxClgwFcozhHbBmSQ==
X-Received: by 2002:a63:6c06:: with SMTP id h6mr12485238pgc.281.1635151867079;
        Mon, 25 Oct 2021 01:51:07 -0700 (PDT)
Received: from carrot.localdomain (i220-108-45-205.s42.a014.ap.plala.or.jp. [220.108.45.205])
        by smtp.gmail.com with ESMTPSA id j126sm18667378pfd.113.2021.10.25.01.51.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Oct 2021 01:51:05 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] nilfs2 updates
Date:   Mon, 25 Oct 2021 17:51:00 +0900
Message-Id: <1635151862-11547-1-git-send-email-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew

Please queue the following changes for the next merge window:

Qing Wang (1):
  nilfs2: replace snprintf in show functions with sysfs_emit

Ryusuke Konishi (1):
  nilfs2: remove filenames from file comments

Thanks,
Ryusuke Konishi
--
 fs/nilfs2/alloc.c     |  2 +-
 fs/nilfs2/alloc.h     |  2 +-
 fs/nilfs2/bmap.c      |  2 +-
 fs/nilfs2/bmap.h      |  2 +-
 fs/nilfs2/btnode.c    |  2 +-
 fs/nilfs2/btnode.h    |  2 +-
 fs/nilfs2/btree.c     |  2 +-
 fs/nilfs2/btree.h     |  2 +-
 fs/nilfs2/cpfile.c    |  2 +-
 fs/nilfs2/cpfile.h    |  2 +-
 fs/nilfs2/dat.c       |  2 +-
 fs/nilfs2/dat.h       |  2 +-
 fs/nilfs2/dir.c       |  2 +-
 fs/nilfs2/direct.c    |  2 +-
 fs/nilfs2/direct.h    |  2 +-
 fs/nilfs2/file.c      |  2 +-
 fs/nilfs2/gcinode.c   |  2 +-
 fs/nilfs2/ifile.c     |  2 +-
 fs/nilfs2/ifile.h     |  2 +-
 fs/nilfs2/inode.c     |  2 +-
 fs/nilfs2/ioctl.c     |  2 +-
 fs/nilfs2/mdt.c       |  2 +-
 fs/nilfs2/mdt.h       |  2 +-
 fs/nilfs2/namei.c     |  2 +-
 fs/nilfs2/nilfs.h     |  2 +-
 fs/nilfs2/page.c      |  2 +-
 fs/nilfs2/page.h      |  2 +-
 fs/nilfs2/recovery.c  |  2 +-
 fs/nilfs2/segbuf.c    |  2 +-
 fs/nilfs2/segbuf.h    |  2 +-
 fs/nilfs2/segment.c   |  2 +-
 fs/nilfs2/segment.h   |  2 +-
 fs/nilfs2/sufile.c    |  2 +-
 fs/nilfs2/sufile.h    |  2 +-
 fs/nilfs2/super.c     |  2 +-
 fs/nilfs2/sysfs.c     | 78 +++++++++++++++++++++++++--------------------------
 fs/nilfs2/sysfs.h     |  2 +-
 fs/nilfs2/the_nilfs.c |  2 +-
 fs/nilfs2/the_nilfs.h |  2 +-
 39 files changed, 77 insertions(+), 77 deletions(-)

-- 
1.8.3.1

