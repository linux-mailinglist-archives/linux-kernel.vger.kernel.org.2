Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4013B4C3A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 05:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhFZDmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 23:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhFZDmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 23:42:49 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818A4C061767
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 20:40:26 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id v11-20020a4a8c4b0000b029024be8350c45so3044978ooj.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 20:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ft2AGISmFijRU2s6dyrdyNujtRf0ZxLLsUvCm77iUq8=;
        b=gHN2JJ9ZJwvZX105RAY1pxBmw7110rPvV0mh+q7GAwrCORyYfbVpzwwSi1j9ErG3ap
         3l0C4AeC2qp5I9RjGujQyYtJOVZ4Y4i13G4zhpfus/Yh6gZAfESAKuXgewAmwjBAMTe1
         540xRpMep3JPpKrlPdwldYFhDp/I9dDrMXE9erE5PG1Ti0ZVyCmTrghdEbOET/bbWEpo
         9LxCtN98mdf+SK90XtvY06EFNZ7xOfPVV0nW0uNSILO0tE6GR8kjI1kyRAO50nP8wu8+
         DVt83Cb+LWkRyYetNiR0zKMEEEEwLbtFpDfppc4RNGus46ctjVHxCa8w6WSiU4tM6qwd
         I49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ft2AGISmFijRU2s6dyrdyNujtRf0ZxLLsUvCm77iUq8=;
        b=tpfuQY7SHcjIhG/GOQUwpDSXlK73jD102y7OhWyzY+qs/jsO4ck0f6dqTlC2SiOo6C
         BVkdz9ong7quDgWm/62flBnE0bXNwxiUGAktk4yl6i3h1egeqISqrAn9Abudk8pzqT5l
         VqrcgR/1RxOpTNRPn7N8QQIf0ENyoGte46Z0fSe/BzNyKxDBXA943Hq+gzazu4f+K26t
         soMGUJ4Z38SGUKcL0bmmPQJiUCOyz5AQlYVm3tbjGwMSynzg6rfKCAwldNOIcu8un0Fr
         IyTqvp1AV2n384OVNDGZIl/0Y9R9qafSf4iUm+EKbzM58/CbVCLzcvBYdo+m2WdSyit9
         zXUQ==
X-Gm-Message-State: AOAM530bZR2I884EKCSMiOJcicB7wJk0pY8Sm0VtmHCyz8ZbcVpMxV6g
        4gutl5xhJEyGv/KsNsJD1ng=
X-Google-Smtp-Source: ABdhPJzqmfdORTXuCj7uPCG9TF1VesE8Jzuh4KG17K13SdlX37yy5ncOzM37n7474QvBQsW6VvxO3Q==
X-Received: by 2002:a4a:88c2:: with SMTP id q2mr9570051ooh.73.1624678825863;
        Fri, 25 Jun 2021 20:40:25 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id k26sm1174817ook.0.2021.06.25.20.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 20:40:25 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     joe@perches.com, linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 1/3] checkpatch: skip spacing tests on linker scripts
Date:   Fri, 25 Jun 2021 21:40:14 -0600
Message-Id: <20210626034016.170306-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210626034016.170306-1-jim.cromie@gmail.com>
References: <20210626034016.170306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before issuing a WARNING on spacing, exclude reports on linker
scripts, which don't comport to C style rules.  skip_on_filename()
skips on *.lds.h files, I think covering all cases.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 scripts/checkpatch.pl | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 23697a6b1eaa..4fe9fab20009 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2546,6 +2546,11 @@ sub get_raw_comment {
 	return $comment;
 }
 
+sub skip_on_filename {
+	my $fname = shift;
+	return $fname =~ m@\.lds\.h$@;
+}
+
 sub exclude_global_initialisers {
 	my ($realfile) = @_;
 
@@ -5134,7 +5139,8 @@ sub process {
 							}
 						}
 					} elsif ($ctx =~ /Wx[^WCE]|[^WCE]xW/) {
-						if (ERROR("SPACING",
+						if (!skip_on_filename($realfile) &&
+						    ERROR("SPACING",
 							  "need consistent spacing around '$op' $at\n" . $hereptr)) {
 							$good = rtrim($fix_elements[$n]) . " " . trim($fix_elements[$n + 1]) . " ";
 							if (defined $fix_elements[$n + 2]) {
-- 
2.31.1

