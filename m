Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DEF3ADF3E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 17:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhFTPsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 11:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhFTPsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 11:48:14 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0524C061574
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 08:46:00 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso15102017otu.10
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 08:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uNULw8Wxtv+zIGQLsQfQlYJ7X4n+hkFjwgFJLvbtrR4=;
        b=UuAAWZDejm0W8lwVw8Kh8ePS/qBx/53i8XoVcDxoVvebHF1rU/rYnsIfhjncJPC4fF
         iHdqFvxwM0QyvTeO+U8fAcK4jeuTys0jOJ6wnmM3grt8ZDRZgSZ0qAzMLNr86GxHv38b
         iE3BrCZljmWPQ7bpX6jVfWI3nj7I7sx63UnqU1gguA8QaxB3PEyDg8HC6u+4Z2I1enyN
         CzBDclraL9pz54RULq4gmKlvPhdalFkEGkeFAj1uyrQpNyiOYQHie99Hxg8jzRg7Unzl
         qbPYYjb6aihIIr1tOAhF3k/IgKs6SyDXB+yFJJbu3Z7nQ+vZ1SUx13sc51j7BPSPZeJI
         9okQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=uNULw8Wxtv+zIGQLsQfQlYJ7X4n+hkFjwgFJLvbtrR4=;
        b=XS+wMaGea4E/16W0n7mAxAyVQr8UWxPe01urn4wnE43wuRAG9xVMd2B3YBIQTYYE3A
         QbNA5AIFCMXZYjGOCqwYtDLcZOo8nZ11v5G62ByvBQ7ZEfFO4a0JzRhyu8WUBbXU57As
         ta70G4XJUULjzmjO25EmUU8cIJMBsqYgvlZej7KDtfQNy+nAqr+lU/6ATQGutoRCdH+f
         AnWLXeh+CXEeTCW1qbpWgjOOfgikPdm76hjaRUpCmiVYlAtEmRAeA51HqoDodX9K8wrY
         CgHukLvzlhNA9WL8lXSPYavkQtPUuvUX6PuSzrDnO6fNxbn5fWT52e+7Fq1jCT9tfVku
         s3wQ==
X-Gm-Message-State: AOAM531zJVU6Jlxd3Q2Kq4PAYJ9YCy9uxBvRwHyKYZkeHvUhkxDeGbNX
        xxnzeGJ7MDSp84eRYh07Oz0=
X-Google-Smtp-Source: ABdhPJxSa7mf7oMdXXfTX2nkdbp4ZG15QxyYQ8x40gIcpDovdYEJH4/Gv7OGtcNmdVIr5rmlv+nBOQ==
X-Received: by 2002:a05:6830:1f51:: with SMTP id u17mr17712847oth.25.1624203958822;
        Sun, 20 Jun 2021 08:45:58 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z14sm3378318oti.29.2021.06.20.08.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 08:45:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Whitcroft <apw@canonical.com>
Cc:     Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH] checkpatch: Do not complain about positive return values starting with EPOLL
Date:   Sun, 20 Jun 2021 08:45:55 -0700
Message-Id: <20210620154555.3848275-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch complains about positive return values of poll functions.
Example:

WARNING: return of an errno should typically be negative (ie: return -EPOLLIN)
+		return EPOLLIN;

Poll functions return positive values. The defines for the return values
of poll functions all start with EPOLL, resulting in a number of false
positives. An often used workaround is to assign poll function return
values to variables and returning that variable, but that is a less than
perfect solution.

There is no error definition which starts with EPOLL, so it is safe to omit
the warning for return values starting with EPOLL.

Cc: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 23697a6b1eaa..cf82dbd7d9d1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5458,7 +5458,8 @@ sub process {
 # Return of what appears to be an errno should normally be negative
 		if ($sline =~ /\breturn(?:\s*\(+\s*|\s+)(E[A-Z]+)(?:\s*\)+\s*|\s*)[;:,]/) {
 			my $name = $1;
-			if ($name ne 'EOF' && $name ne 'ERROR') {
+			if ($name ne 'EOF' && $name ne 'ERROR' &&
+			    rindex($name, 'EPOLL', 0) != 0) {
 				WARN("USE_NEGATIVE_ERRNO",
 				     "return of an errno should typically be negative (ie: return -$1)\n" . $herecurr);
 			}
-- 
2.25.1

