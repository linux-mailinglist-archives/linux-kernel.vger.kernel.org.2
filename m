Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A787B4133CC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhIUNLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 09:11:52 -0400
Received: from foss.arm.com ([217.140.110.172]:33390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232947AbhIUNLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:11:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B0FC106F;
        Tue, 21 Sep 2021 06:10:23 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.50.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B8B643F59C;
        Tue, 21 Sep 2021 06:10:20 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, leo.yan@linaro.com,
        linux-perf-users@vger.kernel.org
Cc:     James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] perf tests: Fix record+script_probe_vfs_getname.sh /tmp cleanup
Date:   Tue, 21 Sep 2021 14:10:07 +0100
Message-Id: <20210921131009.390810-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The temp files are only cleaned up if the test is not skipped, so delay
making them until after the skip so they don't get left behind in /tmp.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/shell/record+script_probe_vfs_getname.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
index bf9e729b3ecf..8d9c04e450ae 100755
--- a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
@@ -15,9 +15,6 @@ skip_if_no_perf_probe || exit 2
 
 . $(dirname $0)/lib/probe_vfs_getname.sh
 
-perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
-file=$(mktemp /tmp/temporary_file.XXXXX)
-
 record_open_file() {
 	echo "Recording open file:"
 	perf record -o ${perfdata} -e probe:vfs_getname\* touch $file
@@ -35,6 +32,9 @@ if [ $err -ne 0 ] ; then
 	exit $err
 fi
 
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+file=$(mktemp /tmp/temporary_file.XXXXX)
+
 record_open_file && perf_script_filenames
 err=$?
 rm -f ${perfdata}
-- 
2.28.0

