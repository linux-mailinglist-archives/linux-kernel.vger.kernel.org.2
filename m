Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B23338692
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 08:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhCLHby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 02:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbhCLHbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 02:31:44 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058ACC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 23:31:44 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id f12so3114266qtq.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 23:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wTTL3epqLr8n/6ho+8HvrvB50DNSmJF+IOAwdRQ37Jw=;
        b=U1Aax+GxxM2k71AkvU4mXJXmXQk/7ENUFn9AAmEijKBQ1GuuDiSmPOAjF2KqEdZTTP
         ivX3CWgyOEzMYN0Vo3SVkfvwhhfgVRonJWO2FLLBQFldQBCSEtWbufV5nFeCMhlbh+u3
         yq5f/5KAjtchym0M0Z9H8bwXFhBI4C0QbRYY9lxC2g1vaemG2av+dBiM+cNw9NX8kIR9
         e6UhwhPasOK/N3Nhs/vvE4rN8XKVBUrGiZmZ9vgkwgYzSkeYSB2T35oWNoqWk2CETPef
         4Kd/YlbXEM744cv8GSEyknAd6BEFZJacr6NK0TwLntGLGLTguy5fqJvkHxpvazVoZ8hO
         7OEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wTTL3epqLr8n/6ho+8HvrvB50DNSmJF+IOAwdRQ37Jw=;
        b=CrvwrGLYykkgP9VdqHanFE8ddIM//sfC4C84WWTwUZC2xAjvjwDuS8CNVEJ+vYwfDV
         Clj246RGqtmsh3O6NlcuF0UPPCuLhETWyS7UhvDx4MnhuGpGV0RHxMp+TK/rpNp1ZTn+
         l9DW0m/YKQIQA1vwSlo4XWR2xRuNZgzvPRdxtGxnMmUpJeLnQnyCJ+c4gu509zNb/qqb
         wH9zoz5IPh4KAP7t43+YlmimV3WJ+k7EQU5LCgmdDJV9w+JPlzvg0CMKC1pjRwRT2HoW
         Pxe+SxephIEdHDW2/VCC/C2GhguusqwEn8MUJ6PvbGqB57kSv3ruMIAJGeYuysYVDWUd
         10CA==
X-Gm-Message-State: AOAM530/wAx0xx/S9jgP4ewozu7VOf5Vzgx2VM7gACvLSXh9jMd9EeBV
        NnAhBxFvuUxT8jPJk+ix2jI=
X-Google-Smtp-Source: ABdhPJxJe0h1hfDAK/LtqJvlL29vIrVqqNPbLGXTE5YMdHJa0P/iNR0RKkEaRP7MQm78oCW/YEhzPw==
X-Received: by 2002:ac8:4543:: with SMTP id z3mr10845208qtn.286.1615534303274;
        Thu, 11 Mar 2021 23:31:43 -0800 (PST)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com.com (177-131-89-8.dynamic.desktop.com.br. [177.131.89.8])
        by smtp.gmail.com with ESMTPSA id t6sm3434026qti.2.2021.03.11.23.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 23:31:42 -0800 (PST)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Mike Rapoport <rppt@kernel.org>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] powerpc/mm/hash: Time improvements for memory hot(un)plug
Date:   Fri, 12 Mar 2021 04:29:38 -0300
Message-Id: <20210312072940.598696-1-leobras.c@gmail.com>
X-Mailer: git-send-email 2.29.2
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
I believe the code may not be very well placed in available files,
so please give some feedback on that.

Best regards,

Leonardo Bras (3):
  powerpc/mm/hash: Avoid resizing-down HPT on first memory hotplug
  powerpc/mm/hash: Avoid multiple HPT resize-ups on memory hotplug
  powerpc/mm/hash: Avoid multiple HPT resize-downs on memory hotunplug

 arch/powerpc/include/asm/book3s/64/hash.h     |  4 +
 arch/powerpc/include/asm/sparsemem.h          |  4 +
 arch/powerpc/mm/book3s64/hash_utils.c         | 78 +++++++++++++++----
 arch/powerpc/mm/book3s64/pgtable.c            | 18 +++++
 .../platforms/pseries/hotplug-memory.c        | 22 ++++++
 5 files changed, 111 insertions(+), 15 deletions(-)

-- 
2.29.2

