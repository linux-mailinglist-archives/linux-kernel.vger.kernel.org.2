Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1601E3E1541
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 15:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241588AbhHENEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 09:04:25 -0400
Received: from foss.arm.com ([217.140.110.172]:45114 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241580AbhHENEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 09:04:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3090E1042;
        Thu,  5 Aug 2021 06:04:09 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.40.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B83563F719;
        Thu,  5 Aug 2021 06:04:06 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, mathieu.poirier@linaro.org, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-perf-users@vger.kernel.org
Cc:     suzuki.poulose@arm.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] perf tools: Warning fixes
Date:   Thu,  5 Aug 2021 14:03:53 +0100
Message-Id: <20210805130354.878120-1-james.clark@arm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
   Add Leo's reviewed by tag that I missed
   
James Clark (1):
  perf cs-etm: Add warnings for missing DSOs

 tools/perf/util/cs-etm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

-- 
2.23.0

