Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A113E34C2C8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 07:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhC2FQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 01:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhC2FPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 01:15:31 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFD9C061574;
        Sun, 28 Mar 2021 22:15:30 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id y5so11370788qkl.9;
        Sun, 28 Mar 2021 22:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ESmbvalCIGrr8Ef7y7MkwA50W3FOLLv9ETTolXZ2Go=;
        b=iAozeI0ePFvj23VNwCrehdxg66ywLFvOTBGsNM5Ib3YJJbE0sqGsOUdaRPMcC3RHBH
         qNMxfFI2U0uS1yhHjgNMB0L9tWSFNr5b4UDBUnBx2o50fTJf+gSDx3PCOygkjfS+f0Dz
         rqoWgvPcpM456xjHokBQiwGETh31iGYs5SwzjDKb5yW0KifeU0SooYF9V2xoXhku+vXr
         eb9wK2xW0JJcBPc88BbwWgk5qnvty+18qcG7bu0pGIUHrVugu0Rrxld1PEJ/e1wfoDub
         VB0LnEISJYRFAl/Vim0NJ47O+2Gv1EAn+gT8LKmb1dSRCnAVw6M0PYG6xBUmMh9Qiuc+
         wOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ESmbvalCIGrr8Ef7y7MkwA50W3FOLLv9ETTolXZ2Go=;
        b=GrWUI+6/eZTSGLFHb7TtUwz+I86oyNK13Q1foyZpCOBqxbT7zkSYY5eW2xs8Km1G3R
         3HKxNrH+N1gUH3N0HwT+zkWEBKwLVt5qfA0U5l2NopZErLQKMowVCM6VgHRmuPTVApZq
         hjP/s6yoHyTMs7hdWKaYY2XZXsMfYpdHZLkQsBFqUCzZctOsDXj1+3wiqy1f/b3e9lys
         arFMZ2KufDyq8HSQ2Go7TFrGqOI9cQZb62VEVFfROwEyofem36pNvAXuFph42c8+U5JV
         p25HavVqQ8yBGD3KMMQK2VZJCzIaGSZBO1SvQx0iHtoYz0V14TMtdm/it5H4I1XBobjm
         6u1w==
X-Gm-Message-State: AOAM532uiQqC+w4MmBnWgnlXT9yumobHbOL+TpYOARs7s2zmFTKPAYWL
        lhODh5WPxMHPr70JjJ7+KzM=
X-Google-Smtp-Source: ABdhPJxk/NMG0gpgx1ilUkeYdI+V9VLvhUZN403AQ68k2qRzOl1sThyHWT81ru4EPqAGXXigDMm9Kg==
X-Received: by 2002:a05:620a:1483:: with SMTP id w3mr23398041qkj.339.1616994923140;
        Sun, 28 Mar 2021 22:15:23 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.195])
        by smtp.gmail.com with ESMTPSA id z124sm12993181qke.36.2021.03.28.22.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 22:15:22 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/23] docs: Mundane typo fixes
Date:   Mon, 29 Mar 2021 10:42:36 +0530
Message-Id: <cover.1616992679.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 This patch series tried to fix trivial spelling fixes.

Bhaskar Chowdhury (23):
  atomctl.rst: A typo fix
  w1: ds2482.rst: A typo fix
  w1-netlink.rst: A typo fix
  w1-generic.rst: A typo fix
  vm: unevictable-lru.rst: Fix a typo
  vm: hwpoison.rst: A typo fix
  vm: hwpoison.rst: A typo fix
  virt: kvm: vm.rst: Fix a typo
  virt: kvm: /mmu.rst: Fix a typo
  virt: kvm: halt-polling.rst: Fixed a typo
  virt: user_mode_linux_howto_v2.rst: Few typo fixes
  v4l: hist-v4l2.rst: Fix a typo
  trace: hwlat_detector.rst: Fix a typo
  trace: ftrace-uses.rst: Fix a typo
  trace: events.rst: Fix a typo
  sparc: oradax/oracle-dax.rst: Fix a typo
  sparc: dax-hv-api.txt: Fix quite a few spellos
  security: core.rst: Fixed a spello
  scsi: ChangeLog.ncr53c8xx: Quite a few spello fixes
  scheduler: sched-bwc.rst: Fix a typo
  scheduler: sched-nice-design.rst: Fix a typo
  riscv: pmu.rst : A spello fix
  openrisc: openrisc_port.rst: Fix a typo

 Documentation/openrisc/openrisc_port.rst      |   2 +-
 Documentation/riscv/pmu.rst                   |   2 +-
 Documentation/scheduler/sched-bwc.rst         |   2 +-
 Documentation/scheduler/sched-nice-design.rst |   2 +-
 Documentation/scsi/ChangeLog.ncr53c8xx        | 260 +++++++++---------
 Documentation/security/keys/core.rst          |   2 +-
 Documentation/sparc/oradax/dax-hv-api.txt     |  18 +-
 Documentation/sparc/oradax/oracle-dax.rst     |   2 +-
 Documentation/trace/events.rst                |   2 +-
 Documentation/trace/ftrace-uses.rst           |   2 +-
 Documentation/trace/hwlat_detector.rst        |   2 +-
 .../userspace-api/media/v4l/hist-v4l2.rst     |   2 +-
 Documentation/virt/kvm/devices/vm.rst         |   2 +-
 Documentation/virt/kvm/halt-polling.rst       |   2 +-
 Documentation/virt/kvm/mmu.rst                |   2 +-
 .../virt/uml/user_mode_linux_howto_v2.rst     |  10 +-
 Documentation/vm/hwpoison.rst                 |   4 +-
 Documentation/vm/unevictable-lru.rst          |   2 +-
 Documentation/w1/masters/ds2482.rst           |   2 +-
 Documentation/w1/w1-generic.rst               |   2 +-
 Documentation/w1/w1-netlink.rst               |   2 +-
 Documentation/xtensa/atomctl.rst              |   2 +-
 22 files changed, 164 insertions(+), 164 deletions(-)

--
2.26.3

