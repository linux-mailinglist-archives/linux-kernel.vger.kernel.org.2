Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F2C30B1E5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 22:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhBAVJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 16:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhBAVJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 16:09:27 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6B3C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 13:08:46 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id a8so24795204lfi.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 13:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w4xw7p1Zqxhp9EJUU/TzfN5yh7Qdrt0nLCbnKbIp9fE=;
        b=rLUugkAhgD6L2nsGFHFaOvNFiWi4R3D1yhuFhsxSUOuu7lvabvkkyRzdXbGGG3KWH0
         zB7PsivQxvFzOkNfXXfngiUsLWWj2FY+/6L/Gzzu6JsACROS8yD1/1lpbkx+7j6Bpeop
         P+SikBRBou5U/Ea3DQsqIDwhyo4P0ASjWKGkozQMtZYAWQsOfXFdZIY6KYWtzy9HatFe
         LtwED+LmCyFHcMW37bRbfvfIZu6mnQ9+j6QSNQQAOs6SeLbFUYdXtWM8T7w2m4vTQiqA
         Hx9IhnWjG169RH1Z0gUVv00BjIv/9jkLqXYYSitbHed46w6wzUP/ETjm4DdGw+qIh9j6
         /Okg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w4xw7p1Zqxhp9EJUU/TzfN5yh7Qdrt0nLCbnKbIp9fE=;
        b=Bad7LQLgOD+cnWzNu516mbznDdT5wMkyZ0K8mrFQkFoebFiM28xeJLVjtpsZBf3W7o
         QJpWdmw9pcgOnAK4H/7vg64Z4NuhSnCmeWQwirONGbFs6GjAnEcGezDBTedWWXhP1Ipd
         m+nMIwSDxLIrGmM8uvF10SIl8XxW+z7/wkSg71Wy+nNeR/8/I4PHIL355b7HDWe09gZv
         m6L4Ixa+Jqr8b8aL49qNirC2PtJ+d9BJAqiBOYXItxl7TTBgx12CXawbYLyc2nCQgeNL
         TIaBsHkqb0LdDdrxFyKz9RRkavMIyNptEkL5kNWPpF0Huk0wj7dqgvoqBUO3JBRRiwma
         7P9Q==
X-Gm-Message-State: AOAM530qL1d8LfYtkryDF5UPxzaX5hwbBTsYX8PsGLpsuCK96l7w/JpV
        g3/QoWFgNmlz8I+3BuLR5tE=
X-Google-Smtp-Source: ABdhPJyoAoXS3JmKTU/9HjAxhgSfVQ51gvRa/Lxtxe8gz5ZSYhQ37sPyXA82/X1DDQyDEepiPe1jBQ==
X-Received: by 2002:a19:ac49:: with SMTP id r9mr9856190lfc.602.1612213725358;
        Mon, 01 Feb 2021 13:08:45 -0800 (PST)
Received: from nova.home (2-108-107-206-static.dk.customer.tdc.net. [2.108.107.206])
        by smtp.gmail.com with ESMTPSA id v14sm3142227lfo.210.2021.02.01.13.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 13:08:44 -0800 (PST)
From:   Claus Stovgaard <claus.stovgaard@gmail.com>
To:     linux-nvme@lists.infradead.org
Cc:     Claus Stovgaard <claus.stovgaard@gmail.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: Mark Phison E16 (Corsair MP600) as IGNORE_DEV_SUBNQN
Date:   Mon,  1 Feb 2021 22:08:22 +0100
Message-Id: <20210201210822.6501-1-claus.stovgaard@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested both with Corsairs firmware 11.3 and 13.0 for the MP600 and both
have the issue as reported by the kernel.

nvme nvme0: missing or invalid SUBNQN field.

Signed-off-by: Claus Stovgaard <claus.stovgaard@gmail.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 81e6389b2042..41b1b0731cbd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3242,6 +3242,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x144d, 0xa822),   /* Samsung PM1725a */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+	{ PCI_DEVICE(0x1987, 0x5016),	/* Phison E16 (Corsair MP600) */
+		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x1d1d, 0x1f1f),	/* LighNVM qemu device */
 		.driver_data = NVME_QUIRK_LIGHTNVM, },
 	{ PCI_DEVICE(0x1d1d, 0x2807),	/* CNEX WL */
-- 
2.26.2

