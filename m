Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461D544AF5F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 15:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbhKIOZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 09:25:02 -0500
Received: from foss.arm.com ([217.140.110.172]:34354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237193AbhKIOY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 09:24:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4F922B;
        Tue,  9 Nov 2021 06:22:09 -0800 (PST)
Received: from ip-10-252-15-108.eu-west-1.compute.internal (unknown [10.252.15.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6AFCD3F800;
        Tue,  9 Nov 2021 06:22:07 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     German Gomez <german.gomez@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: [PATCH v2 0/2] arm-spe/cs-etm: Print size using consistent format
Date:   Tue,  9 Nov 2021 14:21:51 +0000
Message-Id: <20211109142153.56546-1-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sent as a splitted re-roll of patchset [1] to keep the patches more
semantically grouped. The patches themselves have been tested and
reviewed in the previous submission already.

Changes since v1:
  - Sent as a separate patchset.
  - Added acme to the recipients list as I forgot to include him in [1].

[1] https://lore.kernel.org/all/20210916154635.1525-1-german.gomez@arm.com/

Andrew Kilroy (2):
  perf cs-etm: Print size using consistent format
  perf arm-spe: Print size using consistent format

 tools/perf/util/arm-spe.c | 2 +-
 tools/perf/util/cs-etm.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.25.1

