Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8DF317054
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 20:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbhBJTh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 14:37:57 -0500
Received: from mail.codeweavers.com ([50.203.203.244]:43302 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbhBJTfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 14:35:53 -0500
X-Greylist: delayed 1052 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Feb 2021 14:35:52 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=phH8kE+wZBsFBWPgB0qEMRbDfOM0sUU704BhMyO7+Xk=; b=lU9YPHuvG7PB6fbwU3Ioi7Tqjz
        i56W/Z0w2qAEsDPoclsSG56IS8it+SjtfYQWYAErPgZty0f60w79OVqHkTb+RQGBGz+8hP99zdaFn
        S0+TnI9Co/Br7uogpy13DpxBwE0ZLwp+d2nSM0F5ug2wWIwEF/LjCZ0fBrIeydutl1Lc=;
Received: from [10.69.141.136]
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <nfraser@codeweavers.com>)
        id 1l9uzo-0005ck-DS; Wed, 10 Feb 2021 13:17:54 -0600
From:   Nicholas Fraser <nfraser@codeweavers.com>
Subject: [PATCH 3/4] perf archive: Fix filtering of empty build-ids
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org
Cc:     Ulrich Czekalla <uczekalla@codeweavers.com>,
        Huw Davies <huw@codeweavers.com>
Message-ID: <7708cca1-b8f6-c394-75f1-5f9681d625d0@codeweavers.com>
Date:   Wed, 10 Feb 2021 14:17:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -40.5
X-Spam-Report: Spam detection software, running on the system "mail.codeweavers.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  A non-existent build-id used to be treated as all-zero SHA-1
    hash. Build-ids are now variable width. A non-existent build-id is an empty
    string and "perf buildid-list" pads this with spaces. This fixes "perf-archive"
    to skip missing build-ids by skipping lines that start with a padding space
    rather than with zeroes. 
 Content analysis details:   (-40.5 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 USER_IN_WELCOMELIST    user is listed in 'welcomelist_from'
  -20 USER_IN_WHITELIST      DEPRECATED: See USER_IN_WELCOMELIST
  -20 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -0.5 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
 -0.0 AWL                    AWL: Adjusted score from AWL reputation of From: address
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A non-existent build-id used to be treated as all-zero SHA-1 hash.
Build-ids are now variable width. A non-existent build-id is an empty
string and "perf buildid-list" pads this with spaces.

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
2.30.0

