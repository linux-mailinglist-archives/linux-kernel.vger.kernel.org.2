Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6154A42404A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238734AbhJFOnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbhJFOnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:43:32 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5D4C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 07:41:40 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v25so9536934wra.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 07:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ntN5tqgwu99n+aEqEL2zcS4YmnrQSSPWq5iPGALwNCk=;
        b=i3B8MnLe2RLvSLkBY3kizTv7DSF8opLPeuqgTF/WT5qLaecT7XKzpnHjhoZqiRSoeW
         Q6HU5BBQ12GZ1JTfWJN6Mo1d7ay9U8SFclCpkdezbtalr/7WnAhqgdx8/hm2Q3nJk5gr
         tqtChwbf7GTkpgxw/mDuuab90hmQg7ALKov3MzBml0/gogs+7wW95/3QkhVpWKr/EZyO
         QYLiLqWAujSi+rQu3HlozI8xqGRKXKjJyICiQYns9Xr9HtNCVxgqBvIlgipqzeFU4f4s
         UxJz5lJ/2/kQPgV6D8lnnKSu6HYAimSS/HqVGmA4VL0peWTH6lxIPHTKF0n5XylgxqNh
         jEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ntN5tqgwu99n+aEqEL2zcS4YmnrQSSPWq5iPGALwNCk=;
        b=HiKs2DyqDbP/8WItUTM+ogouL71V4b/76L302w4/3+OYiEK8kisHd7l6OTnVBTJCJ+
         joiuDVm4dYodLHbujvNe7HVWQsmLJ7lRadLChMAyPlO3RvxlttUe3IH/z1NgPLH4CUfA
         zH/IC07PXHvdGqPT1xVMkygwZkFqhUd1BEicP7oFOCcrljOUbNJtOBMT0UuGvj8/rX+N
         O22P91bll/APquka4BAK76+Dh7GDytI7cWtRH2UO0+54C2jX7UDqxuTUVMAvwNBIg+UV
         VlvkiP3hQh8HBf605KUx6vcB1+HfMgVSeqiIBSs/CSm4oiD945a2GQegDqbBhD6BL05i
         mu0A==
X-Gm-Message-State: AOAM532bIHAz8VHtlKvOAXZ3kJaBHhJNw/rX4TvAEeqykhtOS/SlsNe7
        K4IOat/BGS9HyfrC1sTfGkQ=
X-Google-Smtp-Source: ABdhPJxCfdpJZu7wucFwmm7prXGvE654Ez0lGx+IhBwdr2X7oG/+Mpi4rdu3jmh6mTryrZOP2+45NQ==
X-Received: by 2002:adf:b185:: with SMTP id q5mr27472212wra.213.1633531298766;
        Wed, 06 Oct 2021 07:41:38 -0700 (PDT)
Received: from localhost.localdomain ([197.49.35.129])
        by smtp.gmail.com with ESMTPSA id n14sm8156526wrm.78.2021.10.06.07.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 07:41:38 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
To:     sohaib.amhmd@gmail.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Fix typo in stable/sysfs-module
Date:   Wed,  6 Oct 2021 16:41:35 +0200
Message-Id: <20211006144136.130213-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove repeated world: "the the source"

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 Documentation/ABI/stable/sysfs-module | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-module b/Documentation/ABI/stable/sysfs-module
index 560b4a3278df..41b1f16e8795 100644
--- a/Documentation/ABI/stable/sysfs-module
+++ b/Documentation/ABI/stable/sysfs-module
@@ -38,7 +38,7 @@ What:		/sys/module/<MODULENAME>/srcversion
 Date:		Jun 2005
 Description:
 		If the module source has MODULE_VERSION, this file will contain
-		the checksum of the the source code.
+		the checksum of the source code.
 
 What:		/sys/module/<MODULENAME>/version
 Date:		Jun 2005
-- 
2.25.1

