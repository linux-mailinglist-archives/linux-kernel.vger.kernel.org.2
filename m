Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38E43765F2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 15:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbhEGNSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 09:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhEGNSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 09:18:08 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47414C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 06:17:08 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id o14-20020a05620a130eb02902ea53a6ef80so5958547qkj.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 06:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qJIcBMd1W+MCNdPVSJmHChbyVDM5OvQnFykcjOHyYnA=;
        b=P37qz7pAcf8eYkBU7n/2uOj0zD1C61zIEYk7xNQyPprYMf8hab0QbrUh5sqXoQZseZ
         F/e0ysFtE4qZ1O0Of2Wv4r0KGssNNUMIpGwXbxT/NCChTm5uFaegdb//3P0pjU7MX6CX
         NJrmDIyOZccIwPH/Sgwh7FVXkMTd8WJjAgy7XZQIcZ6BpfafELovhFHRcDyxCJiag+2b
         rdFjsxhm4+yRJ3LaTee1Z3KFm4OljHgC1ZOE5BCbIwlY40ZlZ6bhJW2x54ceq/uHyQ2N
         06jUOt/OmKZSJwS7gr168tqKqF27aSULNiinVecxbFmyj3dzxj1lMNjJFFJ3kFSHWAXz
         H7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qJIcBMd1W+MCNdPVSJmHChbyVDM5OvQnFykcjOHyYnA=;
        b=GyCW0WUHM9YM4h549cph4xt1LIzW5Gwqh85f0xVL/kxRN3QDsiimawZWensEqxL74z
         w+RBljXvSSnofUys/YkNDQTwi6sFIJAFBW551oPeQczx8unqa/V7pxcg8RGkhXzxNAf1
         WPLz45sMd2lfQA8ceC1Et+ixTXw13EbcvgdXYHfd5HB8MW+EI+MC+zf2XdbDRHaNHlpW
         8NfzeviQO++N6qqNFNA4DP1CSTUVdyZtc+fvBOWh5fb+IQY0kbxqIQtDbxmp7s5PK8cL
         NQmwB18kgYmBfgOyyjYAivqoh0R5E/+1lAHRylvOpt1ixVzvFc83UDGjmWbvQC122LM8
         E6cg==
X-Gm-Message-State: AOAM531mHuOJq2B6Xf9KP4YbZbrNUmq/m/H0IhX+wx4kxptNwaJZVBRK
        m32YpVxp0XjZkP3cgQm0TFp1Nji09A==
X-Google-Smtp-Source: ABdhPJxiuuSAu1neySoRGdFeSopGe0sV999tQvsDVpgWi4bobAQnjXunejePGntoI21UO8hJ5qzYryhRQA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:8a0d:e203:7178:f146])
 (user=elver job=sendgmr) by 2002:ad4:5aa1:: with SMTP id u1mr9626258qvg.23.1620393427474;
 Fri, 07 May 2021 06:17:07 -0700 (PDT)
Date:   Fri,  7 May 2021 15:16:58 +0200
Message-Id: <20210507131658.3754171-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH v3] checkpatch: warn about direct use of send_sig_info and force_sig_info
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     linux-kernel@vger.kernel.org, apw@canonical.com, joe@perches.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        "Eric W . Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting up siginfo and using send_sig_info() and force_sig_info()
directly is discouraged. Instead, new code wanting to generate signals
should use the appropriate helper specific to the signal.

Eric mentioned that he'd like to make these static at some point, but
until that can happen, let's try to avoid introducing new users of them.

Link: https://lkml.kernel.org/r/m17dkjttpj.fsf@fess.ebiederm.org
Link: https://lkml.kernel.org/r/m1eeej3g52.fsf@fess.ebiederm.org
Cc: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Marco Elver <elver@google.com>
---
v3:
* Reword warning message (Joe Perches).
* Simplify regex (Joe Perches).

v2:
* Use ?: because we don't need $2 (suggested by Dwaipayan Ray).

v1: https://lkml.kernel.org/r/20210506132827.3198497-1-elver@google.com
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index ccb412a74725..c714543818e5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7153,6 +7153,12 @@ sub process {
 			     "Where possible, use lockdep_assert_held instead of assertions based on spin_is_locked\n" . $herecurr);
 		}
 
+# check for direct use of send_sig_info(), force_sig_info()
+		if ($sline =~ /\b(force_sig_info|send_sig_info)\s*\(/) {
+			WARN("USE_SIGINFO_HELPER",
+			     "Prefer signal-specific helpers over use of '$1' (see: include/linux/sched/signal.h)\n" . $herecurr);
+		}
+
 # check for deprecated apis
 		if ($line =~ /\b($deprecated_apis_search)\b\s*\(/) {
 			my $deprecated_api = $1;
-- 
2.31.1.607.g51e8a6a459-goog

