Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7C638F191
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 18:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbhEXQ3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 12:29:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25477 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232918AbhEXQ3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 12:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621873652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4nLMwC8kEWrD6J/dDuglp7fEMPmfCCD3GpnEGOSToTc=;
        b=Nj2yf1taMB1ln/Oo+45oQ8NfFEcszf0w6eBEBUie2aKeo0ic0GQYSy1jMWyJWh5S8IVPHb
        1jZwJgqB1WvWPpfw/VlhmpC0akqyxo+wtLsvWAkoGgQ3uwKp+NlPO0h0QiIZTSvE00q/9d
        xBNio1cPVlskVva4gHOziNUWuPJnUnk=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-Q00mrLdEM4y5Mq7Vs5ffKQ-1; Mon, 24 May 2021 12:27:27 -0400
X-MC-Unique: Q00mrLdEM4y5Mq7Vs5ffKQ-1
Received: by mail-oo1-f69.google.com with SMTP id e17-20020a4a55110000b029020eb08e4aedso12181661oob.20
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 09:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4nLMwC8kEWrD6J/dDuglp7fEMPmfCCD3GpnEGOSToTc=;
        b=DBmz4RTJbL7UGToH8eZrqK87lBCC9MBh6zdd4U67aHFgSa6JnJYePSFpuPg8plAn7v
         t+CitE6WQ3dUEcM5gJux6Frd9bz1z0N6JbQ5zPVqMjNbz0n9guB86UyLa+UVkiT8cv15
         qp2bT/RBudVUM5UBxHnttNaGfRNM7kU5slP+70MXCr7ud14hhnL/FesJAdr1qBDXIbZR
         vG2pte/nMfjNMYR+DO97exOz0KsaFoFemQLbU+EC+Nuj1DlLoF94Fd5nIGG/PdMv5E8p
         0OwAgfTld6sycP2bXB5XTpwWnhME/SdEk7rh3655zNHuoeCVgHB35ROhzyci4VeiuXmN
         /Ngg==
X-Gm-Message-State: AOAM532qkyrV548i3uwJwivWsP3gLawLSxtDXzcLjtCj7XmoBGW2+YgH
        xdeAaIu3Vzb4tIY/0IdBQdxz/vUENgUzMbq5Kxb2qK76C2zBQWcfpdkjPfIraCPDR0mkJCWj3ek
        /H0fnZkYtiKWMR1hIATTVM2J5
X-Received: by 2002:aca:f354:: with SMTP id r81mr11384673oih.4.1621873646670;
        Mon, 24 May 2021 09:27:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw42exOlTKgikljKyi6YLzzVPK2zjfc1vkxYWZ1pFeN/mqUzEECdUlPHF6iArYGeKhCGoasWg==
X-Received: by 2002:aca:f354:: with SMTP id r81mr11384661oih.4.1621873646515;
        Mon, 24 May 2021 09:27:26 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u24sm3171103otg.73.2021.05.24.09.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 09:27:25 -0700 (PDT)
From:   trix@redhat.com
To:     russell.h.weight@intel.com, mdf@kernel.org, hao.wu@intel.com,
        michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v3 0/6] generalize fpga_mgr_load
Date:   Mon, 24 May 2021 09:27:21 -0700
Message-Id: <20210524162721.2220782-1-trix@redhat.com>
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

Tom Rix (6):
  fpga: generalize updating the card
  fpga: add FPGA_MGR_REIMAGE flag
  fpga: pass fpga_manager_update_ops to the fpga_manager_write functions
  fpga: defer checking for update ops until they are used
  fpga: use reimage ops in fpga_mgr_load()
  fpga: dfl: stub in reimaging

 drivers/fpga/altera-cvp.c        |  8 ++--
 drivers/fpga/altera-pr-ip-core.c |  8 ++--
 drivers/fpga/altera-ps-spi.c     |  8 ++--
 drivers/fpga/dfl-fme-mgr.c       | 38 ++++++++++++++---
 drivers/fpga/dfl-fme-pr.c        | 40 +++++++++++-------
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
 include/uapi/linux/fpga-dfl.h    | 18 ++++++--
 17 files changed, 192 insertions(+), 111 deletions(-)

-- 
2.26.3

