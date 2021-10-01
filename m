Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63E941EDFC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 14:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353728AbhJAM7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 08:59:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353742AbhJAM6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 08:58:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BC2561AA9;
        Fri,  1 Oct 2021 12:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633092992;
        bh=5IMVnxeKQmBGq+kXHX3jRdtYUAtJAhxvUWwsyEEOvVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hmj4WfbXy2M53h5olsPyPCxcLcmYrXcIyXenWUIVYkk7W1xo3o74CZjJl0MxtvPa8
         hLm7UUxL0eKoaXvBA/oru4AY9S06YY3AV36NkT+d18zfP2NCq9SxbA+EyQIExJ4yiA
         7OKhOJ0t1apmY1WiM9RdA3Pcwwtxy29HQcDD++TeUW0mib0O8GnWHVtHpEZ3r4wYty
         CDhyybsAKd0TGHU1QJgYkKVPdZdz1xS4so6RaYPr6FYdSdAF7C06IU58jb1CAs/hTC
         HKAO1r8CzBxdDaJzIysq2KhGeBXc0qzgaHfGynDWM2RHWnVCwg+n/z4k2tOo4cI3Hv
         tws+Fhtj/Xyig==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] selftests/damon: Add 'schemes' debugfs tests
Date:   Fri,  1 Oct 2021 12:56:03 +0000
Message-Id: <20211001125604.29660-7-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211001125604.29660-1-sj@kernel.org>
References: <20211001125604.29660-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds simple selftets for 'schemes' debugfs file of DAMON.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/debugfs_attrs.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh b/tools/testing/selftests/damon/debugfs_attrs.sh
index bfabb19dc0d3..639cfb6a1f65 100755
--- a/tools/testing/selftests/damon/debugfs_attrs.sh
+++ b/tools/testing/selftests/damon/debugfs_attrs.sh
@@ -57,6 +57,19 @@ test_write_fail "$file" "1 2 3 5 4" "$orig_content" \
 test_content "$file" "$orig_content" "1 2 3 4 5" "successfully written"
 echo "$orig_content" > "$file"
 
+# Test schemes file
+# =================
+
+file="$DBGFS/schemes"
+orig_content=$(cat "$file")
+
+test_write_succ "$file" "1 2 3 4 5 6 4" \
+	"$orig_content" "valid input"
+test_write_fail "$file" "1 2
+3 4 5 6 3" "$orig_content" "multi lines"
+test_write_succ "$file" "" "$orig_content" "disabling"
+echo "$orig_content" > "$file"
+
 # Test target_ids file
 # ====================
 
-- 
2.17.1

