Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4F83924D2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 04:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbhE0C2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 22:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbhE0C2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 22:28:15 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29586C061763
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 19:26:39 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e22so2546850pgv.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 19:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U30t9Nm2G0eqMQgE3ZWtWT4YeFpQiFN7o0XTFNY0j24=;
        b=B+Kg4te2CVHjLKux/ZgeRlLMBdgTTBr8kI6z7nApn6xLs6Uq1GCgdHuQyqbFyMY8aJ
         XRYRxe/bIy4aKc+CWSLRfpXP+ti0ut4lWVYj8IXSZ4hCHiqM6w4ndovRMyfxOBuhxt70
         /+1n5ocEfsJ30G6yUaUNrtHc2FCtRXTHlzdcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U30t9Nm2G0eqMQgE3ZWtWT4YeFpQiFN7o0XTFNY0j24=;
        b=KpGDCh3kxjfBeGReLdXpaYt24Lr5ZmizBqcN3gBp8xBz2Gx0CL+59SAnIfHJ0GtJXG
         uaZqd+JpxS2kFihLsIdm3f/x3mhH/G5fUQopRTovqEda7BWgiI+lX+qSiciXkBfajVQJ
         mi8hOTBje8dtGGWyzHkktYiTdB+Yd5OQ0NcS+Cw9OkaKI/bK0AxkkZ2UYnaemQItq155
         ZBv6+w+eUcum493V8y3eC0kHlcV7j9QCcBZ2u7HpVf1IZkFNwquDsBUz7qFFYPnsvl5k
         LxysjyzGXvanXMHZEkdUFhHAl96yfhZeBoKsb8NFhiuU0oOCw4elYBVQYBfNy7G3si47
         yXCg==
X-Gm-Message-State: AOAM530X/GclwR+atH/Yhas2soW7wlPJAZtNws0kqMtvRdpYjnPh/deN
        3sFWyyryw4jgs37I7xsa8m0itw==
X-Google-Smtp-Source: ABdhPJzJqepglBM474AHyR28bknOoIkK2pZtmD8Ce1bNlOpgqGondAw0hV8aLUyBvvPQeUWoW0iAyg==
X-Received: by 2002:a63:5c5e:: with SMTP id n30mr1509290pgm.87.1622082398713;
        Wed, 26 May 2021 19:26:38 -0700 (PDT)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:202:201:9021:eef6:e19b:9dd])
        by smtp.gmail.com with ESMTPSA id gj21sm470703pjb.49.2021.05.26.19.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 19:26:38 -0700 (PDT)
From:   Julius Werner <jwerner@chromium.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        Ivo Sieben <meltedpianoman@gmail.com>,
        Julius Werner <jwerner@chromium.org>
Subject: [PATCH v2 2/3] Suspicious indentation detection after conditional statement
Date:   Wed, 26 May 2021 19:26:23 -0700
Message-Id: <20210527022624.1034423-3-jwerner@chromium.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
In-Reply-To: <20210527022624.1034423-1-jwerner@chromium.org>
References: <20210527022624.1034423-1-jwerner@chromium.org>
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
jwerner: Simplified some search patterns
Signed-off-by: Julius Werner <jwerner@chromium.org>
---
 scripts/checkpatch.pl | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4aab2450ad629e..624a23c05f5388 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4183,6 +4183,47 @@ sub process {
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
+			$s_next =~ s/\n./\n/g;
+
+			# Remove any comments
+			$s_next =~ s/$;//g;
+
+			# Skip this check for in case next statement starts with 'else'
+			if ($s_next !~ /\belse\b/) {
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

