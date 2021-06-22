Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A699C3AFA4C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 02:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhFVApz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 20:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhFVApy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 20:45:54 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBFAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 17:43:38 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id q20-20020a4a6c140000b029024915d1bd7cso4944028ooc.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 17:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zLfSl2gKoruVSOsM4jUOkjx3cSkNIuW9ElNya7p4bsU=;
        b=qj87DwVnRjigIcaCCx4PTBfhEkeBRuN5A9E5KBFnw3ZU6W/7d4/uqezWkh4kzS6U2Q
         4PRqOQrdRlrR4NzqyMt4HF1BXGHhWxl/XtqKwE4m1fZs29h2wlHLvYlYtxuMyVcabRfd
         PczCm7VtqNE5no7aZd5EkFyXJ8oEJouIlgWIqt4OQlCqdPCikjhNzYxStCGH/SiB/r0O
         NQ02OMOqUOD6pqIpBfez75KLpM0zD7ojxaX51lWkeQokQWxGjkVY2XbWkS2WK9P+7dYW
         UalaS27t3SgPExgJHNsHvWZ0iYi9G4wWSFlVH4TdnLE/9zJlwilfomKPeF6PXHsat+GM
         0rvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=zLfSl2gKoruVSOsM4jUOkjx3cSkNIuW9ElNya7p4bsU=;
        b=HPSlBON6FXXTQ4bhoLTmGAU7/u4lzeNF6z+yCFOJwqYMXju8ad8wa3OClxTDNiYlW/
         vPECUIeR6/ZzBf7Xwba9rxVwWhTZScHnRkWgHC8Ae5t6W7QuNKD6fU9wtrAEgmOUZHJb
         iNKgjGkmVpxqtbBGmgX2VNLNYM11vRDSNQm5+29dQ5BSpHQQ4F3SnA6/rFVzc91O8F3Z
         05uIfsZWo6ACcB5vcHujzgRrsB13JEuBjz8hVK3lBnHlivCm7uGYJ09+7dk6Oon+NYk3
         f+SDW6HJMantXrBz+Ni2Fh9bzyJPORVRGAvk/WlrVAGJBYRmesoY7wbtTtB7gEXQbdn3
         ZKhQ==
X-Gm-Message-State: AOAM530dnmlz3uez03QWdXjhGqkRH7nl8Rt63QDbWj7tzAUYZiwVBsci
        tZRmItZur9/0+I9d0212cB4=
X-Google-Smtp-Source: ABdhPJwZsmKDuCExT2F2fUvhNwdOjFc0m84O8SJ+il40ofIG5Y8WmYm8OUMH8tRH8MJYZC70Oj0BtA==
X-Received: by 2002:a4a:a744:: with SMTP id h4mr824500oom.26.1624322617949;
        Mon, 21 Jun 2021 17:43:37 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v20sm162004ooe.47.2021.06.21.17.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 17:43:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Whitcroft <apw@canonical.com>
Cc:     Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2] checkpatch: Do not complain about positive return values starting with EPOLL
Date:   Mon, 21 Jun 2021 17:43:34 -0700
Message-Id: <20210622004334.638680-1-linux@roeck-us.net>
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
v2: Replaced 'rindex($name, 'EPOLL', 0) != 0' with '$name !~ /^EPOLL/'

 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 23697a6b1eaa..9ab006df01fe 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5458,7 +5458,7 @@ sub process {
 # Return of what appears to be an errno should normally be negative
 		if ($sline =~ /\breturn(?:\s*\(+\s*|\s+)(E[A-Z]+)(?:\s*\)+\s*|\s*)[;:,]/) {
 			my $name = $1;
-			if ($name ne 'EOF' && $name ne 'ERROR') {
+			if ($name ne 'EOF' && $name ne 'ERROR' && $name !~ /^EPOLL/) {
 				WARN("USE_NEGATIVE_ERRNO",
 				     "return of an errno should typically be negative (ie: return -$1)\n" . $herecurr);
 			}
-- 
2.25.1

