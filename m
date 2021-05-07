Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554FA376D96
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 02:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhEHAAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 20:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhEHAAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 20:00:08 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D205BC061574;
        Fri,  7 May 2021 16:59:07 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gj14so6107768pjb.5;
        Fri, 07 May 2021 16:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yVnKEv/GTFWoZTHVwSWln+PoeZZjAnooQp33wJOZnTc=;
        b=dxZu9dNW5j8GiQu00tG20My3QSXGPqb5ryb0Pl2eePoY/70VvqTk5QVrBPhEWjvMOZ
         CK3cX0QmNxFHR7vBzY57pMVfdK+HoUWARpPJxfpZSBrnIjGstBqOspZKfeIDkw/TBeLc
         uIFMCC1LcGdBK99XeVApNwDXQ/+eLC75oT8sU0RlMhhwwFitaOcgizGsw9E2Pe7T6QVl
         HZG0mG7UybOwkcEC6oIvK0cBow+kJHOi2tD0aDHk0aLFOT/IvBCzkIIIi3hf6OFTCY31
         tYSHxjTCehq5P538St6aVCVgKjGgsTIeZc3bWiGOBex2qL61VgfPtaXAYNuQwLEsjSg6
         fRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yVnKEv/GTFWoZTHVwSWln+PoeZZjAnooQp33wJOZnTc=;
        b=Hn051xSKJt+t7oB0FkP24v1f2q2ZS0TvLNNdRxQPSdpTsdQvUZRAcGwLZq1sb5CwJF
         DnY+D6oQqviZBU70AjZ7UwFy9Rq+Vt71cOX6HV3zRoqdEworBDqlsvTF9MglKUf36Xd1
         /33qwmeeTd7nXxCa7rzfc6y3FAwMu5f71yDEx4dmNWYsbEDDMhIbAdeJ3uf3avWsQtYm
         Ypkpfmuupu2BfRlxFQup8a6RJjiAaIfH0ieYEWG0enzf1qkoc6nNzz9bfu06j8LBn3Ta
         NPovenlw8eGc4OwxwwwCBJjd7CIM89CR21SK4DAF6GY/XnvMLdaEdowcBJLcXO4W/cbB
         mrPw==
X-Gm-Message-State: AOAM530M2wLbSRTh8X7STbc++0GrNyASpO8cKPOV6RwO3ZzQ3VEh1msk
        Pl+22kbrGhv9z/YYkTRt2Hw=
X-Google-Smtp-Source: ABdhPJyarzGBJ1FknJAWoWlpxYkHDLxfaDi4+aPL1Ns/IxPNDAdoaOQZFwRgkc6/gGdZpvXI2JOthQ==
X-Received: by 2002:a17:90a:20b:: with SMTP id c11mr12868350pjc.44.1620431947379;
        Fri, 07 May 2021 16:59:07 -0700 (PDT)
Received: from WRT-WX9.. ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id g18sm5700449pfb.178.2021.05.07.16.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 16:59:06 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 0/3] 9p: add support for root file systems
Date:   Sat,  8 May 2021 07:58:39 +0800
Message-Id: <20210507235842.16796-1-changbin.du@gmail.com>
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

v2:
  o use pr_err instead of printk.
  o ROOT_DEV is only set after checking.
  o cleanup DEFAULT_MNT_OPTS.
  o do not retry mount for fd and virtio transport.

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
 init/do_mounts.c                            | 54 +++++++++++++++++
 10 files changed, 198 insertions(+), 2 deletions(-)
 rename Documentation/filesystems/{ => v9fs}/9p.rst (100%)
 create mode 100644 Documentation/filesystems/v9fs/index.rst
 create mode 100644 Documentation/filesystems/v9fs/v9fsroot.rst
 create mode 100644 fs/9p/v9fsroot.c

-- 
2.30.2

