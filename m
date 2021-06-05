Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749DB39CAB6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 21:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhFETUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 15:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhFETUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 15:20:22 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D45C061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 12:18:19 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id md2-20020a17090b23c2b029016de4440381so513890pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 12:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lEDQpHfLYsPS4ui/OdWsymIsdBIwBJQksSc8kuj65Ho=;
        b=gK9XcHv2xaVwaycQOD2OzjboZGuZMeWxjcGF6dzcwSUWLUdR1YpiIgk6mA4QdywsAY
         smnx6NtAqPs8aKDGXtexs2ycrcTM2yCwlZDt4pm4rzE37d8rhoOwZF/D2TW4AF55oama
         SJgDH/foH01eQkEewYlkhRin5UxH8C0A6lqhAeJXXCr+gZLn830X0FRb3CjaLxg9P7T+
         K5+BYFppbaIgxexGUGeof3+Oko2/cc1NjUc2e5kA7csiXp5Jk1scesyPr1s138oCi65j
         vkzjhHNs+5So9S3mV82GZFbAovdgS0qKaQ8QHHYLVbi51NFgoLQP1YKdcGivgtNu/VGS
         EbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lEDQpHfLYsPS4ui/OdWsymIsdBIwBJQksSc8kuj65Ho=;
        b=EiOgcWlNmXIcgprNHuk7RhfPhoe6r8C6+DxEAbX8ZdkgkSCJYqpEPfnAtxe9MNYWek
         sPETZ/YxXaPvUSopN7SREk6xxLMlBCncnU5Xc2TmTfSFrijZixN99WPhtLzZ0J2Eu6Vk
         /F0w8RjlcxLxWZFce+Avf9cJ5NlkbAXIhlAUB5L9qyDR6FXVYwd5qRwcaYdJJmSyWxOf
         quCR4tGriznM6P3cBGqy9EB3EnIsGyNlSFs2W5RH8JZT+tWl0W2ilelR96ecl1ZkLir+
         7H0z3L2ZJ7kOyvsB/K/wwX+T9JqkqTjmUEXlSj9rYsSbDwOM8H2FR5/YerXm7aq88J5U
         2Jnw==
X-Gm-Message-State: AOAM532kYHZ14HEWBpQqXcNoHU2g1eKlT+u4SgB6OcpTliGwpx9RNX86
        qRCK+PGhj+kJfyGEUWVvaP8+/mrtxYCmSw==
X-Google-Smtp-Source: ABdhPJy26Ei8wT6dgonYjXfqR7TTcZTXKWQxrjMYOFWHfgHWnPGxCN2c2aBpvcDqDtKE7ohycMIXlw==
X-Received: by 2002:a17:90a:7bce:: with SMTP id d14mr11946793pjl.38.1622920698314;
        Sat, 05 Jun 2021 12:18:18 -0700 (PDT)
Received: from localhost.localdomain ([49.37.1.243])
        by smtp.gmail.com with ESMTPSA id cq24sm399437pjb.18.2021.06.05.12.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 12:18:17 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH] checkpatch: do not allow using -f/--file option without a filename
Date:   Sun,  6 Jun 2021 00:47:54 +0530
Message-Id: <20210605191754.28165-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When checkpatch is run without a filename, it reads from stdin.
But if --file option is used along with that, it may generate
false positives.

Consider the following test file:
$cat test.c
int x = a - b;

$cat test.c | ./scripts/checkpatch.pl -f
WARNING: It's generally not useful to have the filename in the file
+int x = a - b;

This is a false positive and occurs because $realfile is set to "-".
Also since checkpatch relies on the file's extension to run specific
checks for c files, assembly files, etc, most of the checks are
not run as well.

So it is better to disable -f/--file option when checkpatch is
run without a filename.

Link: https://lore.kernel.org/lkml/294bb4a2c3f5f8cf4a744cf59bfd37562653afb9.camel@perches.com/T/#t
Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3e1795311c87..7dff9206f9f0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -331,6 +331,7 @@ help(0) if ($help);
 
 die "$P: --git cannot be used with --file or --fix\n" if ($git && ($file || $fix));
 die "$P: --verbose cannot be used with --terse\n" if ($verbose && $terse);
+die "$P: -f/--file requires at least one filename\n" if ($file && $#ARGV < 0);
 
 if ($color =~ /^[01]$/) {
 	$color = !$color;
-- 
2.28.0

