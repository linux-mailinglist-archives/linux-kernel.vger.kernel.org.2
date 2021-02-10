Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1476E317066
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 20:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbhBJTks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 14:40:48 -0500
Received: from mail.codeweavers.com ([50.203.203.244]:43488 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbhBJTig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 14:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+bOcUVdVAYOtCyJmcqy1iXDTZLAVVc9IGZhWeNXsHaU=; b=NS55oHFQMMQLxLnCkgk5zv0jwo
        6mCkZsxpiH6ZDGTPwbFHQfuVI5cH6Q8UMBS6PkSrb6lejmeCx02mSMVnOkFAEXSvU34zqEQ6vvokJ
        1xST8bswUETWvZeFKiHFkvMyuLE3BQzSN/QwcFGX9kGidSgpr8hDPJ7OLOuYMKszj0Co=;
Received: from [10.69.141.136]
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <nfraser@codeweavers.com>)
        id 1l9uzc-0005bL-RV; Wed, 10 Feb 2021 13:17:43 -0600
From:   Nicholas Fraser <nfraser@codeweavers.com>
Subject: [PATCH 2/4] perf report: Load PE files from debug cache only
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
Message-ID: <e58e1237-94ab-e1c9-a7b9-473531906954@codeweavers.com>
Date:   Wed, 10 Feb 2021 14:17:38 -0500
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
 Content preview:  dso__load_bfd_symbols() attempts to load a DSO at its original
    path, then closes it and loads the file in the debug cache. This is incorrect.
    It should ignore the original file and work with only the [...] 
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

dso__load_bfd_symbols() attempts to load a DSO at its original path,
then closes it and loads the file in the debug cache. This is incorrect.
It should ignore the original file and work with only the debug cache.
The original file may have changed or may not even exist, for example if
the debug cache has been transferred to another machine via "perf
archive".

This fix makes it only load the file in the debug cache.

Signed-off-by: Nicholas Fraser <nfraser@codeweavers.com>
---
 tools/perf/util/symbol.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 64a039cbba1b..aa9ae875b995 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1569,7 +1569,7 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
 	u_int i;
 	u64 start, len;
 
-	abfd = bfd_openr(dso->long_name, NULL);
+	abfd = bfd_openr(debugfile, NULL);
 	if (!abfd)
 		return -1;
 
@@ -1586,12 +1586,6 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
 	if (section)
 		dso->text_offset = section->vma - section->filepos;
 
-	bfd_close(abfd);
-
-	abfd = bfd_openr(debugfile, NULL);
-	if (!abfd)
-		return -1;
-
 	if (!bfd_check_format(abfd, bfd_object)) {
 		pr_debug2("%s: cannot read %s bfd file.\n", __func__,
 			  debugfile);
-- 
2.30.0

