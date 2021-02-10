Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA4C317063
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 20:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbhBJTkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 14:40:17 -0500
Received: from mail.codeweavers.com ([50.203.203.244]:43472 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbhBJTh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 14:37:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QsgV11qHT3WVZHQoQro7bmE2Olb5ShsdL1WdJYeNLow=; b=iGa6rr42ezWXgxAyUOlsHYnpgI
        ghNn4tFFEngN8PIQQMftim+aq812cX3m4aDXZiWTqOxH83ny8/V6gqfsEsrbg7JialKpPG2U0eB69
        DeK+XnNVDh0uSxgPVoyGWJQR4FXVK6RTfl9sBqxZc+m04/HMsw8fcfHIXPEepyk8ev2M=;
Received: from [10.69.141.136]
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <nfraser@codeweavers.com>)
        id 1l9v01-0005eA-8k; Wed, 10 Feb 2021 13:18:07 -0600
From:   Nicholas Fraser <nfraser@codeweavers.com>
Subject: [PATCH 4/4] perf report: Fix return value when loading PE DSO
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
Message-ID: <1671b43b-09c3-1911-dbf8-7f030242fbf7@codeweavers.com>
Date:   Wed, 10 Feb 2021 14:18:02 -0500
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
 Content preview:  The first time dso__load() was called on a PE file it always
    returned -1 error. This caused the first call to map__find_symbol() to always
    fail on a PE file so the first sample from each PE file alway [...] 
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

The first time dso__load() was called on a PE file it always returned -1
error. This caused the first call to map__find_symbol() to always fail
on a PE file so the first sample from each PE file always had symbol
<unknown>. Subsequent samples succeed however because the DSO is already
loaded.

This fixes dso__load() to return 0 when successfully loading a DSO with
libbfd.

Signed-off-by: Nicholas Fraser <nfraser@codeweavers.com>
---
 tools/perf/util/symbol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index aa9ae875b995..492c873713cc 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1861,8 +1861,10 @@ int dso__load(struct dso *dso, struct map *map)
 		if (nsexit)
 			nsinfo__mountns_enter(dso->nsinfo, &nsc);
 
-		if (bfdrc == 0)
+		if (bfdrc == 0) {
+			ret = 0;
 			break;
+		}
 
 		if (!is_reg || sirc < 0)
 			continue;
-- 
2.30.0

