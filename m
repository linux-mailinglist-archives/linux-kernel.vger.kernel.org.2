Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00DA32F9C2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 12:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhCFLf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 06:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhCFLfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 06:35:21 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAF3C06175F;
        Sat,  6 Mar 2021 03:35:20 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id w34so2091361pga.8;
        Sat, 06 Mar 2021 03:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RFcAptOGUzRFgc1VcA5H4/3lDHhPtSvWgw9OuJoIW28=;
        b=ZvgTalSC71oPlL8WnLg4t8W9jsbTDX2i6R7giAZKzGn89jhZCH6bvptq9X5yzNQS5I
         TqWkQy4xBzy1OqYPpKLPkibJibENFxX0lVx2Z3bBNqQJT6/Cxoo1YJqChS7XXHLYoD1Y
         hAIEuNh9Mniy8UBLnq/dzEFSFRGsZuKkSWTI6xTY74miUVquK7bKEGdjq69axTk/ecyw
         OXwtviL6EtS4ew+my7eiZj7n5tX3sEg6cLFBYdft0RVMHx3jO/htmDoJd07BvIFQCdla
         kFXLUUzIe9kVZjcE3mKs1fqRFOZ+fB/z6yztLuFF/OumKpCvkZU9An0PiPBG1vVRKVHV
         ET0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RFcAptOGUzRFgc1VcA5H4/3lDHhPtSvWgw9OuJoIW28=;
        b=mXHH0GiCM+yk98sQaVFvP7/IPwb5PXMJTOcVIuTLVKEaxmERktK34KwnvTnUgvvGFd
         k+xev7GoazpQMu7+ZmahU8pZgGXCPP8HLbwm2ajGNPeRk4F0FSUT1Sc7gzBN35ZiK9e3
         oKI89U0kKShK5+sOp2AzgXqqCZgbTxvCmNANrVMoTt0ZG3auKkGATN/ERM7QMO/8ldvP
         cYDeum6UoIfWRywNapyMT3mHrariggQgnsmTNGNDQ7BchVh5YGKFWJ8k906GuyAy1ov1
         qBP4It+4RrXbW3TqTJ7jWevnF57cZjWdGRIgRP+vFFb8sjs+6B2UfD3FFKzp6jUIyYH6
         2bDw==
X-Gm-Message-State: AOAM532HYilz3mSAr0Iter4wFx1nI/+dj0oa4agb+lfm7njmKf4duMBm
        wKgL4fGhWIkYsgHI5FsqJIY=
X-Google-Smtp-Source: ABdhPJyVJQxFLZUKLdkwHW2bBFVsEj+2VwFa5BbmcE8NrsH2miLBMn1v3xMmQzBBt4oxhz57odo1ow==
X-Received: by 2002:a63:d618:: with SMTP id q24mr12380661pgg.283.1615030520441;
        Sat, 06 Mar 2021 03:35:20 -0800 (PST)
Received: from localhost.localdomain ([2405:201:600d:a089:2cbb:f743:ffa5:41bc])
        by smtp.googlemail.com with ESMTPSA id n184sm5342980pfd.205.2021.03.06.03.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 03:35:19 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     corbet@lwn.net
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, willy@infradead.org
Subject: [RFC v2] scripts: kernel-doc: fix attribute capture in function parsing
Date:   Sat,  6 Mar 2021 17:05:10 +0530
Message-Id: <20210306113510.31023-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAKXUXMwoYa6xbCsqnUYL5uSA71h_3xV7-8erF6XTpmkck8ozaw@mail.gmail.com>
References: <CAKXUXMwoYa6xbCsqnUYL5uSA71h_3xV7-8erF6XTpmkck8ozaw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kernel-doc warns for function prototype parsing on the
presence of attributes "__attribute_const__" and "__flatten" in the
definition.

There are 166 occurrences in ~70 files in the kernel tree for
"__attribute_const__" and 5 occurrences in 4 files for "__flatten".

Out of 166, there are 3 occurrences in three different files with
"__attribute_const__" and a preceding kernel-doc; and, 1 occurrence in
./mm/percpu.c for "__flatten" with a preceding kernel-doc. All other
occurrences have no preceding kernel-doc.

Add support for  "__attribute_const__" and "__flatten" attributes.

A quick evaluation by running 'kernel-doc -none' on kernel-tree reveals
that no additional warning or error has been added or removed by the fix.

Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
Changes in v2:
- Remove "__attribute_const__" from the $return_type capture regex and add to the substituting ones.
- Add support for "__flatten" attribute
- Modify commit message

 scripts/kernel-doc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 68df17877384..e1e562b2e2e7 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1766,12 +1766,14 @@ sub dump_function($$) {
     $prototype =~ s/^noinline +//;
     $prototype =~ s/__init +//;
     $prototype =~ s/__init_or_module +//;
+    $prototype =~ s/__flatten +//;
     $prototype =~ s/__meminit +//;
     $prototype =~ s/__must_check +//;
     $prototype =~ s/__weak +//;
     $prototype =~ s/__sched +//;
     $prototype =~ s/__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +//;
     my $define = $prototype =~ s/^#\s*define\s+//; #ak added
+    $prototype =~ s/__attribute_const__ +//;
     $prototype =~ s/__attribute__\s*\(\(
             (?:
                  [\w\s]++          # attribute name
-- 
2.17.1

