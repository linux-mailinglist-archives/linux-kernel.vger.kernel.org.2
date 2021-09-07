Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4EF402531
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 10:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242568AbhIGIgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 04:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242600AbhIGIf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 04:35:59 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750A4C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 01:34:53 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id m28so18055015lfj.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 01:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UJApqLngxfd7a6IDA3UxDk/w6qCztaloZ9E8eyhf+ng=;
        b=L2Pt53KMeQrpffXx4u4xBfRkHxzSCo70c1lGMrE4GGJa6EVbAdGx20+4QaNMi/3yPD
         a68eE9Jxt62Mp67DO/1SvMcB9KjPKEo5VCvQacTzyfUymLcba3uJg6dHsI7/ElxFKWrQ
         ihnES8LqLchUk4WT3G1E3+Jyif7VJV1pOAN3SS3KWhxw/R1XNzKSauWn4HvpxrYdYaY+
         jQBTwm49gQ4qJj2caP3a6N2IN45DsVWhDf0Dm9YCU9J5dQ/3l5kSVWpA1TDYd+talUPo
         HGlKfFPB9j1xT38TgAGQbflsilsdbywDcNpvtad94Rtrc1+TrPORCs+RGEOFlpaRNssE
         EaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UJApqLngxfd7a6IDA3UxDk/w6qCztaloZ9E8eyhf+ng=;
        b=horBtVyf3H3KTO+B/9pjQHr2gRvVEfgCh9NgtgR/eZHQGGAKBHMxSMATL49eLuqzhf
         UggJTQ+ftwCTur3mV1d9D+ApyxPfmkEIDef79icJ8EjgAGpV7ffzJX3IFRWiEBcf5cFm
         eo/y9wrj4wKnqrG4Ril/Rmz3IlY5gnpapCroD8IK58F4Lo0M+MtsdcxW32HHDoonASNb
         7ciVh3gbG/pbthIXVbigHuB6kKemt/CY1JLOGGIjD5ttodtprCDl2A+r3XnBcih7F4Jp
         eVzY805B1IWstfo4/USQN2+6hqmTt2NlSGzLBwW5armhl7kkwxt4ZLVDATafiuuPzSdJ
         AG0A==
X-Gm-Message-State: AOAM532BU8lXNtMPo57xtfZDq24KCh01EzQCaoIMPzVYEUDbYIsznOBT
        k5mqbvnQjkWlMgrELrv4GZ/mUbW8mK0=
X-Google-Smtp-Source: ABdhPJwWYyrQMbQbsn8286j/Ujxba+mOtusle06cmfdzVVSuhs4C51+wk/dTIwjjxdRTSca3jZMDFg==
X-Received: by 2002:a05:6512:3f1a:: with SMTP id y26mr12716010lfa.263.1631003691856;
        Tue, 07 Sep 2021 01:34:51 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id q30sm944771lfb.155.2021.09.07.01.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 01:34:51 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: [PATCH v2 1/4] fs/ntfs3: Remove '+' before constant in ni_insert_resident()
Date:   Tue,  7 Sep 2021 11:34:38 +0300
Message-Id: <20210907083441.3212-2-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210907083441.3212-1-kari.argillander@gmail.com>
References: <20210907083441.3212-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need for plus sign here. So remove it. Checkpatch will also be happy.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/frecord.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 938b12d56ca6..d1477cabe3c7 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1451,7 +1451,7 @@ int ni_insert_resident(struct ntfs_inode *ni, u32 data_size,
 		attr->res.flags = RESIDENT_FLAG_INDEXED;
 
 		/* is_attr_indexed(attr)) == true */
-		le16_add_cpu(&ni->mi.mrec->hard_links, +1);
+		le16_add_cpu(&ni->mi.mrec->hard_links, 1);
 		ni->mi.dirty = true;
 	}
 	attr->res.res = 0;
-- 
2.25.1

