Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2632D351E5A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239126AbhDASjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:39:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239671AbhDASQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:16:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F9316121F;
        Thu,  1 Apr 2021 13:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617283571;
        bh=OE1mlfwZCgoAxZvSJkENSCUWDien2K/YeKCFK0w5o+A=;
        h=From:To:Cc:Subject:Date:From;
        b=pDwfzh1ZmI1Qf+4+HUfffzYRoapsI+nJaM3cIi/BmJYCvkB9OBZWkta++iqXsa/vx
         K3QwCF+QvIc3jeLFhfuE9TBK8oIf0G60JRmcRIh23SBfVLS9b8iB7GQYsQr38FdJy0
         vI8VAvRziyxCj8UW/Gf/c6ApYu9gfGQdw/NR+WO6SIYufn592hNKw9Aee+IgcO7lSA
         Z9ueIrNIMeaCbzbCoMNbnq6ClCAIeC7XNqv6O24VEaYRIj9jUdkzepbU/wVhADZqzt
         C+qkb3YJ3b3GzUN/94EJOnEjO6jeCT6927Q4nykKFoOc8/BxuHomcBtPhY+Ak31Gv3
         WJoPdKgE2k8qw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] torture: Correctly fetch CPUs for kvm-build.sh with all native language
Date:   Thu,  1 Apr 2021 15:26:02 +0200
Message-Id: <20210401132602.116352-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Grepping for "CPU" on lscpu output isn't always successful, depending
on the local language setting. As a result, the build can be aborted
early with:

	"make: the '-j' option requires a positive integer argument"

Prefer a more generic solution.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-build.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-build.sh b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
index 55f4fc102624..5ad973dca820 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-build.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
@@ -42,7 +42,7 @@ then
 fi
 
 # Tell "make" to use double the number of real CPUs on the build system.
-ncpus="`lscpu | grep '^CPU(' | awk '{ print $2 }'`"
+ncpus="`getconf _NPROCESSORS_ONLN`"
 make -j$((2 * ncpus)) $TORTURE_KMAKE_ARG > $resdir/Make.out 2>&1
 retval=$?
 if test $retval -ne 0 || grep "rcu[^/]*": < $resdir/Make.out | egrep -q "Stop|Error|error:|warning:" || egrep -q "Stop|Error|error:" < $resdir/Make.out
-- 
2.25.1

