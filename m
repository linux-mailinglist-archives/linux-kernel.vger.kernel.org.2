Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AA43EF2B6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhHQTj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhHQTj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:39:27 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2669EC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 12:38:54 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id n7so722358ljq.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 12:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K/HCxfApfrksSFOOQOfIVwX9Z2BpX2DzBv8+t71Si6M=;
        b=Eld/o6n0HFOBb7Ds+i7p9hSVe7nmy+eXlzRYC47xmheal6g8VOSy7qeiCI2x7tUMd9
         MqzeZx1DYIiwbARNBWC4cXrz3Q2thwYn1ZABYkMGW23tR1hZWdS424lmB/PbzLUF7Bgj
         qtZpRo+/qbXep9PKE1nkNIav/dBWvqtMtWq/hOEC6N2yVicgiTknxeIeft2H3oXFSPrg
         oTscvjoA8Jun7nFvhot/bgaP6P5AR6RzAKlahkKUQMN7NqAzQJxov/FlNdolcXX4XuRG
         ACZ/X8WCJBXnxJ9ZGMKeL1J4Knspq3+alUBgcaClu4bF5Dt+z2IsQoYLqjUYmPyd7bGN
         1GLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K/HCxfApfrksSFOOQOfIVwX9Z2BpX2DzBv8+t71Si6M=;
        b=V8jlV6OP5AIjtsVXX5oK6jxtRFlj9ziZpBPIPN/MHtoyQS7gsESeATMef56sOGh7kk
         ggVquFNogk6jXJKOI7b0cXZgLSX6U0+1eBIQCaQc82cO4dVjhrFAkRbOsOmHPYdCCPND
         z61oMU8hX0Hbyk9RzaAMAxvPQp2CED3GNEvpM2ajEPHuNeWnfWccpC2QwJQZu6oy0Xb/
         90xDcMpmmtrNgXM953nDIxTS8NdsQGxdV7lHT7Qtw25Q2yjbtwXI6Uk4yofi2nWQYFgI
         mx8DKz+H8uIHsaySrNusAsqsfzDGNYuttYTu7xZs0ISuIj8h+8So7M2YvqN7uW8gz1lt
         U0FQ==
X-Gm-Message-State: AOAM531fbAGn5aPCpKwhU8+YrP1mj1afKYpYXk134xDqQiMXc75hFPHo
        syUyJLNkfJ7YyBaSTnSQug101cXvusaMc/jr
X-Google-Smtp-Source: ABdhPJw+xYyUw+C0Js4HHisXu0jweb5yYZ29U1zLss2ookmzZkmXWoPOC4zp7AOUGRa8PXjbMj5CNw==
X-Received: by 2002:a2e:711c:: with SMTP id m28mr4512742ljc.247.1629229132458;
        Tue, 17 Aug 2021 12:38:52 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id o28sm99697lfg.238.2021.08.17.12.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 12:38:51 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Christoph Hellwig <hch@lst.de>
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Use kernel alloc wrappers and fix wargings
Date:   Tue, 17 Aug 2021 22:38:12 +0300
Message-Id: <20210817193815.307182-1-kari.argillander@gmail.com>
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
did not want to "break" patch 2/3. So patch 1/3 address that.

v2:
 - Add patch 1/3 because I found broken utf8 char in source file
 - Add another patch 2/2 which will fix allocation warnings
 - Rewrite some of commit message from first patch

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

