Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BDB416131
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241732AbhIWOlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 10:41:04 -0400
Received: from foss.arm.com ([217.140.110.172]:35296 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241676AbhIWOlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:41:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD76ED6E;
        Thu, 23 Sep 2021 07:39:30 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B6CC63F718;
        Thu, 23 Sep 2021 07:39:29 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     mathieu.poirier@linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 0/5] coresight: TRBE and Self-Hosted trace fixes
Date:   Thu, 23 Sep 2021 15:39:14 +0100
Message-Id: <20210923143919.2944311-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the updated patches from the v3 of the series [0], parts of which
have been queued to coresight/next. This series now applies on the
coresight/next branch.

Changes since v3:
 - Split the spurious IRQ handling patch to :
   a) coresight: trbe: irq handler: Do not disable TRBE if no action is needed
   b) coresight: trbe: Fix handling of spurious interrupts

 - Added a helper to mark the ring buffer when there is WRAP event
   and added a comment to explain.

[0] https://lkml.kernel.org/r/20210914102641.1852544-1-suzuki.poulose@arm.com

Suzuki K Poulose (5):
  coresight: trbe: irq handler: Do not disable TRBE if no action is needed
  coresight: trbe: Fix handling of spurious interrupts
  coresight: trbe: Do not truncate buffer on IRQ
  coresight: trbe: End the AUX handle on truncation
  coresight: trbe: Prohibit trace before disabling TRBE

 .../coresight/coresight-self-hosted-trace.h   |  4 +-
 drivers/hwtracing/coresight/coresight-trbe.c  | 96 ++++++++++++-------
 2 files changed, 64 insertions(+), 36 deletions(-)

-- 
2.24.1

