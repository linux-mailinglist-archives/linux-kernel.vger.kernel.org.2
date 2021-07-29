Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDCE3DAA1D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhG2R2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:28:20 -0400
Received: from foss.arm.com ([217.140.110.172]:53628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhG2R2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:28:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EDDF1FB;
        Thu, 29 Jul 2021 10:28:16 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56C033F73D;
        Thu, 29 Jul 2021 10:28:15 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH 0/2] irqchip/gic-v3: Fix selection of partition domain for EPPIs
Date:   Thu, 29 Jul 2021 17:27:46 +0000
Message-Id: <20210729172748.28841-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

gic_irq_domain_translate()'s GIC_IRQ_TYPE_PARTITION code knows about EPPI, and
gic_populate_ppi_partitions() sets them up, but gic_irq_domain_select() and
partition_domain_translate() didn't get the memo, meaning partitioned EPPI
don't work.

I'm not aware of a platform affected by this, so I don't think its stable
material.

Based on rc1, available here:

git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git irqchip/ppi_partition/eppi_fixes/v1


Thanks,

James Morse (2):
  irqchip/gic-v3: Add __gic_get_ppi_index() to find the PPI number from
    hwirq
  irqchip/gic-v3: Fix selection of partition domain for EPPIs

 drivers/irqchip/irq-gic-v3.c | 61 +++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 11 deletions(-)

-- 
2.30.2

