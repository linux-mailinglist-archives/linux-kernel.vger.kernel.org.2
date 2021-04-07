Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9047D357092
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353669AbhDGPkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242738AbhDGPkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:40:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEDCC061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 08:40:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k15so17917979ybh.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 08:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=gEHEWQ307bRJvhPwioM0OYPFn1eYNcCod2kJGL7jIh4=;
        b=QKNDF7sIGKV3rdjakWbl5h7kEjkYWU5tJ98mGMmUVHVXReB9h+utfWRyjHjDqvt+gD
         9+9Tt0rSr5eQtRl/Wj5DpqRtMsfgMKRTuxcoxNedLdnZTwCKay3LeyIyiYggkn3yOtYF
         G+x6w7ybekbBbg7ybXs6ZoVaz4rMQUdOuLSegV2u2ux7ekdwmezbx/Dx2d/egB1fzcOk
         ssQP3/zueT394Mj1fqRGgjqjWF7o7g3JGIyW4U/7ttK6gmUP4Ru2kRK4H/gCz9lGSJWi
         Cc2cIhUIuvY0Kbm/wIGztl3M3Z53k6FtVZTbp36JdcEMcREbHhfI7vWkRGHX7IELQM0q
         22hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=gEHEWQ307bRJvhPwioM0OYPFn1eYNcCod2kJGL7jIh4=;
        b=IAUmBPSiS0T+xZ2n3ammpM8Ct7jeQPMjj1qYtT75+wKNYhFdUUNJIP+YX9Xg4/r85w
         fFVVf8LF26y8chbNHNdKsipp5QPy9P5PT76/JVYLVCbbELYCIWUSwAyQGzeq/uneqLDv
         n/v175DelzxPLoO7LPVG8kHH9JQvx73biSoRw6c4XLu4PQ3wHXMSGvJty9Fu45nCf6ea
         GFa83BpMGBU5Qc9t+CQhSfgAPCvCJVELMk4+8yoORt0gkmi+F8HAXnlZwigpv6NIzeau
         HeGQXBRlKyEMZA9TSeJwbntcLwvoUx74Ek6DMtVFY7hKdu836iWJFFzEXKk+2GFkVfJf
         qHfQ==
X-Gm-Message-State: AOAM533H5yhJuElHthhMjNXmQ09K4wsGDTRcCXgOdb+Bp0F4ivMXbRHS
        vL7E65LcnCRC0dTaKtYO1qnPqUvAsR/q
X-Google-Smtp-Source: ABdhPJxyF5c2jLs2PsYpDx2eaHlCYtXPlQZONix8B8AIRhg8zffqL2bGb0ZxCromPx+xtMQFhtpthD6DBngQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6d13:3d93:6552:2550])
 (user=irogers job=sendgmr) by 2002:a25:4906:: with SMTP id
 w6mr5252446yba.324.1617810009143; Wed, 07 Apr 2021 08:40:09 -0700 (PDT)
Date:   Wed,  7 Apr 2021 08:39:55 -0700
Message-Id: <20210407153955.317215-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH] perf arm-spe: Avoid potential buffer overrun.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPE extended headers are >1 byte so ensure the buffer contains at
least this before reading. This issue was detected by fuzzing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index f3ac9d40cebf..2e5eff4f8f03 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -210,8 +210,10 @@ static int arm_spe_do_get_packet(const unsigned char *buf, size_t len,
 
 	if ((hdr & SPE_HEADER0_MASK2) == SPE_HEADER0_EXTENDED) {
 		/* 16-bit extended format header */
-		ext_hdr = 1;
+		if (len == 1)
+			return ARM_SPE_BAD_PACKET;
 
+		ext_hdr = 1;
 		hdr = buf[1];
 		if (hdr == SPE_HEADER1_ALIGNMENT)
 			return arm_spe_get_alignment(buf, len, packet);
-- 
2.31.0.208.g409f899ff0-goog

