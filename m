Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE363E36DA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 20:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhHGSyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 14:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhHGSyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 14:54:53 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB19AC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 11:54:34 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d17so11718515plr.12
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 11:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jyQI7CDPpCjYTItgdUVO3/8GzLTHgm0SK6b8vvQ4f9w=;
        b=FPPRVq0mVZ7sJ8JqysTkroRbr4eWeWc5KrINWC9JcHuDy4BonRVMU03PqwYwBvW4pq
         YYjsRyCbTCaa40t7PjCyPHoJnTidsXKWMTDDrXmN1ocdeVu6kWbwNT1+rh0qQqy3N9eb
         7QiflpsrETGjpYxumbzrUERSxFOwhvk+5j/JKDG5CAJeowpR7s6r0PQb/fUejxLtAA86
         cRKWZjf6NcFONnIHZmzgXZ8jzB5Gzs4TSi90Uvua2I+OGn1I1htp2ZYfEsf9ZvhENw73
         Ok9GrEsLGUY1dkSO86u8/xU6riBDPtFVPBCqd4jqEdhBwf2t/ajJTnb2ztiGz41ZS/p0
         rPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jyQI7CDPpCjYTItgdUVO3/8GzLTHgm0SK6b8vvQ4f9w=;
        b=fxvkG7DbRD85bXI8qB6Xi5C43Bt4DwvRGgYQMrvPGHWbQ/tNvj9RCYlDu/5CRKZyM5
         RSa5poI+xluerwMN2PyTOrcRm8ejVa9VDnk6X6tM3/D3n4bqpVtpN3r6Ke9wylljezMu
         RSwQYyY8oOqerfP7191X3jztyuucA92BaO3j4ruiy70JAvvh8b8rkDgR/sY0sG8xtDiy
         p5L4OCuqJvKzqM8U5cmve9qlaUkER12Y9lXEkDIaHgUCPiPSRrrqUE4HO2fCL6xtBJ/N
         UR6WwE2ohWxnOdS/vmVRDt7hIORbtZ3swCPGkp6ZWr8PjIGREw2zQindH37iVr7rlpFW
         JSbA==
X-Gm-Message-State: AOAM5320utQaSIpwbcysyGouEvNGan6SxPWlpLxTqPnGSo+nEaTayrOR
        jUHoIyeGxNwB5uGZsfvLRd3NiQ==
X-Google-Smtp-Source: ABdhPJztCu9D7cPyHEsPC0K5TtWLcUoMKxTldOfjgB1BHYNSddroHMqJ8fHuRLJfkIfRMebUYfTEzg==
X-Received: by 2002:a63:cf0a:: with SMTP id j10mr372125pgg.4.1628362474018;
        Sat, 07 Aug 2021 11:54:34 -0700 (PDT)
Received: from T490.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id m6sm2418851pjv.40.2021.08.07.11.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 11:54:33 -0700 (PDT)
From:   wuqiang <wuqiang.matt@bytedance.com>
To:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org, mingo@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        wuqiang.matt@bytedance.com
Cc:     mattwu@163.com
Subject: [PATCH 0/2] *** kretprobe scalability improvement ***
Date:   Sun,  8 Aug 2021 02:54:15 +0800
Message-Id: <20210807185417.9209-1-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kretprobe is using freelist to manage return instances, but freelist as
a LIFO queue based on singly linked list, scales badly and thus lowers
throughput of kretprobed routines, especially for high parallelization.
Here's a typical result (XEON 8260: 2 sockets/48 cores/96 threads):

      1X       2X       4X       6X       8X      12X     16X
10880312 18121228 23214783 13155457 11190217 10991228 9623992
     24X      32X      48X      64X      96X     128X    192X
 8484455  8376786  6766684  5698349  4113405  4528009 4081401

This patch implements a scalabe, lock-less and numa-aware object pool
and as a result improves kretprobe to achieve near-linear scalability.
Tests of kretprobe throughput show the biggest gain as 181.5x of the
original freelist. Tge extreme tests of raw queue throughput can be up
to 282.8 of gain. The comparison results are the followings:

                  1X         2X         4X         8X        16X
freelist:  237911411  163596418   33048459   15506757   10640043
objpool:   234799081  294086132  585290693 1164205947 2334923746
                 24X        32X        48X        64X        96X
freelist:    9025299    7965531    6800225    5507639    4284752
objpool:  3508905695 1106760339 1101385147 1221763856 1211654038

The object pool is a percpu-extended version of original freelist,
with compact memory footprints and balanced performance results for
3 test caess: nonblockable retrieval (most kertprobe cases), bulk
retrieval in a row (multiple-threaded blockable kretprobe), huge
misses (preallocated objects much less than required).

wuqiang (2):
  scalable lock-less object pool implementation
  kretprobe: manage instances with scalable object pool

 include/linux/freelist.h | 521 ++++++++++++++++++++++++++++++++++++---
 include/linux/kprobes.h  |   2 +-
 kernel/kprobes.c         |  83 ++++---
 3 files changed, 536 insertions(+), 70 deletions(-)

-- 
2.25.1

