Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA1541F672
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 22:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355450AbhJAUtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 16:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhJAUtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 16:49:14 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40588C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 13:47:30 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 75so10486589pga.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 13:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CM75l1KfmJgyjxqnyhwFA+NjvDgZwcBD+dHHoEi1ePM=;
        b=d90nkWX271k0CCQ2LTMWKAYScJ4vQCjCbwa0ymrK43hSqZeTZ7oI2idmY9G10VUwYT
         xp+JpXAqJIpWkPLkcgrEPqZVqGhKnfBPsVDCNP++UFV+JprM1BgunKdFDtWtz85whA0t
         f4SQkLVN/W6P0x0QmkRlFV6tXNKWvRUANWyEFwl3W2EqeBL7kEJT6WoJ5RM7C4KVaRv1
         wsfz8rAoC68g/xjeeozngNbMEgqQ6LoMAL1HbWu+7EKremzt8wMy3r5OFzMZEO5wFgxE
         YQGb1GOVQnG/0YFx9ygXxrYJPk2qQAOyXHe0enNrFu2eT+Fx5/lUkcVeYzchNog++bk4
         khOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CM75l1KfmJgyjxqnyhwFA+NjvDgZwcBD+dHHoEi1ePM=;
        b=xEP5+ldXe51pvy/g6fqQY7SkM2F5fE8P9kwxwpqSUC3cDE5nns8MmQGnljftuOt3mp
         qKR7TVvEn99buwwk3JZrgyRFbBdNlAiSpcgo9yJaM4goF1YFEw6wZnnff8/FIj0OFiVQ
         gN9XrP4y+I936xM+GJECgAem2Q1VVzByPrs+rkMuJBLoaWYZsaIlM984ZtBF/JpXgKKF
         crk5aRw8YEPGTmboB7jyusRa4ZEXBD9ctKs0tflTdwe+oTk19MWCYS0DlJXj1SSXmg5a
         g/Sa/s89HOfexaa59Iesr02rJXmD7QNkyexL5GqMtCm8oRI1iZvjNSOtp0eg284JpKWz
         veZQ==
X-Gm-Message-State: AOAM532odz+Au8QmqhJxduAyYoQsPW3lyhktBEISulmH0dimJupmumo6
        bXXrEoi4IEbFMVLZ9fEy69M=
X-Google-Smtp-Source: ABdhPJz32rOhPnU0RMhNp8a3xGXqf+M+r5UUgPzoQmpi9ulWc12h4qwDzGkMayccF+ifq3y0ablffQ==
X-Received: by 2002:a05:6a00:b47:b0:43d:cac0:cbe with SMTP id p7-20020a056a000b4700b0043dcac00cbemr13102367pfo.79.1633121249611;
        Fri, 01 Oct 2021 13:47:29 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:6006:a148:3571:e0d6:948:af69])
        by smtp.googlemail.com with ESMTPSA id z25sm7030934pfj.199.2021.10.01.13.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 13:47:28 -0700 (PDT)
From:   Utkarsh Verma <utkarshverma294@gmail.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org,
        Utkarsh Verma <utkarshverma294@gmail.com>
Subject: [PATCH v2] checkpatch: add check for continue statement in UNNECESSARY_ELSE
Date:   Sat,  2 Oct 2021 02:17:05 +0530
Message-Id: <20211001204705.7448-1-utkarshverma294@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <91569a87ac55da392fa894e8ad55292b98c558f3.camel@perches.com>
References: <91569a87ac55da392fa894e8ad55292b98c558f3.camel@perches.com>
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
 scripts/checkpatch.pl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c27d2312cfc3..edbb74dda5cb 100755
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
+			if ($prevline =~ /^\+\t{$tabs,$tabs}(?:break|continue)\b/ ||
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

