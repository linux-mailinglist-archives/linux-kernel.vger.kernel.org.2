Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDC43BDFB3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 01:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhGFXTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 19:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhGFXTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 19:19:34 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A17C061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 16:16:54 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id p9so400449pjl.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 16:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=JuZ8SoMGBhzolM/moZAT3v/oIjhe46Yu+vxjZZGSd8E=;
        b=eHDKSA9h483+9+D2Rj3HstdAHa4Fb4/ztLHNDgt8wL/nXfbElK7Jw0uIVGMSTuB28d
         BLevvBoJilonzHlzgqruR6qiQzOfX1z/DcISu5SpUHhfTVWJYRM5hmihmsBCOnCPD0kx
         CsvUon4nmFre4PL5hmn4RG9uBvqrABOv2rfZLDZ0orsKli+AZ54bqnL4ZiRjl6qx9Ly3
         IDv0o2UWoFMNi4FcGrImqsNpyLZQ2T8s89SNYbiEaf5sxOdapKNQYH0JMsScPxh1SQEZ
         mHNdBZlLHydvAtCbqF0ggAat12OBZ2NSuzP/E2FPDj39CIu7bQVvc2hQTwuARVNeBGFc
         7D4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=JuZ8SoMGBhzolM/moZAT3v/oIjhe46Yu+vxjZZGSd8E=;
        b=bC0i6x+AitxKXFj7bymmXRvbpYgupKoKaKu3gLkxYRZddsGE/G5Qn5aPFGkf2ma0Ou
         tozGxbvCYvOzqtBONg1gAwy/1bD0B8ahNnkh3u05Q4PH6jE4UbAgJ1tIXekspQf+GDGF
         153p64pT7vMH7QescAzdi0/qvoi9AG//1MsaCcxfIa3LY9i5Q2KLokd7Tjhq7HWscY0w
         4uFSzv/tUq9gUcAUw/d9h5T6yZPe5F4C6mJF2JMmHD947VFiztlyul0Q0wtTr1+lASoG
         wFmfqnSGaJZCYHnZJbCqH71YctkFPkq3ij7eU1ZYG/V0LnzMJ6L/d+/xuT1ykYObSF9R
         k4aw==
X-Gm-Message-State: AOAM531ekXFV+32BT+Vtp1Rk3fUNskL6nWVeT+vNDo5KxMrvOA5JYHrk
        DvcidCDZ+dAh6F/Z3IEpG0PI0Q==
X-Google-Smtp-Source: ABdhPJz7fhU217bNKlcFahqT0eWIXW292QSD6CIanyP7YHcaZtiswKt2wSy+wA8KsMXXmEX8gTHNJA==
X-Received: by 2002:a17:90a:510b:: with SMTP id t11mr2762778pjh.178.1625613414159;
        Tue, 06 Jul 2021 16:16:54 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id lm21sm4039846pjb.8.2021.07.06.16.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 16:16:53 -0700 (PDT)
Subject: [PATCH] checkpatch: Don't show signatures in git-log
Date:   Tue,  6 Jul 2021 15:30:29 -0700
Message-Id: <20210706223029.2377293-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

I have git-log setup to show signatures.  I've recently noticed this
breaking checkpatch error messages, which show something like

    ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit gpg: Signatu (":05 PM PDT")'
    #8:
    the module region by 3a02764c372c ("riscv: Ensure BPF_JIT_REGION_START

instead of something more helpful, like

    ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 3a02764c372c ("riscv: Ensure BPF_JIT_REGION_START aligned with PMD size")'
    #8:
    the module region by 3a02764c372c ("riscv: Ensure BPF_JIT_REGION_START

which shows up with this patch.  I'm not sure if these just started
showing up for if I just noticed them or if they've been around forever.

I've only found it necessary to add --no-show-signature to the git-log
invocation in git_commit_info(), but a cursory glance indicates that the
other two invocations may suffer from similar problems so I've just
added it everywhere.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 scripts/checkpatch.pl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 461d4221e4a4..4df508b4915d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1103,7 +1103,7 @@ sub seed_camelcase_includes {
 	$camelcase_seeded = 1;
 
 	if (-e "$gitroot") {
-		my $git_last_include_commit = `${git_command} log --no-merges --pretty=format:"%h%n" -1 -- include`;
+		my $git_last_include_commit = `${git_command} log --no-show-signature --no-merges --pretty=format:"%h%n" -1 -- include`;
 		chomp $git_last_include_commit;
 		$camelcase_cache = ".checkpatch-camelcase.git.$git_last_include_commit";
 	} else {
@@ -1165,7 +1165,7 @@ sub git_commit_info {
 
 	return ($id, $desc) if ((which("git") eq "") || !(-e "$gitroot"));
 
-	my $output = `${git_command} log --no-color --format='%H %s' -1 $commit 2>&1`;
+	my $output = `${git_command} log --no-color --no-show-signature --format='%H %s' -1 $commit 2>&1`;
 	$output =~ s/^\s*//gm;
 	my @lines = split("\n", $output);
 
@@ -1215,7 +1215,7 @@ if ($git) {
 		} else {
 			$git_range = "-1 $commit_expr";
 		}
-		my $lines = `${git_command} log --no-color --no-merges --pretty=format:'%H %s' $git_range`;
+		my $lines = `${git_command} log --no-show-signature --no-color --no-merges --pretty=format:'%H %s' $git_range`;
 		foreach my $line (split(/\n/, $lines)) {
 			$line =~ /^([0-9a-fA-F]{40,40}) (.*)$/;
 			next if (!defined($1) || !defined($2));
-- 
2.32.0.93.g670b81a890-goog

