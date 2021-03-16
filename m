Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B632133D5E2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 15:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbhCPOhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 10:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbhCPOha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 10:37:30 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3950C061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 07:37:29 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id ox4so56908093ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 07:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=vlOwQB4wqa5CjFenq2TYl+SsUWKaiBeLfLRxnljtshU=;
        b=XiQj4kcEgeCJU9sYgoHLb8P4TrUdBoskbtUo+tuHtEFPFYRqb4MTQCpWt88XcHnyRu
         lVJiGa54TNCd01TPR3JmbSv2/ISseu5P3+vrBOG1SDIcvXtGztKekqN54zlCDSN+MMwE
         5pJSxHcjsDiYyS4yNAgkVDZWlzkEhaNcWn3rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=vlOwQB4wqa5CjFenq2TYl+SsUWKaiBeLfLRxnljtshU=;
        b=oA58UBpHNaQTk67dbCmGeiqUuXN4RodwqipONePhR7r/jZZcqfxUl3iKY+E7JZGO1p
         lgsJgneF6FyJIVUwChPf3GQDauuvxKqkpPOzADn/i9LWV32JnnjQriDgo0jPI9e8RKQn
         EysE1IDCdlruB8dZjdu7bGvSPjRJEmoAXb0Vzigd9Vh7pc1MJtg64fyuo0/yy4l6GoIk
         +drTZQjyjXldhk3SpjTMIk7iFq7/eKrE0M5kgLgzZD3u41ddWGg8Qb1thVMiObn7ICBT
         iPIfUe/Vv0+rmpMY9dKQ1K7HMxM62qxBaq3Bt2rXETbeN9GfgPj7entU3D8MJumxc/89
         UpvQ==
X-Gm-Message-State: AOAM5328JBEAspU7pkGaPuuNjSGxCHTfTW/7kBCzYyts9l4S5mMqBEMR
        Gp7Qx0gsJ6VRBU2sk4D45t1WEVL56gF8vg==
X-Google-Smtp-Source: ABdhPJyK6hG2YpjGagEk34eBscWDEErR9feMY+tifSxG0L1bK9y/Ryr7t3KXXyo6VJp22KqwE6M9hQ==
X-Received: by 2002:a17:907:94cc:: with SMTP id dn12mr29976930ejc.177.1615905448624;
        Tue, 16 Mar 2021 07:37:28 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id i10sm9666945ejv.106.2021.03.16.07.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 07:37:28 -0700 (PDT)
Date:   Tue, 16 Mar 2021 15:37:21 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse fixes for 5.12-rc4
Message-ID: <20210316143435.GC1208880@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.12-rc4

Fix a deadlock and a couple of other bugs.

Thanks,
Miklos

----------------------------------------------------------------
Alessio Balsini (1):
      fuse: 32-bit user space ioctl compat for fuse device

Amir Goldstein (1):
      fuse: fix live lock in fuse_iget()

Vivek Goyal (1):
      virtiofs: Fail dax mount if device does not support it

---
 fs/fuse/dev.c             | 26 ++++++++++++++++----------
 fs/fuse/fuse_i.h          |  1 +
 fs/fuse/virtio_fs.c       |  9 ++++++++-
 include/uapi/linux/fuse.h |  3 ++-
 4 files changed, 27 insertions(+), 12 deletions(-)
