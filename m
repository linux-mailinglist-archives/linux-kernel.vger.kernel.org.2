Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5318439D225
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 01:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhFFXLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 19:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhFFXLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 19:11:39 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CBBC061766;
        Sun,  6 Jun 2021 16:09:41 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mp5-20020a17090b1905b029016dd057935fso2570857pjb.5;
        Sun, 06 Jun 2021 16:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vp1Wp7b6hj5hLqATqLU1PoeUzeXuB+6KhE9dxOGwDjU=;
        b=DdFZS8E9uQRmYi/93NmeUBqMINQezlZh2Ugm8Vf7M41y2UicS3RdJRPvLMcETyDJxq
         IGIQZX5JFKzMeWv6bn3XodnixWx0fZ4pKvG/fry1D3HBKgEZV+J3ZjubGLkyqOC6yHQM
         lhRfHuhlfjWc5FtQEa3kTV0wYaRXmjsGJebIEs5JBp8W9jv3DQXDmTVtDLCG03qBN9Td
         swUYxIL7cxFiDRvfAw9mh8T0D7YqxCMTNHqnXkkfQ73+udNQZwkF681pTeRhVzdUMmJU
         yyCYwCkeKIFP4K5j2UkI1WZDRT8YhhqctICBOUs94EFC2JC31CoFPTTT6hoAstXVm64j
         Cx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vp1Wp7b6hj5hLqATqLU1PoeUzeXuB+6KhE9dxOGwDjU=;
        b=UEq8sTVYyHKQvMWop3BzpTjen6DZfwM3MzWcV69t+RV1+MZ8GwCv7v86Lpf3y0jmk/
         9TLaNUQxWrl7KIQ3xi8KPI4eSWXAt2cNfhJcKHUew9X1uj0Wx8yp8O3LWf8CbnvOswlZ
         k/y9lxnnIHbmUe5JFi000gzWOxAZaYVNeDdMfilyAJVV2bgmU9D5YcbnPfNIOOKqMUcC
         +100FtVkcmTy8WH1Jc3Qo2bjEJBddIbd5cKFY6l5Z3hmz0CJbItZuoPgOWniMpMovekf
         WmZqwdGeeIvZagGsXctqyspnZilNrLui3reefOf1lNSUNFDlMGXXUZXOe3VsmLm+iRZD
         NuSg==
X-Gm-Message-State: AOAM533BW8BTChavwor+fQJtbTAVCAft+iABtMcNZMekGT53n5J5FqT6
        KZa7cuUbxmQPptUth6qdt9M=
X-Google-Smtp-Source: ABdhPJwDpmnszLHCk9lao0DsKXYQQGdoI16gZonWUVAPOfpoWxLTmbKwT01TNSnRl1ksb0jaF3FXng==
X-Received: by 2002:a17:902:7c94:b029:fc:5e8b:e645 with SMTP id y20-20020a1709027c94b02900fc5e8be645mr15191312pll.18.1623020980815;
        Sun, 06 Jun 2021 16:09:40 -0700 (PDT)
Received: from WRT-WX9.. ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id f15sm6775672pgg.23.2021.06.06.16.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 16:09:40 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 0/3] 9p: add support for root file systems
Date:   Mon,  7 Jun 2021 07:09:19 +0800
Message-Id: <20210606230922.77268-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like cifs and nfs, this short series enables rootfs support for 9p.
Bellow is an example which mounts v9fs with tag 'r' as rootfs in qemu
guest via virtio transport.

  $ qemu-system-x86_64 -enable-kvm -cpu host -m 1024 \
        -virtfs local,path=$rootfs_dir,mount_tag=r,security_model=passthrough,id=r \
        -kernel /path/to/linux/arch/x86/boot/bzImage -nographic \
        -append "root=/dev/v9fs v9fsroot=r,trans=virtio rw console=ttyS0 3"

v3:
 o rebase.

v2:
  o use pr_err instead of printk.
  o ROOT_DEV is only set after checking.
  o cleanup DEFAULT_MNT_OPTS.
  o do not retry mount for fd and virtio transport.

Changbin Du (3):
  9p: add support for root file systems
  9p: doc: move to a new dedicated folder
  9p: doc: add v9fsroot description

Changbin Du (3):
  9p: add support for root file systems
  9p: doc: move to a new dedicated folder
  9p: doc: add v9fsroot description

 Documentation/filesystems/index.rst         |  2 +-
 Documentation/filesystems/{ => v9fs}/9p.rst |  0
 Documentation/filesystems/v9fs/index.rst    | 12 ++++
 Documentation/filesystems/v9fs/v9fsroot.rst | 52 +++++++++++++++++
 MAINTAINERS                                 |  8 ++-
 fs/9p/Kconfig                               |  6 ++
 fs/9p/Makefile                              |  1 +
 fs/9p/v9fsroot.c                            | 64 +++++++++++++++++++++
 include/linux/root_dev.h                    |  1 +
 init/do_mounts.c                            | 55 ++++++++++++++++++
 10 files changed, 199 insertions(+), 2 deletions(-)
 rename Documentation/filesystems/{ => v9fs}/9p.rst (100%)
 create mode 100644 Documentation/filesystems/v9fs/index.rst
 create mode 100644 Documentation/filesystems/v9fs/v9fsroot.rst
 create mode 100644 fs/9p/v9fsroot.c

-- 
2.30.2

