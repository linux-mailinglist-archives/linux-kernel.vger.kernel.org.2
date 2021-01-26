Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211AA3055F2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 09:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S316927AbhAZXMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 18:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbhAZEyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 23:54:53 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5773FC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 20:54:12 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id f63so9786926pfa.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 20:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=URXlqBgoW7eAYBt11EAu/NCKWLHcYYQnmUuvvKGQmRM=;
        b=oAA75emX2LUkL0OriTWd/U4OgUv5Q8NkCuD80YRVzEoMy9o8aRNi5jCWD+Ka9vACj8
         4o8+ltLoTjJgsgd0kW9wbkioFgOBzULbdd18GENLIAkBQtQtt8w4tAYkQLlyeQdAOCgD
         y/u98b4yRDcVSiBn9LW6Vqf0waUsLa+/YBMzqw7MztW/I/dR95Ppe3JZVrovV6IsHzMg
         aW5r1O5msM7ppOQLJ0bI5aRFp1jg7H6vl7wdtSUp9/Q/fCyX9AAXWhAwz3oWVZKyQ1xD
         xP/XzrmnIVMddeqg5OU/PLFMaHD8aWGHUFUuCMaB0UtfZxVrVpMTVYmtuopOm8Sk5GlT
         9qTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=URXlqBgoW7eAYBt11EAu/NCKWLHcYYQnmUuvvKGQmRM=;
        b=pvM0u3EnMTwJTRexZm1uV2hxkTI5vM9Ne4IxFMg0gIwiG8xwjJ9FFsO7hkRs8WvK5b
         +pRIw10nHiRCyEsimejvLVYvnT5byUtVsHZaD3JuOYebxWU/rKKO7+lx3LSgDbQdbHUP
         Y0bpxddyyerEo+byuYEF9Q4cntHGx896Uy8idoC36BVTREkglBcoe1VIRXb0BXzle45m
         G0N3jM6P4fK2E1/0Q4U3qF9iP6y6Gay1dAWAtbgDa+gIBdxy7nE3EYBtPmMgHqWfIyhp
         ywLmgQpdq0g+WewVPiLcdS+h0Rwt/toZ9KuAr798yajtr9u/WtlgFsRuaHw5d4+7IYkK
         5x4w==
X-Gm-Message-State: AOAM531nZMr6SLuLlUNslsbd4NwflBJD9Cs44HModJBp/MLHpz7PQnPn
        XBvHIiXW+r9s3bz5c5+06TE=
X-Google-Smtp-Source: ABdhPJxt734s9oKLQGLg+sFcYM1CKLFzq+gXIDmgTQbVyqzDGVbfuYrrWYig5tQPBuLc/oK0V1L/dg==
X-Received: by 2002:a63:cb01:: with SMTP id p1mr3973348pgg.406.1611636851909;
        Mon, 25 Jan 2021 20:54:11 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (192.156.221.203.dial.dynamic.acc50-nort-cbr.comindico.com.au. [203.221.156.192])
        by smtp.gmail.com with ESMTPSA id w184sm18803382pgb.71.2021.01.25.20.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 20:54:11 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/5] mm/vmalloc: cleanup after hugepage series
Date:   Tue, 26 Jan 2021 14:53:59 +1000
Message-Id: <20210126045404.2492588-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph pointed out some overdue cleanups required after the huge
page series, and I had some other comment and warning changes.

Thanks,
Nick

Nicholas Piggin (5):
  mm/vmalloc: remove map_kernel_range
  kernel/dma: remove unnecessary unmap_kernel_range
  powerpc/xive: remove unnecessary unmap_kernel_range
  mm/vmalloc: remove unmap_kernel_range
  mm/vmalloc: improve allocation failure error messages

 Documentation/core-api/cachetlb.rst |   4 +-
 arch/arm64/mm/init.c                |   2 +-
 arch/powerpc/kernel/isa-bridge.c    |   4 +-
 arch/powerpc/kernel/pci_64.c        |   2 +-
 arch/powerpc/mm/ioremap.c           |   2 +-
 arch/powerpc/sysdev/xive/common.c   |   4 -
 drivers/pci/pci.c                   |   2 +-
 include/linux/vmalloc.h             |  19 +---
 kernel/dma/remap.c                  |   1 -
 mm/internal.h                       |   7 ++
 mm/percpu-vm.c                      |   7 +-
 mm/vmalloc.c                        | 164 ++++++++++++++--------------
 12 files changed, 104 insertions(+), 114 deletions(-)

-- 
2.23.0

