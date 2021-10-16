Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761ED430165
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 11:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbhJPJJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 05:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbhJPJJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 05:09:11 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B5DC061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 02:07:04 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e10so3017545plh.8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 02:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G+kT5N/LlfyUJbC/6MhhfqyqIT+2xyqIMuaKUvu/iNs=;
        b=UlNzPDJ1h4X0fPvLjG6HjThaRzDbai+QeVe3P/h9Y0N9/V0PdDEINdBrWQaH8vOM7e
         tqkAfnaY63oIhiud678m09o4mgbI5kFxlg2zE3l9+cDIGo57g8MmI2OTBMPmW8LpLPBh
         I3WUapy9hln6hKheK2J8aZB3qiZOfggALPMy0uVm28KvBBX5lNtoDIn77Vkt5ml3J0jV
         JXtRtJ09iJYymiEthqdE5W6PjmE98KMrCU1Vj3Ef5JcMc8vt1mHzGZjMZF2hD2oNBPkV
         bCYdqTlJLwqmCkiDvEZR7C/T+pPHQdBePkBTzyeyJWuWKeZhui5OC+VcDyWOA5Z/Gwus
         AgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G+kT5N/LlfyUJbC/6MhhfqyqIT+2xyqIMuaKUvu/iNs=;
        b=tPmP1glsX411Cc4bgT/Z426dDiSOMjFTULsJLtCsTp0BMOp7iC6mvwzsbiJxFWuAXG
         OG2Z4wxtc6wU+YQSICr/ZS1oennErKKziaP5ZMJcl/I02sIzTiOrAfvmKo7InMino5jH
         s0pUNqiFo9NbTSorkEdQmbDa8/vpAqdGPgeQmCliCUyedNI1drsJ8DMARj/PoC/P1W9c
         jr+RgN3QPxUq6ut/ZX/2FZYkPhlJfOXn2HZfPaoOu9KxNr/7Bg+CcUwBnYtdzgmpbESf
         4XXNbasJMfSwDsIsWmO4nocO+ApOLCLOBUeTfxwx7rfDw5bBJPapiAzo/QN5SnzknElT
         pMFw==
X-Gm-Message-State: AOAM530ehL2Gc0Woj8piZFJ8nQaIcnGQ+dFJUju+s+vKRiA3IGGoLE+y
        33pVfPjvKrWVanXKUWhX9zQ=
X-Google-Smtp-Source: ABdhPJwlpOgLSxq/zQ/sH7mIHiSorJ/2+ECev61ajwtEDnT6gS7Q075D4n7bv59xkVAegKakpayeHw==
X-Received: by 2002:a17:90a:e010:: with SMTP id u16mr33550961pjy.217.1634375223567;
        Sat, 16 Oct 2021 02:07:03 -0700 (PDT)
Received: from lb01399.pb.local ([2405:201:5506:8116:c405:d8b7:e765:cf87])
        by smtp.gmail.com with ESMTPSA id n202sm7134897pfd.160.2021.10.16.02.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 02:07:03 -0700 (PDT)
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
To:     nvdimm@lists.linux.dev, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     dan.j.williams@intel.com, david@redhat.com, mst@redhat.com,
        cohuck@redhat.com, stefanha@redhat.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, pankaj.gupta@ionos.com,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH] virtio-pmem: add myself as virtio-pmem maintainer
Date:   Sat, 16 Oct 2021 11:06:46 +0200
Message-Id: <20211016090646.371145-1-pankaj.gupta.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pankaj Gupta <pankaj.gupta@ionos.com>

Adding myself as virtio-pmem maintainer and also adding virtualization
mailing list entry for virtio specific bits. Helps to get notified for
appropriate bug fixes & enhancements.

Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1bd721478800..6a1ced092cfa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19941,6 +19941,13 @@ S:	Maintained
 F:	drivers/i2c/busses/i2c-virtio.c
 F:	include/uapi/linux/virtio_i2c.h
 
+VIRTIO PMEM DRIVER
+M:	Pankaj Gupta <pankaj.gupta.linux@gmail.com>
+L:	virtualization@lists.linux-foundation.org
+S:	Maintained
+F:	drivers/nvdimm/virtio_pmem.c
+F:	drivers/nvdimm/nd_virtio.c
+
 VIRTUAL BOX GUEST DEVICE DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 M:	Arnd Bergmann <arnd@arndb.de>
-- 
2.25.1

