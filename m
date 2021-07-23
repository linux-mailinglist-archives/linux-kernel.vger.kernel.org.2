Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6133D4223
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 23:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhGWUnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 16:43:31 -0400
Received: from mail-pj1-f49.google.com ([209.85.216.49]:42960 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGWUna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 16:43:30 -0400
Received: by mail-pj1-f49.google.com with SMTP id hg12-20020a17090b300cb02901736d9d2218so5503250pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 14:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yzEp0tmBm9n++A8HeJjxBmlCkflDZMSD2H5K4XfXTEc=;
        b=rT1MfAght2leW4dIbBrAjzcaWeqb4fdZ6bu0PBc6kTprQeUb8i1NIk6VXLtKudpECu
         HiOuUvp7l2c+AJ9xBO6Gv82BHMPLARxCtYMdJ56jqNpfCZEux+Y82shK4MTrHC73Jow1
         /X33LX128xPMPrl02Gh/5u/h+YfX5Q2uJTnqgcXCgLxIDoOq1rgfjOt7LEep02PCIqJU
         oRAZ1LkNU5qFSoxRKIntkAjkscoP2nw/lz2PHSy4GT1KGB96TzVcto7FMHCIOSa+79+k
         yOAzQ5i5IsGqclRITZBcNecu+psiyquep2IhrLKxmZLBqdq+Jhb3ZTnXvV5SD4MObM5z
         kA5w==
X-Gm-Message-State: AOAM532L06I80lKVqsYv7k/BzRoqQ8ypA2nZmXUaKj8FtR5szeMpczuQ
        42iiVt1FgLvGE8z8/A9vVUM=
X-Google-Smtp-Source: ABdhPJwyW/pDJ3C1Sj9zOi0ejDzoLrbRZwPrCg8RADT/UKk6mF5p0u+UlauG5S0hnfg0UHK3w2AqKQ==
X-Received: by 2002:a17:902:e551:b029:12b:7e4c:b34 with SMTP id n17-20020a170902e551b029012b7e4c0b34mr5149729plf.43.1627075442819;
        Fri, 23 Jul 2021 14:24:02 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:db72:85bb:463f:5c41])
        by smtp.gmail.com with ESMTPSA id w16sm39854011pgi.41.2021.07.23.14.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 14:24:01 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Yanko Kaneti <yaneti@declera.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/4] Improve the configfs read and write iterators further
Date:   Fri, 23 Jul 2021 14:23:49 -0700
Message-Id: <20210723212353.896343-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

This patch series addresses Linus' feedback on my most recent configfs patch,
adds unit tests for configfs and also includes one functional change that I
came up with while writing these unit tests. I will leave it to you to decide
whether to submit these patches for inclusion in kernel v5.14 or v5.15.

Thanks,

Bart.

Bart Van Assche (4):
  configfs: Rework the overflow check in fill_write_buffer()
  configfs: Fix writing at a non-zero offset
  kunit: Add support for suite initialization and cleanup
  configfs: Add unit tests

 fs/configfs/Kconfig         |   8 +
 fs/configfs/Makefile        |   2 +
 fs/configfs/configfs-test.c | 369 ++++++++++++++++++++++++++++++++++++
 fs/configfs/file.c          |  17 +-
 include/kunit/test.h        |   4 +
 lib/kunit/test.c            |  14 ++
 6 files changed, 406 insertions(+), 8 deletions(-)
 create mode 100644 fs/configfs/configfs-test.c

