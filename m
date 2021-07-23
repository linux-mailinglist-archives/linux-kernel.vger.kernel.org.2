Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE833D425B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 23:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbhGWVAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 17:00:17 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:53135 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbhGWVAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 17:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1627076438; x=1658612438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CVn7oX0CjfibpYFFpqHWKgpHrrL7Xnf/XJqEMEbWufY=;
  b=I3YhLYCYXOyjQmfd7NjMgSObNw8JiNTFxnRo8fqzh2qWV45pc5DfbL+Y
   5YvdAe4WfY4N4PZAjlnX9cZtX8ZrGun5JUlnuVyxvs7e6y7dnc5PrnYAh
   2f1/l1dvOBUW2gNkpXfE0hLm7fFRodvwlC1zxWRF91KdMD8h5J+x8SHW4
   Zs4mAh5ntglJIhbqVFsYr0jMYwGB5wXbzdljSipEBByVD8dYwnmQ64HTI
   VKkFu7C5T8iak80e/N0eIC3XQ6/lBKnE6aWHSD4J2VQ3E13sEeDNlWsqB
   mAvNf57iybdhlONt1QHcvV4qE9OkW64o4vz8ulVBxod3/dil/f2Y7Fdvz
   g==;
X-IronPort-AV: E=Sophos;i="5.84,265,1620662400"; 
   d="scan'208";a="279198474"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2021 05:40:38 +0800
IronPort-SDR: MaPQalYt1s5J/irtK+2I9xeyOvHsqOmB0UDaXcwP8LNGJIKICd1z7bWoF7Ml4qDEtEVeiDZfm6
 tzcQDO3BZ25QZ6897uCRHP1EC5Tp9QBlHlEfLs07Hd2k489vfRHxDo9QU6LC9cWhjh3/NBhJl5
 5f5T36cXl8GpClyBuEzBBxAy1KLBDtq0UffrA4qDPoPRMMGxtfLrjEs+3x/3xzvV4+isGY5AO2
 ir8v/Kyj24mrzaXT58QoCVkasIxOx9rAzBQN6OgbfQQNLC6N08vlPRiN51uopbtoEgrOKpvJOf
 mF0SU2aw+VS9j4xq5c39ORRz
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:16:47 -0700
IronPort-SDR: qhmdgrA1THlc1t/uoxnlsIj0rUGoMMu54qei7gUWzJ87apTwDnCvOIRNBoziAyb682Fgk8jRYW
 UcnQ0MFzhh8mMx4cCW8MaT8l+6SGuqwmTGzpjclU1SRda/TiKJfNmAERHZ7vruJbQbqj+9akst
 Zy3PrYdD05YDUud56v6fL93ksTdhe8tU/rO4Z3KZSrDBVeLvwxNigChWwMk+eKF4Kh9+8OoRpp
 HbIAUxanozLZ7K6AaSrtNE+1ypjkoxDYqn0/HSxVF48FGlduZ0tmkOcdTrI8grrvNtTC8wvyvW
 Vu0=
WDCIronportException: Internal
Received: from ucfbox21.ad.shared (HELO hulk.wdc.com) ([10.225.167.4])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Jul 2021 14:40:38 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Hellwig <hch@lst.de>, devicetree@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        iommu@lists.linux-foundation.org, linux-riscv@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tobias Klauser <tklauser@distanz.ch>
Subject: [RFC 5/5] RISC-V: Support a new config option for non-coherent DMA
Date:   Fri, 23 Jul 2021 14:40:31 -0700
Message-Id: <20210723214031.3251801-6-atish.patra@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210723214031.3251801-1-atish.patra@wdc.com>
References: <20210723214031.3251801-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In future, there will be more RISC-V platforms with non-coherent DMA.
Instead of selecting all the required config options in every soc, create
a new config that selects all the required configs related non-coherent
DMA.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8fcceb8eda07..931b283c8ec9 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -209,6 +209,14 @@ config PGTABLE_LEVELS
 config LOCKDEP_SUPPORT
 	def_bool y
 
+config RISCV_DMA_NONCOHERENT
+	bool
+	select ARCH_HAS_DMA_PREP_COHERENT
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
+	select ARCH_HAS_SETUP_DMA_OPS
+	select DMA_GLOBAL_POOL
+
 source "arch/riscv/Kconfig.socs"
 source "arch/riscv/Kconfig.erratas"
 
-- 
2.31.1

