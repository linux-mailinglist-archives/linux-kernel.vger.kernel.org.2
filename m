Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9FC93FF0EF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346156AbhIBQQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbhIBQQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:16:35 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E16C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 09:15:36 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id j12so4553973ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L2qC6irbQbtN+g0+v1wnhPSc9BwrkkXerk0d5qG4QOc=;
        b=I8+ZexOjMnWdmPQaRlQA/OHfiqAkzLoeBoQZBqAq40UtxhDNdiJ0RzK/0Uk7xQVuk4
         sUAXajs9EtiX7Jz+nIiPklFdc8mh1fzHxZDa5WojWgi6MI2mO69Z3TUoFaS+I6E8sdTA
         bYbQ5KrcwEZ85BPCG4zUlNPUtWEdkRxxrbCKJeme9QefIOS0jB/XXM8kMLNTMBhKfpQt
         bqK6Rrs6MNhKexRw4FhTE11SOxxfRbLr5r9h+oENapG2ABYbxPYgg9cn+FHruIbe86Zg
         QHSHtahDjYLByXE7lDRlgDdUupspyqxXeu6APpOoUqKAM29g6hyBnCbm5cvIrRXduAy1
         1E7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L2qC6irbQbtN+g0+v1wnhPSc9BwrkkXerk0d5qG4QOc=;
        b=FcnpwLcyYC0xlggNZUKdFQPwIqkXQ9lr4tnVC0fkoJTuG0Q272Uj60dYqEdd8yeHHN
         etxXiAbkVfRSsJbqBV139pIPPdeP77mCnpVEowFZ6tTW24Tmy9yI/FzaZn5zh13WqjJh
         4Yllcg05syX14Nf39n5Dm8vSzvh6XqhZmHESPjzguoC2XWds0ksUmJQoMVKLFSLqd/2K
         Ktgzmq80mBTZTWSNVX1iBqekKks1vZlvK/nyJk9uXg3Y2BPLTVdAdiH0kOxAcp36MMAw
         LN57ocTRyAVwKAhxPuGnb76ZvZZBTx4zYGEnKeNrL3NvNus8mn6hrw6ijTMSs54JwUiP
         636g==
X-Gm-Message-State: AOAM530ZPrcvkYNO6uOujgKBo/tToW+fIS3nFEXklzOVsMu1sJSAF1m3
        ydIQVJDXRN7mpV8eeToL/UI=
X-Google-Smtp-Source: ABdhPJzBuEQRUhVbd2nKi1QmDqdsN2U9cy82Wmv53cJKKdNhYQlOoIC2YmQLe1WZHnCYeLq5/JTzGA==
X-Received: by 2002:a05:651c:10a3:: with SMTP id k3mr3216248ljn.471.1630599334984;
        Thu, 02 Sep 2021 09:15:34 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id m7sm267811ljj.58.2021.09.02.09.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 09:15:34 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] fs/ntfs3: Refactor header includes
Date:   Thu,  2 Sep 2021 19:15:20 +0300
Message-Id: <20210902161528.6262-1-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now header includes are big mess with ntfs3 imo. We cannot example
include ntfs3 headers without need of punch of includes to source file.
This patch set try to address that. When this patch series is applied we
can include any header file without need of include anything else. This
does not mean source file should rely what header file includes. Instead
it should include them by self also if it needs them.

When some include is added I have write why this is needed to commit
message. Hopefully this will help when someone wants to correct them
again. I have also just delete unnecessary headers from some .c files
and not added what is needed. Usually deleted headers where there
because ntfs_fs.h need them not file itself. When file was simple enough
I added all necessary linux headers.

I did not add linux/headers to all files yet. That is big job. This is
good starting point. I did try to build every file itself so this will
build like it should.

Please do not hesitate to tell if there is something wrong with this
series or somethings could be done better.

V2:
	Add missing first patch
	Rebase
	Use base-commit with format-patch

Kari Argillander (8):
  fs/ntfs3. Add forward declarations for structs to debug.h
  fs/ntfs3: Add missing header files to ntfs.h
  fs/ntfs3: Add missing headers and forward declarations to ntfs_fs.h
  fs/ntfs3: Add missing header and guards to lib/ headers
  fs/ntfs3: Change right headers to bitfunc.c
  fs/ntfs3: Change right headers to upcase.c
  fs/ntfs3: Change right headers to lznt.c
  fs/ntfs3: Remove unneeded header files from c files

 fs/ntfs3/attrib.c                |  5 -----
 fs/ntfs3/attrlist.c              |  3 ---
 fs/ntfs3/bitfunc.c               |  7 +------
 fs/ntfs3/bitmap.c                |  3 ---
 fs/ntfs3/debug.h                 |  3 +++
 fs/ntfs3/dir.c                   |  3 ---
 fs/ntfs3/file.c                  |  1 -
 fs/ntfs3/frecord.c               |  3 ---
 fs/ntfs3/fslog.c                 |  4 ----
 fs/ntfs3/fsntfs.c                |  1 -
 fs/ntfs3/index.c                 |  1 -
 fs/ntfs3/inode.c                 |  2 --
 fs/ntfs3/lib/decompress_common.h |  5 +++++
 fs/ntfs3/lib/lib.h               |  6 ++++++
 fs/ntfs3/lznt.c                  | 10 +++++-----
 fs/ntfs3/namei.c                 |  4 ----
 fs/ntfs3/ntfs.h                  |  9 +++++++++
 fs/ntfs3/ntfs_fs.h               | 31 +++++++++++++++++++++++++++++++
 fs/ntfs3/record.c                |  3 ---
 fs/ntfs3/run.c                   |  2 --
 fs/ntfs3/super.c                 |  2 --
 fs/ntfs3/upcase.c                |  8 ++------
 fs/ntfs3/xattr.c                 |  3 ---
 23 files changed, 62 insertions(+), 57 deletions(-)


base-commit: d3624466b56dd5b1886c1dff500525b544c19c83
-- 
2.25.1

