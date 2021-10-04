Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B0C42130D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 17:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235980AbhJDPwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 11:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbhJDPw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 11:52:29 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E6BC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 08:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=mcPsMWFUXThCmrbwjJ6iqZMj928t2CHXjl9mKy5UmgM=; b=SL
        yROnRVrv2VvaKzY55jDSB1kAOjyMd698pXfqruEnyuQYqFBBeUB8zjL6C+Ljn3T+ApHxY5j6y9feG
        j5j1rQHuzxCSLfk875ijHovPNEKQ8aHH31zkQEJwr9ei6ryMNBYMsLuCwbtU8L7YfyQ1K4b+uPUos
        1pOxZszBSP1VVhtPxHTbgIk5dyD+nRAfLEeJIgykUHJH1m8QgvrcTxrCFe0ALiH+iyfUeOVPnpZQW
        pQaW6341iZIvtIxr/AS97S61/zz9FzyUcNh2MAFMJBgVvjkz7yC6HJXFtxnnPAfw8p4ntzBotZZ4U
        5AikMf2FudnTPFLFw59RtafUhBif3uNg==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mXQEU-0008Us-FQ; Mon, 04 Oct 2021 16:50:26 +0100
From:   John Keeping <john@metanate.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     John Keeping <john@metanate.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tools/build: drop slang include path in test-all
Date:   Mon,  4 Oct 2021 16:50:19 +0100
Message-Id: <20211004155020.1287199-1-john@metanate.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cbefd24f0aee3 ("tools build: Add test to check if slang.h is in
/usr/include/slang/") added a proper test to check whether slang.h is in
a subdirectory, and commit 1955c8cf5e26b ("perf tools: Don't hardcode
host include path for libslang") removed the include path for
test-libslang.bin but missed test-all.bin.  Apply the same change to
test-all.bin.

Fixes: 1955c8cf5e26 ("perf tools: Don't hardcode host include path for libslang")
Signed-off-by: John Keeping <john@metanate.com>
---
 tools/build/feature/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index d024b5204ba0..71390309f4d7 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -91,7 +91,7 @@ __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(
 ###############################
 
 $(OUTPUT)test-all.bin:
-	$(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -I/usr/include/slang -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma -lzstd -lcap
+	$(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma -lzstd -lcap
 
 $(OUTPUT)test-hello.bin:
 	$(BUILD)
-- 
2.33.0

