Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEA63325DA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhCIMxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhCIMxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:53:34 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9725AC06174A;
        Tue,  9 Mar 2021 04:53:34 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so5147102pjv.1;
        Tue, 09 Mar 2021 04:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7ONx2FOzWIgS1h/Pt0rxIhJX/kU2VsrARJ7BsHy15OI=;
        b=As/Wcc+Nm78iyZnkMMtOT6fGyXZyC3DHVFw89k3TlkYga5f+rKBaYOvVgAqJtypnYK
         R21+jzQbgGr4Gd1sk5HPbHfBO5jEGBrjyWxGISauE3fLwWe/ffth+ifVrC4i7ksKR+5v
         gn5t6weqhxEzl+U6Gyt/RwPp+k7CtH4e0FULDaOoZg+GX7ZgCSRSK0DfVz5QEv0MP41I
         icWlvpX9wYZX/4dHRadJ1mLlg2MPdPJQHlub8+NC4EzEkgL5jNFl2p53+aQ6WEKEWRM+
         PjPcnkH/fq7CMSEboVD9kRz0SkBTgeYQbj8pWhvYWki4mTbJND6p0x2aSUltlHSqfVF+
         PkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7ONx2FOzWIgS1h/Pt0rxIhJX/kU2VsrARJ7BsHy15OI=;
        b=KUveYVDDXX8pfB8axPDUimPJJ7aaOYPPiyHqRTu0rZrhWOajeBFP0VpBinpYLKnFfF
         4W4IuPX9avw1H9R/ScZ4Ra1VFj/zsAgoIuGSsZ3cdSvYFfyH2P70E/h69iIIMv6j5WiK
         4EpM7EWraUIZe7UTr7daWsLY/NSUClsqWRLM8S0Nk7vkqInlOkGKqFA25V9BkF8TIgL6
         FNCtQxLNgU4au6wgqs5l9K7V+arOVxZZlG8p01LqlDWIM8dar+OTH+Ku7vfb9PYiycNX
         TA5P+qJDB8E3GWiLvWWMfQN70gQTVmaqOpvt9FBOTp1cttjiPaE3afPyQ3fkqZnmed2c
         gZUw==
X-Gm-Message-State: AOAM532kiO2wkmYkhMjtBquBBERPBfvAR/gR6shy8gFfHSunz4yaBuIX
        edD+TlQb2IeEhLrWzhdI91I=
X-Google-Smtp-Source: ABdhPJyFTdNLtllnen9bXqUvuviYG1ht1aZEMb65CmDxsBfkktSxfZy7nikXYd1iICBRKl1W5xlItw==
X-Received: by 2002:a17:90a:e298:: with SMTP id d24mr4542602pjz.171.1615294414128;
        Tue, 09 Mar 2021 04:53:34 -0800 (PST)
Received: from localhost.localdomain ([2405:201:600d:a089:f1c9:5654:cd78:ceac])
        by smtp.googlemail.com with ESMTPSA id 197sm9192499pgg.53.2021.03.09.04.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 04:53:33 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     corbet@lwn.net
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [RFC] scripts: kernel-doc: avoid warnings due to initial commented lines in file
Date:   Tue,  9 Mar 2021 18:23:24 +0530
Message-Id: <20210309125324.4456-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting commented lines in a file mostly contains comments describing
license, copyright or general information about the file.

E.g., in sound/pci/ctxfi/ctresource.c, initial comment lines describe
its copyright and other related file informations.

But as kernel-doc reads these lines, it results in ineffective warnings by
kernel-doc, related to these.

Provide a simple fix by skipping first three lines in a file for checking
kernel-doc comments.

Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
 scripts/kernel-doc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index e1e562b2e2e7..431add05248e 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -2375,6 +2375,7 @@ sub process_file($) {
     my $file;
     my $initial_section_counter = $section_counter;
     my ($orig_file) = @_;
+    my $lineno = 0;	# to maintain the count of line number in a file
 
     $file = map_filename($orig_file);
 
@@ -2388,13 +2389,16 @@ sub process_file($) {
 
     $section_counter = 0;
     while (<IN_FILE>) {
+	$lineno++;
 	while (s/\\\s*$//) {
 	    $_ .= <IN_FILE>;
+	    $lineno++;
 	}
 	# Replace tabs by spaces
         while ($_ =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {};
 	# Hand this line to the appropriate state handler
-	if ($state == STATE_NORMAL) {
+	if ($state == STATE_NORMAL
+	    && $lineno > 3) {	# to avoid starting comment lines describing the file
 	    process_normal();
 	} elsif ($state == STATE_NAME) {
 	    process_name($file, $_);
-- 
2.17.1

