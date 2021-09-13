Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138FB40A197
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 01:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244861AbhIMXfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 19:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243754AbhIMXfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 19:35:15 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A59C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 16:33:36 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id ib9-20020a0562141c8900b003671c3a1243so58901406qvb.21
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 16:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0Y0FJaNZSCUHBQ+fPBNDuJMCC4vLwAceS4k6e2oEzTI=;
        b=rhfks4k8tFJpfDygh87cLnVtYjz8ukOMJzU+cQgjOrQK9p2isZjg59tGhZxAKa9n0g
         cC/Cfh594aAVQKc9izkjZvaaKvIOb9WBzU7JWJvUgq1WQB7VuiOghxgfCHCLhPF573mZ
         caK21nI63Tn2iLqq+YEuYTmOyr0go55vFWTuDq22JwHuFZtp2UlXlNjGC+HE2FF1gCHR
         aqH8g5N+AHhhEUuBCF6dtiR6GdMgb0y4G9F3DsYCVx9CcSMycbOlUkeXPAr5vI9HaPt/
         WTfFTHHhsfh+Fo9H5zkI+vJeLN0EBBegNfMUCktXaSlKfbl991tkMXrcl59Ha2a74Na3
         IX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0Y0FJaNZSCUHBQ+fPBNDuJMCC4vLwAceS4k6e2oEzTI=;
        b=ajQQ51IgVlvbrLHoaxPTUbxo1mKVHapuSsQ45UKFlFBo+Bt7PyamTQRJuFdVj7hhVO
         dy+XT4cmmBK1DOUPzvyB7rf1zsH1Cje9mnvE/pMgMoDkKkNePRz32SkEebodiRAmcfrt
         eudnaMPKTqnFiN6zelUgu/nW47xpj1DOk6xZRfZAv7irkbDpITAi/47sIlGVq0+E1ztT
         xpo7KQ7OelHvsmvriRZYE8OBz8Iuu7/Te2a0oIqBAq+Octk88Iyprpg1a4KhR1HMa5vE
         TMBmv2O+iUUfB1i1iCdGkLqQ/zZolpllSA9VlOL8QIRlQXcQ8VtQcoEaUSVmglP66Oga
         s2HQ==
X-Gm-Message-State: AOAM531ZkV4DkMuo7+I/K27fK9fiIVXStCaJ7umP+D2z4tQaPRIJlFNE
        zr10+rxLz2evUrEUuNbJhLsOiq4=
X-Google-Smtp-Source: ABdhPJz4t0kfCW661zPkNNWFwGXWI60FRYqxzfLLamJIfQAaOBYVdS+vsk1fwUxFneDMXhDda0fVcZY=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:f533:d5d5:c2b4:c981])
 (user=pcc job=sendgmr) by 2002:ad4:4aa8:: with SMTP id i8mr2255539qvx.59.1631576015445;
 Mon, 13 Sep 2021 16:33:35 -0700 (PDT)
Date:   Mon, 13 Sep 2021 16:33:24 -0700
Message-Id: <20210913233325.23263-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH] checkpatch.pl: use correct gitroot when running from
 non-top-level dir
From:   Peter Collingbourne <pcc@google.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Peter Collingbourne <pcc@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My workflow usually requires running checkpatch.pl from a subdirectory
of the kernel source tree. This works for the most part, but the script
will be unable to find the .git directory and will therefore refuse to
run any git commands (so, e.g. commit ID verification will fail). Fix
it by prepending $root to $gitroot when a root is set.

This also requires fixing one root directory assumption in a git
invocation.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/I33dc5f38e2bfcd95c8ea59933bba5305cce50404
---
 scripts/checkpatch.pl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c27d2312cfc3..171c5993efb4 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -434,6 +434,8 @@ if ($tree) {
 		print "Must be run from the top-level dir. of a kernel tree\n";
 		exit(2);
 	}
+
+	$gitroot = "$root/$gitroot";
 }
 
 my $emitted_corrupt = 0;
@@ -1131,7 +1133,7 @@ sub seed_camelcase_includes {
 	}
 
 	if (-e "$gitroot") {
-		$files = `${git_command} ls-files "include/*.h"`;
+		$files = `${git_command} ls-files "$root/include/*.h"`;
 		@include_files = split('\n', $files);
 	}
 
-- 
2.33.0.309.g3052b89438-goog

