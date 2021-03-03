Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B80732C15A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838539AbhCCTAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 14:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1580486AbhCCSeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 13:34:15 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6C8C061761
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 10:33:35 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id lr13so44140425ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 10:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LnOC0uNXUE44ciK8bmce/8ac0cOgTk35A1lz1/wb5qE=;
        b=gdw7UI+zewj3nObPzpoPiss8jEu67twJtLHiwjA4wUJLX/GBBq07jjBzbdt8CSycJ9
         K4KKVM4nx+GzXyzlqYw6t8MQynABCmQU51lybNZI/Pbw3GG1Oz+WpLuB6RWxBtfcOza7
         ebu0KVo+vc8P4ZdpDLZrL7veBg4849Cc98WASlBbfvkuSg77WLd8duztW58Qpvw2LOSa
         YGUGWWbWr+g/eJaaZgCfAf81PoQb27DALWd7l65GFlKN63yX8/CcOkgHiEQvMT88NwPr
         ykKaxZduItQSBQ/WOuwxn5cIUAy1ae2u9EsscU3OGfgFIYQnflA+5v0HXvh7axE9TDwi
         1XPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LnOC0uNXUE44ciK8bmce/8ac0cOgTk35A1lz1/wb5qE=;
        b=HHVLWUGRSvwuCL97/lRdeuRRWiw8+5U3/zGQFa8zYUBrFgVW/Z/TLQK9FpVydhKPMd
         mHdJwzGE9gs2h5cZ9UdbkqNDTJsWnZkRjGYE0IymIBHPpH1FS2bvbxDmBNvRN8phHobP
         tP4TYcCCMpf8Mo5/TnTkgwrc5myHgjhcC7KnzI8UVy6FiYgLl5bAVwi5iwY/zB/99lvP
         0S2swvDnjTOryYyp/f8ExjAz/3fPYCRuS7fz21p+M+BhTPZm/yoOk2iz366AG+MUdw5g
         YX3bByJd2e5m+B/aXJ+AJiPuG4CFxrzQSpMkvAz9nRkCh8Ms/6ini5Jzz5WyD4TuZ5Q1
         MX8g==
X-Gm-Message-State: AOAM5300uEPjF38McnY8KrucJGUoWEN7qxePk70SzQ3uDCoRThmbilbq
        J895oOIRdp9cJ6xI4MiICz0=
X-Google-Smtp-Source: ABdhPJzP3qyzdjg/SeT6+FHs9/3xFZp9/7bMChd92Zf7Pynh8Tm+3nEnto2nU44dFKryitTtwu11+Q==
X-Received: by 2002:a17:906:3685:: with SMTP id a5mr196771ejc.352.1614796413722;
        Wed, 03 Mar 2021 10:33:33 -0800 (PST)
Received: from localhost.localdomain (dynamic-046-114-034-198.46.114.pool.telefonica.de. [46.114.34.198])
        by smtp.googlemail.com with ESMTPSA id q12sm14951405ejd.51.2021.03.03.10.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 10:33:33 -0800 (PST)
From:   Gon Solo <gonsolo@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Gon Solo <gonsolo@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Perf: Clean beauty directory.
Date:   Wed,  3 Mar 2021 19:32:47 +0100
Message-Id: <20210303183247.217385-2-gonsolo@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303183247.217385-1-gonsolo@gmail.com>
References: <20210303183247.217385-1-gonsolo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 tools/perf/Makefile.perf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 5345ac70cd83..293e297f719d 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1087,6 +1087,7 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)$(sync_file_range_arrays)
 	$(call QUIET_CLEAN, Documentation) \
 	$(MAKE) -C $(DOC_DIR) O=$(OUTPUT) clean >/dev/null
+	$(call QUIET_CLEAN, beauty) $(RM) -r $(beauty_outdir)
 
 #
 # To provide FEATURE-DUMP into $(FEATURE_DUMP_COPY)
-- 
2.27.0

