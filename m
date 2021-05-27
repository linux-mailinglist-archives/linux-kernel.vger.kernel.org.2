Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C5B3924D1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 04:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbhE0C2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 22:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbhE0C2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 22:28:12 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48D1C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 19:26:39 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 29so2548546pgu.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 19:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JpTW2yg1Z5OhfyFhok8ov6y6DJLaEQAE9Hi7jUiRv6I=;
        b=USpXUNslxNLCtunXjHfcvt9hHgp/8UcrlwAL7KUO34alPDZRbf5gl2X466jnO4Cmdk
         hcUzdoGobTLA3aVGFPvBQvYHsk5iNqw3XYsUnGbxGYotdiWiKxneCG32cLdJ6HRmz1uy
         RQSxltGpX1jm88PPbKyg6qGva2OfQkl/5jgB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JpTW2yg1Z5OhfyFhok8ov6y6DJLaEQAE9Hi7jUiRv6I=;
        b=tZS4RnKIQIMe7HQySjAZq9LNU82HJfQb7X4bDswEZj4l/YMYde+ROcj9wT0B7L6skM
         PlW1M4vsldG4PJYJbHZa13/vdl0TBecmfwRZNYtEYkoiYzcqSV/wKUgmRfTEtfnwRmYZ
         vl/VWlFDeHFkDVmjzbD7SyYeysktcXBejGf7dUMOjSkL86sDcwPDOl25O2aWhJWg9O9J
         fkdrjq7GB2Il/jhFftxVifXxkcVOcJQk6w/4bQ2NgzQvfRfyAVjdLz7r7puae9/CiGA7
         MLgkQ/874ZdaL2mHfP0fCQ1WxRQYrLY2niwnfkSYbfRNY7LWVYJ5po0UWLwXe9FPDpwZ
         cDYg==
X-Gm-Message-State: AOAM531avLJK871rNPDlZMOrM88Y85pV35cbo1ZwaIpWieKJH14Y/tBF
        iR/0XIsshzp8bFPA0lTr1ce7Qw==
X-Google-Smtp-Source: ABdhPJwc71sVBemOhZgV9etCEQR5LcwOkUBRIhDBTqmxrZ2difKG0dv/uuwhzwkz6jvyQNc1cWU1Yw==
X-Received: by 2002:a63:4760:: with SMTP id w32mr1514894pgk.383.1622082399429;
        Wed, 26 May 2021 19:26:39 -0700 (PDT)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:202:201:9021:eef6:e19b:9dd])
        by smtp.gmail.com with ESMTPSA id gj21sm470703pjb.49.2021.05.26.19.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 19:26:39 -0700 (PDT)
From:   Julius Werner <jwerner@chromium.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Julius Werner <jwerner@chromium.org>
Subject: [PATCH v2 3/3] checkpatch: Ignore labels when checking indentation
Date:   Wed, 26 May 2021 19:26:24 -0700
Message-Id: <20210527022624.1034423-4-jwerner@chromium.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
In-Reply-To: <20210527022624.1034423-1-jwerner@chromium.org>
References: <20210527022624.1034423-1-jwerner@chromium.org>
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
index 624a23c05f5388..6fd16111b52cc6 100755
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
@@ -4195,6 +4199,9 @@ sub process {
 			# Remove any comments
 			$s_next =~ s/$;//g;
 
+			# Remove any leading labels
+			$s_next =~ s/\n( ?$Ident:)/"\n" . " " x length($1)/eg;
+
 			# Skip this check for in case next statement starts with 'else'
 			if ($s_next !~ /\belse\b/) {
 
-- 
2.29.2

