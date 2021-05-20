Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119EC38AE97
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbhETMmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241923AbhETMlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:41:25 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDF8C0611E4
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:50 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h4so17341861wrt.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LSk8PJWA2mLFQptLpvRy6SQT0qGCu3VNDirVI3p3YFM=;
        b=ryk/qhWaGWbbs1acfB/NE3DeKWAKr1FiJRHcXoyvdhDZDhM0d4FyBU6CJ/6bC3F1Kt
         VoeK427t0Ocyjr7o7CNSAou5JIaKHZZJZG8bIfXxLuuMZnS98PCG4uR+VVEaCWHVVZS0
         0+TG4YXxlVmlSIEbQCkMyur7FFIKVZ99IN9mpiQLpRuK4hTbIEVpqvS5VfBpeEiRC+vZ
         z9K1Vzg1pzEvW5Q7grA659abPt4jvlDSAYj3Xie3v6VPbQz9hygPCtrtXSk36NIATWj7
         +i9GEhS7fIdnc353fUsxHV48/0emHfNmwr0bSp+6ZNutRsEp76b5ML9PAjUDfHHdrZgm
         IGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LSk8PJWA2mLFQptLpvRy6SQT0qGCu3VNDirVI3p3YFM=;
        b=lsEq3pmOhpsAMNyD0CPhY1hAYXmLvQugr9/KMX8qZ3cbJKADLHNkP+tFtoTJyI7vcV
         UBRPz5XqmQNbOQPGXpQqnqomNJdZiq9KkXc7+qFcapS2m5yrNjUo77LPplUYifKoIz0N
         4D9+x/Byr1zAMBCXtV3tszFPXbI0WIqMHhuokvU2aL0u1Ze3hLziLt/OYKdZKjTNok8S
         SecWxewXGvyMq4oyAgx2OFFPUolPDO/GzElJwvNl5Dcr6f2KPXgSY5gfr7sAhS3cfv2t
         ESCBNxh4Xs9135zULf0IuNljUHwNLlIfikk+z3Y+rjfTkiN70FSPmMvY6IWOQf6lGVNn
         Ib4A==
X-Gm-Message-State: AOAM532bS1tkVW0mZ1opOeGoCFp2WRb+sGSepA8cX6oJT8wo1j2OeA/F
        NcddcY9PI3AnYQJHQ3bhtdiSlw==
X-Google-Smtp-Source: ABdhPJzu5t4scsuBudttjz2xSwz5DOedJgiewDQe4MinYJ1i57ogOz9OqzzK2ducKUUPjKe9tTVgAA==
X-Received: by 2002:a5d:44cb:: with SMTP id z11mr3984539wrr.159.1621512049315;
        Thu, 20 May 2021 05:00:49 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id s199sm8848269wme.43.2021.05.20.05.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:00:48 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 04/15] fs: ntfs: unistr: Add missing param descriptions for 'name{1,2}_len'
Date:   Thu, 20 May 2021 13:00:32 +0100
Message-Id: <20210520120043.3462759-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120043.3462759-1-lee.jones@linaro.org>
References: <20210520120043.3462759-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ntfs/unistr.c:87: warning: Function parameter or member 'name1_len' not described in 'ntfs_collate_names'
 fs/ntfs/unistr.c:87: warning: Function parameter or member 'name2_len' not described in 'ntfs_collate_names'

Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ntfs/unistr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ntfs/unistr.c b/fs/ntfs/unistr.c
index a6b6c64f14a93..faa73be4201f1 100644
--- a/fs/ntfs/unistr.c
+++ b/fs/ntfs/unistr.c
@@ -65,7 +65,9 @@ bool ntfs_are_names_equal(const ntfschar *s1, size_t s1_len,
 /**
  * ntfs_collate_names - collate two Unicode names
  * @name1:	first Unicode name to compare
+ * @name1_len:	length of @name1
  * @name2:	second Unicode name to compare
+ * @name2_len:	length of @name2
  * @err_val:	if @name1 contains an invalid character return this value
  * @ic:		either CASE_SENSITIVE or IGNORE_CASE
  * @upcase:	upcase table (ignored if @ic is CASE_SENSITIVE)
-- 
2.31.1

