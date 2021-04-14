Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FBD35FB9F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 21:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbhDNT0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 15:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhDNT0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 15:26:02 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01C8C061574;
        Wed, 14 Apr 2021 12:25:40 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id 20so6747542pll.7;
        Wed, 14 Apr 2021 12:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KpLOFoYfcHiJCEdbxKTdXhAPH70ztnzVmclf6+HcyKc=;
        b=Q2rpGYCZu6fcLua1Gy3C3msvUvuIABOekDOGgskk2jj3PWoMrSQ/wVOESzgeP6FpXP
         w+lzkE2D0nBfdTtaYca32OIUfKpPd2/SAXa7vYogp6T+4X7Njs+oAXrgXRG94TgM/LgN
         hzFa4EvNsw9TZMY8bsHXQ8s0aUO5082L5hjPYjDCw2v90EpSojmcKGuSRE+el+c3MUKF
         kKHIOB3KMTIjP2cr/KwXf2UZjO/lAgq60cfSq11kRn4X6qwhoSUnLC58f06rL29RCpQo
         FjVVAIL9JfP3oXdr8Jm9Hsj8T2P/w02qu1owpqIVIuF2koJwX58wB15mUxGFb8fNoTsk
         C0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KpLOFoYfcHiJCEdbxKTdXhAPH70ztnzVmclf6+HcyKc=;
        b=n5qAtXPw5rlqPS2QtMwPHwuZEMVVwunAxYJfXDIJbApPFe62ZCkmOa0w9eevFdcesd
         kFwyk1g8/xD24i/8kuOX4IlJZtxhYXBZsHayv577RqidMePAYayjldCNG1N45HQCc9XD
         VIj1oPBMJ1t5zc2Zd9e67I/GpisbUjIha8E4/1sdzZ8/12t7jaajzsHrN1+p1vKaQtpx
         jOHDXkExVzTRjjHCwYqfnR66YY3BSGh1b4Rq//hmE7RVXIcJ91W1jIibBLmHsl3+nQXD
         yUUTniDYZ56wQ+s+jXKGE7zjZYNvwy2eM1CbtixbZ6ZkmEtUcX1+vcb+AC/nqyfxv/fZ
         Er0g==
X-Gm-Message-State: AOAM530jr2dN6xkeAhhZ0yu6Q5rmQxWx4bA7Hh49TsaKi6JCxHfhoCTG
        9pzeGrif8lBW8dVJlGiXnbqgsQ7QIiFimw==
X-Google-Smtp-Source: ABdhPJz93KXn1rbP+KYjOKNWk+IK6exmdiFZYY5gf+skoogwzYMgSlMGcsdXvXs4SEjivvX24nDuOw==
X-Received: by 2002:a17:90b:302:: with SMTP id ay2mr5216317pjb.84.1618428339999;
        Wed, 14 Apr 2021 12:25:39 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a089:d8d9:c36b:b907:6d78])
        by smtp.googlemail.com with ESMTPSA id d26sm188652pfo.162.2021.04.14.12.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 12:25:39 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     corbet@lwn.net
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] scripts: kernel-doc: improve parsing for kernel-doc comments syntax
Date:   Thu, 15 Apr 2021 00:55:29 +0530
Message-Id: <20210414192529.9080-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kernel-doc does not identify some cases of probable kernel
doc comments, for e.g. pointer used as declaration type for identifier,
space separated identifier, etc.

Some example of these cases in files can be:
i)" *  journal_t * jbd2_journal_init_dev() - creates and initialises a journal structure"
in fs/jbd2/journal.c

ii) "*      dget, dget_dlock -      get a reference to a dentry" in
include/linux/dcache.h

iii) "  * DEFINE_SEQLOCK(sl) - Define a statically allocated seqlock_t"
in include/linux/seqlock.h

Also improve identification for non-kerneldoc comments. For e.g.,

i) " *	The following functions allow us to read data using a swap map"
in kernel/power/swap.c does follow the kernel-doc like syntax, but the
content inside does not adheres to the expected format.

Improve parsing by adding support for these probable attempts to write
kernel-doc comment.

Suggested-by: Jonathan Corbet <corbet@lwn.net>
Link: https://lore.kernel.org/lkml/87mtujktl2.fsf@meer.lwn.net
Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
 scripts/kernel-doc | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 888913528185..37665aa41e6b 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -2110,17 +2110,25 @@ sub process_name($$) {
     } elsif (/$doc_decl/o) {
 	$identifier = $1;
 	my $is_kernel_comment = 0;
-	if (/^\s*\*\s*([\w\s]+?)(\(\))?\s*([-:].*)?$/) {
+	my $decl_start = qr{\s*\*};
+	my $fn_type = qr{\w+\s*\*\s*}; # i.e. pointer declaration type, foo * bar() - desc
+	my $parenthesis = qr{\(\w*\)};
+	my $decl_end = qr{[-:].*};
+	if (/^$decl_start\s*([\w\s]+?)$parenthesis?\s*$decl_end?$/) {
 	    $identifier = $1;
-	    $decl_type = 'function';
-	    $identifier =~ s/^define\s+//;
-	    $is_kernel_comment = 1;
 	}
 	if ($identifier =~ m/^(struct|union|enum|typedef)\b\s*(\S*)/) {
 	    $decl_type = $1;
 	    $identifier = $2;
 	    $is_kernel_comment = 1;
 	}
+	elsif (/^$decl_start\s*$fn_type?(\w+)\s*$parenthesis?\s*$decl_end?$/ ||	# i.e. foo()
+	    /^$decl_start\s*$fn_type?(\w+.*)$parenthesis?\s*$decl_end$/) {	# i.e. static void foo() - description; or misspelt identifier
+	    $identifier = $1;
+	    $decl_type = 'function';
+	    $identifier =~ s/^define\s+//;
+	    $is_kernel_comment = 1;
+	}
 	$identifier =~ s/\s+$//;
 
 	$state = STATE_BODY;
-- 
2.17.1

