Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056384339D2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbhJSPKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:10:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234185AbhJSPKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:10:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C228D6137D;
        Tue, 19 Oct 2021 15:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634656092;
        bh=6Ey2yQL8vp45TglKXfKMfCMTfAI/Z6m/vrgKMF/aoKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T+72k1Ul51sB0eB7OvCjH62yRwI7JwQOcFn7OOmzX5ZWoB2MopwQs/sX9NGzFP89y
         8ScpcD5g+OrE65AoETrkyNxxBHiyKEfNUy1YcoyqueDauFvifpX7WcseNUUEn1n8XY
         9oktHlGLzx36XySWvNB7bOmvQ9ROQc2jpEhxs8ekXwCUFTdVSCOufPuhmZNQOy/umf
         4OE04ETjPMj42H9EvKq8XA8wUYAaKqVLFDwO6Xi2jRge/BPeqQlIJXPfmY9U+1TOp1
         S5mdPgrKtriiKfuomsRUPlN0GGagVvpWu0GOUGbW80dJ7RQRqp3Sd5R7KSnJR9bGun
         YBa3Z4PtGIx2A==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/15] selftests/damon: Support watermarks
Date:   Tue, 19 Oct 2021 15:07:29 +0000
Message-Id: <20211019150731.16699-14-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211019150731.16699-1-sj@kernel.org>
References: <20211019150731.16699-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit updates DAMON selftests for 'schemes' debugfs file to
reflect the changes in the format.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/debugfs_attrs.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh b/tools/testing/selftests/damon/debugfs_attrs.sh
index 466dbeb37e31..196b6640bf37 100755
--- a/tools/testing/selftests/damon/debugfs_attrs.sh
+++ b/tools/testing/selftests/damon/debugfs_attrs.sh
@@ -63,10 +63,10 @@ echo "$orig_content" > "$file"
 file="$DBGFS/schemes"
 orig_content=$(cat "$file")
 
-test_write_succ "$file" "1 2 3 4 5 6 4 0 0 0 1 2 3" \
+test_write_succ "$file" "1 2 3 4 5 6 4 0 0 0 1 2 3 1 100 3 2 1" \
 	"$orig_content" "valid input"
 test_write_fail "$file" "1 2
-3 4 5 6 3 0 0 0 1 2 3" "$orig_content" "multi lines"
+3 4 5 6 3 0 0 0 1 2 3 1 100 3 2 1" "$orig_content" "multi lines"
 test_write_succ "$file" "" "$orig_content" "disabling"
 echo "$orig_content" > "$file"
 
-- 
2.17.1

