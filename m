Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21D43B258C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 05:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhFXDnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 23:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhFXDnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 23:43:16 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67B4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 20:40:56 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id p9so3595071pgb.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 20:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NZ+5u/3FQBWJpz6rgvDEPJOqY9HFVit9UNSurv/3XAo=;
        b=bPxUvfH1hicKqr/5RLTN+v5d3hmJtqKPBLhqt/aILJcVbY0xZwO8QSexq6qypSpAwm
         jz4dCpf47RokwWM2HQbvGJEOYum/WZ93e1ypJ/AsOlOm+rOeqlvmPZqDfZdSSWZ3AWrq
         T6joaO8GE6iurLPFBq+F+CzwbczEAmP++IXXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NZ+5u/3FQBWJpz6rgvDEPJOqY9HFVit9UNSurv/3XAo=;
        b=i5tY9mL3T/yllq9a0jEZJBIBZNTgFBV8C/sdgk6OOTypy/xZJi+QJlQ01rFpPNu9S9
         LaHaJbosBKspfEDcmIMULqCkNYjRw3Ug3EG5wAm88O4DYKCS62qq2JJ1aO6W4yscmExr
         0U7n0T5leVAbtWknVANgFRORhOdCbG1sgTHdpCxSp7uS4gAu2xSZrgz4SlMoXQiRZdRg
         E8FRj2z+MGRDOILlHcFzoMG3XsJsDm3qWOv4Y8vr5H+PKEDql7ZMYQehcqqkcYWb1QVa
         QpXRyEAomHs9W3CmVdhH+9HGI2GfF1dbpZYDwb8Y8iOE7G4QjYpB6AaIcJu4DRIp9cmT
         Kb2w==
X-Gm-Message-State: AOAM533i+yPUa7BEhz4B/Fx/itEE8NEuWfgaPlQEybohqRv2LiYrIgL0
        //vLuNAHU4W1qgtfSh/Wb6896YVIg2q7hw==
X-Google-Smtp-Source: ABdhPJxKBNUxj9TLBqOZ1Vsk97fOuZIzqqF6nxVKDlcrkJNJ1knxKZtKY350l3cH6JZ4bwXM1c3X2A==
X-Received: by 2002:a62:ce83:0:b029:306:f58:aa14 with SMTP id y125-20020a62ce830000b02903060f58aa14mr2705692pfg.67.1624506056039;
        Wed, 23 Jun 2021 20:40:56 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id k9sm563729pgq.27.2021.06.23.20.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 20:40:55 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, elver@google.com,
        akpm@linux-foundation.org, andreyknvl@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v16 0/4] KASAN core changes for ppc64 radix KASAN
Date:   Thu, 24 Jun 2021 13:40:46 +1000
Message-Id: <20210624034050.511391-1-dja@axtens.net>
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

This series just contains the kasan core changes that we need. These
can go in via the mm tree. I will then propose the powerpc changes for
a later cycle. (The most recent RFC for the powerpc changes is in the
v12 series at
https://lore.kernel.org/linux-mm/20210615014705.2234866-1-dja@axtens.net/
)

v16 applies to next-20210622. There should be no noticeable changes to
other platforms.

Changes since v15: Review comments from Andrey. Thanks Andrey.

Changes since v14: Included a bunch of Reviewed-by:s, thanks
Christophe and Marco. Cleaned up the build time error #ifdefs, thanks
Christophe.

Changes since v13: move the MAX_PTR_PER_* definitions out of kasan and
into pgtable.h. Add a build time error to hopefully prevent any
confusion about when the new hook is applicable. Thanks Marco and
Christophe.

Changes since v12: respond to Marco's review comments - clean up the
help for ARCH_DISABLE_KASAN_INLINE, and add an arch readiness check to
the new granule poisioning function. Thanks Marco.

Daniel Axtens (4):
  kasan: allow an architecture to disable inline instrumentation
  kasan: allow architectures to provide an outline readiness check
  mm: define default MAX_PTRS_PER_* in include/pgtable.h
  kasan: use MAX_PTRS_PER_* for early shadow tables

 arch/s390/include/asm/pgtable.h     |  2 --
 include/asm-generic/pgtable-nop4d.h |  1 -
 include/linux/kasan.h               |  6 +++---
 include/linux/pgtable.h             | 22 ++++++++++++++++++++++
 lib/Kconfig.kasan                   | 12 ++++++++++++
 mm/kasan/common.c                   |  3 +++
 mm/kasan/generic.c                  |  3 +++
 mm/kasan/init.c                     |  6 +++---
 mm/kasan/kasan.h                    |  6 ++++++
 mm/kasan/shadow.c                   |  6 ++++++
 10 files changed, 58 insertions(+), 9 deletions(-)

-- 
2.30.2

