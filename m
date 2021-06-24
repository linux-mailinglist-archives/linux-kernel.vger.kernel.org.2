Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504B43B3870
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 23:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbhFXVUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 17:20:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43978 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232163AbhFXVUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 17:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624569461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VbuTBMFChOy4pqwvCtsZG3RUwzvZUOwMhboraTVRj4M=;
        b=bA9cYCK4BHJtz2xulgZF239GLFOBPLdPlozAxR4dGOQY26lQZMIOMxhFNAU3lBQEda76Bp
        l11tUjI0+2+cmnUBH/27pYF/m9nD8v33u7lH3jNb2p68dklODaesDmFIGK4+NYGOe0OZLm
        jN7yGipgB6Mq5IndlLaI1hF/SA4F7PU=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-BlqleBFcOYyXO1DO0-FtjQ-1; Thu, 24 Jun 2021 17:17:40 -0400
X-MC-Unique: BlqleBFcOYyXO1DO0-FtjQ-1
Received: by mail-oo1-f71.google.com with SMTP id e10-20020a4ab14a0000b029020e1573bdb7so4502397ooo.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 14:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VbuTBMFChOy4pqwvCtsZG3RUwzvZUOwMhboraTVRj4M=;
        b=EIvjXN2bGCAKYztTdR5+7XfuVnGfafQML/XYjUpF9mTF0LUnh5qUPAohx253T1GW7P
         frR1OmYwcAzv9P/can0lZw98XbQT73E/BJdL3Uvoqhnen6oKN0M5gfu2wza5pXciZQLz
         aVRyHP/XZfFP8l2OWlVNBqm0c0XlU6p3R08YBHxifo5Ta8kulzbJeCEPiLvUvImc5Xok
         hIrUFezXU1xd2Ey3XeAI/+wirRZiY6tqN8+IcjxPxiEL7ntQwSBr02Czjcnq+u47qTfl
         neWh1+B03rd2XXMV/ubkNLGVd9TzmT/+nFP4F6IQ5mPf7dHlvu4vSVkkJFVCa77/JacJ
         W0kg==
X-Gm-Message-State: AOAM532UUPBts/KHCqZHdLkGTfXDQDyfjcYnvPV2m46Kjn5PdJC08CK6
        W34kEng4PvXvvVVRhZlZ9QWzK8droufmYfbMfu94Jqrwe5oSGRW9x9nUomLLjVw5vvU8NwfoHM3
        v3D1Y66A8NRckvEZil8mgiXc0
X-Received: by 2002:a05:6830:1c2e:: with SMTP id f14mr6444879ote.133.1624569459332;
        Thu, 24 Jun 2021 14:17:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMtb0KwbhrC4hX3KzMWzQtC+1uIfeoLx9w4mgt0iXeUxBWaQ4cK/XbrTlFsKjiaexh1vNAOA==
X-Received: by 2002:a05:6830:1c2e:: with SMTP id f14mr6444852ote.133.1624569459075;
        Thu, 24 Jun 2021 14:17:39 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 94sm915513otj.33.2021.06.24.14.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 14:17:37 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v4 0/5] generalize fpga_mgr_load
Date:   Thu, 24 Jun 2021 14:17:21 -0700
Message-Id: <20210624211727.501019-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Depends on
https://lore.kernel.org/linux-fpga/20210623182410.3787784-1-trix@redhat.com/

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

Stub in remimage support for dfl

Changes since v1:
- update op names changed from
  partial_update to reconfig
  full_update to reimage
- dropped the cancel() and get_error() ops.
- add FPGA_MGR_REIMAGE bit
- refactor fpga_mgr_load to use either update ops

Changes since v2:
- Fix a missed write op change
- Stub in dfl reimage

Changes since v3
- refactor for wrapper ops patchset
- drop 0004 fpga: defer checking.., wrapper ops took care of that
- drop 0006 fpga: dfl stub in..., simplify the patchset
- add a wrapper for write_sg
- rearrange the passing of update ops to be last.
- simplify some wrapper checks, this should go in the wrapper ps.

Tom Rix (5):
  fpga: generalize updating the card
  fpga: add FPGA_MGR_REIMAGE flag
  fpga: pass fpga_manager_update_ops to the fpga_manager_write functions
  fpga: use reimage ops in fpga_mgr_load()
  fpga: fpga-mgr: simplify mops check in wrappers

 drivers/fpga/altera-cvp.c        |   8 +--
 drivers/fpga/altera-pr-ip-core.c |   8 +--
 drivers/fpga/altera-ps-spi.c     |   8 +--
 drivers/fpga/dfl-fme-mgr.c       |   8 +--
 drivers/fpga/fpga-mgr.c          | 103 +++++++++++++++++++------------
 drivers/fpga/ice40-spi.c         |   8 +--
 drivers/fpga/machxo2-spi.c       |   8 +--
 drivers/fpga/socfpga-a10.c       |  10 +--
 drivers/fpga/socfpga.c           |   8 +--
 drivers/fpga/stratix10-soc.c     |   6 +-
 drivers/fpga/ts73xx-fpga.c       |   6 +-
 drivers/fpga/xilinx-spi.c        |   8 +--
 drivers/fpga/zynq-fpga.c         |  10 +--
 drivers/fpga/zynqmp-fpga.c       |   6 +-
 include/linux/fpga/fpga-mgr.h    |  35 +++++++----
 15 files changed, 140 insertions(+), 100 deletions(-)

-- 
2.26.3

