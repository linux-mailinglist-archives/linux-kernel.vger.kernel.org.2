Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66220374A01
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 23:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhEEVSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 17:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhEEVSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 17:18:23 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E29C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 14:17:24 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id g4-20020a9d6b040000b029029debbbb3ecso3011763otp.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 14:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lnb309EHsvW62boTcdJKaStV7Ili46SfwMsHJrZuHdM=;
        b=erJ5JmsWf02UPK9ZE+Cc9wV6053fj9gDNXKi7auyTdWA0sSqX9KLjCiw3FQxYzuLKV
         u14Il/C6Fkb1xON22JNDEYdTZ3RV9ka1L2wmKpoEprVHWngZtNoCEXh8BVlOkUcme43X
         8UnRztGCQesVt2/EV2xe4LsRI0aseZ8puKJnWWFF8R18Ruu8io3oJxT5toQ01EvNQSn9
         rYZmuSrat0EktXS1P+b1A+6b2EelW6Davt2Ta5SWuK4a84CuSKUwg9Kvw8os4N92b6PH
         aNfWCr5nFzm9jEB1ENPUp/ecAmr9K+ab4hnkiylMFTJjeUs34bLfVofs99eVW8TI4Jqk
         Oq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Lnb309EHsvW62boTcdJKaStV7Ili46SfwMsHJrZuHdM=;
        b=npJXYMCAUSwyj+9Iz3ytAFKutnv8i0N1zwFWzPdU2OKiQskkVF1lbdY7gK57amX4QR
         CSYLZppf2c4+QwQV70if6mC6in0Pyy5tCk4U1lu7c4P5VhUy+w7Y9E3w1WBuwjbrNn3Z
         iu98/5oQnT8stC5rc+v5TPhpfYQ/gyPdRmjHY13NtJY5L+Nac+WiyNNUkrX8axUQm9N5
         uOvfrhd8JudvfFnmh2gj9H5ORNF67bwJ4XhCvyq1Ds8Vl7+y/Ff3dWf2noY87dJ8XoKe
         nc7uj2P5V7Mwt5GdSGtv9gQ+vM85MjH5NuBB4FAgr4CByJ5Pz6iuZiWNlb6gTdOvCVUA
         6Wqw==
X-Gm-Message-State: AOAM533eLasGnbO+szF2lEc8tnfygZeaYWtGgBtkkrM2/F8LfZqhsJ/8
        u6WDDhcGdr1nY/eIdmmwoJS8a/2iRjQ=
X-Google-Smtp-Source: ABdhPJzLvwkfd2htUILAjm4ateGc8RH9xdwiJ2prkfR9EZRLV10Dcg13C28LGM2B+W66uVLKd6HsAw==
X-Received: by 2002:a05:6830:2247:: with SMTP id t7mr542610otd.179.1620249444389;
        Wed, 05 May 2021 14:17:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b14sm72461oic.30.2021.05.05.14.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 14:17:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bert Vermeulen <bert@biot.com>
Subject: [PATCH] checkpatch: scripts/spdxcheck.py now requires python3
Date:   Wed,  5 May 2021 14:17:20 -0700
Message-Id: <20210505211720.447111-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit d0259c42abff ("spdxcheck.py: Use Python 3"), spdxcheck.py
explicitly expects to run as python3 script. If "python" still points to
python v2.7 and the script is executed with "python scripts/spdxcheck.py",
the following error may be seen even if git-python is installed for
python3.

Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 10, in <module>
    import git
ImportError: No module named git

To fix the problem, check for the existence of python3, check if
the script is executable and not just for its existence, and execute
it directly.

Cc: Bert Vermeulen <bert@biot.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index ccb412a74725..8a1b782dd7e7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1084,10 +1084,10 @@ sub is_maintained_obsolete {
 sub is_SPDX_License_valid {
 	my ($license) = @_;
 
-	return 1 if (!$tree || which("python") eq "" || !(-e "$root/scripts/spdxcheck.py") || !(-e "$gitroot"));
+	return 1 if (!$tree || which("python3") eq "" || !(-x "$root/scripts/spdxcheck.py") || !(-e "$gitroot"));
 
 	my $root_path = abs_path($root);
-	my $status = `cd "$root_path"; echo "$license" | python scripts/spdxcheck.py -`;
+	my $status = `cd "$root_path"; echo "$license" | scripts/spdxcheck.py -`;
 	return 0 if ($status ne "");
 	return 1;
 }
-- 
2.25.1

