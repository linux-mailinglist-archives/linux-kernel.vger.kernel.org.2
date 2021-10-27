Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9506C43C826
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 12:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhJ0K7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 06:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239786AbhJ0K7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 06:59:16 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388F1C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 03:56:51 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x192so5201898lff.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 03:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s2N13FmOEYQNpt6BncLBbaLCyj4beMEaWW0ResefSLU=;
        b=QpZeNjrwXoUDv74u/Vt5/yjPKeirdC3bBtjTbxCLXEgpnFL5FB+VvtY34BzU5HyMHe
         hZHDg6g/jeHqhqz6uFKt5DqSegxzFMb2Xh+qgMVzE7IYFf+q15FLmjHv8/nyepgvmKrL
         UCvJBPZlT0/Iiw63lffWsd9vq8O7c402Z0uveQ9IgA7JeGjooiFcfhmZePC2haYszhL4
         Iy0SbilmB2ER3y9LOXsXX+uDFY+p9C+Sev/GARJvcOpepoM2OL+0pE0Z2iS49/C0t03t
         3bD08RzOYP4MPy9OF16Jcd4hUUDJ16LT/775pU2KCCGBtsChv7FtnwRmxEXRDEdPwhbH
         jkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s2N13FmOEYQNpt6BncLBbaLCyj4beMEaWW0ResefSLU=;
        b=x9MkNKtsYiszoZaC8dpH+1uh+CeVTkE4LjOu/1XOK3AONCcUseZBNVrfdKrs9YPxMA
         O/RgGA21l2cLV8tmm5dDWm0iXLDBUr4yLpQ8idwne1HijpeDEgJBA/1twitXcy3dJxta
         63B/Kg6cu1BbGGVnrBzt6wtBGdCJIiZSH/WZSdgd34tjnduMAPWEuKICJkp6+i62yToe
         tgQ0T6AHdXJgGZwj3p882L/d7iIj28OVnfK5b1ORnRmqd9nD6epf8Y0rAsyuzRV+6nQX
         ZoMNr+BRN80MQHciAuX/lhw32mMEi1Y2neLCyJp/LEafP04SHm3Tk+RjH0ow1qqJEdak
         t6BQ==
X-Gm-Message-State: AOAM533P4pDx+juIn/0T8MEtHgEsxlsUKsZlEIfsKofZh2GJndgh2CXL
        G5wfrk3MeXrISTf76HP8llc=
X-Google-Smtp-Source: ABdhPJyikWVwet80BXAhvtjDXrRAgcazYpwGuvo/ChrFMpFKJnR81d4QzubW2YP3JIFxkKvtPDNaew==
X-Received: by 2002:ac2:4352:: with SMTP id o18mr28410983lfl.48.1635332209590;
        Wed, 27 Oct 2021 03:56:49 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id a6sm816098lfs.115.2021.10.27.03.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 03:56:48 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     apw@canonical.com, joe@perches.com
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev
Subject: [PATCH v2] checkpatch: Improve CVS revision marker check
Date:   Wed, 27 Oct 2021 13:56:36 +0300
Message-Id: <20211027105636.29571-1-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This check gives false alarms at least in fs/ntfs3/ as there $LogFile is
used quite lot because it is name of file which logs NTFS metadata. This
improves check so it does not false alarm so easily.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
v2:
	- Just improve checking. Thank for Jow Perches for regex.
v1:
Link: lore.kernel.org/ntfs3/20211026231637.3750-1-kari.argillander@gmail.com
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 461d4221e4a4..a45c6274fcb4 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4018,7 +4018,7 @@ sub process {
 		}
 
 # check for RCS/CVS revision markers
-		if ($rawline =~ /^\+.*\$(Revision|Log|Id)(?:\$|)/) {
+		if ($rawline =~ /^\+.*\$(?:Revision|Log|Id)(?::.*)?\$/) {
 			WARN("CVS_KEYWORD",
 			     "CVS style keyword markers, these will _not_ be updated\n". $herecurr);
 		}
-- 
2.30.2

