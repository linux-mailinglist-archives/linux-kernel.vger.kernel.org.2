Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166D632402E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238232AbhBXOld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 09:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236991AbhBXNcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:32:25 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005B5C06178C;
        Wed, 24 Feb 2021 05:30:10 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id w18so1184568plc.12;
        Wed, 24 Feb 2021 05:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qfRfzFAwrIoV1GXQkJdn6bloQGW/Oh86EcITr8l8t7o=;
        b=SZoAHANGnhmCzJHG1dCPjNAO/11Ivn7BKBvM+XcDvW+Cc2H5L+epyrPF+ywHodcFyV
         +vKe5obmeeRtNmM/z4AekygbVJU7JW8hQsTuG/9DHJSQjXi9aV0DukKRjQwwbH7CiQk+
         afpA0OzYsOGeYlF4/QzCj2SAAv56Ux6QRAM6tIEShVwD+v1WjM2kW/1wgKjpy6ebXDMo
         U8igCoWCGv+luVMNG9zdre/woqzpuh88dHoUpG3qHirNr/GGngN+F59zyitkRyFrQpRP
         BN/9qwOdBGFgkgC43FJxUR9k0yG1BWXVtyhvhJqoVOi08QGQFbOvpm/MOSFyD4W+Ebij
         uh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qfRfzFAwrIoV1GXQkJdn6bloQGW/Oh86EcITr8l8t7o=;
        b=PLJ23WZPb82UqxCGMuBl5CA6/Cj6uaIv+OY4VdcMSk3mW5f5az2f/XkGP/F264sJW4
         5USb/Hcs8PSDasLCwQToQtAwrsM0Iy0I/I6bX3igL+xBOkhCpjc5ZDpqbBt+UflnSlF+
         iSkoQ/FIGIQGK2Pm5hGxhQ5bUATZffZD0UXm3K1IxRXJNA5e8jTtJT6uCA3ONAEzRnVT
         QgUdkQQClSHe7YUqqXH4xTMunJl19Tg/UPJ5OL5AqifXbmge3KGgeDrGEhIkKMW7mq0w
         wI8N2yATq52FCVJU9rfUq2SvEHzfgJAYbGDbGQSuOkuR1rFT4pO0XyQ7UAaOup45/6Y8
         a/Uw==
X-Gm-Message-State: AOAM530TvugkR7IN64E2fuDMUH5SEEhtpK2MxzeRA6tglr93YFsuvJcR
        inYCVRCQWDZem/EmjZmQQROwZvGS73uR7B4m
X-Google-Smtp-Source: ABdhPJxIPjwG9lM4N5J/rrkK6hFq/627Aqe0h8jJPpIfPt26lVSWCEX1mKKxaUKytjrY5nrJyS2xbw==
X-Received: by 2002:a17:902:9f8b:b029:e0:a90:b62 with SMTP id g11-20020a1709029f8bb02900e00a900b62mr32736085plq.70.1614173410483;
        Wed, 24 Feb 2021 05:30:10 -0800 (PST)
Received: from localhost.localdomain ([2405:201:600d:a089:5c4:262b:be36:c819])
        by smtp.googlemail.com with ESMTPSA id p11sm2809756pjb.31.2021.02.24.05.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 05:30:10 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     corbet@lwn.net
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [RFC v2] scripts: kernel-doc: fix typedef support for struct/union parsing
Date:   Wed, 24 Feb 2021 19:00:02 +0530
Message-Id: <20210224133002.13503-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <875z2jlr2j.fsf@meer.lwn.net>
References: <875z2jlr2j.fsf@meer.lwn.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there are 447 files in the kernel tree, which use 'typedef
struct/union' syntax for defining some struct/union. In total, there
are ~1290 such occurrences in the kernel tree.

However, kernel-doc does not support it currently, and running
scripts/kernel-doc -none on include/linux/zstd.h emits:
"error: Cannot parse struct or union!"

Add support for parsing struct/union following this syntax.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
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

