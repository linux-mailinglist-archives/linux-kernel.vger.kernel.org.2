Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37AB34CD0D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 11:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhC2JaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 05:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbhC2J37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 05:29:59 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5CDC061574;
        Mon, 29 Mar 2021 02:29:59 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id h8so4111953plt.7;
        Mon, 29 Mar 2021 02:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=I2rYcnAf0ifNkAwBrdzfC3Hucp+PdY95Y1i5iXCzcs4=;
        b=DWp35A6ITBgFsPERJoKrnD9oIp9n4wapfaTcGC2EG6YLrSB5O3Nq0M0kcN7pV4Xk6z
         fDyfD26eVfv9+wOhmh7PcmI8AUF7tDgYEYMviw+lg1KX9MV3Dt/k/GkB+pj6+tPI5R7W
         KkylbAr0Hy83xpbgXRhZSJKC7Pw/yTFB2O2pIVAkGr5DsyvOLDRYcZQfAE7lpRPPhO2P
         S8/2WUwaxBCscvR4kRpbfY342rTnsJRIgEdxUxxtmD25Nbprj593WvV9jFmkaVhB94WY
         BKkBC0NkbfHU+CMNx3IuhvKltB9rx+6NZkpuOlT2H5wdmQCyI3zRt5P3Toe6QTX8ZtsS
         iDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I2rYcnAf0ifNkAwBrdzfC3Hucp+PdY95Y1i5iXCzcs4=;
        b=epTUeO/e+dlnLOVjgJh6DNTxS3g+wbG3uMdsre55+3ETvYId6hwVIer5rsQXRK5dJT
         NSTP0YcmmMe7JjbZFL8v5mwv5+NNhpk4HHx92m6ZcAJFL3xDoXBGyPb5jB32V1h5vUPK
         Gwt1BBuVQw5hwpIUL9cUcnlv5V4pP0SdnTF6nV7HFrx3ZrPGBV44z7mhLSUCwoklq2rp
         id7+gQ4lLmht1mWswN6W+xaAPyMdbEO94Pt2ese6eJ7LGjD1Qlnqeifcj7jAZejrgPTK
         DBSYMbQT4at/4GAjBDjpQV8BxOUd83gIYOrKGhmTg0HAtjcEN10czWhpv1BiLY7B9Dgg
         1Mww==
X-Gm-Message-State: AOAM532ZDIZEIWnRdMBHZzyhPO0m56YzsEKjyEFbwf6eCocNTGpFVDs2
        rplt9IEEAYOUvxTowl3XGjM=
X-Google-Smtp-Source: ABdhPJx8yZaadvCrbGyAu8R22UEr9i0Qzbzpk5yBbA8vuFl5QZLV1SahL4l40JzN+KlSnvGEOUdKcw==
X-Received: by 2002:a17:90b:16cd:: with SMTP id iy13mr26404121pjb.46.1617010199064;
        Mon, 29 Mar 2021 02:29:59 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a089:4ed:8f53:adc7:b574])
        by smtp.googlemail.com with ESMTPSA id z1sm16581419pfn.127.2021.03.29.02.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 02:29:58 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     corbet@lwn.net
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scripts: kernel-doc: add warning for comment not following kernel-doc syntax
Date:   Mon, 29 Mar 2021 14:59:45 +0530
Message-Id: <20210329092945.13152-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kernel-doc start parsing the comment as a kernel-doc comment if
it starts with '/**', but does not take into account if the content inside
the comment too, adheres with the expected format.
This results in unexpected and unclear warnings for the user.

E.g., running scripts/kernel-doc -none mm/memcontrol.c emits:
"mm/memcontrol.c:961: warning: expecting prototype for do not fallback to current(). Prototype was for get_mem_cgroup_from_current() instead"

Here kernel-doc parses the corresponding comment as a kernel-doc comment
and expects prototype for it in the next lines, and as a result causing
this warning.

Provide a clearer warning message to the users regarding the same, if the
content inside the comment does not follow the kernel-doc expected format.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
 scripts/kernel-doc | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index cb92d0e1e932..b1d71a7b721f 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -2103,15 +2103,17 @@ sub process_name($$) {
 	}
     } elsif (/$doc_decl/o) {
 	$identifier = $1;
-	if (/\s*([\w\s]+?)(\(\))?\s*([-:].*)?$/) {
+	my $is_kernel_comment = 0;
+	if (/^\s*\*\s*([\w\s]+?)(\(\))?\s*([-:].*)?$/) {
 	    $identifier = $1;
+	    $decl_type = 'function';
+	    $identifier =~ s/^define\s+//;
+	    $is_kernel_comment = 1;
 	}
 	if ($identifier =~ m/^(struct|union|enum|typedef)\b\s*(\S*)/) {
 	    $decl_type = $1;
 	    $identifier = $2;
-	} else {
-	    $decl_type = 'function';
-	    $identifier =~ s/^define\s+//;
+	    $is_kernel_comment = 1;
 	}
 	$identifier =~ s/\s+$//;
 
@@ -2133,6 +2135,13 @@ sub process_name($$) {
 	    $declaration_purpose = "";
 	}
 
+	if (!$is_kernel_comment) {
+	    print STDERR "${file}:$.: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst\n";
+	    print STDERR $_;
+	    ++$warnings;
+	    $state = STATE_NORMAL;
+	}
+
 	if (($declaration_purpose eq "") && $verbose) {
 	    print STDERR "${file}:$.: warning: missing initial short description on line:\n";
 	    print STDERR $_;
-- 
2.17.1

