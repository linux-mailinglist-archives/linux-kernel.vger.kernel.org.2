Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B243E4137EF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 19:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhIURCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 13:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhIURCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 13:02:44 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B199CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 10:01:15 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id e15so71081lfr.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 10:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WkliQtuiB7gvGpUed1TYW2cuQJQCTGKxOOGy0fW2hRk=;
        b=WbOckG2skYZuQKXj+ZAjrYV7deYygJ/bpLQKvThd0tPoDGHuyHvFFDYrbDftUvObHH
         O0okqjuCgOAk165AorGHrwfcXmWaGNt9K9ndgbUaCMlygpyNO1abhzxl6dreVnl1vL2i
         vraLDIIkNsB2mgFUUK0R18SKvJsH6TPmM8ro+XXPtgD+4z3FWMyWbD1sWuFcB3RJJKoc
         7VSQkcECcadKjXO5xfdzDrdyDuGoGjKO7oeZWG0ywucxIoFndSF1GPbD0rD9RK1bhSJT
         PEB0qrCdsLTExfDsNbmbaZlngKF9sCTVQiuN+d481RBJwyk3wrzq5hMI3aAjMYWnL/Ls
         cacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WkliQtuiB7gvGpUed1TYW2cuQJQCTGKxOOGy0fW2hRk=;
        b=rPFewE0QLsfuNzJLyj9+WgIticRPjoSqPdphmlUA9G+8lLcNeXQSmtPb+5fDz9Ei53
         d4pYRiESHnjsc6uvYK2kPtyRgpx/pkwho+nLVy89Iy9O7TA1RxR+rm7/ALJGWqzcddr3
         qzFW+nufkgb8d7NAatskcw1R5byy0yHtYEQAqwP5k0nSkqjWIpp+dKw9HI/xrac+cqxS
         5rwe8O599t8FIFPRkWIHGtQJUSIWYzxhTj/eMlrXlQnLRvefQDptp87JUZEgrG/tU9N5
         PDEpK+Pap2YEBP8xUSKLPJI3Br2uD1B0HjUbT4pUFEWDqIFTeZFGSPQmOIScha54FT3D
         cy8Q==
X-Gm-Message-State: AOAM5316E4Fhkz4/Le+UUsSb3AimbS3z2fD/5ZB3nImbVxc/xaKbYPWW
        PUzCfb3pSHSTQhq1BZs0uEVU44GUvbJbCg==
X-Google-Smtp-Source: ABdhPJzrJZKyUtD/n4mB5S/SLyhOR8MN/nGmg3MWJXyWm7D1ECqQK9A8AuUtiyBIRU5UbqiXYQ9H9w==
X-Received: by 2002:ac2:4a6e:: with SMTP id q14mr24704180lfp.685.1632243674060;
        Tue, 21 Sep 2021 10:01:14 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id v26sm1718430ljv.77.2021.09.21.10.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 10:01:13 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH] fs/ntfs3: Remove deprecated mount options nls
Date:   Tue, 21 Sep 2021 20:00:53 +0300
Message-Id: <20210921170053.48676-1-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some discussion has been spoken that this deprecated mount options
should be removed before 5.15 lands. This driver is not never seen day
light so it was decided that nls mount option has to be removed. We have
always possibility to add this if needed.

One possible need is example if current ntfs driver will be taken out of
kernel and ntfs3 needs to support mount options what it has.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
Patch is compile and checkpatch tested.
---
 fs/ntfs3/super.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 6a535b144ff9..66a3d02a5e14 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -246,11 +246,6 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
 	fsparam_flag_no("prealloc",		Opt_prealloc),
 	fsparam_flag_no("acsrules",		Opt_noacsrules),
 	fsparam_string("iocharset",		Opt_iocharset),
-
-	__fsparam(fs_param_is_string,
-		  "nls", Opt_iocharset,
-		  fs_param_deprecated, NULL),
-	{}
 };
 
 /*

base-commit: 6354467245ff8dd04b54e39790f2ee4d21d5419e
-- 
2.25.1

