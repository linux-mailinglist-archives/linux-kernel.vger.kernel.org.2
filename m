Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717E339E542
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhFGR0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:26:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35875 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230241AbhFGR0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623086670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TEP31TFdWd4l/tTP+PI0xsmjj+INe8K7ttjcjq53ptQ=;
        b=g2ureQQjw+Dcfvt1wVKyYoqTVv1DEmvRSq3raLwRfrP04yPt/2lWUn5onsj1tnq8FrXIoe
        UNK+reGXjkVlYQTK5gRHHRF4QhtVglUrN0MoHZnSKv6ODkz80Spqd4uzExvx1adv05awNn
        JZYe2+8D8K7tAuJbe4JxznW6mEjwURQ=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-5UaaPUfhPf-EgoBfeWr_ig-1; Mon, 07 Jun 2021 13:24:28 -0400
X-MC-Unique: 5UaaPUfhPf-EgoBfeWr_ig-1
Received: by mail-ot1-f70.google.com with SMTP id z18-20020a0568301292b02902dc88381e4dso12042773otp.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 10:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TEP31TFdWd4l/tTP+PI0xsmjj+INe8K7ttjcjq53ptQ=;
        b=ky6Sx9a96dXDylgoi0tKViEhIZ1rj086tFwe2kBoozH4UZkOEAznU70Zd5XjASrG8P
         s4OrZFx0LxSByrcZm7IMmD8qZ9HZcmfZ8MCLfk8zwot5AoZvpU4MVLxHUwZdRGjDv6Uh
         piKuxNWFX3HfyyAjwRRsAK3kC8799+EMtEOa+Yh1+kXOQoOsYeG34IC135wQFEVRIjow
         MTi2P3vjbBSpompcs9zC3ScZ1qxkQCAInSPzXE0e8nD4Bq1Mp4W0kRPyccoYSotM0lkk
         p0PmeUzb0oY6H3zXFrrT/dsACO1NJkVueJUppUC6rnF9/j8PKC/3XPEpvoUEIq8pN4xH
         1wog==
X-Gm-Message-State: AOAM531FIafnimIyyzPWKJUGCYG1EiqBjIz5BnE22cnFxEUIRxWqFFog
        qszerRu834vDeSsS2UU4vslZsbrYjVor8lIfTBHFhxCwVYeAp2NaUfIADIVxPqswSe34DXhAAEi
        hyli9vK9rHSgRB8qWm8gp/gcC
X-Received: by 2002:a05:6830:200b:: with SMTP id e11mr14860935otp.349.1623086668182;
        Mon, 07 Jun 2021 10:24:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZaUyERwELD4Yo3dxSCuUEjYFdaNad6e8SmjPnerQlkCLYK3J0lULnWCzJzpfF2wyloptH9Q==
X-Received: by 2002:a05:6830:200b:: with SMTP id e11mr14860925otp.349.1623086668040;
        Mon, 07 Jun 2021 10:24:28 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 15sm2409859oij.26.2021.06.07.10.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 10:24:27 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH 0/7] fpga: wrappers for fpga_manager_ops
Date:   Mon,  7 Jun 2021 10:23:55 -0700
Message-Id: <20210607172402.2938697-1-trix@redhat.com>
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

write_sg op was not wrapped on purpose.  Its checking / use in
fpga_mgr_buf_load_sg() did not warrant a wrapper.

Tom Rix (7):
  fpga: wrap the write_init() op
  fpga: make write_complete() op optional
  fpga: wrap the write() op
  fpga: wrap the status() op
  fpga: wrap the state() op
  fpga: wrap the fpga_remove() op
  fpga: collect wrappers and change to inline

 drivers/fpga/dfl-fme-mgr.c   |   6 ---
 drivers/fpga/fpga-mgr.c      | 102 +++++++++++++++++++++++------------
 drivers/fpga/stratix10-soc.c |   6 ---
 drivers/fpga/ts73xx-fpga.c   |   6 ---
 drivers/fpga/zynqmp-fpga.c   |   7 ---
 5 files changed, 67 insertions(+), 60 deletions(-)

-- 
2.26.3

