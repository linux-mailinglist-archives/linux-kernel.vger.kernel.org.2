Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2110F3979F9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 20:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbhFASXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 14:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbhFASXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 14:23:48 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7387DC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 11:22:05 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id e1so3073952pld.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 11:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N590ERPxxGg8/dMTw4VCa6qnq3T7bZw0OnBgJ+94JC0=;
        b=myeIShlJLASAlCPHOcNqaie+PXracNEfNlGHIyAKJ1GTdY5P0EcciI6cHQi+P/+PUq
         gUb0gM4Ir3sOoY5AFs0MZ7Z5FnGtvcUh+KdQcuZYeSwhQ/8S1jm44wmazpaqqz3uhJId
         tuLdQRXk4a/EFPccoKuGvjvT0ELpQsmQWZQlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N590ERPxxGg8/dMTw4VCa6qnq3T7bZw0OnBgJ+94JC0=;
        b=JGbMm+ouaZyuZ8ZEMkhojMeRQHavH4iMyZu2o6L1wYcFwsfKhyfIc9l1cYDHNoRZal
         vmdwv6p5bL8sTxam9hUWKJVa0uyOmJ/ASurSkQ3Jrluvlb9wqnfBZqry92uq8TMd1wt0
         1FhaLKH16wJEHFCSJ37JxS9XWEdCjlM4i3b6+JIFs321YHFDqimJJFtvzVSu16h5NCHl
         CrUCFMVPJC1bna8bs4GA9X7H4fhGpprgGI1EEJMUIJ0ILAvNPZ7T6aZ3QOcTEdembc5Q
         VQ4Kmhw73/d0/bJh3dlcR3FlZwLfM5Lhvrnv5SXOzrolllKrIQ94fKODXk1LOw8UBuNQ
         FW1w==
X-Gm-Message-State: AOAM530WXOf+rMsFdEkeBD+mG+j4cdObnZhC4xBJakO7nYmBmaVHjb2k
        EtevQ9G7spjo0DYin3CaIeko1g==
X-Google-Smtp-Source: ABdhPJycRHp/Fs/mycv/09GBfTzFmVr3DcT4Qh/upYDbYbTpuP7W+MVvQmpZ0VnO3Sk2j3TqxcfvJg==
X-Received: by 2002:a17:90a:4f0a:: with SMTP id p10mr1225781pjh.36.1622571724975;
        Tue, 01 Jun 2021 11:22:04 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:ee82:b2a7:c8bd:18e7])
        by smtp.gmail.com with ESMTPSA id g29sm14510982pgm.11.2021.06.01.11.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 11:22:04 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>
Subject: [PATCH v3 0/4] slub: Print non-hashed pointers in slub debugging 
Date:   Tue,  1 Jun 2021 11:21:58 -0700
Message-Id: <20210601182202.3011020-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was doing some debugging recently and noticed that my pointers were
being hashed while slub_debug was on the kernel commandline. Let's force
on the no hash pointer option when slub_debug is on the kernel
commandline so that the prints are more meaningful.

The first two patches are something else I noticed while looking at the
code. The message argument is never used so the debugging messages are
not as clear as they could be and the slub_debug=- behavior seems to be
busted. Then there's a printf fixup from Joe and the final patch is the
one that force disables pointer hashing.

Changes from v2 (https://lore.kernel.org/r/20210526025625.601023-1-swboyd@chromium.org):
 * Fixed up Fixes tag on first first patch
 * Picked up acks
 * Moved decl of no_hash_pointers() to kernel.h

Changes from v1:
 * Dropped the hexdump printing format
 * Forced on the no_hash_pointers option instead of pushing %px

Joe Perches (1):
  slub: Indicate slab_fix() uses printf formats

Stephen Boyd (3):
  slub: Restore slub_debug=- behavior
  slub: Actually use 'message' in restore_bytes()
  slub: Force on no_hash_pointers when slub_debug is enabled

 include/linux/kernel.h |  2 ++
 lib/vsprintf.c         |  2 +-
 mm/slub.c              | 13 ++++++++++---
 3 files changed, 13 insertions(+), 4 deletions(-)


base-commit: d07f6ca923ea0927a1024dfccafc5b53b61cfecc
-- 
https://chromeos.dev

