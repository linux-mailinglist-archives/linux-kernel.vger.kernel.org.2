Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CF636FC86
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbhD3OhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhD3OhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:37:10 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96511C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:36:20 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id j19so11444452qtx.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yn6cRUZOgPdZlOt5EBUKFzM6s47R+iRZGiASN1vYsQ4=;
        b=aoxU14J5potZB1dXg9Q7C2x7LFjtZngLn0ahKSp/xAqYDnjc2hQh7xowvDgNRxoIvh
         bD1EAWUgsw3EG4T/CHQstKVUN6kuiwE8Kw25LKuiq7rsry+TX5PciEfYjMd46u5/UHCm
         ChFoJHL7WLq/DAP9PA+FIuYwxIffO755NsywxjdoHut0PXW3FoKVeqqSgK/DlO0pnIOJ
         dLGkgdFBxHArWpThE9tUduLiMBjNudB6WmKCF1AtqKRxyE26IG8LsFG438Rbw/7mQLLI
         ANANW+uL7T+W3Yx9w7rv1qdF8GdYNUXOcOWFleHHrW9eJjSCGue6iTOCHGkuqLgse8Dp
         eMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yn6cRUZOgPdZlOt5EBUKFzM6s47R+iRZGiASN1vYsQ4=;
        b=es4VEmT5wGGmwiN3mt3mRV1Qm6odu7At/3nRMXfvpJ01oIWlPmCb3K76vrUYcWgR+m
         +ie0hj3ZlnIH4gbc+VqGZcURj28masHo88ZqPojb/6wUwf1GFWjPL5FaciqPllu7H3Cc
         hIPL0PJKHhqtCN81qTrupxTVC2ouNYwrJE28SFf/qKHGQu/rAkaPEhAKZoXeTZX3MgRj
         K6EnDjor2/pkHRDbmorpZHHzncFVyzOKC4tfWHkKkMlPtObSxzYOjpS5BIZow4Z0Gsow
         tlAsIJUsMVBF9udwtTtPIH1i2zL4b1WhlJhI5cSHl8tM8egIRfcPFpXl/6Se0aO54KHK
         RLKg==
X-Gm-Message-State: AOAM530Pj7LVcq2SwHqe27pTU+NUpEWTnQfMuf2kvuBVYW+wU8fX2RMe
        1iL0sxNcJEz2V3qmfEtCmgKZv9nX42U=
X-Google-Smtp-Source: ABdhPJyYWXW1/5+XXCLmoSfDUVveeDxgw8oPV0pE61dNT8mV2KAhhW8tMLPpeXpbnie+jHyvKi2O9Q==
X-Received: by 2002:ac8:6b8d:: with SMTP id z13mr4744880qts.31.1619793379867;
        Fri, 30 Apr 2021 07:36:19 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com.com ([2804:14c:482:7b04::1001])
        by smtp.gmail.com with ESMTPSA id 190sm1532560qki.115.2021.04.30.07.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:36:19 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] powerpc/mm/hash: Time improvements for memory hot(un)plug
Date:   Fri, 30 Apr 2021 11:36:04 -0300
Message-Id: <20210430143607.135005-1-leobras.c@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset intends to reduce time needed for processing memory
hotplug/hotunplug in hash guests.

The first one, makes sure guests with pagesize over 4k don't need to
go through HPT resize-downs after memory hotplug.

The second and third patches make hotplug / hotunplug perform a single
HPT resize per operation, instead of one for each shift change, or one
for each LMB in case of resize-down error.

Why haven't the same mechanism used for both memory hotplug and hotunplug?
They both have different requirements:

Memory hotplug causes (usually) HPT resize-ups, which are fine happening
at the start of hotplug, but resize-ups should not ever be disabled, as
other mechanisms may try to increase memory, hitting issues with a HPT
that is too small.

Memory hotunplug causes HPT resize-downs, which can be disabled (HPT will
just remain larger for a while), but need to happen at the end of an
hotunplug operation. If we want to batch it, we need to disable
resize-downs and perform it only at the end.

Tests done with this patchset in the same machine / guest config:
Starting memory: 129GB, DIMM: 256GB
Before patchset: hotplug = 710s, hotunplug = 621s.
After patchset: hotplug  = 21s, hotunplug = 100s.

Any feedback will be appreciated!

Changes since v1:
- Atomic used to disable resize was replaced by a mutex
- Removed wrappers, testing for !radix directly in hot(un)plug routine
- Added bounds to HPT resize loop
- Removed batching from dlpar_memory_*_by_index, as it adds a single LMB 

Best regards,
Leonardo Bras (3):
  powerpc/mm/hash: Avoid resizing-down HPT on first memory hotplug
  powerpc/mm/hash: Avoid multiple HPT resize-ups on memory hotplug
  powerpc/mm/hash: Avoid multiple HPT resize-downs on memory hotunplug

 arch/powerpc/include/asm/book3s/64/hash.h     |  4 +
 arch/powerpc/mm/book3s64/hash_utils.c         | 95 ++++++++++++++++---
 .../platforms/pseries/hotplug-memory.c        | 35 +++++++
 3 files changed, 119 insertions(+), 15 deletions(-)

-- 
2.30.2

