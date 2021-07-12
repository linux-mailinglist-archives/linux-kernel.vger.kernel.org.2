Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A623C5B88
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbhGLLle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 07:41:34 -0400
Received: from foss.arm.com ([217.140.110.172]:53966 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233825AbhGLLld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 07:41:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5DCF6D;
        Mon, 12 Jul 2021 04:38:44 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1D5A73F694;
        Mon, 12 Jul 2021 04:38:43 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        al.grant@arm.com, anshuman.khandual@arm.com, leo.yan@linaro.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        peterz@infradead.org, suzuki.poulose@arm.com,
        Tamas.Zsoldos@arm.com, will@kernel.org
Subject: [PATCH 0/5] coresight: TRBE and Self-Hosted trace fixes
Date:   Mon, 12 Jul 2021 12:38:25 +0100
Message-Id: <20210712113830.2803257-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series of fixes addressing the issues in the way we handle
  - Self-Hosted trace filter control register for ETM/ETE
  - AUX buffer and event handling of TRBE at overflow.

The use of TRUNCATED flag on an IRQ for the TRBE driver is
something that needs to be rexamined. Please see Patch 3 for
more details.

Suzuki K Poulose (5):
  coresight: etm4x: Save restore TRFCR_EL1
  coresight: etm4x: Use Trace Filtering controls dynamically
  coresight: trbe: Keep TRBE disabled on overflow irq
  coresight: trbe: Move irq_work queue processing
  coresight: trbe: Prohibit tracing while handling an IRQ

 .../coresight/coresight-etm4x-core.c          | 109 ++++++++++++++----
 drivers/hwtracing/coresight/coresight-etm4x.h |   7 +-
 drivers/hwtracing/coresight/coresight-trbe.c  |  91 ++++++++++-----
 3 files changed, 149 insertions(+), 58 deletions(-)

-- 
2.24.1

