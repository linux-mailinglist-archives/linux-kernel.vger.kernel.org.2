Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA083D9CDB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 06:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbhG2Elj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 00:41:39 -0400
Received: from mail-pj1-f42.google.com ([209.85.216.42]:47049 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbhG2Elg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 00:41:36 -0400
Received: by mail-pj1-f42.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so7377854pji.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 21:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AbtcFfa/EJaWfMmgo8zAPpzyWQi/Wq16C1gNIwKAQQE=;
        b=KcKLwJbx4oMHnQgYAgAEWUNbV00HLH9jLZdYsO22NKrTBmWhlN7lVHKy/R5ypsERXL
         hJFzk74TGgswVcPjCKAPzft8tSSKvFgaj9EGS4dhLAfHvPwt7Dcy1MmT4eGfsK4r2sk9
         Cc6IJISHmYzAGgZ3a099YWQyPp5kO9pSqqSKjilJR7eiEnJNlO4vJaFJBZb5T0Kzx3Y6
         QV3Ow5apQollAH7yYTDPiuwqcGlfJHiQZzGGQ5nc9Il731Hbz+Lok+2TATLfTrUQO0ty
         43t/tha1yp6IsW3SSWcFRHnHM9ufHVQNn7c8XcU2cdWjdyZRc39zvnLajBJuyVQ69eBn
         TaUQ==
X-Gm-Message-State: AOAM530spCkOjE2egtoUy9SMuc8VSw/ZT36FYSZip3a/nM/71X+Z2CjO
        WNbMwnogGIdwKBrtaoHMcJw=
X-Google-Smtp-Source: ABdhPJy1Lt6DBshmE9OxwqfXpnLrF1I1OwPaGHa6+vaLDut/ffTaZFMmQD16pCFik5zjSPvYJ+hx4w==
X-Received: by 2002:a17:902:b941:b029:12b:81c3:6919 with SMTP id h1-20020a170902b941b029012b81c36919mr2845783pls.7.1627533692947;
        Wed, 28 Jul 2021 21:41:32 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:9eeb:60dc:7a3c:6558])
        by smtp.gmail.com with ESMTPSA id dw15sm1415405pjb.42.2021.07.28.21.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 21:41:32 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/3] Restore the kernel v5.13 text attribute write behavior
Date:   Wed, 28 Jul 2021 21:41:22 -0700
Message-Id: <20210729044125.7435-1-bvanassche@acm.org>
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
 fs/configfs/configfs-test.c | 427 ++++++++++++++++++++++++++++++++++++
 fs/configfs/file.c          |  18 +-
 include/kunit/test.h        |   4 +
 lib/kunit/test.c            |  14 ++
 6 files changed, 461 insertions(+), 12 deletions(-)
 create mode 100644 fs/configfs/configfs-test.c

