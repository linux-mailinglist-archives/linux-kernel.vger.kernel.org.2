Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1666936A555
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 09:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhDYHNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 03:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhDYHNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 03:13:47 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC88EC061574
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 00:13:08 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g1-20020a17090adac1b0290150d07f9402so3384512pjx.5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 00:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9U8RsCzIt8kYk6ckxWyO8c6psI9/7wH1Z//rhNu6hTQ=;
        b=s+zPrgvJtGD5DFD8JhXuy2xgwsFDC7xXZGSxvw2kLGx5iY57yNO+5ak7d8LlhpKWC9
         fOjsYGWUV9qojx0/Wf5VSs5oKPu3uiJLONotAlkHvkjooJsrQrRyzq4UR/+RpuDETDCX
         XNPENVAOH8Cy+hz4LoLYtSvEBoFrYOykpgPvosdzFBC+IaOspCftRGuDo5Vx653esmzd
         nHA6F8phLxTQXKaMEd0C61ykCFtAU/qPjwyClIlAj4Yxk5K8jYIGI8TX5y1SAHFv2ZlD
         Ka537oDTUdsNuMjSWPWpAF2r4qhQD4XF8n0QnsORuLKOLWmqikteFVh6VOZrZEmNiy7M
         g3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9U8RsCzIt8kYk6ckxWyO8c6psI9/7wH1Z//rhNu6hTQ=;
        b=Uz90X5JWGpcxbZfGAo/BcOdmbII97iEJAF9Vp/RQM4ifriJhq53pjjpGMD372tj4k8
         mLiARPZCqzj2jeDzuqSeyeUHdPOIXVNTH2J9Z/DGzeT4QpuEbIT7csmGQnqZy0vkTMZF
         KRkeBKyc5gK7r/QlUHrfGoYx+HY0LJELcWGP+a4ukQg1aQhs5uDyE6l90wAYnAAf0+p5
         rtyXRGQSYeVMSZBjshlE24UxG25T0HCy+7ccRAm5nQ9JqZGbPCJ3e2fn9PwkZDYdz6T4
         A4Bzkpa/avpRBH4vFl/KCEE8l9G03DNaLK+wcucovjQRRm16OxYY5jAAChxGsf3gNcR5
         19qw==
X-Gm-Message-State: AOAM531mxYbq1nhVdhH5nDonl9yD9KurA+VCEK2GXdk7IluEPjvkyXs9
        UC4WTuNiybFFGTD7r2XzjJI=
X-Google-Smtp-Source: ABdhPJxl3L+PVbOUOZH6hcsZnOJJZPqZnIGRczw1TtQgwzc70cv+1KZmz9ZlHaib7TuFG8I/PJLPaw==
X-Received: by 2002:a17:90b:60a:: with SMTP id gb10mr15469275pjb.71.1619334787969;
        Sun, 25 Apr 2021 00:13:07 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9004:6b9b:1106:23bd:5fcd:29ca])
        by smtp.gmail.com with ESMTPSA id d17sm8148438pfn.60.2021.04.25.00.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 00:13:07 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH] checkpatch: fix uninitialized return value in raw_line subroutine
Date:   Sun, 25 Apr 2021 12:43:06 +0530
Message-Id: <20210425071306.5114-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the second argument to raw_line subroutine is 0,
$line remains uninitialized and is returned back to the callee.

If the callee tries to perform string concatenation with that
value, checkpatch throws an error:

Use of uninitialized value in concatenation (.) or string at
./scripts/checkpatch.pl line 1960.

Fix it by providing an empty string as the initial value
for $line.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 23697a6b1eaa..a98217360375 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1943,7 +1943,7 @@ sub raw_line {
 	my $offset = $linenr - 1;
 	$cnt++;
 
-	my $line;
+	my $line = "";
 	while ($cnt) {
 		$line = $rawlines[$offset++];
 		next if (defined($line) && $line =~ /^-/);
-- 
2.30.0

