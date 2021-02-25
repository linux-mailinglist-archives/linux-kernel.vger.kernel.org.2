Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F993251C0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 15:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbhBYOv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 09:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhBYOvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 09:51:22 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2401EC061786;
        Thu, 25 Feb 2021 06:50:42 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id f8so3312232plg.5;
        Thu, 25 Feb 2021 06:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ICxR1l/7KZSqo36Cd5u0xbdSpjciCk+ekMLVc8kZuio=;
        b=nE6FMH8tBWhfqZypIJmxC5ZJEacdZdRTQGVNDmCmx4YJNFIJcmYMWDXn4VIoeXDo13
         jzFLbi7t95uHfCk9Zv/FVCJYJ9P3c9i45qgjJF5H6TMlNeSOS/rjfcjl+iAMX1c/KfXr
         gN8kryvUYUs9lcMEWRgh9xYg2aIcHAKCEZ+UmAg0OCflDlScn4y97eDbrJ53NnNzKhjk
         n6OcnXDpC0hMsFZhOH7nG/divlVa8I7xzQQoSQNKaZXL9XQFc+ffpVH1w4kSyg+xoi1S
         kzUc7+XH2zRKkg3tY8a3bzPgUzTkog0aMj1J5UuS7hDRSKQ25zDHXyyanhBNF0qnQuRi
         Racw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ICxR1l/7KZSqo36Cd5u0xbdSpjciCk+ekMLVc8kZuio=;
        b=crO7Nzl1GLu7BbCOfo4T4luowQVnJx+fzo9ZfRUPoGJHjCohVmYzipFACbJzmKpHmY
         KsxWTQswmpNWGu4jEa5oR7nu3eXfJxKJf8MqbrFwTPEp78XZrQ9n3CiubK02mbVdz+6p
         LQfIGyLm/midH5QvJ6NQ0tfXDuSjOVfT0b1ACUsnxXTe6x99qewN0KKmFNjZ5MPj/HJo
         d7XCUscLncviWTS2YqH1lIN1VLX2K3d7AmLkA9mKX//WA9mE5vqGBWTZl1FKm2Ac0OQY
         hqZtAfbV5kBDuPQ3ovO24IEeUceWAeLsBjN1UHZV+wIfs/t12WinEggi0Ls4W3lfKcZD
         Z+eg==
X-Gm-Message-State: AOAM533jLbZYU5HaLBMISYoWzbApReEmzjCCsXdt+RJnKn15sHfUqNJN
        EiwjY57I7XnG5vz9KQf5JqI=
X-Google-Smtp-Source: ABdhPJy0xwfu4LfbRHmB35h3GPFN6CKqur6cB8K9GM7y1x9Cw1fj+2bpbHW0NMjS52DUc2zE6Yc3bw==
X-Received: by 2002:a17:902:f688:b029:da:a817:1753 with SMTP id l8-20020a170902f688b02900daa8171753mr3410714plg.76.1614264641504;
        Thu, 25 Feb 2021 06:50:41 -0800 (PST)
Received: from localhost.localdomain ([2405:201:600d:a089:7d05:ce5c:6c16:3c9f])
        by smtp.googlemail.com with ESMTPSA id x2sm6389082pfi.220.2021.02.25.06.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 06:50:40 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     corbet@lwn.net
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [RFC v3] scripts: kernel-doc: fix typedef support for struct/union parsing
Date:   Thu, 25 Feb 2021 20:20:33 +0530
Message-Id: <20210225145033.11431-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAKXUXMzHPnM=ie06ZGuFXyJ7RcRjYomjyASbp3ND9-Mb2Es+2w@mail.gmail.com>
References: <CAKXUXMzHPnM=ie06ZGuFXyJ7RcRjYomjyASbp3ND9-Mb2Es+2w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there are ~1290 occurrences in 447 files in the kernel tree
'typedef struct/union' syntax for defining some struct/union. However,
kernel-doc currently does not support that syntax. Of the ~1290
occurrences, there are four occurrences in ./include/linux/zstd.h with
typedef struct/union syntax and a preceding kernel-doc; all other
occurrences have no preceding kernel-doc.

Add support for parsing struct/union following this syntax.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
Changes in v3:
- Modify commit message

Changes in v2:
- Split recurring regex into multiple variables
- Modify commit message

 scripts/kernel-doc | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 8b5bc7bf4bb8..68df17877384 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1201,12 +1201,23 @@ sub dump_union($$) {
 sub dump_struct($$) {
     my $x = shift;
     my $file = shift;
+    my $decl_type;
+    my $members;
+    my $type = qr{struct|union};
+    # For capturing struct/union definition body, i.e. "{members*}qualifiers*"
+    my $definition_body = qr{\{(.*)\}(?:\s*(?:__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)))*};
 
-    if ($x =~ /(struct|union)\s+(\w+)\s*\{(.*)\}(\s*(__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)))*/) {
-	my $decl_type = $1;
+    if ($x =~ /($type)\s+(\w+)\s*$definition_body/) {
+	$decl_type = $1;
 	$declaration_name = $2;
-	my $members = $3;
+	$members = $3;
+    } elsif ($x =~ /typedef\s+($type)\s*$definition_body\s*(\w+)\s*;/) {
+	$decl_type = $1;
+	$declaration_name = $3;
+	$members = $2;
+    }
 
+    if ($members) {
 	if ($identifier ne $declaration_name) {
 	    print STDERR "${file}:$.: warning: expecting prototype for $decl_type $identifier. Prototype was for $decl_type $declaration_name instead\n";
 	    return;
-- 
2.17.1

