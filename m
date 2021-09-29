Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F89641C2BA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 12:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245517AbhI2KbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 06:31:22 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:46828
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245513AbhI2KbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 06:31:21 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 93624405FA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 10:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632911377;
        bh=DbOD0C5oNNiLE6C6+Qay26kE8pgt12Q4nTJI+OMiTsU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=R+nFcLZjz/qJ3jmpK4CyYtakx6/bbBmTK+HPlbkuqajeam1tPZTCrO6rfm4LPHJkE
         AcwV+6xrvYhbeWsglX8AOsSEmAO/vGBweit4+dCOkVAOFFrsSVfFxUwNfkFN94d7sS
         0kGpawsikg57J+3Tsd1sfP5cYAr+26FSA0eZEhVKgMc5pbWQBOlKQBfeAGcaUs9suv
         YUnDJxNRF2KgtSJHYhFnonISKDpJdGYrxfXadxFhN5PmUqmR8YtVOy5ITzSyYyf6P7
         prqYd8TazmaIbyytbyJSsXcZGs0TNmrgFdGBj3KFO0ArJ4bHfm+YA8kp7r3Z9x8zNT
         cDpNVcX1+U22g==
Received: by mail-pl1-f200.google.com with SMTP id m18-20020a170902db1200b0013b994f3709so1046650plx.20
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 03:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DbOD0C5oNNiLE6C6+Qay26kE8pgt12Q4nTJI+OMiTsU=;
        b=WXR8qpU7l/iwHNzpyVbYzqa3W9U2RdtHmonAdLz/BEWBDV6xCUA+THcDiYWifgMQFk
         XUyUBaE75V+Jc7NhY/+cKZhtkH2kiu099aXn8yOvWHEBFaqTu1X9KrD6VmSKLCCNtBNq
         vZWCQWCbzpdc+pakKnpvksD34RnzsGA16bGyqZiFRjV6w44UOon3Q/tz7KtFjanpQU0U
         K4hKw00Kj2GaPcJmtOJZKHhOryPaeWMPJiquMgGa7Mr9iuOyukmoR2LlILX4kWr+T0V5
         d0cufI/eQcxyNiIi7yEobzobfFmpIOTMzI6zo6ZUKjWawDuWMS+VaYGOwDJOXIe52SJ7
         Iz4w==
X-Gm-Message-State: AOAM533zhY541t4Z4Mx9NE0IVPrWk3n2oTo9PNqqPM5ezbHK5GXJrJmS
        V/Fqj4im80+hMSn4mNJReZdX0bU+Fvb0c7ibM9w31fbJHDqP9BJqs4RpKWsgXVD5frN2blujCUD
        YyH0DkH3wtFl8proUnjBbq9jlUNTEl0oEFBOs7UJd
X-Received: by 2002:aa7:82ce:0:b0:44b:436b:b171 with SMTP id f14-20020aa782ce000000b0044b436bb171mr2613253pfn.21.1632911375996;
        Wed, 29 Sep 2021 03:29:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZzh2Mp9pgSih3XerMnOf17A+2UyCKpRU8SP4bN7YL0nUc2n2nsgAA9DQXoamAR348zg9/Dw==
X-Received: by 2002:aa7:82ce:0:b0:44b:436b:b171 with SMTP id f14-20020aa782ce000000b0044b436bb171mr2613241pfn.21.1632911375713;
        Wed, 29 Sep 2021 03:29:35 -0700 (PDT)
Received: from localhost.localdomain (223-136-83-121.emome-ip.hinet.net. [223.136.83.121])
        by smtp.gmail.com with ESMTPSA id f27sm2254786pfq.78.2021.09.29.03.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 03:29:34 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     po-hsu.lin@canonical.com, skhan@linuxfoundation.org,
        shalomt@mellanox.com
Subject: [PATCH] selftests/ptp: Use kselftest skip code for skipped tests
Date:   Wed, 29 Sep 2021 18:28:48 +0800
Message-Id: <20210929102848.27158-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The phc.sh script in the ptp directory is still using exit 0 when
the test has been skipped due to some unmet requirements.
Use kselftest framework skip code instead so it can help us to
distinguish the return status.

Criterion to filter out what should be fixed in ptp directory:
  grep -r "exit 0" -B1 | grep -i skip

This change might cause some false-positives if people are running
these test scripts directly and only checking their return codes,
which will change from 0 to 4. However I think the impact should be
small as most of our scripts here are already using this skip code.
And there will be no such issue if running them with the kselftest
framework.

Note that there are some SKIP messages exit with 1, I leave those
unchanged.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/ptp/phc.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ptp/phc.sh b/tools/testing/selftests/ptp/phc.sh
index ac6e5a6..0820544 100755
--- a/tools/testing/selftests/ptp/phc.sh
+++ b/tools/testing/selftests/ptp/phc.sh
@@ -1,6 +1,9 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# Kselftest framework requirement - SKIP code is 4.
+readonly KSFT_SKIP=4
+
 ALL_TESTS="
 	settime
 	adjtime
@@ -13,12 +16,12 @@ DEV=$1
 
 if [[ "$(id -u)" -ne 0 ]]; then
 	echo "SKIP: need root privileges"
-	exit 0
+	exit $KSFT_SKIP
 fi
 
 if [[ "$DEV" == "" ]]; then
 	echo "SKIP: PTP device not provided"
-	exit 0
+	exit $KSFT_SKIP
 fi
 
 require_command()
-- 
2.7.4

