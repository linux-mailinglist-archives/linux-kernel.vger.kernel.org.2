Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9563E0D56
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 06:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbhHEEf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 00:35:29 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:44805 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhHEEfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 00:35:25 -0400
Received: by mail-pj1-f48.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so6784593pjh.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 21:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8o0Q90pDauyJuQ7iK2ZxA0iu5uzS1tOP9P8LZmNgL/o=;
        b=uWblf0k8yGjHZyXNuGRd/fzqHfVITXXchOQeGg3/CF+djHzPHUGnHwoA2jqGgYBklB
         cZjJgrU46nIdBdXTbdx/RfcdJoSextjI7w0OHHf6TCdUOigTKnhdFOf4RjRd0gGtc/UP
         i/K05HCuVy4/rMGKEYMaP4dxLnZPPKov4F8XCMicW8E2HIieznTz8tRCJ0GdStzBWR7N
         oxTSbu2hiaeRSFjtWgIKObgshCWJWhDNk6AijWXZmY/hWSw261TKEsYf4ngSW0CbEKNW
         vQfhgskJQksprx+meeAiRtxJHYOpTSotjFqDQv4GrjDQVFDzNG/UTZx6BCOXAZm8iqki
         XSwg==
X-Gm-Message-State: AOAM532M9Sv47xYOqgVy9Q7ELBATzvtU+AGbxjm36OyMMAYHkLInAazQ
        Z4MS7fvCrl6cPG4MXLdTO8c=
X-Google-Smtp-Source: ABdhPJzSp4amPYNVVLr0DyRhlH3dCFxBSlvmnL0atr2off/xGQGCOq4JxU3ZXU73mEmUcrgyU5UZ5g==
X-Received: by 2002:a05:6a00:140f:b029:3ad:1fe4:70ff with SMTP id l15-20020a056a00140fb02903ad1fe470ffmr3135374pfu.71.1628138110626;
        Wed, 04 Aug 2021 21:35:10 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:e365:91b7:6284:3848])
        by smtp.gmail.com with ESMTPSA id b15sm5642153pgj.60.2021.08.04.21.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 21:35:09 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v4 0/3] Restore the kernel v5.13 text attribute write behavior
Date:   Wed,  4 Aug 2021 21:35:00 -0700
Message-Id: <20210805043503.20252-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

This patch series restores the v5.13 text attribute write behavior and also
adds unit tests for configfs. Please consider these patches for inclusion in
the Linux kernel.

Thanks,

Bart.

Changes compared to v3:
- Changed config CONFIGFS_KUNIT_TEST from tristate into bool. The unit test
  calls do_mount(). do_mount() has not been exported and hence is not available
  to kernel modules. This was detected by the kernel build robot.

Changes compared to v2:
- Modified description of patch 2/3.

Changes compared to v1:
- Instead of making the text attribute write behavior POSIX compliant, restore
  the v5.13 behavior.
- Added more unit tests.

Bart Van Assche (3):
  configfs: Restore the kernel v5.13 text attribute write behavior
  kunit: Add support for suite initialization and cleanup
  configfs: Add unit tests

 fs/configfs/Kconfig         |   8 +
 fs/configfs/Makefile        |   2 +
 fs/configfs/configfs-test.c | 429 ++++++++++++++++++++++++++++++++++++
 fs/configfs/file.c          |  18 +-
 include/kunit/test.h        |   4 +
 lib/kunit/test.c            |  14 ++
 6 files changed, 463 insertions(+), 12 deletions(-)
 create mode 100644 fs/configfs/configfs-test.c

