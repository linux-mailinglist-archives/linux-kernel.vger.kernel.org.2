Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8233B495F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 21:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhFYTyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 15:54:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28346 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229573AbhFYTyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 15:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624650721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ef9qFAYdxrVH6/HlVHojSk640HF0K6FvgDiFwPqxu5U=;
        b=JEs8bf3kbVdVmwDbSxceBzIVzs+KWIXNgdvIR4XOmkWlA0XnRBx8FCfI7MIVi4j7RadGOr
        kMvIIlYZOkFtq4OXQF1vOSvc/nOzmlXExY0Z54pfRVdCcdfXBKY3eOJ08NrAitODGWwLx5
        z9HMmIg8ccWDo0jsZmnQJcHLUV9PEx4=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-HlbKaA4ONDmnbF2mMhbSjA-1; Fri, 25 Jun 2021 15:52:00 -0400
X-MC-Unique: HlbKaA4ONDmnbF2mMhbSjA-1
Received: by mail-ot1-f69.google.com with SMTP id v29-20020a056830091db029045efea1ec9bso6551029ott.21
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 12:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ef9qFAYdxrVH6/HlVHojSk640HF0K6FvgDiFwPqxu5U=;
        b=Coip1Oi7fu6hxw8nSjtYjZbeMYQK+Qfos/aSvO21dmkPc0Ljxlw/iU9zzIo7YdQ45K
         x+R2ZQPiQv1SIWdSDmTkLusT9pPzZoTkbGFuToC+/pxeX0WdF6c/j235JSu9DGK9eB0g
         ajJrcjD/mm+oAXemlKAL4jFRAiJ7P8GRtcF1CoUK4KEKQBr9ySvAE1o3c3UmkwErrtMs
         1byHYbtYpXPvjLVkJAIcT+GljQnYWhFHIrUCEGM4hMhEVGJ95IrsUZdj8x/k/jpIOTfm
         kTy/OxEw4LZe+/iFeS6SjofOG3czRUWWpEMUe0f/GpxtFdzY/OKM2+Ss4WYgMTfIGBh6
         2jfg==
X-Gm-Message-State: AOAM533mvwYve5VCZmxWTrjRsa2WRZ9fQ7tad5mXRIzCCYbSXoXARFnX
        JOU4xQgxUflKZbPGl5tPWqxlN/DtCaXaGq4ZgV8QseNGBdHbTbsrZCRNjQOHUklEg4yNMKxN8YD
        Xv/NG+NJPcmumVbA7EQVf9+QG
X-Received: by 2002:a9d:634d:: with SMTP id y13mr11285126otk.294.1624650719409;
        Fri, 25 Jun 2021 12:51:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9SONxhvUh55/AyVb2xueMPq6ATJRY/MzaDu3zdxqWTtJLSpUkP8d50R9gFMFN0vLoTE02qw==
X-Received: by 2002:a9d:634d:: with SMTP id y13mr11285114otk.294.1624650719191;
        Fri, 25 Jun 2021 12:51:59 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o25sm1535446ood.20.2021.06.25.12.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 12:51:58 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v4 0/7]  wrappers for fpga_manager_ops
Date:   Fri, 25 Jun 2021 12:51:40 -0700
Message-Id: <20210625195148.837230-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

As followup from
https://lore.kernel.org/linux-fpga/06301910-10a1-0e62-45a0-d28ab5a787ed@redhat.com/

Boards should not be required to have noop functions.
So improve or create fpga-mgr wrappers for the fpga_manager_ops.  
Remove the noop functions.
Refactor fpga-mgr to use the wrappers.

Changes from

v1:
  commit subject,log

v2:
  rebase to next-20210623

v3:
  remove mops check
  add write_sg wrapper
  drop 'fpga-mgr: collect wappers and change to inline'

Tom Rix (7):
  fpga-mgr: wrap the write_init() op
  fpga-mgr: make write_complete() op optional
  fpga-mgr: wrap the write() op
  fpga-mgr: wrap the status() op
  fpga-mgr: wrap the state() op
  fpga-mgr: wrap the fpga_remove() op
  fpga-mgr: wrap the write_sg() op

 drivers/fpga/dfl-fme-mgr.c   |   6 --
 drivers/fpga/fpga-mgr.c      | 111 +++++++++++++++++++++++------------
 drivers/fpga/stratix10-soc.c |   6 --
 drivers/fpga/ts73xx-fpga.c   |   6 --
 drivers/fpga/zynqmp-fpga.c   |   7 ---
 5 files changed, 75 insertions(+), 61 deletions(-)

-- 
2.26.3

