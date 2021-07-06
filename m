Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E048F3BDDB2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 21:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhGFTDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 15:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhGFTDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 15:03:12 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF0BC061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 12:00:33 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id b2so422903oiy.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 12:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MYqXeCbxfuybGK62bv3hAjB3EwNsrsPCCNHRlyOcG8Q=;
        b=SZDOnd82dh3+2n0fe48q5ZarUx6lX6BybOllKe1C3ezf752oddc2y8MINhFxAt3mIz
         qf6lyXwFzTHDe/G6j3FnMtjEeRoG2k+4weigV0vGziiwFm86Wc1YCzC9J4chsa1HUBYu
         CTDlWF1xKDjkcHKq3gPXddE0tCz2RKSWLxf4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=MYqXeCbxfuybGK62bv3hAjB3EwNsrsPCCNHRlyOcG8Q=;
        b=Ullk55nv3wgERgV3GVos9zQ2p8RlX468o/e4wY5RW8od+nzDePSbM88IbK/yKhTdG4
         vk3qgDA6M6jzWWME4HGSWe5SlCrkNIK1FEbgk+pLc7qA5YDHC7TC7e1wwYYBTCP3fo4z
         45miRXWl6BBOtMybuu/v3f0YjxXcv3fMkKKRoXj6xleeUMY4ngXS2fEyOMmRCwcWLk+i
         jDjdnHpUN9EfRgKIkoKcYcueii31BgP69Y+k/7xy8/s5tkUKrT4/VhYdAtZE3bNBTaMO
         OciK0Df8CGvcfBL5YCi1JOeq13bMIOi/1+AfaCliUQ+DucX1UlAr6fMWaWTZbxRhDJio
         ZKCg==
X-Gm-Message-State: AOAM530ksW+D1kDzlOv2rgSoOD98LS8VxPuZMKGU4TNwEffIGAM8dPgR
        8LoTrdBd0C5IQaIPP1X4OVnDNA==
X-Google-Smtp-Source: ABdhPJwNSVBif6ncE0Xa4cvgNggvIOjnq3TNMxm/WAFC8jYHux3tTbOntJHGKfqlEknZOlPLy3FpFw==
X-Received: by 2002:aca:c74a:: with SMTP id x71mr1553537oif.35.1625598032637;
        Tue, 06 Jul 2021 12:00:32 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id q26sm3470186oiw.25.2021.07.06.12.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 12:00:32 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
From:   "Justin M. Forbes" <jforbes@fedoraproject.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jforbes@fedoraproject.org, jmforbes@linuxtx.org
Subject: [PATCH] Fix the perf trace link location
Date:   Tue,  6 Jul 2021 13:59:51 -0500
Message-Id: <20210706185952.116121-1-jforbes@fedoraproject.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The install perf_dlfilter.h patch included what seems to be
a typo in the Makefile.perf, which changed the location of the trace
link from '$(DESTDIR_SQ)$(bindir_SQ)/trace' to
'$(DESTDIR_SQ)$(dir_SQ)/trace' This reverts it back to the correct
location.

Fixes: 0beb218315e06 ("perf build: Install perf_dlfilter.h")
Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index c9e0de5b00c1..a1b9be78a1e0 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -923,7 +923,7 @@ install-tools: all install-gtk
 	$(call QUIET_INSTALL, binaries) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'; \
 		$(INSTALL) $(OUTPUT)perf '$(DESTDIR_SQ)$(bindir_SQ)'; \
-		$(LN) '$(DESTDIR_SQ)$(bindir_SQ)/perf' '$(DESTDIR_SQ)$(dir_SQ)/trace'; \
+		$(LN) '$(DESTDIR_SQ)$(bindir_SQ)/perf' '$(DESTDIR_SQ)$(bindir_SQ)/trace'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(includedir_SQ)/perf'; \
 		$(INSTALL) util/perf_dlfilter.h -t '$(DESTDIR_SQ)$(includedir_SQ)/perf'
 ifndef NO_PERF_READ_VDSO32
-- 
2.31.1

