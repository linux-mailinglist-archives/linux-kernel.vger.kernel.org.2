Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF0335ADE1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 15:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbhDJN73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 09:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbhDJN72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 09:59:28 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E411C06138A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 06:59:13 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so6390740pjh.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 06:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=rfTe7qVwJ3j0wr2RCsj+TUrasTd+AoVaaUkJcF+TL78=;
        b=h5Ou9+OiaESvdUnOFknMWzm5BZvQjhhLDihQC+Fczy8srhBlFsRJZsXov9/5n+vfUK
         SZN1d3T7LbiSBKZbnhqF3vhZyafvp3qJy0jlpz9/JcqkkPoE3dInG5uX+ippegOzaWyl
         Cn3fqkxA/V9lcmPBqWAr4hsCP3Z/iXWDlWpZ1dEhnKagnLFLW5fQlVZBZL8jqlP1CK+A
         vkiMUxCAXM5UeFq7MMtptKcccmJrXyzD/N9xOqc+S02GF8s0j0zviIaCmXpo01l0S/GG
         uLhbMqJm1jKz9YFx3bvKbQZYAj94FXISxhEXZ5FTSn0rbBbCRVzAXSqCxXPe4kTFMGOv
         aIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=rfTe7qVwJ3j0wr2RCsj+TUrasTd+AoVaaUkJcF+TL78=;
        b=B2Rc91xdVIB6s1WfwsAc7/1RDsF5+5zpZgOsQpHiyvv+2T75nqsgyNU7YHtNJ1ATLv
         kcUFxNTyUF+T5I+i5sKL/QzJ7F/Bn7EDvwB9BNVznfeRQEzbKuWb/xuazKCzzLS/dC7J
         Xgl/IVNQs6Y4dy6grfvej793fiyUh4sTD8eEiFEZdzxDyLKdeFQPgrGCpi6Es8RvFcFu
         F+KwvxV2LUu+tZPruCSbhhGQZfmOPcHRekZ4c8ZmwiFWXZlZ25QYyTWi5ontzhLWGAlQ
         F3ApdAydfybCtwUHq4OFX2l94WIiZmpo7Do6oxgnVUEG0RNXY64inocFjgYwQBSg7eT4
         yHiw==
X-Gm-Message-State: AOAM5318enmATUIV6+ccD4wB1imCmcTXIHrdwosqIdgcVK6DQJQqSMQT
        xsgz96tupEg3RCTie9aK4i0=
X-Google-Smtp-Source: ABdhPJxeehylySE2bL479tNyW69Q0UAX9z+Ki1FawSLvDa4Wh/+z6Nskm8LDqPK2pytH+5VNfgzzAA==
X-Received: by 2002:a17:90a:7348:: with SMTP id j8mr8072477pjs.155.1618063152360;
        Sat, 10 Apr 2021 06:59:12 -0700 (PDT)
Received: from kali ([106.195.15.71])
        by smtp.gmail.com with ESMTPSA id q66sm5519824pja.27.2021.04.10.06.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 06:59:11 -0700 (PDT)
Date:   Sat, 10 Apr 2021 19:29:03 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v3] staging: rtl8192e: fixed pointer error by adding '*'
Message-ID: <YHGvJxMhQ8nzHf6I@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed pointer error by adding '*' to the function.
Reported by Julia.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
Changes from v2:- modified patch body but writing commit message
clearly.
Changes from v1:- added pointer to the function.

 drivers/staging/rtl8192e/rtl819x_TSProc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 4457c1acfbf6..78b5b4eaec5f 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -327,7 +327,7 @@ bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 	}
 
 	*ppTS = SearchAdmitTRStream(ieee, Addr, UP, TxRxSelect);
-	if (ppTS)
+	if (*ppTS)
 		return true;
 
 	if (!bAddNewTs) {
-- 
2.30.2

