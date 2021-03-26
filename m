Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1719E34A05F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 04:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhCZDvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 23:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhCZDvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 23:51:04 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70B5C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 20:51:03 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y5so4010869pfn.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 20:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8w8naJum/vopwmyKMpQEykT893Mp4UP1aA3kggA0VF8=;
        b=aQlHjrFo1kH08LTRuV2Thzie+JQZXgDTwmA2d/RIpnVxhp8800rQqHuwTgf23cbvpI
         6g0hMBJ5g34KIaqLXfYwD+fmlQFFsEcHQp0LMsotG4YASB+iFvaCOQsZEA9DKwaFwivM
         aazDv2XumIIClXotwqmnhMtWBwa5/tEyV2VjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8w8naJum/vopwmyKMpQEykT893Mp4UP1aA3kggA0VF8=;
        b=mbsWMneF2zJPosUsmlJhJ81EkAjToAeiJm0dMG+7kMBX7sAy1IWXRdJkl1z08dyX9u
         vOShjYb5kDPz3Z9c4Fub2m1S//G6ymzciCQldwaeTX7M9dk4Py1kUu4og08sxMW7cXLp
         nL5q9shm/IRC1YngoCizcmRPfKY73Fe75B2xh3410G8bUBy6us5cnV67WyKKnBLv46QS
         yLfRIkWsCWAIJZeWrt85V+CIbyFcdTMocIDDYN+PiF4JsZP9mDQcT+k3hH0rzlMMCvYN
         R1SzTcreTDu54SOFlruWh70ClAgIyRS3PCUnBVNAW8B5GrtA+EyAlSIiouuvKrtWYJ4a
         ToiQ==
X-Gm-Message-State: AOAM533m62/XewBl3WD+nu5w6BiNZzKsz2FRxbsN6LTIVM/1cacp9Q9i
        LvGwTSNrih809OyYOulZmdYRAA==
X-Google-Smtp-Source: ABdhPJw7vU4B9NZ18L8SVgCuG0B+GSUs+h/S+qII1rBx02sWezIg5cN29xhuxULAjDw6szbChopNbA==
X-Received: by 2002:a62:6202:0:b029:208:f11c:2143 with SMTP id w2-20020a6262020000b0290208f11c2143mr11063995pfb.32.1616730663488;
        Thu, 25 Mar 2021 20:51:03 -0700 (PDT)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:202:201:d0b:23e:bf14:3ec9])
        by smtp.gmail.com with ESMTPSA id v11sm7196345pgg.68.2021.03.25.20.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 20:51:03 -0700 (PDT)
From:   Julius Werner <jwerner@chromium.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Ivo Sieben <meltedpianoman@gmail.com>,
        linux-kernel@vger.kernel.org, Julius Werner <jwerner@chromium.org>
Subject: [PATCH 3/3] checkpatch: Ignore labels when checking indentation
Date:   Thu, 25 Mar 2021 20:50:35 -0700
Message-Id: <20210326035035.3057800-4-jwerner@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210326035035.3057800-1-jwerner@chromium.org>
References: <20210326035035.3057800-1-jwerner@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Goto labels are commonly written in the leftmost column (sometimes with
one space in front), regardless of indentation level. Sometimes they're
on a line of their own, but sometimes the same line is shared with a
normal code statement that then starts at the expected indentation
level. When checking indentation, we should check where that normal
piece of code starts, not where the label starts (there's a separate
INDENTED_LABEL test to check the label itself). Therefore, the
line_stats() function that is used to get indentation level should treat
goto labels like whitespace. The SUSPICIOUS_CODE_INDENT test also needs
to explicitly ignore labels to make sure it doesn't get confused by
them.

Signed-off-by: Julius Werner <jwerner@chromium.org>
---
 scripts/checkpatch.pl | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c1dfc0107be41d..d89367a59e7d37 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1396,8 +1396,12 @@ sub copy_spacing {
 sub line_stats {
 	my ($line) = @_;
 
-	# Drop the diff line leader and expand tabs
+	# Drop the diff line leader
 	$line =~ s/^.//;
+
+	# Treat labels like whitespace when counting indentation
+	$line =~ s/^( ?$Ident:)/" " x length($1)/e;
+
 	$line = expand_tabs($line);
 
 	# Pick the indent from the front of the line.
@@ -4197,6 +4201,9 @@ sub process {
 			# Remove any comments
 			$s_next =~ s/$;//g;
 
+			# Remove any leading labels
+			$s_next =~ s/\n( ?$Ident:)/"\n" . " " x length($1)/eg;
+
 			# Skip this check for in case next statement starts with 'else'
 			if ($s_next !~ /\s*\belse\b/) {
 
-- 
2.29.2

