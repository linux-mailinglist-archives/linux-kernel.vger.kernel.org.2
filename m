Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2735D3820DD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 22:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhEPUWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 16:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbhEPUWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 16:22:23 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D54C061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 13:21:08 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id s25so4709752ljo.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 13:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ftlbpKyqwT0RJWIAe0hR3P6y0TcUKvWKDzduTTWn2Fg=;
        b=lieanZqLCLS2LxP9L02DVSLudXXd7PRMTH6t3WR9+JM+RBJOFnmYxHffww3ace9rFQ
         p6WP8/iqS4geaNxxt/o0sjvuncrPKb0fKBEQRB7Sy23AY0frBsPBGvGerLVAGHi6qVHw
         RHJ1mjs5MZvWLYpvR9gkQ4WEu3AHOEKMHH1+n/Ied465UQY2K3d5aN5i8rkkHUMjIiV5
         NVSHaBdXf9hF9P+2dJnTb5/ETaOwWROj+xGXZuGewUAkWt3Ao5la106TZ81nyKhaUzMr
         iJJIHgk/WFgoGXJhiNnXyWXSFmcv/Vjc8AVGJqVdSiKq92Y1KjAXlv2pqnn/SkGFE63v
         Oceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ftlbpKyqwT0RJWIAe0hR3P6y0TcUKvWKDzduTTWn2Fg=;
        b=UpTrWmDeBXAml4GAkHhhHy6dAuQbbbQzVC6FxyZTcgCAh8GkKt99c3dvAsO/lEYJoU
         nzqyLNmmKIUCXek62bL5F4Il3WUxickUDEJcLPjRaJRc6QYYiZU7mcY1gQnWCgqZB1sT
         Yd9gMcACwf1YEInkHl1yLun9vMpTf2+xkRJWyE0d2hZbYA+OwKcMJ6JddgmJFJ7607sU
         iilgIm117NCEMg/l+6aT6E3SppqbQM52dd9Pp4T6qrbT26qXh6VGLFnjQFy1tu3wJ8HW
         0lwfpJFX3xGLNrKX6m9ljSoBwMszmSAejPPW9qxUHHzIj2vJkwX4PP05S2cTAGyD7hwv
         ie2A==
X-Gm-Message-State: AOAM533EUGWnpW17ZQTkB3SKbUGC5/02sAfNMCJsh3S4LlCI5kyXobAI
        amErhVWSGafgnRYBfetn+Mk=
X-Google-Smtp-Source: ABdhPJx8rYX1Khb1coxRS+ykKXCHKjLxc5SYiXS4V3D0lZSIcRrzsoWERwsfqXE93w4C2Vyjq6MTIQ==
X-Received: by 2002:a2e:91cb:: with SMTP id u11mr41546365ljg.83.1621196466691;
        Sun, 16 May 2021 13:21:06 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id y28sm378195lfg.210.2021.05.16.13.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 13:21:05 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 0/3] vmalloc() vs bulk allocator v2
Date:   Sun, 16 May 2021 22:20:53 +0200
Message-Id: <20210516202056.2120-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

There are three patches in this small series. This is a second iteration.
First one was buggy and leaded to kernel panic due to passing NUMA_NO_NODE
as "nid" to the bulk allocator(it assumes to have a valid node). 

Therefore the patch number [1] adds an extra helper that guarantees a correct
numa node ID if it is not specified. Basically saying when it is invoked with
NUMA_NO_NODE.

A patch [2] has been slightly updated, the change-log is below.

V1 -> V2:
    - Switch to the alloc_pages_bulk_array_node() helper so the NUMA_NO_NODE
      is correctly handled(similar to alloc_pages_node() API func).
    - Use "while()" loop instead of "for()" for high-order pages and increase
      number of allocated pages after actual alloc.

Uladzislau Rezki (Sony) (3):
[1]  mm/page_alloc: Add an alloc_pages_bulk_array_node() helper
[2]  mm/vmalloc: Switch to bulk allocator in __vmalloc_area_node()
[3]  mm/vmalloc: Print a warning message first on failure

 include/linux/gfp.h |  9 ++++++
 mm/vmalloc.c        | 78 +++++++++++++++++++++++++--------------------
 2 files changed, 52 insertions(+), 35 deletions(-)

--
2.20.1
