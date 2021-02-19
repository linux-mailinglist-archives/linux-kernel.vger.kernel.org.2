Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDF831FCD7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 17:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBSQKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 11:10:36 -0500
Received: from mail.codeweavers.com ([50.203.203.244]:37606 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhBSQKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 11:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jT5f4TpoKfVTfDMBAhV54XTxsbl0u6l9viXqS/JqH9s=; b=k3PPX17zXtUx2v6qvyZSoouE4m
        7YunB+IJX5R9tJwFju9QBP0gxser4+++Z7WA/s0Cm0TgQXXaO5YGItKmrGIATz2VNkKdmw8OHid6D
        14e/0gCqfPThf64QpgJJdLI4JSXGTefO44/zuD1fj8RpBXeuIuHRLUDD1WP9NFlK8rbk=;
Received: from [10.69.141.136]
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <nfraser@codeweavers.com>)
        id 1lD8Lk-0003In-ER; Fri, 19 Feb 2021 10:09:48 -0600
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Cc:     Ulrich Czekalla <uczekalla@codeweavers.com>,
        Huw Davies <huw@codeweavers.com>
From:   Nicholas Fraser <nfraser@codeweavers.com>
Subject: [PATCH 1/2] perf archive: Fix filtering of empty build-ids
Message-ID: <442bffc7-ac5c-0975-b876-a549efce2413@codeweavers.com>
Date:   Fri, 19 Feb 2021 11:09:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A non-existent build-id used to be treated as all-zero SHA-1 hash.
Build-ids are now variable width. A non-existent build-id is an empty
string and "perf buildid-list" pads this with spaces. This is true even
when using old perf.data files recorded from older versions of perf;
"perf buildid-list" never reports an all-zero hash anymore.

This fixes "perf-archive" to skip missing build-ids by skipping lines
that start with a padding space rather than with zeroes.

Signed-off-by: Nicholas Fraser <nfraser@codeweavers.com>
---
 tools/perf/perf-archive.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/perf-archive.sh b/tools/perf/perf-archive.sh
index 0cfb3e2cefef..133f0eddbcc4 100644
--- a/tools/perf/perf-archive.sh
+++ b/tools/perf/perf-archive.sh
@@ -20,9 +20,8 @@ else
 fi
 
 BUILDIDS=$(mktemp /tmp/perf-archive-buildids.XXXXXX)
-NOBUILDID=0000000000000000000000000000000000000000
 
-perf buildid-list -i $PERF_DATA --with-hits | grep -v "^$NOBUILDID " > $BUILDIDS
+perf buildid-list -i $PERF_DATA --with-hits | grep -v "^ " > $BUILDIDS
 if [ ! -s $BUILDIDS ] ; then
 	echo "perf archive: no build-ids found"
 	rm $BUILDIDS || true
-- 
2.30.1

