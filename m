Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DA6416140
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241758AbhIWOlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 10:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241681AbhIWOls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:41:48 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518C3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 07:40:16 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id ee50so24570845edb.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 07:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forissier-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Yaq+Io+aloqpeNrqkhGX2eCCGpJnifon/5BjWIeCRs=;
        b=fR4uDbtGmldOZAuI5ln4zQVgk3TJCWa1jOMhGXIf7tXUdq0xiZUZJcv/KxdrDQug30
         FM4DnhJ0MVMpZneEgIiZGgrobWTCXECvyS/NyXSzjAVPNG7iU63lypI4KcweXGaTrU53
         x/Z3j5b0zjMyX7l8ZJrDJHKkQJsvDjw5fuDc3JhzjzTB/9PPdGAfhMTzjEQCdYwcUUEl
         fdLW8eN8vcwqy8Xe5KtkmW2lWwpAmRfuRqx1KHAZff5AQfH+UPG8fxR4zzPl5wCxrumX
         5HaMD+ikLPexa+EIn6kZDYZs5+JN5aZiXkcbY6ks8njqg651KuSGDXnU9ZIn0ahqxzam
         xosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Yaq+Io+aloqpeNrqkhGX2eCCGpJnifon/5BjWIeCRs=;
        b=WIzyqlR4tYGZ9NGHP4/T7cvJMVun8yYkZvlZ9JzGw2nGqOjrS1t2Npa+54t75aZ52p
         OsRk0w95Et24cuNSQbcwK5vg9Z9o+LyFPOA5h+/mY4ouIzg2l7HAJ35Wv1krznal8LpR
         3gu9Rc0bSIr9ZwxC7QUQYw/U+Qg+FvgoDTDxVvvzB3EyBUdNT44OfpX7WIDjj09bx+ZT
         MhAKKSV7uhIZc8BliAL2sVjo0f1RXTCrOHLqxpDtcEBlwwU1CutamjNo2+jyHzaPg1Q3
         BLOkjIvx3bFbTHz5XjkMVcOO0I6QxpdwDhTnh2hvwalO4SXcGO0RawVIiBo1qdC4f+CK
         Uazw==
X-Gm-Message-State: AOAM530dgibSq92iYDckfzDR9w6iHC9+FATQDcwoJyGvMVnzT9FHNngI
        SSpZvzw4SdDy6LToPfRJP+Mfkw==
X-Google-Smtp-Source: ABdhPJxAefN4F4ApYx42YsyuTD40jDQyU/uSf9VZgYlQeUSoSF+gBupuoUTOjGoTbFFlJmxWVPwIhQ==
X-Received: by 2002:a17:906:414a:: with SMTP id l10mr5168365ejk.561.1632408014727;
        Thu, 23 Sep 2021 07:40:14 -0700 (PDT)
Received: from matebook.. ([2a01:e0a:3cb:7bb0:3c27:6eff:2c08:5257])
        by smtp.gmail.com with ESMTPSA id a24sm3630785edu.49.2021.09.23.07.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 07:40:14 -0700 (PDT)
From:   Jerome Forissier <jerome@forissier.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jerome Forissier <jerome@forissier.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: relax regexp for COMMIT_LOG_LONG_LINE
Date:   Thu, 23 Sep 2021 16:38:42 +0200
Message-Id: <20210923143842.2837983-1-jerome@forissier.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One exceptions to the COMMIT_LOG_LONG_LINE rule is a file path followed
by :. That is typically some sort diagnostic message from a compiler or
a build tool, in which case we don't want to wrap the lines but keep the
message unmodified.
The regular expression used to match this pattern currently doesn't
accept absolute paths or + characters. This can result in false
positives as in the following (out-of-tree) example:

  ...
  /home/jerome/work/optee_repo_qemu/build/../toolchains/aarch32/bin/arm-linux-gnueabihf-ld.bfd: /home/jerome/work/toolchains-gcc10.2/aarch32/bin/../lib/gcc/arm-none-linux-gnueabihf/10.2.1/../../../../arm-none-linux-gnueabihf/lib/libstdc++.a(eh_alloc.o): in function `__cxa_allocate_exception':
  /tmp/dgboter/bbs/build03--cen7x86_64/buildbot/cen7x86_64--arm-none-linux-gnueabihf/build/src/gcc/libstdc++-v3/libsupc++/eh_alloc.cc:284: undefined reference to `malloc'
  ...

Update the regular expression to match the above paths.

Signed-off-by: Jerome Forissier <jerome@forissier.org>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c27d2312cfc3..bf2094cb4271 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3147,7 +3147,7 @@ sub process {
 		    length($line) > 75 &&
 		    !($line =~ /^\s*[a-zA-Z0-9_\/\.]+\s+\|\s+\d+/ ||
 					# file delta changes
-		      $line =~ /^\s*(?:[\w\.\-]+\/)++[\w\.\-]+:/ ||
+		      $line =~ /^\s*(?:[\w\.\-\+]*\/)++[\w\.\-\+]+:/ ||
 					# filename then :
 		      $line =~ /^\s*(?:Fixes:|Link:|$signature_tags)/i ||
 					# A Fixes: or Link: line or signature tag line
-- 
2.30.2

