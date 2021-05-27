Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6E5393864
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 23:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbhE0VtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 17:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhE0VtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 17:49:23 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5158C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 14:47:47 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so3445070wmk.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 14:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c8610SbT0epVJTQqY9Ri5rpbvG7EHYsiNE4dwA9QJjw=;
        b=hNShJ9WaRhPwbYFUC6iY9J4S0KDOFrfH8Jx06xdeLWvO5Bh8hj+sjy7HJlG3IhNo5C
         SPh4vkU/2m8gN1HRbswSueFZGQyGuR2U5UbU4Eg3dwRPk7+kQSEG+lzG2x6naVtIbBQe
         sf6StgpQ0OaQwlRu8yhhascwjpbMwfJ805jFyEoXArpsoWRtQAe7uSMPvzUsqSNLqQLP
         Li9j21NrHZtUy4JOklRXW+0rdqIw9i4cmDTr7nbamMrrUsbabcWf82HegkH3pgcEsWqZ
         coV8Q53DzWC2B40gMnyhHclVFQ2gocSGYI9xm0s5iSI0Ayn6h71bLXDNfrwm77coAkSU
         WfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c8610SbT0epVJTQqY9Ri5rpbvG7EHYsiNE4dwA9QJjw=;
        b=M2AAZNMWA4WJAbOzVTr8STv96wljBKh9wm3Qc/6QowQ8PI8g0TmCl6fADLlHYXO9uI
         uzKqrnZuw3PzQIOmfHkoUHv/Gm7epVTD3Y21+Oi17t10sNSmgJMkvCV4PyAM8JpGhIk5
         E/qp2SALWD322a3+vRhbzzpLTWwYdL2WTjFjG37+G/+oFZqHI5uaWCrI/j6m79VP1D29
         i1g0RgRIJiFz0LY0OnLIFwBkcdhxAPHEksoe0YEGpmn5zYrUO8FAJX7b74EW0X4DuWiZ
         hDyA1k32/aszOsS2e5icT7Gh0eiuhn6LRpwI4Ke2XMKMw46GZX7phnjLYAiF1iIUGdrE
         Gjpg==
X-Gm-Message-State: AOAM532KpS+hr1OLCszAYbsYi0abd+AR4u7sHa8s9GyokyEPGkqZcaFp
        UsFQMVKDLpXhfEbA9gAM4K4=
X-Google-Smtp-Source: ABdhPJzGqWZ9YWupljyKpDhrK6EHcxlHWYkAad2Xj0FxyRxu3Wr/85x2HSc/zcX2qITc/BFiycXepw==
X-Received: by 2002:a1c:f212:: with SMTP id s18mr10131194wmc.172.1622152066518;
        Thu, 27 May 2021 14:47:46 -0700 (PDT)
Received: from lshz10676.. ([88.123.50.136])
        by smtp.gmail.com with ESMTPSA id h1sm12571903wmq.0.2021.05.27.14.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 14:47:46 -0700 (PDT)
From:   Antonio Borneo <borneo.antonio@gmail.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Antonio Borneo <borneo.antonio@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: fix incorrect camelcase detection on numeric constant
Date:   Thu, 27 May 2021 23:47:41 +0200
Message-Id: <20210527214741.180449-1-borneo.antonio@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code fragment below
	int foo(int *array, int index)
	{
		return array[index & 0xFF];
	}
triggers an incorrect camelcase detection by checking a subset of
the hex constant:
	CHECK: Avoid CamelCase: <xFF>
	#3: FILE: test.c:3:
	+	return array[index & 0xFF];

This is caused by passing the whole string "array[index & 0xFF]"
to the inner loop that iterates over a "$Ident" match.
With no check to exclude a constant, the match iterates over
"array", "index" and "xFF", thus the camelcase detection.

Similar issue can be detected with other constants like "1uL",
"0xffffU".

Force the match to start at word boundary so the constants will be
filtered-out.

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

To: Andy Whitcroft <apw@canonical.com>
To: Joe Perches <joe@perches.com>
To: Dwaipayan Ray <dwaipayanray1@gmail.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 23697a6b1eaa..f0032166dfc1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5656,7 +5656,7 @@ sub process {
 			    $var !~ /^(?:[a-z0-9_]*|[A-Z0-9_]*)?_?[a-z][A-Z](?:_[a-z0-9_]+|_[A-Z0-9_]+)?$/ &&
 #Ignore some three character SI units explicitly, like MiB and KHz
 			    $var !~ /^(?:[a-z_]*?)_?(?:[KMGT]iB|[KMGT]?Hz)(?:_[a-z_]+)?$/) {
-				while ($var =~ m{($Ident)}g) {
+				while ($var =~ m{\b($Ident)}g) {
 					my $word = $1;
 					next if ($word !~ /[A-Z][a-z]|[a-z][A-Z]/);
 					if ($check) {

base-commit: c4681547bcce777daf576925a966ffa824edd09d
-- 
2.31.1

