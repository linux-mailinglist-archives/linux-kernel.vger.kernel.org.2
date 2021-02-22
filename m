Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31509321C65
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 17:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhBVQHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 11:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbhBVQFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 11:05:09 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848B8C061793;
        Mon, 22 Feb 2021 08:03:55 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id kr16so8875351pjb.2;
        Mon, 22 Feb 2021 08:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=g/df7huNH6MfWEYwBa1KL4hvVPRnxd7sYN0b7qrS+Eo=;
        b=YP9xzY8apNP3InqG+PM1WTiqx1/NMTiW4Hjvdj2gSAg9FlQ8zEwFWKnqERvnc5D267
         eB3iLEJYcvnfae/4iFq6m9bZpvBfg2nFHXDZzIGNkWp7nFxrZm66AJVldpKP/Rn2G+CF
         z5nbRNt/5Sh6XRXpq56MxX0Vnl5/6+v5S5QBL7k3kWamaW8TcDRxcwU2n3QJmFkMFwiM
         3XE+nR2lW9wTN6306HphrG78dAExYFAv8nzY3GkeyBLVuem0Fahpzn/ryDcQmb/Vdo8+
         uDhGPvIf6hTom85/o7UMA4EFIdoYLupLV0yyPA97EShNNOm7iOqOxNWG0FLj1PRmGYyw
         aSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g/df7huNH6MfWEYwBa1KL4hvVPRnxd7sYN0b7qrS+Eo=;
        b=IK2a90YIlEMI7Xsi9iRKjgjgY9wB5kSFmd4PgdVKtb2EngntE6Q+ZuV0z7xOv8snys
         3yu6v1pl5UeDusWP2FYINZeoBk7T5cJrx7P3WkCvaIJjDsBpYucVj32Vimt5uHHEjwNS
         n4L/DVuAU+/lLKrEcRs5CDQfp2hsKn+5fEOsh8atM1st73ahO9SwqIJ6uhI4zzs6ZAJ5
         u0DJYkfYx8zdkUCZMqaol7ZzOoDO0/WpSvDD9MxvB0x3tKZt9NdVpi2wpG0YCV6leUp/
         Csur2ow4TJQWEnczZbjb3dx9OHV4oX4mHWQqn+pkABWtg82fRktSE2DA+ku5YrgQRb39
         q4FA==
X-Gm-Message-State: AOAM530C6LThdc8MHsOUOjxdFQsa8LIvyqVySiC9LUBtwLftt2I96uaA
        mGX0yw9aMo7gGH6qru48e9I=
X-Google-Smtp-Source: ABdhPJwVZA8/60TITCfjuud2smvskuBah0kv6QccJazhIC+JGnxqinDyG7ls9VFb59+lMsi/UtNr/A==
X-Received: by 2002:a17:902:6949:b029:e3:1ee9:6bfd with SMTP id k9-20020a1709026949b02900e31ee96bfdmr23241817plt.66.1614009835024;
        Mon, 22 Feb 2021 08:03:55 -0800 (PST)
Received: from localhost.localdomain ([2405:201:600d:a089:d92b:2fcb:b6a3:bcc0])
        by smtp.googlemail.com with ESMTPSA id s18sm18541728pjr.14.2021.02.22.08.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 08:03:54 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     corbet@lwn.net
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [RFC] scripts: kernel-doc: fix typedef support for struct parsing
Date:   Mon, 22 Feb 2021 21:33:47 +0530
Message-Id: <20210222160347.23410-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are files in kernel, which use 'typedef struct' syntax for defining
struct. For eg, include/linux/zstd.h, drivers/scsi/megaraid/mega_common.h,
etc.
However, kernel-doc still does not support it, causing a parsing error.

For eg, running scripts/kernel-doc -none on include/linux/zstd.h emits:
"error: Cannot parse struct or union!"

Add support for parsing it.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
 scripts/kernel-doc | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 8b5bc7bf4bb8..46e904dc3f87 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1201,12 +1201,20 @@ sub dump_union($$) {
 sub dump_struct($$) {
     my $x = shift;
     my $file = shift;
+    my $decl_type;
+    my $members;
 
     if ($x =~ /(struct|union)\s+(\w+)\s*\{(.*)\}(\s*(__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)))*/) {
-	my $decl_type = $1;
+	$decl_type = $1;
 	$declaration_name = $2;
-	my $members = $3;
+	$members = $3;
+    } elsif ($x =~ /typedef\s+(struct|union)\s*\{(.*)\}(?:\s*(?:__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)))*\s*(\w*)\s*;/) {
+	$decl_type = $1;
+	$declaration_name = $3;
+	$members = $2;
+    }
 
+    if ($members) {
 	if ($identifier ne $declaration_name) {
 	    print STDERR "${file}:$.: warning: expecting prototype for $decl_type $identifier. Prototype was for $decl_type $declaration_name instead\n";
 	    return;
-- 
2.17.1

