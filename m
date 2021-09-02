Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31C43FF0F0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346175AbhIBQQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbhIBQQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:16:37 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929ACC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 09:15:38 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y34so5468516lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TFcTQJKSbXDRLP9mWB7XxD8YdU1LWh59xr03hi/9bMs=;
        b=Ncbaywy50BWV9K53Lja0oOK+hE2NJc3JWDDWmDuJkBmZFH3dJuRUQhFel0fj8Oie3/
         Iib1SN4j3zZkSg/U13+RuASbw9thH/kaiaR9DbbwMJh5lyS2abh7XOGUvTsLVtNIOLPC
         i/JbMPIpRx1zY+3diKLAWqMUq2DLX/O64A7H0x3dwDs89DK4vm0+iQZF/mpljg45gpZx
         idAkOeUndYt0yWcqoNe22CrXa9Gymjy2YIG+rkf+CzKMtVcfTeIjHRec1cLDxDbGvvVj
         2eDryjk02v3/0vu7oIclQxktr1j0G37wH7B/1noKm4FfZA+psBcMuqUlsf+0TOba290V
         KucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TFcTQJKSbXDRLP9mWB7XxD8YdU1LWh59xr03hi/9bMs=;
        b=uHl1RNVBlnmfbkJO20t5T+WwA76fTgwv6B2rg9Jk6/UsdE0lMaS5zAb1HOIRQXroEi
         QieMaqJbuc+DP+5CfUZiWXaPNxZeoTpElHH4E3frUpTAiVTKgr7DKpGie6NctHOZH30l
         5Jy/XagWCIh/PsdWoI52namLhr+h3IPpOYsHWnpFvb8MXLpC7zC4FbDn0JCqYOqtRuPC
         4583XdPr+V6PzGSWbs/iNL/iidN98mkBSFDXJPo42iCwMw6bySA6AvPwnnA/VGlyN6Zo
         BMma2pF4rSqGy/5Wu2W6ZLabS1IRuo01RJ3SOvLU9w1yNF+jbgscGHBmJ1mN3/oZ14Li
         WXSQ==
X-Gm-Message-State: AOAM532O9dboVsrftDMgSRVa4We3YQSZOXhaRM96EgE2OUPFLsfGy6cl
        YrPqWilFa6zr7XTinT/W+us=
X-Google-Smtp-Source: ABdhPJyNOOMEs/bXSH41xnWiO4/nVy+dtMoDUlM/uXEKQkHzOL69XPmqEPxeEsAd5vv85Z3jWJ+SNw==
X-Received: by 2002:a19:4853:: with SMTP id v80mr3147164lfa.365.1630599336951;
        Thu, 02 Sep 2021 09:15:36 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id m7sm267811ljj.58.2021.09.02.09.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 09:15:36 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] fs/ntfs3. Add forward declarations for structs to debug.h
Date:   Thu,  2 Sep 2021 19:15:21 +0300
Message-Id: <20210902161528.6262-2-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210902161528.6262-1-kari.argillander@gmail.com>
References: <20210902161528.6262-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add forward declarations for structs so that we can include this file
without warnings even without linux/fs.h

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/debug.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs3/debug.h b/fs/ntfs3/debug.h
index 31120569a87b..53ef7489c75f 100644
--- a/fs/ntfs3/debug.h
+++ b/fs/ntfs3/debug.h
@@ -11,6 +11,9 @@
 #ifndef _LINUX_NTFS3_DEBUG_H
 #define _LINUX_NTFS3_DEBUG_H
 
+struct super_block;
+struct inode;
+
 #ifndef Add2Ptr
 #define Add2Ptr(P, I)		((void *)((u8 *)(P) + (I)))
 #define PtrOffset(B, O)		((size_t)((size_t)(O) - (size_t)(B)))
-- 
2.25.1

