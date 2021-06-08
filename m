Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9D53A04B1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbhFHT5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:57:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36010 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234060AbhFHT5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 15:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623182112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=g/+OD7OvS+76UUwXsW39r3R0qwsEt76jbnvntpEkAgY=;
        b=SDRWthhL61IjPb9M8bYDVk+PSOrMVCZU7hF3r5pwUytroEJHPRwMOblYaz0e+LjH6zVdRy
        MibAQBpXSDkueatIfIH48PYLYfs7/YfUdjzfkMstIWVO0OHI/sxf/ejuD55ON7Mce5/a6T
        +wVdC5rdccI5NMxZyNSWb5N6VP24vNA=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-7aCWCDA7OT23y0lDGGzRsQ-1; Tue, 08 Jun 2021 15:55:11 -0400
X-MC-Unique: 7aCWCDA7OT23y0lDGGzRsQ-1
Received: by mail-oi1-f200.google.com with SMTP id j1-20020aca65410000b02901f1d632e208so8034667oiw.16
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 12:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g/+OD7OvS+76UUwXsW39r3R0qwsEt76jbnvntpEkAgY=;
        b=pKBi+kGgGXrRh7gNEQv5XYJiZbc8JW3i+Duq1axw4g6liz8l01L3bro+mONhkvuvnq
         poqPlXDLMS0Re9DfaCjYybKAHyZED29o3hOlyZnR2kD9fs6WpkSLX7WqiArWlplE1W60
         4sdgKifrMvr4xnrDmsgqkkxwhMmCDNHldzXhac/WoQsEGibQPkjvhW9lP8Gv1AmiIFrw
         QeE9DSB0mJd2nYxGPuUT1R9Bce9iPk62/2MISvcDLxBDnZiNdtKKNobeTlBI4YCPbB6v
         eRFNmUivkHZjcuTmS4KUG0JP4lX18DRlBa83bxoaF/ogsjgxa8O1UpJoaEyGlwwPTr+a
         obpg==
X-Gm-Message-State: AOAM530wYeg4Nji3ftlxLXVxyvIdNVOcU3o292Ua+jf7zDvUQ+eQbe/t
        4AT4biNVzYb/PTVENmFohhagq30gTPe1kPfvDJ6upKhnPo57/ceAt4cccRQ61Oym0coWQfOfc3X
        0qg3zSKBt4xFjOh3Adisn3m+b
X-Received: by 2002:a4a:a843:: with SMTP id p3mr18458763oom.29.1623182111169;
        Tue, 08 Jun 2021 12:55:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7iFsOk+xHbLD3KsS/d+cS++jYnbcHd1SPwdO/kpmBt2w1RQcd/Tt8SvWaTnz4Ft10DJ6acg==
X-Received: by 2002:a4a:a843:: with SMTP id p3mr18458754oom.29.1623182110927;
        Tue, 08 Jun 2021 12:55:10 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s17sm3024046oog.31.2021.06.08.12.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 12:55:10 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2 0/7]  wrappers for fpga_manager_ops
Date:   Tue,  8 Jun 2021 12:54:58 -0700
Message-Id: <20210608195506.3022550-1-trix@redhat.com>
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

Changes from

v1: commit subject,log

Tom Rix (7):
  fpga-mgr: wrap the write_init() op
  fpga-mgr: make write_complete() op optional
  fpga-mgr: wrap the write() op
  fpga-mgr: wrap the status() op
  fpga-mgr: wrap the state() op
  fpga-mgr: wrap the fpga_remove() op
  fpga-mgr: collect wrappers and change to inline

 drivers/fpga/dfl-fme-mgr.c   |   6 ---
 drivers/fpga/fpga-mgr.c      | 102 +++++++++++++++++++++++------------
 drivers/fpga/stratix10-soc.c |   6 ---
 drivers/fpga/ts73xx-fpga.c   |   6 ---
 drivers/fpga/zynqmp-fpga.c   |   7 ---
 5 files changed, 67 insertions(+), 60 deletions(-)

-- 
2.26.3

