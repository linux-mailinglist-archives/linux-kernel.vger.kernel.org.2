Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DC741FC68
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 16:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbhJBOFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 10:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbhJBOFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 10:05:14 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187BFC0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 07:03:29 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id v11so555893pgb.8
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 07:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j6bc62fJKriPiLvCCqtI4vfnS9A2ln4GTK9v11F+mtw=;
        b=kWIplTUT/HM07TCKdKRNVhvgGEUVKOnSSLUs/2E1P9uSUQjGpI/W4s3u+4G2SrY9Qo
         pdnsbD7BB14P/UwiLNoGKmyPvyuXFOI88WOa965dNPkRND6gPOl7g/Cw9oPBbRe8ff7J
         0NkaPHhkDf9KxnWu46u0i4FoKbdk6TTtMqIBn8oab9a54pS8oL4DVC6iYUJY0GRg2e3/
         F6rudCXBJmdrRRltgICDS6NxTmyTxbjOE+nYodN/emDwJsfrkO4aYpG1lMD+lEOqsS8A
         xb3QBR3t8tbbKzAbl9MLFB2l48vnBZ3fMJ1OKZPJ/egLfb4sFKHPSFF0S/qYBKGsdolC
         DOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j6bc62fJKriPiLvCCqtI4vfnS9A2ln4GTK9v11F+mtw=;
        b=DRaG0Kt9L3LvDXcYN9fzrZlBRQ9cB4NXkXL8JTJit3W7U62F/6A21btbt4Iw5FLD+X
         Sq9z2SAYDUu0F6V7dOILUL//Xv6L+QXQJFeN+jPbJPwS3nq8/zSODe0asrO0yClH8jV+
         tE7xyNqLnk0w/qADPsrOZcKoT8RM9jahpOSNt+1L/r14WwnkuMs1khenIknWn6eGkfMy
         KApdyOAMqvki0+pqron41bECxI7sBTCS4Z0Q45kJSZv1k7lSN/upKdzP9kUZxK6/AEaS
         jcdSQnHPuyEW5MUUG7x0Z5lEA3vuWebCa2CvrupTHNUYl6U5J/79hE+mVWC7+VoVkULt
         0TBg==
X-Gm-Message-State: AOAM530EjwmOh4MH1Vbrsho8J8uTP4euC8OPdVqWk7IZa1IrnkiHKgit
        AdDKY78eSgSqfMQJdNfaKhM=
X-Google-Smtp-Source: ABdhPJxG96LpJgB9i/K7J+Av8OoH9qsEn4iohqKuPTUVoWYlRL/P0abafhIyPm5ZtlVU9w8AD/dz7Q==
X-Received: by 2002:a63:535f:: with SMTP id t31mr3015771pgl.270.1633183407240;
        Sat, 02 Oct 2021 07:03:27 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:6006:a148:5133:c24f:f24a:a8c])
        by smtp.googlemail.com with ESMTPSA id s188sm8931276pfb.44.2021.10.02.07.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 07:03:26 -0700 (PDT)
From:   Utkarsh Verma <utkarshverma294@gmail.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org,
        Utkarsh Verma <utkarshverma294@gmail.com>
Subject: [PATCH v3] checkpatch: add check for continue statement in UNNECESSARY_ELSE
Date:   Sat,  2 Oct 2021 19:32:47 +0530
Message-Id: <20211002140247.28677-1-utkarshverma294@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <d15bba541aac03ebe24c733f24b6bda96d03a3ec.camel@perches.com>
References: <d15bba541aac03ebe24c733f24b6bda96d03a3ec.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UNNECESSARY_ELSE only checks for the usage of else after a return or
break. But the same logic is also true for continue statement.

else used after a continue statement is unnecessary. So add a test
for continue statement also.

Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
---
 scripts/checkpatch.pl | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c27d2312cfc3..0eee086d87fe 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4011,15 +4011,15 @@ sub process {
 
 # check indentation of any line with a bare else
 # (but not if it is a multiple line "if (foo) return bar; else return baz;")
-# if the previous line is a break or return and is indented 1 tab more...
+# if the previous line is a break or continue or return and is indented 1 tab more...
 		if ($sline =~ /^\+([\t]+)(?:}[ \t]*)?else(?:[ \t]*{)?\s*$/) {
 			my $tabs = length($1) + 1;
-			if ($prevline =~ /^\+\t{$tabs,$tabs}break\b/ ||
-			    ($prevline =~ /^\+\t{$tabs,$tabs}return\b/ &&
-			     defined $lines[$linenr] &&
-			     $lines[$linenr] !~ /^[ \+]\t{$tabs,$tabs}return/)) {
+			if ($prevline =~ /^\+\t{$tabs,$tabs}(break|continue|return)\b/ &&
+			    !($1 eq "return" &&
+			      defined $lines[$linenr] &&
+			      $lines[$linenr] =~ /^[ \+]\t{$tabs,$tabs}return/)) {
 				WARN("UNNECESSARY_ELSE",
-				     "else is not generally useful after a break or return\n" . $hereprev);
+				     "else is not generally useful after a $1\n" . $hereprev);
 			}
 		}
 
-- 
2.25.1

