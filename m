Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BB23DB1F8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 05:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbhG3DfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 23:35:18 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:40678 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhG3DfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 23:35:17 -0400
Received: by mail-pj1-f48.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so18732176pja.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 20:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dGfizDAyuiq57tvL5Gn5eEbFu2Nm1OH4ChRU0gczuQA=;
        b=bwyK3YCalE1R8K2qUWq26I9eW1ZE1GrZtDPy3k3hcHxewSo6lvduO1ZDHvlj7G2scA
         G18KOAvRb9Lh/vWyUk9Yk4wVSSo8wakKp0vSPNiDQIM86EV53x0uHg6MIertVi7a6o5p
         q9XV+A/oejzvE0eH7S3hGoTZoqXw3rVjN5lJcXdsCTNerJK5bbTWWply00dtIkMxp85K
         ZZwNkX14atMkzdkiKBHdxK4G834HCY42lLpac2+ZkuPQ8iXHZq+GHwvaJjqLJg3+nkta
         2ug51MisuwYFDFq9n2XeSO2P3PcRa9Xcxf6m6XZiGDXKj7v/bvZXEPqMK0+wCZHzmu+3
         gf2Q==
X-Gm-Message-State: AOAM532oSc4shiNkvczJwMSWIMc9OHEbJmL7pJf64j19keEtXKLgt0gU
        NZYwuArhbqoWe+eJsNifWEw=
X-Google-Smtp-Source: ABdhPJyTZobtotAeI6XnrVVHQSnu8IOswDM9K6UFB8JNd0W36pSr8Q81khUoH1QMtyVYNsE2Lzk+uA==
X-Received: by 2002:a63:6ca:: with SMTP id 193mr376097pgg.265.1627616111830;
        Thu, 29 Jul 2021 20:35:11 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:3f66:df55:a341:f79d])
        by smtp.gmail.com with ESMTPSA id y7sm292830pfi.204.2021.07.29.20.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 20:35:10 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 0/3] Restore the kernel v5.13 text attribute write behavior
Date:   Thu, 29 Jul 2021 20:35:01 -0700
Message-Id: <20210730033504.8228-1-bvanassche@acm.org>
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
 fs/configfs/configfs-test.c | 427 ++++++++++++++++++++++++++++++++++++
 fs/configfs/file.c          |  18 +-
 include/kunit/test.h        |   4 +
 lib/kunit/test.c            |  14 ++
 6 files changed, 461 insertions(+), 12 deletions(-)
 create mode 100644 fs/configfs/configfs-test.c

