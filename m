Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F583EC100
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 08:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbhHNGwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 02:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbhHNGw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 02:52:28 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B06C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 23:52:01 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id qe12-20020a17090b4f8c00b00179321cbae7so8655266pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 23:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=xiWIs3sY5kKi+XKFiiCom1CbSNm2N5jCulCs6CDrg0A=;
        b=bOyHjR2lyUuP1uh1PyterGYVjgPGptdS83UJH1mxRtsMxOnoqPcYIUcwulbc4mlIg3
         8Os2bBWBiPP/z5IPcDKr5kxdN23BVuADWK8TJhK9VRlXWPC4f3iuauC3jGgy27XjDH/Q
         L+3t/TmrtreqUVn0CrHTBTKJurPQHSfPzlz/WBQcGDs4sriMG5R2op6n/tDVZqhhSUn4
         yxGC6Zop9PlCwFsKDmuoRNmOTLGdMEg3yf0E8PNi42IKZZnM/qbOQyyrqRc6ug2122vd
         OMHbar9fhnkVfWiocqqvVyesGv1mEyMHACh5dOkR5d48vMnTmKbdTa7e2m3EECy0/Mh1
         TxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=xiWIs3sY5kKi+XKFiiCom1CbSNm2N5jCulCs6CDrg0A=;
        b=Zh6tCtAH9sVNbMsetCVvGRzGqw3GLwzQUtF9WboR7koMc4+xeYIcj4vZfsAeQ7flYD
         sMFpaeVNFhfglE30rmpS8paBr2p03X452RBLvymrf23fNrNCyewhNZW4Opv3ACPAl7jx
         yr4cYQBvWiD3fjq0UQzyAIimTuI/EQFincUn5ihM2Z43LlmLxC1GO05vrO7rno7wshL6
         BHG/qLf6qjDHx235I+F184BkeOQ453u48H7W+qCEZCFATKcoYjKd/7LiNErp2hw+SFSg
         vJnMRW41LtJ7lrQZ+1EqDmPPMNXdxF51EyKB6GQIEd9vnUK84VghnYqnjJVtYftoHTTM
         yVhQ==
X-Gm-Message-State: AOAM530o5+jtWh44VN6zjjMLDh2ikv+y2aXXyje7UqqMd1h4/M8sLyIg
        d7o2xkKZCV50KHl/cqaR2qnJdQ==
X-Google-Smtp-Source: ABdhPJzv/CRvgnLeOZF/zbHg/X+9VxSH7LvMm0YJpE8vhIg6NJd5Ow9N7QyuHWh2jLvRZ87vG+QdUg==
X-Received: by 2002:a17:902:9b89:b0:12d:7f02:f6a5 with SMTP id y9-20020a1709029b8900b0012d7f02f6a5mr4874020plp.39.1628923920450;
        Fri, 13 Aug 2021 23:52:00 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id k22sm713215pff.154.2021.08.13.23.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 23:51:59 -0700 (PDT)
Date:   Fri, 13 Aug 2021 23:51:59 -0700 (PDT)
X-Google-Original-Date: Fri, 13 Aug 2021 23:51:54 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.14-rc6
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-eb8a31c1-f921-487c-8e96-8d4c32f8ed16@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 867432bec1c6e7df21a361d7f12022a8c5f54022:

  Revert "riscv: Remove CONFIG_PHYS_RAM_BASE_FIXED" (2021-08-06 22:41:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.14-rc6

for you to fetch changes up to fdf3a7a1e0a67a52f631b055975c6ac7e0e49a65:

  riscv: Fix comment regarding kernel mapping overlapping with IS_ERR_VALUE (2021-08-12 07:16:58 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.14-rc6

* A fix to avoid passing -mno-relax to compilers that don't support it.
* A comment fix.

----------------------------------------------------------------
Alexandre Ghiti (1):
      riscv: Fix comment regarding kernel mapping overlapping with IS_ERR_VALUE

Changbin Du (1):
      riscv: kexec: do not add '-mno-relax' flag if compiler doesn't support it

 arch/riscv/kernel/Makefile | 2 +-
 arch/riscv/mm/init.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
