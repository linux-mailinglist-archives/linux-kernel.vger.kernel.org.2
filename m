Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35A7413834
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 19:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhIURUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 13:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhIURUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 13:20:46 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E10C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 10:19:17 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z24so203046lfu.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 10:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UgfqvwQAazOlHIXcgFNfzq1ZdpEvlmtOO/XH1GP+f4k=;
        b=oJXjpHvCGQJLAA0DhTlfYxl9dxCtowtACDgbFh9MDIXtqM29jzSB8077+iMR/7NCoi
         bZDg4bBvBRgS4kvg1g0U03+jOiwSal7FEtmpFB4niVtZinzGfNwoH+PVnzAtjgLXfYt6
         bDoag0R0NGPUN9KBLvEs5JbUOfJJvrTIjjE1YgZ3fNqcDcZvVmSDrxS862iw/sFiAJAU
         44Eyfn06yoXvnGbZ5BEsOybL1w+UbjgaF7zLws5tjEDI8AletGWa3ralyvWFFfv92uuD
         HDV9MgDBr6iDlWCNHzzoBN1KnGy85GsJ16duikVGSwdcx85aRd61llmXUPdTOmrTJi54
         0AmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UgfqvwQAazOlHIXcgFNfzq1ZdpEvlmtOO/XH1GP+f4k=;
        b=fQAM2Mo1MgWPIBc8pSsscH0R0WyrmU+Sn3H674aUTNqmCf/lv1tpPdCzvhlVW5hMsF
         z9HvNBrdVmeqEMo7LS7J0QaQEuMYPLjABw0ilsZqfBb7ZREAa4oQdcoR2B+a9DuR0RFC
         ArbECIW5HEOSifMEjQxjzfLyQ3OPhe7OZgTww6gLOqGGUJVdgKQc5zGAHGuDif+yhoO3
         a3amzZQFHLz4aG1mR2U+kUqsTVazFmvp7ky5d5m1nVIGfcuBTvt7IMkvbTyPH9+5yXGJ
         wGQckDCvzxljsLYhemvIiSQxxzpwzQUJsGX+a9jdd3YmlhK3Tkv9vtSky+yrWybT7oG8
         ey3A==
X-Gm-Message-State: AOAM532Pwx3IAZzM3tl4Kse8jXRXoImrPNIrqq53NCCdh/F5RXuAcADt
        3wD7fqS8rqWFY05h5VfYpcXDx0F1pX+H0w==
X-Google-Smtp-Source: ABdhPJwlEx6b1YEEbjuBXwWeH2SHiMdFzGwheKz7e511BhxAIkOtew+4tlb7eEQSgQBHcV8p4cZLtw==
X-Received: by 2002:a05:6512:2244:: with SMTP id i4mr13240636lfu.219.1632244756199;
        Tue, 21 Sep 2021 10:19:16 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id w12sm1709258lfr.140.2021.09.21.10.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 10:19:15 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH v2] fs/ntfs3: Remove deprecated mount options nls
Date:   Tue, 21 Sep 2021 20:19:01 +0300
Message-Id: <20210921171901.49176-1-kari.argillander@gmail.com>
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

v2:
	-Do not delete {}
---
 fs/ntfs3/super.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 6a535b144ff9..800897777eb0 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -246,10 +246,6 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
 	fsparam_flag_no("prealloc",		Opt_prealloc),
 	fsparam_flag_no("acsrules",		Opt_noacsrules),
 	fsparam_string("iocharset",		Opt_iocharset),
-
-	__fsparam(fs_param_is_string,
-		  "nls", Opt_iocharset,
-		  fs_param_deprecated, NULL),
 	{}
 };
 

base-commit: 6354467245ff8dd04b54e39790f2ee4d21d5419e
-- 
2.25.1

