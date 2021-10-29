Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13E543F787
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 08:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhJ2G4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 02:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbhJ2G4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 02:56:02 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81C7C061714
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 23:53:34 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id c4so8992310pgv.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 23:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N33O/jKwx1/k7vQIGoBJU3vb76C/gdsxbsKwqC4sYls=;
        b=dAIDwhYfub8YTxIIXzFRr2stikRQ4Bztr6AglvMFUQd0c3vA9PKVZMWEpexAOJO3Z9
         QRC2brcGMVgd84c+KG0IZm5nDF07VhHXu86Dn7H1ucsSERjhJM38wzYMG/xhAW+JoDwF
         6IDwDD8n+P1EEAKAnmHPkXJIvbV1RP08QSlQ/gsGe06BSEvI5rOzl0Co4cU9WrS6rhTl
         lKMo+1UYf87phXMvYamf8s0C3juEe2+8L8iGzgmwR3Ek9hKlnji0pqIexCGnCrVOzRRr
         f5qamx0gdIS2dC6Dbw/jQU6/h2PPHrEXnf7+VMuilokSnjjo/ediDxmaVAxPelyQ4F5r
         fMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N33O/jKwx1/k7vQIGoBJU3vb76C/gdsxbsKwqC4sYls=;
        b=V6NZKjjUkawL3rHdqFSewsP/7Sq7dU+A9/0nLkeoOtL0NtPYWJ5lAn13p0lMArqx48
         oHxVCOlWHykD60Z1Tb6onyT58+elciHTrv8ppEpehBwQcAWn8vC3SCEV4dgR5PqZXUkM
         6LPrXefDfNErmiHc/tOSgspriPKfFvyeHxTvdL4qS8xPGoPsbgzCiIyLwqDQ4Pa4fzVt
         q2+MZDbsd9zomzSch9DJ4BHPZ3h68zaGJTXQ2bVjqhFYrQjuz3oohzjphHFk2S7I1BU9
         yUD4S7w4AueMKZ18zZ0eHp27H2VEhuilARbN7SjWNTwEYFUI25uQtwbiPMGeMOopHw4P
         7JTQ==
X-Gm-Message-State: AOAM531O7uxHHyZccG50P3HQ9bYlibKGXvAdR++Snr6QBv8VojYH8MGI
        YNWv4YNQ0IRIvULmJ1IBnn4=
X-Google-Smtp-Source: ABdhPJwglch1mQLG80CLD8lru0CrUB6PoLM7HrZrVXwsfKeAcxUw3GazDmMTucfI5mwYLFcKwC8Itw==
X-Received: by 2002:a05:6a00:16d2:b029:300:200b:6572 with SMTP id l18-20020a056a0016d2b0290300200b6572mr9114424pfc.62.1635490414423;
        Thu, 28 Oct 2021 23:53:34 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id gn1sm4729741pjb.34.2021.10.28.23.53.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Oct 2021 23:53:34 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     nianfu.bai@unisoc.com, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] pstore: Modify kconfig to align text
Date:   Fri, 29 Oct 2021 14:51:20 +0800
Message-Id: <1635490280-8798-3-git-send-email-zhenguo6858@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1635490280-8798-1-git-send-email-zhenguo6858@gmail.com>
References: <1635490280-8798-1-git-send-email-zhenguo6858@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>

Modify kconfig help for text consistency

Signed-off-by: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
---
 fs/pstore/Kconfig | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 288ed3c..008ce38 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -4,15 +4,15 @@ config PSTORE
 	select CRYPTO if PSTORE_COMPRESS
 	default n
 	help
-	   This option enables generic access to platform level
-	   persistent storage via "pstore" filesystem that can
-	   be mounted as /dev/pstore.  Only useful if you have
-	   a platform level driver that registers with pstore to
-	   provide the data, so you probably should just go say "Y"
-	   (or "M") to a platform specific persistent store driver
-	   (e.g. ACPI_APEI on X86) which will select this for you.
-	   If you don't have a platform persistent store driver,
-	   say N.
+	  This option enables generic access to platform level
+	  persistent storage via "pstore" filesystem that can
+	  be mounted as /dev/pstore.  Only useful if you have
+	  a platform level driver that registers with pstore to
+	  provide the data, so you probably should just go say "Y"
+	  (or "M") to a platform specific persistent store driver
+	  (e.g. ACPI_APEI on X86) which will select this for you.
+	  If you don't have a platform persistent store driver,
+	  say N.
 
 config PSTORE_DEFAULT_KMSG_BYTES
 	int "Default kernel log storage space" if EXPERT
-- 
1.9.1

