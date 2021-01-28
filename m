Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93E2307587
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 13:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhA1MG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 07:06:26 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11459 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbhA1MFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 07:05:24 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DRJz10YK2zjCtw;
        Thu, 28 Jan 2021 20:03:41 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Thu, 28 Jan 2021 20:04:34 +0800
From:   John Garry <john.garry@huawei.com>
To:     <will@kernel.org>, <mathieu.poirier@linaro.org>,
        <leo.yan@linaro.org>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <jolsa@redhat.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <james.clark@arm.com>,
        <linuxarm@openeuler.org>, <nakamura.shun@fujitsu.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 0/4] perf vendor events arm64: Some tidy-up/refactoring
Date:   Thu, 28 Jan 2021 20:00:32 +0800
Message-ID: <1611835236-34696-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is much event duplication in the common and uarch events for A76
and Ampere eMag support, so factor out into a common JSON.

Since the wording for events may differ between CPU datasheet and
the architecture reference manual, the current wording is kept. This
is unless there are minor differences. In addition, event names are
renamed to be same as architecture reference manual, to keep commonality.

Also a minor fix is included for the Ampere eMag JSON.

Differences to v1:
- tidy some ',' misplaced

John Garry (4):
  perf vendor events arm64: Fix Ampere eMag event typo
  perf vendor events arm64: Add common and uarch event JSON
  perf vendor events arm64: Reference common and uarch events for Ampere
    eMag
  perf vendor events arm64: Reference common and uarch events for A76

 .../arch/arm64/ampere/emag/branch.json        |   8 +-
 .../arch/arm64/ampere/emag/bus.json           |   5 +-
 .../arch/arm64/ampere/emag/cache.json         |  58 +---
 .../arch/arm64/ampere/emag/clock.json         |   4 +-
 .../arch/arm64/ampere/emag/exception.json     |  10 +-
 .../arch/arm64/ampere/emag/instruction.json   |  34 +--
 .../arch/arm64/ampere/emag/memory.json        |  11 +-
 .../arch/arm64/arm/cortex-a76-n1/branch.json  |  12 +-
 .../arch/arm64/arm/cortex-a76-n1/bus.json     |  19 +-
 .../arch/arm64/arm/cortex-a76-n1/cache.json   | 118 +++------
 .../arm64/arm/cortex-a76-n1/exception.json    |  10 +-
 .../arm64/arm/cortex-a76-n1/instruction.json  |  45 +---
 .../arch/arm64/arm/cortex-a76-n1/memory.json  |   6 +-
 .../arch/arm64/arm/cortex-a76-n1/other.json   |   4 +-
 .../arm64/arm/cortex-a76-n1/pipeline.json     |  12 +-
 .../arm64/armv8-common-and-microarch.json     | 248 ++++++++++++++++++
 16 files changed, 356 insertions(+), 248 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json

-- 
2.26.2

