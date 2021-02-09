Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C029D315213
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbhBIOwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhBIOwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:52:35 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E58C061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 06:51:55 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id y10so9872995plk.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 06:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZWWHpXAtueOvtEp4dRO+F3IyhokP+W7CqDb15pWkQNc=;
        b=aNtOWabB4DnuOXSIK7ijlLDJdeei5KRilQjEWKD4hUJSZJZ6bxPAO1PSdAtUQOSctF
         kcIqDK++spBVJLP14WckDPLcqrKMj9WcUIrt2VxOZVJkl8WM0PxoPRDkmKteeCEQIgd4
         hpVriIncRe1iKLFLfuMQPNBBpCKrUlVTr2+qo+qOTU2BIXclfilM6fCc9GYlYiTne2Nq
         o9Ovg+GvDoeAXUvS+oqCAgIqvp4gOhp/7GlicSDbTqvCqKc0DYTlWVXZYx4vR9TGeZ/e
         JHuG8G0kRuJysn0tkIGiszthXGLqXNaJKPD1k7i9L4v6j9//IQHpbhagl6vIEvZP8Mu+
         619Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZWWHpXAtueOvtEp4dRO+F3IyhokP+W7CqDb15pWkQNc=;
        b=VWPDgcFnl9wJUQR5wMQ409KqRi5ES4FYY6C0DuWGmuCb7T2HVcgnkTqDscFbKq2dYA
         SPWDDFl+DF050734FgVU2drWQLo+7ancfBoWGy36a8qjWe7cjuf2l8+j/DJw35hJS2b3
         UGZoFxvjFCQjswpXN/SFZkfiao2EZOQ6aKUmwOovNyRviu1pbRj08z9HuQPHXPZjjUav
         dktsUUfGhLazKsyv05nbvR0u5axFZc4Ls8LikR+PzH3WLJfJGMOLhnXDyD5L+EwXMmbs
         oVFCZF0KUEnazxR7M07a1nWQIyLEVQWMN/cqPLxWkEogC0T6y/Y0v5UYUKMjYOavhJBy
         0xpQ==
X-Gm-Message-State: AOAM533lKHCxfu1fhcdNSdBR+qIQiHzh8NKAbOUcVll0Rw1rMaxo6W+8
        nSc+P1SuP3li7W0GoAy1mcBNR9tKQVvWSyEV
X-Google-Smtp-Source: ABdhPJzzclLhQAXPu6XkWejwMYBmpc3dDCtRSO5ZpwOZdaxi3nX15lpdiXSkxoOBPxVBL4WGAjMv7Q==
X-Received: by 2002:a17:90a:dc0d:: with SMTP id i13mr4448971pjv.145.1612882314279;
        Tue, 09 Feb 2021 06:51:54 -0800 (PST)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id gx22sm2840747pjb.49.2021.02.09.06.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 06:51:53 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jacek Caban <jacek@codeweavers.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Remi Bernon <rbernon@codeweavers.com>
Subject: [PATCH] perf: Use (long) for iterator for bfd symbols
Date:   Tue,  9 Feb 2021 14:51:48 +0000
Message-Id: <20210209145148.178702-1-dima@arista.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC (GCC) 8.4.0 20200304 fails to build perf with:
: util/symbol.c: In function 'dso__load_bfd_symbols':
: util/symbol.c:1626:16: error: comparison of integer expressions of different signednes
:   for (i = 0; i < symbols_count; ++i) {
:                 ^
: util/symbol.c:1632:16: error: comparison of integer expressions of different signednes
:    while (i + 1 < symbols_count &&
:                 ^
: util/symbol.c:1637:13: error: comparison of integer expressions of different signednes
:    if (i + 1 < symbols_count &&
:              ^
: cc1: all warnings being treated as errors

It's unlikely that the symtable will be that big, but the fix is
oneliner and as perf has CORE_CFLAGS += -Wextra, which makes build to
fail together with CORE_CFLAGS += -Werror

Fixes: eac9a4342e54 ("perf symbols: Try reading the symbol table with libbfd")
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jacek Caban <jacek@codeweavers.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Remi Bernon <rbernon@codeweavers.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/perf/util/symbol.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 64a039cbba1b..1645fb4ec9ed 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1561,12 +1561,11 @@ static int bfd2elf_binding(asymbol *symbol)
 int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
 {
 	int err = -1;
-	long symbols_size, symbols_count;
+	long symbols_size, symbols_count, i;
 	asection *section;
 	asymbol **symbols, *sym;
 	struct symbol *symbol;
 	bfd *abfd;
-	u_int i;
 	u64 start, len;
 
 	abfd = bfd_openr(dso->long_name, NULL);
-- 
2.30.0

