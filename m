Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7AD34A05E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 04:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhCZDvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 23:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhCZDvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 23:51:03 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C53C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 20:51:03 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id ay2so265119plb.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 20:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ArvyZNkA4X6QBbWp3l8eai7BeYdl1nKDCZ6CEoX3V4A=;
        b=bmRm8dTvuD0l9u/aEwYbtqAJhwHE5Nrp1VFn2hGsl1ZMJh/h9JTF9SVDk3/624tWyV
         zmQHPUHwGujTAsiG5vvCrSVHeMsAw8ps0GjABEPet4Jd9SYx3S8o5WEboYje9h5FCEd8
         Brzzf/vfP0NJlGDQlx2omqdDXqiKRKhwaKgMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ArvyZNkA4X6QBbWp3l8eai7BeYdl1nKDCZ6CEoX3V4A=;
        b=f/KANz6yq3WmYO/hTflX1Jy4zB/uspXCf4Vcr40i0dPKR2QW4QH4hRg6Ld+ceEqN9g
         N2E4XKm9eb2l5yxqhbXkpBu30+bL1LWdUJy8vRANSQtlPDM3g4y8WWkZ41uek/cPt26c
         1P+Xfz8E7Gl7PpkbcZxIfTi9FzDqFK/KQxzZQZsTgfqxMNxIjL60/CRSC4anltn0QIZ7
         P6sY3fryq+lIp8vqv/7kWH+1rDR4JQ7LyY0S4bzNPUTNqfjJOaPRXXS5CO0/Yl9cChMq
         CgDbjoH+BVXnx6WqSthL16XRbmcBq8CICQo2lyOCQHzD90P/w0IMLQHvjci4Bk7BtvXp
         Fdxw==
X-Gm-Message-State: AOAM530mrgpWm2KaOj552zenVO2tkfKBwoQjgm0Y+oMxeaZ5XcszoE2q
        TSzIsUSnrSXo50yhBxN7EvFGpTtu4lYCkg==
X-Google-Smtp-Source: ABdhPJwdzbmSmxPfI43S/eXyTXHe760CuisElnd02YTUP+H3yscb90sNK9xT5dPTJAErCxTNSSC3eA==
X-Received: by 2002:a17:90a:9103:: with SMTP id k3mr12204593pjo.157.1616730662681;
        Thu, 25 Mar 2021 20:51:02 -0700 (PDT)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:202:201:d0b:23e:bf14:3ec9])
        by smtp.gmail.com with ESMTPSA id v11sm7196345pgg.68.2021.03.25.20.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 20:51:02 -0700 (PDT)
From:   Julius Werner <jwerner@chromium.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Ivo Sieben <meltedpianoman@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Suspicious indentation detection after conditional statement
Date:   Thu, 25 Mar 2021 20:50:34 -0700
Message-Id: <20210326035035.3057800-3-jwerner@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210326035035.3057800-1-jwerner@chromium.org>
References: <20210326035035.3057800-1-jwerner@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivo Sieben <meltedpianoman@gmail.com>

Raise a SUSPICIOUS_CODE_INDENT warning when unexpected indentation is found
after a conditional statement. This can be used to find missing braces or
wrong indentation in/after a conditional statement.

For example the following error is caught;

	if (foo)
		bar();
		return;

Which can be either intended by the programmer as:

	if (foo)
		bar();
	return;

or
	if (foo) {
		bar();
		return;
	}

Signed-off-by: Ivo Sieben <meltedpianoman@gmail.com>
---
 scripts/checkpatch.pl | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index ffccbd2033e579..c1dfc0107be41d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4185,6 +4185,47 @@ sub process {
 				WARN("SUSPECT_CODE_INDENT",
 				     "suspect code indent for conditional statements ($indent, $sindent)\n" . $herecurr . "$stat_real\n");
 			}
+
+# Also check if the next statement after the previous condition has the same indent
+			my ($stat_next, undef, $line_nr_next_next) =
+				ctx_statement_block($line_nr_next, $remain_next, $off_next);
+			my $s_next = $stat_next;
+
+			# Remove line prefixes
+			$s_next =~ s/\n./\n/gs;
+
+			# Remove any comments
+			$s_next =~ s/$;//g;
+
+			# Skip this check for in case next statement starts with 'else'
+			if ($s_next !~ /\s*\belse\b/) {
+
+				# Remove while that belongs to a do {} while
+				if ($stat =~ /\bdo\b/) {
+					$s_next =~ s/^.*\bwhile\b\s*($balanced_parens)\s*?//;
+				}
+
+				# Remove blank lines
+				$s_next =~ s/\s*\\?\n//g;
+
+				# Get the real next lines
+				my $next_nof_lines = $line_nr_next_next - $line_nr_next;
+				my $stat_next_real = raw_line($line_nr_next, $next_nof_lines);
+				if (!defined($stat_next_real)) {
+					$stat_next_real = "";
+				} elsif ($next_nof_lines > 1) {
+					$stat_next_real = "[...]\n$stat_next_real";
+				}
+				my (undef, $nindent) = line_stats('+' . $s_next);
+
+				#print "stat_next<$stat_next> stat<$stat> indent<$indent> nindent<$nindent> s_next<$s_next> stat_next_real<$stat_next_real>\n";
+
+				if ($nindent > $indent) {
+					WARN("SUSPICIOUS_CODE_INDENT",
+					     "suspicious code indentation after conditional statements\n" .
+					     $herecurr . "$stat_real\n$stat_next_real\n");
+				}
+			}
 		}
 
 		# Track the 'values' across context and added lines.
-- 
2.29.2

