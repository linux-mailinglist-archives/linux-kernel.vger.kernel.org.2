Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B663442003D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 07:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhJCFlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 01:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhJCFll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 01:41:41 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF9DC0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 22:39:53 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id np13so3023656pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 22:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MHHrRyhaaSDdyDXA0sw78/JGPr6cOHuLgaZg+N4Xe6U=;
        b=Z/bDX0E8Tg4Rx3ZSANxhh7uQgC6DVmNIXLklE26atN51paijLMN7APASynBLbT+9J6
         KMABmrXp2yH8kzKamw+dqWwvTexYUoz/KuSWUUKPeSqOWiJkjNvtoPFTK91E5lrB9yC/
         jcW/O2wxuSlgXwklPmYdrR3B278RX3uposeae02p3FRTRVRe/PUndr56CyXBx8b0bqK1
         WvG6dRA9aR8T3FMv19IlvPLD74RGBMlQp2oCmeZtep+fqHHOgjKL+iEizaHEYPcFxHPZ
         nnoPy4DzWFL0Eb4ia/ZMliHUHIrzE4H9rstDJ/zctzlvgQF6bH+i/5i4kpwC08NwPKZP
         j4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MHHrRyhaaSDdyDXA0sw78/JGPr6cOHuLgaZg+N4Xe6U=;
        b=8QHY98J+qut8kTxSe6HMZHXyHivjQCppITdf5Ob+4Pg42ZoG1eIEwhRJc3QvnU+J6b
         K13tzDXOdO8xyLDH/qSQ+f00JsezVszWclb2aN8JWxki+PEepmwcCfWH0+pN81NpSdDw
         r8HG0iLPbR9tE1DcuCh0z40q90bLQvcIToomtsm8pqKW+4biyX6OKmWv8J4YBctsPMHN
         CwyF0epb+2CApgLe02eYlHae4pZ8r3NTxvcZH2t8kcMBvq1gprzCkHoA/yqvBw6s+weE
         vyhKlb5JSzm1AecQ89W10zbegL57crWRj4GejTDWW3UIU0nbcRMl54f7pxQRo2VSgZ+S
         /7EQ==
X-Gm-Message-State: AOAM530oYmRT9PFvIblMfD1awJER+Kfw+NdfaryvajBcsSQHUjzeXi46
        Bmeh4V9kHAI9PiUrHPQ8Lzg=
X-Google-Smtp-Source: ABdhPJxeSik6ef7wkacHPzAsUw4qfCTU1Cx487tjA4klSwidPAfICQXAj1pKvDOSQDYuC6zR3Zmzcg==
X-Received: by 2002:a17:90a:9908:: with SMTP id b8mr29642248pjp.203.1633239592645;
        Sat, 02 Oct 2021 22:39:52 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:6006:a148:3549:857c:c627:c3bc])
        by smtp.googlemail.com with ESMTPSA id w4sm10455485pfb.3.2021.10.02.22.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 22:39:52 -0700 (PDT)
From:   Utkarsh Verma <utkarshverma294@gmail.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Utkarsh Verma <utkarshverma294@gmail.com>
Subject: [PATCH v4] checkpatch: add check for continue statement in UNNECESSARY_ELSE
Date:   Sun,  3 Oct 2021 11:08:56 +0530
Message-Id: <20211003053856.10348-1-utkarshverma294@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UNNECESSARY_ELSE only checks for the usage of else after a return or
break. But the same logic applies for the continue statement.

An else branch used after a continue statement is unnecessary. So add
a test for the continue statement, too.

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

