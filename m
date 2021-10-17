Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFF44306A2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 06:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244954AbhJQEb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 00:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244942AbhJQEbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 00:31:23 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0D8C06176D
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 21:28:57 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id q19so12003719pfl.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 21:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ohO5ogKSAkRU2HlGVfuByKrc4u8vbxINrbBIB21Ms4k=;
        b=fij2Te9eph7sxFwrTV3Yyszsi/5a01jQRHiSPC6JhEF9aaMga3qb008F1hR543abrn
         PuBNmzeFL3hJk12hRBJuRBpqS3WcFLzsOt3V6yQqyuIDu3fYbqlUXzkEGgHb9X9a2Jxg
         +gFL0vptv39nLYM/jmoRTTh+RB+0dAex9JtauPpN6nIzJYhxwLCwqaxiTRiaNSXrmksu
         Dct+sZC2dh+coTIUvwVST3bkK+JyvYtOui+Vowa1gjnBafAHFvMQG7Gq/pLpaGOXpV94
         B5ohOSxWZRxHDKckLsOPjcUcAO0uO5bkltGBYnvbd8/iD8F6/LHWPHVhjDv9afLN00Ub
         jOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ohO5ogKSAkRU2HlGVfuByKrc4u8vbxINrbBIB21Ms4k=;
        b=AgjXaDBQ7ILWKbKGjZFrYdMkqpjKTaPQu5KspMyutjKNyAO+o7TVuhgslsi58BlA2L
         PpsYpuqoO2wnMHExLhhigFc871zaXWo4L2/auZgv6hf4YNtO6Lpy4gZmc7kZV7/fd4Gm
         68RGOL8nZ7iIC3G2Ls/SzBjkbtqkKHqiperQus8oXAS086RBj2++4aYH9QdSCQdFmuTI
         a2ES0dANJ8+Rf0G0fmQlT+rCzo3AfiEKUQRSVLzA9jvUxr+5SBrfLpsvktbT7lsgR1wP
         7Kg14YPSWG7SDC5mjDPwTjW29kPKD7Q7EoACZvlLOUoDA2Rg6aIVIJoxGuPW8Y8TA2E+
         ZLFQ==
X-Gm-Message-State: AOAM531PXVCMYRAs7x23RDae7xksLYpaZBhjo1NpQTx/8MzlU79Quu9U
        IoW6V8WRAnV4fcRbh6HDMyM=
X-Google-Smtp-Source: ABdhPJxLCMuYDHuwtsT3z4nWa3gYXTVa5DS6waE/Rj1zL3eLYHq3VynHB7by5vvJHWCZ3Jr56AajcQ==
X-Received: by 2002:a63:3f4f:: with SMTP id m76mr9745128pga.315.1634444937058;
        Sat, 16 Oct 2021 21:28:57 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (24.151.64.34.bc.googleusercontent.com. [34.64.151.24])
        by smtp.gmail.com with ESMTPSA id p25sm2063406pfh.86.2021.10.16.21.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 21:28:56 -0700 (PDT)
Date:   Sun, 17 Oct 2021 04:28:52 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [RFC] More deterministic SLOB for real time embedded systems
Message-ID: <20211017042852.GA3050@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been reading SLUB/SLOB code for a while. SLUB recently became
real time compatible by reducing its locking area.

for now, SLUB is the only slab allocator for PREEMPT_RT because
it works better than SLAB on RT and SLOB uses non-deterministic method,
sequential fit.

But memory usage of SLUB is too high for systems with low memory.
So In my local repository I made SLOB to use segregated free list
method, which is more more deterministic, to provide bounded latency.

This can be done by managing list of partial pages globally
for every power of two sizes (8, 16, 32, ..., PAGE_SIZE) per NUMA nodes.
minimal allocation size is size of pointers to keep pointer of next free object
like SLUB.

By making size of objects in same page to have same size, there's no
need to iterate free blocks in a page. (Also iterating pages isn't needed)

Some cleanups and more tests (especially with NUMA/RT configs) needed,
but want to hear your opinion about the idea. Did not test on RT yet.

Below is result of benchmarks and memory usage. (on !RT)
with 13% increase in memory usage, it's nine times faster and
bounded fragmentation, and importantly provides predictable execution time.

current SLOB:
memory usage:
            Slab:               7936 kB
hackbench:
    Time: 263.900
    Performance counter stats for 'hackbench -g 4 -l 10000':

	527649.37 msec cpu-clock                 #    1.999 CPUs utilized
              12451963      context-switches          #   23.599 K/sec
                251231      cpu-migrations            #  476.132 /sec
                  4112      page-faults               #    7.793 /sec
          342196899596      cycles                    #    0.649 GHz
          228439896295      instructions              #    0.67  insn per cycle
            3228211614      branch-misses
           65667138978      cache-references          #  124.452 M/sec
            7406902357      cache-misses              #   11.279 % of all cache refs

	263.956975106 seconds time elapsed

           5.213166000 seconds user
         521.716737000 seconds sys

SLOB with segregated free list:
memory usage:
            Slab:               8976 kB
hackbench:

    Time: 28.896
    Performance counter stats for 'hackbench -g 4 -l 10000':

              57669.66 msec cpu-clock                 #    1.995 CPUs utilized
                902343      context-switches          #   15.647 K/sec
                 10569      cpu-migrations            #  183.268 /sec
                  4116      page-faults               #   71.372 /sec
           72101524728      cycles                    #    1.250 GHz
           68780577270      instructions              #    0.95  insn per cycle
             230133481      branch-misses
           23610741192      cache-references          #  409.414 M/sec
             896060729      cache-misses              #    3.795 % of all cache refs

	28.909188264 seconds time elapsed

           1.521686000 seconds user
          56.105718000 seconds sys
