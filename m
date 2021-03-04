Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5343332DDBE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 00:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhCDXUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 18:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbhCDXUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 18:20:15 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929FDC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 15:20:15 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d8so219653plg.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 15:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+EANd2tRGWvmXdhTmEOwaAXoG0qnppr8pGCskqJFHYs=;
        b=ZFSDIozVIFv6zCoAj7sUaWo8JzEhkFk809bGmP5eqBhXz8HlO8x0LZku24pJEkIIwa
         qgfhanKnmUJFgNSBGk1C14aYHEBBZKzjctwEjXkGITD4xGuw3TbvKlFOxMYzIJDKJm/h
         QWDotQGdW1sMk7JzocHXjrCyYJAZiezCeUV4t4FHKe1HKPx4MLpUrCT8d9kYY5yF4AHp
         nUqxEWXDL/R9cOZDsS9VDSM7qFj4F3HAEhZmgj5kCjU1mnrcbwMoykRBTQSh0rSPxOdU
         JpfU73vxxXocX7vZrM8PeGr44WwQ5ZdoiIevN23YeSzijVosUtpwWaJbNlgwoO2KZYwB
         4cWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+EANd2tRGWvmXdhTmEOwaAXoG0qnppr8pGCskqJFHYs=;
        b=k0E38hw7c8QG5ODDhYWAesinzUb7FEtQhToi3FaKcpgetgmiXjH8WJQLjml4pvPZsu
         NaAClXNLL+QrZGjL2t3DcrFaWNDz2gSVHxpa8suEwLV/RlsrgKiCswLj5hRtWVufKDMY
         Bl8wkIKL03lALHmfrS8x4Eocu7DiN/z9RZN/2Cm7veciBzkhylD4RUwJExKKW6kTeSDd
         6NQze+5v/fV1fk/b5zgDreCt5gJRx/2nj5SP2B7Y7btSVSU79iRN16Hep6U2CLVH41ZN
         2oe9JcXdZ9xBFlrAdEYnqqVeGpRg9JeVAmEda83nh64Bofj2W8mKa4Nkn6ZPCpZoN5Tm
         KDWw==
X-Gm-Message-State: AOAM532WVr9qy5Xej6MnkuNWSAbZNrsq3bjmkUb9jc0+Fzktvq0e70Ys
        0xzHJ3av/eZZBtrx8MlklCbEs/cEsLjl7A==
X-Google-Smtp-Source: ABdhPJyoEtjiav4GuVm1KSuipTRUYsjeq30jwUl5tmbEj3jjUn+SWiHYkQhxAf1JtZSw+uVbrfU+dA==
X-Received: by 2002:a17:90a:9604:: with SMTP id v4mr6914960pjo.201.1614900014616;
        Thu, 04 Mar 2021 15:20:14 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id u66sm429290pfc.72.2021.03.04.15.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 15:20:13 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christian Koenig <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Daniel Mentz <danielmentz@google.com>,
        =?UTF-8?q?=C3=98rjan=20Eide?= <orjan.eide@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Simon Ser <contact@emersion.fr>,
        James Jones <jajones@nvidia.com>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v8 0/5] Generic page pool & deferred freeing for system dmabuf heap
Date:   Thu,  4 Mar 2021 23:20:06 +0000
Message-Id: <20210304232011.1479036-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for letting so much time pass since the last revision!

The point of this series is trying to add both deferred-freeing
logic as well as a page pool to the DMA-BUF system heap to improve
allocation performance.

This is desired, as the combination of deferred freeing along
with the page pool allows us to offload page-zeroing out of
the allocation hot path. This was done originally with ION
and this patch series allows the DMA-BUF system heap to match
ION's system heap allocation performance in a simple
microbenchmark [1] (ION re-added to the kernel for comparision,
running on an x86 vm image):

./dmabuf-heap-bench -i 0 1 system
Testing dmabuf system vs ion heaptype 0 (flags: 0x1)
---------------------------------------------
dmabuf heap: alloc 4096 bytes 5000 times in 88092722 ns          17618 ns/call
ion heap:    alloc 4096 bytes 5000 times in 103043547 ns         20608 ns/call
dmabuf heap: alloc 1048576 bytes 5000 times in 252416639 ns      50483 ns/call
ion heap:    alloc 1048576 bytes 5000 times in 358190744 ns      71638 ns/call
dmabuf heap: alloc 8388608 bytes 5000 times in 2854351310 ns     570870 ns/call
ion heap:    alloc 8388608 bytes 5000 times in 3676328905 ns     735265 ns/call
dmabuf heap: alloc 33554432 bytes 5000 times in 13208119197 ns   2641623 ns/call
ion heap:    alloc 33554432 bytes 5000 times in 15306975287 ns   3061395 ns/call


Daniel didn't like earlier attempts to re-use the network
page-pool code to achieve this, and suggested the ttm_pool be
used instead, so this series pulls the page pool functionality
out of the ttm_pool logic and creates a generic page pool
that can be shared.

New in v7 (never submitted):
* Reworked how I integrated the page pool with the ttm logic
  to use container of to avoid allocating structures per page. 

New in v8:
* Due to the dual license requirement from Christian König
  I completely threw away the earlier shared page pool
  implementation (which had evolved from ion code), and
  rewrote it using just the ttm_pool logic. My apologies
  for any previously reviewed issues that I've reintroduced
  in doing so.

Input would be greatly appreciated. Testing as well, as I don't
have any development hardware that utilizes the ttm pool.

thanks
-john

[1] https://android.googlesource.com/platform/system/memory/libdmabufheap/+/refs/heads/master/tests/dmabuf_heap_bench.c

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Chris Goldsworthy <cgoldswo@codeaurora.org>
Cc: Laura Abbott <labbott@kernel.org>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: Daniel Mentz <danielmentz@google.com>
Cc: Ørjan Eide <orjan.eide@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Ezequiel Garcia <ezequiel@collabora.com>
Cc: Simon Ser <contact@emersion.fr>
Cc: James Jones <jajones@nvidia.com>
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org

John Stultz (5):
  drm: Add a sharable drm page-pool implementation
  drm: ttm_pool: Rework ttm_pool to use drm_page_pool
  dma-buf: heaps: Add deferred-free-helper library code
  dma-buf: system_heap: Add drm pagepool support to system heap
  dma-buf: system_heap: Add deferred freeing to the system heap

 drivers/dma-buf/heaps/Kconfig                |   5 +
 drivers/dma-buf/heaps/Makefile               |   1 +
 drivers/dma-buf/heaps/deferred-free-helper.c | 138 ++++++++++++
 drivers/dma-buf/heaps/deferred-free-helper.h |  55 +++++
 drivers/dma-buf/heaps/system_heap.c          |  47 +++-
 drivers/gpu/drm/Kconfig                      |   5 +
 drivers/gpu/drm/Makefile                     |   2 +
 drivers/gpu/drm/page_pool.c                  | 214 +++++++++++++++++++
 drivers/gpu/drm/ttm/ttm_pool.c               | 156 +++-----------
 include/drm/page_pool.h                      |  65 ++++++
 include/drm/ttm/ttm_pool.h                   |   6 +-
 11 files changed, 557 insertions(+), 137 deletions(-)
 create mode 100644 drivers/dma-buf/heaps/deferred-free-helper.c
 create mode 100644 drivers/dma-buf/heaps/deferred-free-helper.h
 create mode 100644 drivers/gpu/drm/page_pool.c
 create mode 100644 include/drm/page_pool.h

-- 
2.25.1

