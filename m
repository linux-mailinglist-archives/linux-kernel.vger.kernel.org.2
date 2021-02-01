Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB8D30AF5D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhBASdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbhBASbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:31:03 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07027C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:30:22 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id l22so11990626pgc.15
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to;
        bh=jmVH+B5byuoeCWBByF+rlgs1IXxlR3I67Dpk6zRz3g4=;
        b=SosvEstR48V1+HoHfiXGnSkDBo6c3RZs6iuOhiDQyZjm9TnrH7JIfkwKv8wGZRq6yS
         XEA9LefU8MB1mV5RA1WAXX5j+n+LUBkbMdz/mQbd5QviOoZKCN/lnUw618TSSfUPrrYt
         xePuFn6+rn4FC4tEsd5IgP9j2ohvNJ1tDqb4IHkjJpRq0v0bTyuPGPgimqUJD9Jhcpvb
         4eWManaTi4YMg0Rub+JEsVfoVWQEXxetnYgoJZ8btWoXceKQv1pjC9+aIMJQi1EQs479
         GVHei57xNQZbS00ckImI9fdie1QtctBpwObaFaZCvzO1heGZs6zbDzRc922TaadtIIVX
         Ui/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to;
        bh=jmVH+B5byuoeCWBByF+rlgs1IXxlR3I67Dpk6zRz3g4=;
        b=hCyD8mhznZudU3Y/XEcPmE+TXF78xcRrtGT6cQjtkXhriP5MeIUGMrsokdBcm6DBHw
         9WeBBn7KcT4BRpf+tBdou9rk+kFYB3lHLPF6H2gsSDKKh7ZKVW/syRqOD6a5Pnr+u+6M
         V5o5QKVbQ/vyZSkVZcU7/lf7tm5CaQjE7l0dqKk4AFQwPoLkUYjREiwEtZKw7jocUpSR
         TQyQA/hJzgh1rJ8B85qe9yobxtd7AxkbUcLFSkhTIo5MXw+goUIYuLRnvxfGJyqQBXlV
         N2ck7JIzjO+dxsTh8CxVx4B3vKx55LZxP1OcRpBr3mjg01xrw2m6kVU1ihmRy/uLqX2s
         yR0w==
X-Gm-Message-State: AOAM533OihsxwL+0Fc3Ylq7Pw9Hsixvbvney/OpAobiBkHolUqsPjIQd
        bbmRXW5HoNdQSXZQCF5ccVbTvbMziw==
X-Google-Smtp-Source: ABdhPJw91byWRyJEd+QII2hd/UYZLifFIxJy6ksqPbqPXXoI12a7ZnTaYTpJH9qVyZ2rTyjQMxFgH+s6dw==
Sender: "jxgao via sendgmr" <jxgao@jxgao.kir.corp.google.com>
X-Received: from jxgao.kir.corp.google.com ([2620:0:1008:11:695f:7f9e:413c:e3c7])
 (user=jxgao job=sendgmr) by 2002:a17:902:6b88:b029:df:ff72:7bc6 with SMTP id
 p8-20020a1709026b88b02900dfff727bc6mr18389861plk.23.1612204221515; Mon, 01
 Feb 2021 10:30:21 -0800 (PST)
Date:   Mon,  1 Feb 2021 10:30:14 -0800
Message-Id: <20210201183017.3339130-1-jxgao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH V2 0/3] SWIOTLB: Preserve swiotlb map offset when needed.
From:   Jianxiong Gao <jxgao@google.com>
To:     jxgao@google.com, erdemaktas@google.com, marcorr@google.com,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        gregkh@linuxfoundation.org, saravanak@google.com,
        heikki.krogerus@linux.intel.com, rafael.j.wysocki@intel.com,
        andriy.shevchenko@linux.intel.com, dan.j.williams@intel.com,
        bgolaszewski@baylibre.com, jroedel@suse.de,
        iommu@lists.linux-foundation.org, konrad.wilk@oracle.com,
        kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVMe driver and other applications may depend on the data offset
to operate correctly. Currently when unaligned data is mapped via
SWIOTLB, the data is mapped as slab aligned with the SWIOTLB. This
patch adds an option to make sure the mapped data preserves its
offset of the orginal addrss.

Without the patch when creating xfs formatted disk on NVMe backends,
with swiotlb=force in kernel boot option, creates the following error:
meta-data=/dev/nvme2n1   isize=512    agcount=4, agsize=131072 blks
         =               sectsz=512   attr=2, projid32bit=1
         =               crc=1        finobt=1, sparse=0, rmapbt=0, refl
ink=0
data     =               bsize=4096   blocks=524288, imaxpct=25
         =               sunit=0      swidth=0 blks
naming   =version 2      bsize=4096   ascii-ci=0 ftype=1
log      =internal log   bsize=4096   blocks=2560, version=2
         =               sectsz=512   sunit=0 blks, lazy-count=1
realtime =none           extsz=4096   blocks=0, rtextents=0
mkfs.xfs: pwrite failed: Input/output error

Jianxiong Gao (3):
  Adding page_offset_mask to device_dma_parameters
  Add swiotlb offset preserving mapping when
    dma_dma_parameters->page_offset_mask is non zero.
  Adding device_dma_parameters->offset_preserve_mask to NVMe driver.

 drivers/nvme/host/pci.c     |  4 ++++
 include/linux/device.h      |  1 +
 include/linux/dma-mapping.h | 17 +++++++++++++++++
 kernel/dma/swiotlb.c        | 16 +++++++++++++++-
 4 files changed, 37 insertions(+), 1 deletion(-)

-- 
2.27.0

