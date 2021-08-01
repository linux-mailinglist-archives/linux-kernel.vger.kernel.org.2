Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8E23DCE0A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 01:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhHAXHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 19:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhHAXHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 19:07:53 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA43C0613D3
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 16:07:43 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 19-20020a9d08930000b02904b98d90c82cso15882961otf.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 16:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cDRPsZdmId6F01UxjjBGm1uG3CxOif2upjzXx/3U3ww=;
        b=k2b/2Sgb7mVJi7LQSgOeFmEN/NmmJboSSUY2hk0GROnpGtuITWvHzNQLpC2nFfahh0
         SlI/DtVfxKKkcAl1qxzwh5Axmg4O1B1GJXu6kY/e9N2WbEi/WGv5BppUotTqx8zgAYot
         f3Ocqm/K3OYAf5uXrO9fRkLxgjqOQXl46bDmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cDRPsZdmId6F01UxjjBGm1uG3CxOif2upjzXx/3U3ww=;
        b=ulFv6VSkNZG5FB4CfUOgKJW4YtRRVA/wio1eaqoXz4+UnPPj2WGNWi53zPIJIeOwSk
         Bmx+5ZSk00bWhxgMIF/f4+M5H0CylOYtHR+cE7ukwcFeMUFXZqgQiEuP4qXbV9knGi7G
         psdX1wDCsYAnD2O25aI0Wl1kkLheitOC6QjTOtrDRAC5jE8HKn3rrcKllFh/cUFkh3HE
         CHB8xpW3BWdfDQ8ysan416/rPWdLAEWaAMdD6vLInnxKzv+LJ1caLDrl0qtgFZ+HszFH
         ophQ1lWVt2WjiJP7jeOWrQ342fb8sUoKT/nurTUSY+rre1zB0KlJ+Pz3gPdkxnPueDMd
         RPUA==
X-Gm-Message-State: AOAM533ONWKbNjGt5PRKlTBXHBb3uRdEzQb3sCE5mPuw2KrsgQl/0E1n
        eFfss5JPwXWwg6tXcFvkEOTjVP+Bv77/8S3G
X-Google-Smtp-Source: ABdhPJzD7gQGw9zWwb1JFtM9144yZPAopebawAatoawHDQtxpbVuKcAtVYvjzVQNxOZCXkg6WeSphg==
X-Received: by 2002:a05:6830:33c9:: with SMTP id q9mr4499944ott.170.1627859262128;
        Sun, 01 Aug 2021 16:07:42 -0700 (PDT)
Received: from kiwi.bld.corp.google.com (c-67-190-101-114.hsd1.co.comcast.net. [67.190.101.114])
        by smtp.gmail.com with ESMTPSA id l1sm1624953otd.30.2021.08.01.16.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 16:07:41 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Joe Perches <joe@perches.com>, Simon Glass <sjg@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] checkpatch: Support wide strings
Date:   Sun,  1 Aug 2021 17:07:35 -0600
Message-Id: <20210801170733.1.I3f9784fd3c1007d08ec2e70b151d137687575495@changeid>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>

Allow prefixing typical strings with L for wide strings and u for
unicode strings.

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

 scripts/checkpatch.pl | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 461d4221e4a4a1..a65753c05a6936 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -501,7 +501,7 @@ our $Binary	= qr{(?i)0b[01]+$Int_type?};
 our $Hex	= qr{(?i)0x[0-9a-f]+$Int_type?};
 our $Int	= qr{[0-9]+$Int_type?};
 our $Octal	= qr{0[0-7]+$Int_type?};
-our $String	= qr{"[X\t]*"};
+our $String	= qr{(?:\b[Lu])?"[X\t]*"};
 our $Float_hex	= qr{(?i)0x[0-9a-f]+p-?[0-9]+[fl]?};
 our $Float_dec	= qr{(?i)(?:[0-9]+\.[0-9]*|[0-9]*\.[0-9]+)(?:e-?[0-9]+)?[fl]?};
 our $Float_int	= qr{(?i)[0-9]+e-?[0-9]+[fl]?};
@@ -6132,7 +6132,8 @@ sub process {
 		}
 
 # concatenated string without spaces between elements
-		if ($line =~ /$String[A-Za-z0-9_]/ || $line =~ /[A-Za-z0-9_]$String/) {
+		if ($line =~ /$String[A-Z_]/ ||
+		    ($line =~ /([A-Za-z0-9_]+)$String/ && $1 !~ /^[Lu]$/)) {
 			if (CHK("CONCATENATED_STRING",
 				"Concatenated strings should use spaces between elements\n" . $herecurr) &&
 			    $fix) {
@@ -6145,7 +6146,7 @@ sub process {
 		}
 
 # uncoalesced string fragments
-		if ($line =~ /$String\s*"/) {
+		if ($line =~ /$String\s*[Lu]?"/) {
 			if (WARN("STRING_FRAGMENTS",
 				 "Consecutive strings are generally better as a single string\n" . $herecurr) &&
 			    $fix) {
-- 
2.32.0.554.ge1b32706d8-goog

