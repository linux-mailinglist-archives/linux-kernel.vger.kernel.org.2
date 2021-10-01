Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B7C41F5B9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 21:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353716AbhJAT3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 15:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhJAT25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 15:28:57 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD0CC061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 12:27:13 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s11so10313398pgr.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 12:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nCY5yCLArbXzwsfESm+PhL1Wysw6zxf3zJUxo56fNHo=;
        b=Jk3uxnPZjmZVPuU/w4ivy9eCIXIqifG4QHsFM/YngAemKTOjKlJulu5zwTbm9u2i1z
         EFgE1WEwI1ColHbUOr54wKzD1y4Vlwz9H7hGhXtf3k11qFS8ZSal/+JhsjsmtECbncHM
         yNPCt9Qgii16V+dTfQg1K2kJvVrc5o1zGuL1EEMUZZ/qjOA4rfBclNyNKh6knwkye1A6
         Qk5PApGuylZ3XyfqVVBIWIa24BwL2P6YA3DYRwMwfxbztGhBBsWOJaQZnJh9nG20wYYw
         34CqOERzOnUClH4s3SqKjcIaBPN6SJ556cnWIJSs5DRzRzH/TAHwlb4iBlv4rKA64J3B
         saaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nCY5yCLArbXzwsfESm+PhL1Wysw6zxf3zJUxo56fNHo=;
        b=Y/rN0t8X4jfjC15MmoP3QxZv2v8//lvLjFLYYh8IJtWuSKMFpLjOIUzCWG7rH+KFnB
         HyOH5wljARQOklCDb6/Uloe3FbNKrp/Xgd1oY99gDoRe0mLtJM4+4+7VfVUCHWWoZu3A
         k37XJPXpzx5/2pOygiv6IoH/fi80Uo0Gi2y/46EQ0C7DoH0rTpj6RpMMrOxSgTXbQKjX
         tYQJXWqpzJsfsK9Qvqioy2PeM0VmUypN20xhWmJ/29daGCRL4r3HyuBKfODQ2u6QFflp
         UgIjBG3EtH6xkJKbQrVfTZlFwRZXrSaEkppmscDgEum5KpTiPfU3ipjGJq6HlQTdn4E8
         bW1w==
X-Gm-Message-State: AOAM531aykn9M5bKCTSOs4cmNJZi8A7eFm2Kg7TZIyUwSBL7O98gln4v
        3crvcBjLZVqlUPL937q5v5wHCTZYHNoDBLL0vCQ=
X-Google-Smtp-Source: ABdhPJzxviZNw75M+elQfTAMvu/WBCy8vmVUMzn19eSUoj2c0GYStPScDwcWTKNxVeu8KEAeP37GXQ==
X-Received: by 2002:a65:47c9:: with SMTP id f9mr11047857pgs.292.1633116432938;
        Fri, 01 Oct 2021 12:27:12 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:6006:a148:c9bc:b8d0:c5af:34e3])
        by smtp.googlemail.com with ESMTPSA id x15sm6752390pgt.34.2021.10.01.12.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 12:27:12 -0700 (PDT)
From:   Utkarsh Verma <utkarshverma294@gmail.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org,
        Utkarsh Verma <utkarshverma294@gmail.com>
Subject: [PATCH] checkpatch: add check for continue statement in UNNECESSARY_ELSE
Date:   Sat,  2 Oct 2021 00:56:28 +0530
Message-Id: <20211001192628.19179-1-utkarshverma294@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211001190927.GA18097@uver-machine>
References: <20211001190927.GA18097@uver-machine>
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
 scripts/checkpatch.pl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c27d2312cfc3..f5a911aa6b64 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4011,15 +4011,16 @@ sub process {
 
 # check indentation of any line with a bare else
 # (but not if it is a multiple line "if (foo) return bar; else return baz;")
-# if the previous line is a break or return and is indented 1 tab more...
+# if the previous line is a break or continue or return and is indented 1 tab more...
 		if ($sline =~ /^\+([\t]+)(?:}[ \t]*)?else(?:[ \t]*{)?\s*$/) {
 			my $tabs = length($1) + 1;
 			if ($prevline =~ /^\+\t{$tabs,$tabs}break\b/ ||
+			    $prevline =~ /^\+\t{$tabs,$tabs}continue\b/ ||
 			    ($prevline =~ /^\+\t{$tabs,$tabs}return\b/ &&
 			     defined $lines[$linenr] &&
 			     $lines[$linenr] !~ /^[ \+]\t{$tabs,$tabs}return/)) {
 				WARN("UNNECESSARY_ELSE",
-				     "else is not generally useful after a break or return\n" . $hereprev);
+				     "else is not generally useful after a break or continue or return\n" . $hereprev);
 			}
 		}
 
-- 
2.25.1

