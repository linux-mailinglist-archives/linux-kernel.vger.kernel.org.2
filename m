Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4C338B5FA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 20:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbhETSal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 14:30:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39509 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234290AbhETSak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 14:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621535358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KuRG9vWY0jfUiOP1f57t7lLfBEAT6/lfYeU935poEww=;
        b=agLdnSyrVT7KZMnsFrFBwtkw+hFDN+/YPjIKP5h8evDlmsQ/dhUSXGMPzGDHO8YeO/0goO
        aAFu83ZpvcWxSMAE2jw+AfjqIHTtSOBTLaA/ZRIeqidkz5QKJgi7v5fkfGE5ZvjZCGmoLS
        XtuVIVfNkXxy7VImbCgTY+RyNuYigF4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-IoWwIO88MW691TQICrW5tg-1; Thu, 20 May 2021 14:29:16 -0400
X-MC-Unique: IoWwIO88MW691TQICrW5tg-1
Received: by mail-qv1-f69.google.com with SMTP id n12-20020a0cdc8c0000b02901efdf8d3bc7so11206867qvk.23
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 11:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KuRG9vWY0jfUiOP1f57t7lLfBEAT6/lfYeU935poEww=;
        b=NpIBdsBPzGIuTfYgSMlgwnNBqnQMj7DlCC38OCjbKRHUljHoPzS6NxzBLrhGm8gNEr
         ujVilb1qyOBg7fuhWEDdG5dm4E0D3NVMH+UsD96PnYxqqVmK9uGLBXfGY/49TcydRq3H
         IsStfoZ88fyA0EQKB8WuwZy5vmlrsCiMQEp1rSq/8AXVhqgUs3ZoWkOy+nvCjBMO0FTa
         bCrjAcRDboUgAWNHC+882EC7v4gaxQxguJaChWwKrOXaBb0QrGpUcqndkFfaduZXqQdo
         gE+yZaDLR59dDRSVFWJ551iZ1qKAudjn4ZnzcrkeUiprGmSplvf1zhB4euhcuAz0IY92
         jcuA==
X-Gm-Message-State: AOAM530/rbdO864zWGrUDkdbQGZ2TjZmI/G1WIAvMxK1OHYYyGYt4vHd
        tjny9wpmKkn3BpOSBz1ymu6B9KGBkYxHn+oRTl72YL3xkAR3x6mVoqSylp1jI/AywhTxsbC3+86
        nfY3Y0Vbx7HkG+5y3SU5l3nZ0
X-Received: by 2002:a37:a309:: with SMTP id m9mr7206203qke.126.1621535355837;
        Thu, 20 May 2021 11:29:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwldeFbz0RULF07VGqpc5h9My9BH9z98cOaZH/dSszgRT8CgQ/ebLHUQRBrmVYBM65/8fiWkg==
X-Received: by 2002:a37:a309:: with SMTP id m9mr7206181qke.126.1621535355674;
        Thu, 20 May 2021 11:29:15 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l10sm2702932qtn.28.2021.05.20.11.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 11:29:15 -0700 (PDT)
From:   trix@redhat.com
To:     russell.h.weight@intel.com, mdf@kernel.org, hao.wu@intel.com,
        michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2 0/5] generalize fpga_mgr_load
Date:   Thu, 20 May 2021 11:29:06 -0700
Message-Id: <20210520182906.2021594-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A refactor of the fpga-manager to make space for the
functionality of the secure update in this thread.
https://lore.kernel.org/linux-fpga/20210517023200.52707-1-mdf@kernel.org/T/#mf3a1951d429a973c863eee079ed990c55056827c

Splits the reconfig write ops into its own ops structure and
then has an instance for the existing loading (reconfig) and the
secure update (reimage)

fpga_mgr_load uses a new bit, FPGA_MGR_REIMAGE, in fpga_info_info
to use either the reconfig or the reimage ops.

valid write op checking has moved to make the reimage path option.

Since fpga_image_info_alloc zalloc's the fpga_info_struct, the
reimage path will not be taken.

Changes since v1:
- update op names changed from
  partial_update to reconfig
  full_update to reimage
- dropped the cancel() and get_error() ops.
- add FPGA_MGR_REIMAGE bit
- refactor fpga_mgr_load to use either update ops

Tom Rix (5):
  fpga: generalize updating the card
  fpga: add FPGA_MGR_REIMAGE flag
  fpga: pass fpga_manager_update_ops to the fpga_manager_write functions
  fpga: defer checking for update ops until they are used
  fpga: use reimage ops in fpga_mgr_load()

 drivers/fpga/altera-cvp.c        |  8 ++--
 drivers/fpga/altera-pr-ip-core.c |  8 ++--
 drivers/fpga/altera-ps-spi.c     |  8 ++--
 drivers/fpga/dfl-fme-mgr.c       | 10 ++---
 drivers/fpga/fpga-mgr.c          | 72 ++++++++++++++++++++------------
 drivers/fpga/ice40-spi.c         |  8 ++--
 drivers/fpga/machxo2-spi.c       |  8 ++--
 drivers/fpga/socfpga-a10.c       | 10 ++---
 drivers/fpga/socfpga.c           |  8 ++--
 drivers/fpga/stratix10-soc.c     |  8 ++--
 drivers/fpga/ts73xx-fpga.c       |  8 ++--
 drivers/fpga/xilinx-spi.c        |  8 ++--
 drivers/fpga/zynq-fpga.c         | 10 ++---
 drivers/fpga/zynqmp-fpga.c       |  8 ++--
 include/linux/fpga/fpga-mgr.h    | 35 +++++++++++-----
 15 files changed, 125 insertions(+), 92 deletions(-)

--
2.26.3

