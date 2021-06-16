Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172BC3A94A2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 10:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhFPIE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhFPIEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:04:55 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E811EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 01:02:49 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id g22so1335257pgk.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 01:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cw10uFtM6j6ivpIAHKyfGYAPjF+AZvHLGbY1I1Cvnes=;
        b=QPnQjC/imXfUDfxqjiSI4NF+/NKMtw6Adrdw/ELeXbXZra76qgDP9zC6J1U1y9NOt4
         u3kgAKeQQuREYzGZQlZMFN4+Pq0lK/VqesWv/DqZLZyDm6UlMjUAZqIob+QtbqgV6ZMS
         Cop5PE067jtkmcXpYSnRdeBlAyFJ/etIcr1Eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cw10uFtM6j6ivpIAHKyfGYAPjF+AZvHLGbY1I1Cvnes=;
        b=CZ8btvdbraVPYAqg0mQmxAxEn1jykJxpFgsGlCWIKtO2D/KUJIUuTFLdcCdK3hevLC
         FSbuYWPFgVWm+yK/kQRa8dMIR6kmeNV5qok4kPmKKaax8wrMpwMzIdSKV5aH5uJ9ktw6
         YItFue8/KQJRZbkFfHFn2flurbkjPIljbwV9HMD3/9RFLh5JBVx3Q/UmDjmOWbJfHjw7
         OARAEI0CB9H/45U2hiBMbRAnsMsseRv1DweAuPGx6PaYzbSfKx4F6OmWS+iZDI3qF1zz
         LPmiqoDFvmpW1zH+yyBTb05AYpmmRDDSF90kwoiXm5qcthdzEEStBWeUiruRjEI0Ebmi
         RNvQ==
X-Gm-Message-State: AOAM530gy2fqL/kQtfxBt+c/keygQ6mGzkC86ji6CXykfo1/iADsf3D1
        xsXqC9JWLy9+rEkVaLlHsY0uWO8L8PKmOQ==
X-Google-Smtp-Source: ABdhPJy5hVPBnk/1qjUJFKWZR7abAM3qeGiX96PaDRnrHnAkkctatxXsM4js2+i2npCAT/eew3P16A==
X-Received: by 2002:a63:a805:: with SMTP id o5mr3777437pgf.328.1623830569286;
        Wed, 16 Jun 2021 01:02:49 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id k19sm1408921pji.32.2021.06.16.01.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 01:02:48 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, elver@google.com,
        akpm@linux-foundation.org, andreyknvl@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v13 0/3] KASAN core changes for ppc64 radix KASAN
Date:   Wed, 16 Jun 2021 18:02:41 +1000
Message-Id: <20210616080244.51236-1-dja@axtens.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building on the work of Christophe, Aneesh and Balbir, I've ported
KASAN to 64-bit Book3S kernels running on the Radix MMU. I've been
trying this for a while, but we keep having collisions between the
kasan code in the mm tree and the code I want to put in to the ppc
tree.

So this series just contains the kasan core changes that we
need. These can go in via the mm tree. I will then propose the powerpc
changes for a later cycle. (The most recent RFC for the powerpc
changes is in the last series at
https://lore.kernel.org/linux-mm/20210615014705.2234866-1-dja@axtens.net/
)

v13 applies to next-20210611. There should be no noticeable changes to
other platforms.

Changes since v12: respond to Marco's review comments - clean up the
help for ARCH_DISABLE_KASAN_INLINE, and add an arch readiness check to
the new granule poisioning function. Thanks Marco.

Kind regards,
Daniel

Daniel Axtens (3):
  kasan: allow an architecture to disable inline instrumentation
  kasan: allow architectures to provide an outline readiness check
  kasan: define and use MAX_PTRS_PER_* for early shadow tables

 include/linux/kasan.h | 18 +++++++++++++++---
 lib/Kconfig.kasan     | 14 ++++++++++++++
 mm/kasan/common.c     |  4 ++++
 mm/kasan/generic.c    |  3 +++
 mm/kasan/init.c       |  6 +++---
 mm/kasan/kasan.h      |  4 ++++
 mm/kasan/shadow.c     |  8 ++++++++
 7 files changed, 51 insertions(+), 6 deletions(-)

-- 
2.30.2

