Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB9B3FCCD0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 20:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240310AbhHaSQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 14:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239874AbhHaSQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 14:16:17 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C0AC061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 11:15:21 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id c8so710051lfi.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 11:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JHwVl9p3WIdSGjWbPUSNGnijhNENWZWD5QfH1eVWlE4=;
        b=cRaWoteDywWKRle0O6x88j38TTkXzjFwy28g2Z7CtEEsieen3UuD4OcN76wU9rkEY0
         MYvfdkZ6lQ75oYM74QcpDX31P/vaHdnxu0N+IXd0qn+eNFuS3U6ty+hAJauRO0RFVLL9
         IKFbPK3uqSg2av/EVmfs5hzs0HDx/Q3VWmJGVh1caUQhYAFP30N3R4YQ6/Tcy0D2mFJc
         iB4WJQl4hI8tSVURmf2ZAummiaHV3QhrW2JVnlf1xCpGUlGXUDrGY+kcOwMW1kgSLAkN
         b7HEZxRTWHV9RFsCD0+OVAAfjH7zhRnbzeiw1nfz6RXnW0th9PPxZOHveY3sGbmm6Ig8
         DW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JHwVl9p3WIdSGjWbPUSNGnijhNENWZWD5QfH1eVWlE4=;
        b=jWvIzBnSVjMaKVgYUAra2PWA5pVpQS4FqcwpBIzhf7LVrAY6p0Uxw2hsRYFgQsppXF
         v3Lk837HkrbgCH/KTNPkwvmGMMfrp60G3LCu0VKkGPhQ/qKyI/ODMOcWp7SLVeJMS0yY
         qtyDI8mxjiYPty0W1d2ZsWSNoA3BEm2OrPJehkpmlXUAu6Bc2R7AS04RqXR/PGhX4d2+
         utDIOOUOMqMvp3ZWThJOgNwDLA68y3sEtToc9nWWmvPlX0PDSTGr0qOvhWHOnGjIgjct
         CQ5S3rBgPVK3NYK8kot1iQiJNrEAD+WoGk2d8jW88VqUpYtckBQlX7eT2WlL1f3f2/+v
         CY3Q==
X-Gm-Message-State: AOAM531elK8A9U3dFHzHsljs3Gg4I3SGXcsOwOxAgpXsx/GorSLv1Ttu
        H7nCg4m5yil4HFVkStIcasw=
X-Google-Smtp-Source: ABdhPJxfH0Jemwd+4N04GgmmLpXPStD7IWJ37erkb6a9OETOhF+smVyfGWrUXJX3wP7U5LbP1gitlw==
X-Received: by 2002:a05:6512:302:: with SMTP id t2mr11287728lfp.87.1630433719610;
        Tue, 31 Aug 2021 11:15:19 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id z11sm2270757ljn.114.2021.08.31.11.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 11:15:19 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] fs/ntfs3: Place Comparisons constant right side of the test
Date:   Tue, 31 Aug 2021 21:15:03 +0300
Message-Id: <20210831181505.1074767-4-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210831181505.1074767-1-kari.argillander@gmail.com>
References: <20210831181505.1074767-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For better code readability place constant always right side of the
test. This will also address checkpatch warning.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/frecord.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index b207d260ac06..bc3887635012 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1606,7 +1606,7 @@ struct ATTR_FILE_NAME *ni_fname_type(struct ntfs_inode *ni, u8 name_type,
 
 	*le = NULL;
 
-	if (FILE_NAME_POSIX == name_type)
+	if (name_type == FILE_NAME_POSIX)
 		return NULL;
 
 	/* Enumerate all names. */
-- 
2.25.1

