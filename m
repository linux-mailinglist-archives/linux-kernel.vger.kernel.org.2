Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661EC38DB6E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 16:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhEWOeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 10:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbhEWOeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 10:34:24 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F6EC061574;
        Sun, 23 May 2021 07:32:56 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id q67so1658687pfb.4;
        Sun, 23 May 2021 07:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=80oEOEMtjRDbSB+qf+VpWW8ktshD+Ev6RXgmcb2Yryg=;
        b=LJgraF0zltHesYML2Hh6g8kAJJKk1IY9s6V3w9sPul6auOktjjaN1eIVLaIj0gRRIA
         +GpEEfArRBpYmYt8FHuQbol/acDgcWlsyM/9pZBma4IKGnqFZPQ+a3aZbaduSBB5vXT1
         9/ZJ6KbDhc3mBPSmAC6US+zebuwf+Muk/JcWqUwVL+RDBxojmTqf76EIK5iLQQq3WDRb
         aaf6lgPM55SpuLlRf23nvNBfyzOiBFC7zQeIKXdLYAtagbS/IkiF3rvGmJEEYFaFu/Lw
         OXt4zdOxetI8SUnAC2fk3lTVdHkakdaHTPdYEzrIDN2lzyR68+Ed2vjv0VIytVDEd3Jf
         /5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=80oEOEMtjRDbSB+qf+VpWW8ktshD+Ev6RXgmcb2Yryg=;
        b=orZEscEVMiA2hNqWq3obD796YpvlYM8SuYXNJcjxqAu8CtFkWxBoJpGvGwjxCkYsnZ
         RNCNM1glW+EXv3A0uz+mNrOpkgaDA/MT1KGrhyGGAn202/jTUrifqLKd+ROyf/hBXOz5
         b5K9Uls4lT+GjDQeA11KDuN6n0adT4hcD706ePJcjlSpDLfhBeQYZkroQuokroQvS/cY
         ++ph7P0P0xfLLlR4jArHxLvehvQD3RVgQkezz2OLSxIWWNUGr05+Tor4XLrICV+20iAM
         IKcMdhtHtD7uKAbxyn8AHleEoTe5TVItqef5VHEHpEjjzU6+Mhth71XN0YY48akoqJyW
         +OhA==
X-Gm-Message-State: AOAM5322soCil5bhpPrXlnN6jUtPh5QauTc15ZX2hd3Lby1oTZT9lJ43
        l9O3zxYUPwCbj53Cdz8k7Ic=
X-Google-Smtp-Source: ABdhPJzsmevD/ZAiSNoaU4f+57udZ8vqYKNCuzS0Q5au4B6tdKmWAhLlEXYFD1QUxEedPEKXycOnsw==
X-Received: by 2002:a62:ab14:0:b029:2db:b3d9:1709 with SMTP id p20-20020a62ab140000b02902dbb3d91709mr19579788pff.80.1621780376223;
        Sun, 23 May 2021 07:32:56 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a93f:c492:941f:bc2a:cc89])
        by smtp.googlemail.com with ESMTPSA id t1sm9365231pgl.40.2021.05.23.07.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 07:32:55 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     will@kernel.org
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        rdunlap@infradead.org, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org
Subject: [PATCH] iommu/vt-d: fix kernel-doc syntax in file header
Date:   Sun, 23 May 2021 20:02:45 +0530
Message-Id: <20210523143245.19040-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opening comment mark '/**' is used for highlighting the beginning of
kernel-doc comments.
The header for drivers/iommu/intel/pasid.c follows this syntax, but
the content inside does not comply with kernel-doc.

This line was probably not meant for kernel-doc parsing, but is parsed
due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
causes unexpected warnings from kernel-doc:
warning: Function parameter or member 'fmt' not described in 'pr_fmt'

Provide a simple fix by replacing this occurrence with general comment
format, i.e. '/*', to prevent kernel-doc from parsing it.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
 drivers/iommu/intel/pasid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 72646bafc52f..aaffb226a6a9 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * intel-pasid.c - PASID idr, table and entry manipulation
  *
  * Copyright (C) 2018 Intel Corporation
-- 
2.17.1

