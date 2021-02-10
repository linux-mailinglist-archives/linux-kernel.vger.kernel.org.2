Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B7F31705F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 20:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhBJTjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 14:39:07 -0500
Received: from mail.codeweavers.com ([50.203.203.244]:43430 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbhBJThA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 14:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=I81yJZtEPT1n9yj0/hKZqLTI85QuMnBB8Jdw7b8uljw=; b=NVwJTR6HmMDqgYXR0ukwIunyYk
        /z1Ss52FiH+TGqa/eeh5LkXZAPYSwa5hRm0K4R18kEdEekyEPyts2A+XwBgYqwE4T+t/MjRcAsdYR
        RP/M4TAbKadU1h8tpu/wBz83iSxTZO/zpJJgPT7xwwFcuig/FULN+YkxIscF9VXLLbKU=;
Received: from [10.69.141.136]
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <nfraser@codeweavers.com>)
        id 1l9uzQ-0005Zj-Ll; Wed, 10 Feb 2021 13:17:30 -0600
From:   Nicholas Fraser <nfraser@codeweavers.com>
Subject: [PATCH 1/4] perf buildid-cache: Don't skip 16-byte build-ids
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
Message-ID: <597788e4-661d-633f-857c-3de700115d02@codeweavers.com>
Date:   Wed, 10 Feb 2021 14:17:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -40.6
X-Spam-Report: Spam detection software, running on the system "mail.codeweavers.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  lsdir_bid_tail_filter() ignored any build-id that wasn't exactly
    20 bytes. This worked only for SHA-1 build-ids. The build-id for a PE file
    is always a 16-byte GUID and ELF files can also have MD5 or [...] 
 Content analysis details:   (-40.6 points, 5.0 required)
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

lsdir_bid_tail_filter() ignored any build-id that wasn't exactly 20
bytes. This worked only for SHA-1 build-ids. The build-id for a PE file
is always a 16-byte GUID and ELF files can also have MD5 or UUID
build-ids.

This fix changes the filter to allow build-ids between 16 and 20 bytes.

Signed-off-by: Nicholas Fraser <nfraser@codeweavers.com>
---
 tools/perf/util/build-id.c | 5 +++--
 tools/perf/util/build-id.h | 4 +++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 02df36b30ac5..e32e8f2ff3bd 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -448,7 +448,8 @@ static bool lsdir_bid_tail_filter(const char *name __maybe_unused,
 	int i = 0;
 	while (isxdigit(d->d_name[i]) && i < SBUILD_ID_SIZE - 3)
 		i++;
-	return (i == SBUILD_ID_SIZE - 3) && (d->d_name[i] == '\0');
+	return (i >= SBUILD_ID_MIN_SIZE - 3) && (i <= SBUILD_ID_SIZE - 3) &&
+		(d->d_name[i] == '\0');
 }
 
 struct strlist *build_id_cache__list_all(bool validonly)
@@ -490,7 +491,7 @@ struct strlist *build_id_cache__list_all(bool validonly)
 		}
 		strlist__for_each_entry(nd2, linklist) {
 			if (snprintf(sbuild_id, SBUILD_ID_SIZE, "%s%s",
-				     nd->s, nd2->s) != SBUILD_ID_SIZE - 1)
+				     nd->s, nd2->s) > SBUILD_ID_SIZE - 1)
 				goto err_out;
 			if (validonly && !build_id_cache__valid_id(sbuild_id))
 				continue;
diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
index 02613f4b2c29..c19617151670 100644
--- a/tools/perf/util/build-id.h
+++ b/tools/perf/util/build-id.h
@@ -2,8 +2,10 @@
 #ifndef PERF_BUILD_ID_H_
 #define PERF_BUILD_ID_H_ 1
 
-#define BUILD_ID_SIZE	20
+#define BUILD_ID_SIZE	20 /* SHA-1 length in bytes */
+#define BUILD_ID_MIN_SIZE	16 /* MD5/UUID/GUID length in bytes */
 #define SBUILD_ID_SIZE	(BUILD_ID_SIZE * 2 + 1)
+#define SBUILD_ID_MIN_SIZE	(BUILD_ID_MIN_SIZE * 2 + 1)
 
 #include "machine.h"
 #include "tool.h"
-- 
2.30.0

