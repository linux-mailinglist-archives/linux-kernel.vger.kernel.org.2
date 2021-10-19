Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BD14339CB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbhJSPKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:10:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233940AbhJSPKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:10:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5DB36138D;
        Tue, 19 Oct 2021 15:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634656087;
        bh=9wR2yQTF4duC2O5BurjkFj5qJNjplT/+cPtJMjRRLTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F0Kk7vAbkCZ9UIHP6tqf99Ebh5GfDaM3uP6AZrgIr9/PcNenfFuRlcCRkLazJt9MD
         nKcPl4ofcuMRqGGxZ0wP0Q/aFnMaPG6mJ1Abp51PpYegkHRHJmxUx0fMW5Nllj1KiV
         QuTlhtQS/kYoGoFTHpC82efRFz8fYJ4sCj0d62ygTHpNDXeXSO/NI1Im5lYObfmerX
         +zkJZ1WtmAa5yG9JJL3EG9r6X4szyPE/zC7dZTW/Hwd2KT77jQCSjKIkxJxFqBmLls
         JQfFFP5aToV3xKGU23d3n1hN8K8aHD7m2/nT3nP2KDG57SAfzCwSht0aV1ArR6tbTq
         PBOQHm52FrYPA==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/15] tools/selftests/damon: Update for regions prioritization of schemes
Date:   Tue, 19 Oct 2021 15:07:26 +0000
Message-Id: <20211019150731.16699-11-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211019150731.16699-1-sj@kernel.org>
References: <20211019150731.16699-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit updates the DAMON selftests for 'schemes' debugfs file, as
the file format is updated.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/debugfs_attrs.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh b/tools/testing/selftests/damon/debugfs_attrs.sh
index 8e33a7b584e7..466dbeb37e31 100755
--- a/tools/testing/selftests/damon/debugfs_attrs.sh
+++ b/tools/testing/selftests/damon/debugfs_attrs.sh
@@ -63,10 +63,10 @@ echo "$orig_content" > "$file"
 file="$DBGFS/schemes"
 orig_content=$(cat "$file")
 
-test_write_succ "$file" "1 2 3 4 5 6 4 0 0 0" \
+test_write_succ "$file" "1 2 3 4 5 6 4 0 0 0 1 2 3" \
 	"$orig_content" "valid input"
 test_write_fail "$file" "1 2
-3 4 5 6 3 0 0 0" "$orig_content" "multi lines"
+3 4 5 6 3 0 0 0 1 2 3" "$orig_content" "multi lines"
 test_write_succ "$file" "" "$orig_content" "disabling"
 echo "$orig_content" > "$file"
 
-- 
2.17.1

