Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABFE3C966B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 05:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbhGODVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 23:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbhGODVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 23:21:15 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA50C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 20:18:23 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id x12-20020a05620a448cb02903b3dabbe857so2736456qkp.15
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 20:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7/xc8cqxfVSWmB+kmkeDRwW1dN4YLLT0+dk6TAA9Q2g=;
        b=m1QGMCpYdwQXgMdZ85p+hNZcm4O1o717u5aFQQewmDjUw9o/TNmtcIFov4T7v4nLS0
         hRWx18dcda+5CgsRuzG6H+XUmqNJ++3Ft4eyGEs9DvbAewdbn9HFO2d7DCfrs0IpIoDc
         uH1T7MKdTwbOOPtxnUKr8tpCZzVBBLV7VHW8/FH3j+Yk08p/ltACqF252Yy8UNgLNV4s
         EnDqlEKR34pbZN4B+BQSlypE5JHO66kirHRuDfhcjelwgECnOyOD2MtJdl9tNadvtI2Z
         6X5mwrx9jqhLmOorgTDS10zQXIkvcwW+pQyQahLYwoOIvg+HjBi154al5rgSSOjp9OBh
         njrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7/xc8cqxfVSWmB+kmkeDRwW1dN4YLLT0+dk6TAA9Q2g=;
        b=GkW0fPX/mIIuIOLswBAN6O+P948prqxDOkdf1ulipXHaFxdmG1drb20tEl4U2ATq0R
         vrQQIFlxSExvSNB3WVBghC9KkeBy1YAmgPFz97oEgCkgtouUqlvQifFjf6SvJn5SpYcM
         K0ZUOyowLk3SEmCCDYrqTr3s19tYFgGgegJmvB7V4GzyP5RM15wmrDDUgUw66JKRsmhS
         s0FDMJHvcgQUNjLIUMTzhrIXcfpojzJ2kk+Tet6ggUIee73zvy/dpUTOEPK5RR5x04nN
         rVzeWB2CIQPnXXD9GlXdlyBIUcysXNBw+EMLu+SX4EO5xHD5+m/7bHRAlt3KbWxq2MV/
         UwMw==
X-Gm-Message-State: AOAM530i07OcQepjK0JBIyQ+lqqckAnwp7ZAsJY05sp73kPVBKihOGVZ
        LHJgupOODm0Z0RT6niEaw4TDZTo9J0aM6w==
X-Google-Smtp-Source: ABdhPJwG7HpXPRPtevKMPWqDnagiWZbcHbK31mY0DZh9Wp6KOu9EBQ1ExmCsPWkpHzSxuB/QLt1GqIzsXdslEg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:b1])
 (user=cmllamas job=sendgmr) by 2002:a05:6214:1941:: with SMTP id
 q1mr1725624qvk.35.1626319102670; Wed, 14 Jul 2021 20:18:22 -0700 (PDT)
Date:   Thu, 15 Jul 2021 03:18:05 +0000
In-Reply-To: <20210715031805.1725878-1-cmllamas@google.com>
Message-Id: <20210715031805.1725878-3-cmllamas@google.com>
Mime-Version: 1.0
References: <20210707162419.15510-1-cmllamas@google.com> <20210715031805.1725878-1-cmllamas@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 3/3] selftests/binderfs: add test for feature files
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Steven Moreland <smoreland@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Verify that feature files are created successfully after mounting a
binderfs instance. Note that only "oneway_spam_detection" feature is
tested with this patch as it is currently the only feature listed.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 .../filesystems/binderfs/binderfs_test.c        | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 477cbb042f5b..0315955ff0f4 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -62,6 +62,9 @@ static int __do_binderfs_test(struct __test_metadata *_metadata)
 	struct binder_version version = { 0 };
 	char binderfs_mntpt[] = P_tmpdir "/binderfs_XXXXXX",
 		device_path[sizeof(P_tmpdir "/binderfs_XXXXXX/") + BINDERFS_MAX_NAME];
+	static const char * const binder_features[] = {
+		"oneway_spam_detection",
+	};
 
 	change_mountns(_metadata);
 
@@ -150,6 +153,20 @@ static int __do_binderfs_test(struct __test_metadata *_metadata)
 	}
 
 	/* success: binder-control device removal failed as expected */
+
+	for (int i = 0; i < ARRAY_SIZE(binder_features); i++) {
+		snprintf(device_path, sizeof(device_path), "%s/features/%s",
+			 binderfs_mntpt, binder_features[i]);
+		fd = open(device_path, O_CLOEXEC | O_RDONLY);
+		EXPECT_GE(fd, 0) {
+			TH_LOG("%s - Failed to open binder feature: %s",
+				strerror(errno), binder_features[i]);
+			goto umount;
+		}
+		close(fd);
+	}
+
+	/* success: binder feature files found */
 	result = 0;
 
 umount:
-- 
2.32.0.93.g670b81a890-goog

