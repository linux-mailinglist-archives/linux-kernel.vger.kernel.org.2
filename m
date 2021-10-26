Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E64843BDB5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 01:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240226AbhJZXTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 19:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240214AbhJZXTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 19:19:15 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735AFC061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 16:16:50 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id h11so1560294ljk.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 16:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a6gYg/L6HNljWV7ztbgtErIsUDjL4vvotoGwopXV/dc=;
        b=QOaXM4yTxqbRwoCEUYWgesu0tqS/vkbRxK9hipLoMGdUi8qxpQWSOoENZR2ZZc+HvJ
         7dzfBzDoyfA0bG2RFbYrF5ZDPJwGIQRy9RFotEQCs+qsNNrs/Uw3HDag45ChWD2TdFRC
         df1Ptd1WLYzOSk3rz/HVLkRoRDi1+P9qQJRS0Wtq28JyhyToRHtXpfBvsQkC1ID872cv
         PiIet2VGzEmhwwuIxtL3/VRjeB95a6bdF+zIXpUeS4jAnSVZOeFHZxqvGw1l5U6wcIo7
         uM74/u4IGiFUe13f+E70roE0OoOxtGzHdg9UiQ9+PCQgOtkdt2x2Ih2KZAqciG7RoGUG
         FnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a6gYg/L6HNljWV7ztbgtErIsUDjL4vvotoGwopXV/dc=;
        b=hYGrEFlDVhztqNm0Yza1svE1DBWoj2Cc4f1e6mLCChznvO8f9pnCW9zl0iSOseMCgj
         YENXFIFimEh87rStHqBz1qzqa3UacIlBNEySP3VBF6OpBXj2kmuKdD/3Y9kAuSD3c1i8
         A+TM03nCmxRyOxCyWhAzu5ly/LeQHfO+rIR6oafvmH6aK58/xB8m+jDtLMoM7gA6NILv
         w8Z+Wx1788qRMOALEcprbtTFqSzTh+KkoMakOB6T1egKZulOBmNnF6IZa8lmuTnzo9zc
         JyE/6yCwfxQk4IVHfMp75eCK0YbIFHvb74m2z3o+kOOk9k55Wxh0s09tTHDtI8YYXPMw
         jXRA==
X-Gm-Message-State: AOAM533kupPXBq0Lb1qAYQMCejPmBrNasiMwcHHybSzMCJ5Xaf9c2wJ9
        lF5BCF1aZMIC+oIQIWvtvGIen254uFcqqw==
X-Google-Smtp-Source: ABdhPJyDblFTuryWLS3iucovhk6KFAMypJB98GedC/QxLhKNjVNHv+vH2CKrCuHiG564LeXsNzCrzw==
X-Received: by 2002:a2e:9ca:: with SMTP id 193mr4557281ljj.83.1635290208768;
        Tue, 26 Oct 2021 16:16:48 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id y5sm2132178ljy.38.2021.10.26.16.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 16:16:48 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     apw@canonical.com, joe@perches.com
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev
Subject: [PATCH] checkpatch: Remove cvs keyword check
Date:   Wed, 27 Oct 2021 02:16:37 +0300
Message-Id: <20211026231637.3750-1-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Time has pass and we do not need these anymore as almost all people are
using git now days. Those who use cvs for kernel development probably
will handle cvs pretty well already so this check is not needed anymore.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---

If someona nack about this can you also help howto fix false alarms in
fs/ntfs3/ by this cvs check. We need to use $Log in comments as it is
real name. I'm also triccered to see these false alarms. I'm not
familier with perl regex syntax and do not really understand what we
are trying to do here. Maybe also because I do not know CVS very well.

I can do patch or someone else can do it. I just want this "problem"
away as it has been sitting my todo list too long.

---
 Documentation/dev-tools/checkpatch.rst | 5 -----
 scripts/checkpatch.pl                  | 6 ------
 2 files changed, 11 deletions(-)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index f0956e9ea2d8..08e53ec02f48 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -1105,11 +1105,6 @@ Others
     The patch seems to be corrupted or lines are wrapped.
     Please regenerate the patch file before sending it to the maintainer.
 
-  **CVS_KEYWORD**
-    Since linux moved to git, the CVS markers are no longer used.
-    So, CVS style keywords ($Id$, $Revision$, $Log$) should not be
-    added.
-
   **DEFAULT_NO_BREAK**
     switch default case is sometimes written as "default:;".  This can
     cause new cases added below default to be defective.
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 461d4221e4a4..6d65b748ac20 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4017,12 +4017,6 @@ sub process {
 			}
 		}
 
-# check for RCS/CVS revision markers
-		if ($rawline =~ /^\+.*\$(Revision|Log|Id)(?:\$|)/) {
-			WARN("CVS_KEYWORD",
-			     "CVS style keyword markers, these will _not_ be updated\n". $herecurr);
-		}
-
 # check for old HOTPLUG __dev<foo> section markings
 		if ($line =~ /\b(__dev(init|exit)(data|const|))\b/) {
 			WARN("HOTPLUG_SECTION",
-- 
2.25.1

