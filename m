Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286BD31D1AB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 21:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhBPUjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 15:39:05 -0500
Received: from mail.codeweavers.com ([50.203.203.244]:46354 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhBPUjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 15:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7T+1dSDXmlJhVGwZ01TgYw2ktCZ2H9YMeHFP+6OeIMU=; b=iYkWw37o4443MbcaLfWv6Z2VMS
        BY4sQh78xgPFU0zfEyxkcHIpsx0EHrLI+KMh/nhqdjTTHaj0EE2Poh+CwwLsuuk6QfXM4mvUkE1kD
        gcOWg9FEsyi7h4Y2MWd811lI/YCoCdWY7WsX28Rty8n+EJZYUV4g0FmnsoHplg4+zX1c=;
Received: from [10.69.141.136]
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <nfraser@codeweavers.com>)
        id 1lC76y-0001sQ-3E; Tue, 16 Feb 2021 14:38:22 -0600
Subject: [PATCH 2/2] perf buildid-cache: Add test for 16-byte build-id
From:   Nicholas Fraser <nfraser@codeweavers.com>
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
References: <d1c87379-8837-a5e7-eb44-f063ca0f4766@codeweavers.com>
Message-ID: <c08be235-7434-5208-5f21-e8c9a3265464@codeweavers.com>
Date:   Tue, 16 Feb 2021 15:38:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <d1c87379-8837-a5e7-eb44-f063ca0f4766@codeweavers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -40.5
X-Spam-Report: Spam detection software, running on the system "mail.codeweavers.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  tests/shell/buildid.sh added an ELF executable with an MD5
    build-id to the perf debug cache but did not check whether the object was
    printed by a subsequent call to "perf buildid-cache -l". It was bei [...]
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

tests/shell/buildid.sh added an ELF executable with an MD5 build-id to
the perf debug cache but did not check whether the object was printed
by a subsequent call to "perf buildid-cache -l". It was being omitted
from the list.

A previous commit fixed the bug that left it out of the list. This adds
a test for it.
---
 tools/perf/tests/shell/buildid.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/buildid.sh b/tools/perf/tests/shell/buildid.sh
index 4861a20edee2..de02a23b7c7b 100755
--- a/tools/perf/tests/shell/buildid.sh
+++ b/tools/perf/tests/shell/buildid.sh
@@ -50,6 +50,12 @@ check()
 		exit 1
 	fi
 
+	${perf} buildid-cache -l|grep $id
+	if [ $? -ne 0 ]; then
+		echo "failed: ${id} is not reported by \"perf buildid-cache -l\""
+		exit 1
+	fi
+
 	echo "OK for ${1}"
 }
 
-- 
2.30.1


