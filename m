Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63D2320FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 04:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhBVDHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 22:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbhBVDHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 22:07:13 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C79C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 19:06:33 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id b21so9366956pgk.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 19:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ifwY+K3DGDVE8I0fPuDEawPR/idvz3X1KyWG92YlP7Q=;
        b=d4hNSdjWAyEB8dGRDngbGNIdJWAR92fB1TqLMDQAqH3vRQ2ATeKOqanW3ThV4FM5xb
         0l0uT9euAV8i94Jijxbp5cCq+vRVxGYjMgboH38A4lMyOZNiM6lQgUNkranHwupfL+OF
         kmDmf2SIYyhpUNdjfJgU+0kzxCUYjo2INHAVbxXSvDOqSMOjFxchdeeiRbCv+2z3Lsjv
         f+8ovlgVXiLsBZ89/lfCmEGrju4nmDVlTxNCxWe7/6iA7N6CWXMp137EUJ3xV4HXo8CD
         1fbtMWgrTfn/pKbXMOUJgP1WRU7MvrUn9Yi4TmbPzvBogfvoQPo7A2EfkhInMGP77lRK
         toQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ifwY+K3DGDVE8I0fPuDEawPR/idvz3X1KyWG92YlP7Q=;
        b=JocbIEposkRSqDDWn2RZhAc9nRZSMJfUlce/dIckkT/XNMszfgF7LcjL5d4TJ+eZDX
         XRWPwYSPH8sy6MTS3LHtwK25993i95sweddptBFbP/lB6NwamVJgCTI3SaPTu5dlUBYP
         grXlcXCe8gQjuGIzGpYQiWZEu256R23wCdJek9km00DR2zZ2w6Q2o6ynBiXvkb0wv/EM
         jDAsxb0BDEQlLJlaKI7l6syysIZU4JjJC+H2ibOxaP7jZRm4q2UQTwh3RVcZxSkglprI
         y8tkBEDOe+hURJAOm0pKf5KnUjK7m8s7gUg09p4WBgEGrP3jUwQjzflMvr7AguHOsflR
         M1Pg==
X-Gm-Message-State: AOAM531VPcpxIWWzBpXtKnmtzA9R7eeNkxtgor2KlZ+tzo4G4MFJUh4q
        HKCbEscgq0wP40Kw4Yhk2E0=
X-Google-Smtp-Source: ABdhPJylE+H5xMZAZU/R9gwSuZmwNyF0hWU0J8hajfvV6cjFdgC3FgIq8U5Rp+wonCB697wPCnUjCw==
X-Received: by 2002:aa7:98ca:0:b029:1ed:4469:f03c with SMTP id e10-20020aa798ca0000b02901ed4469f03cmr12205119pfm.78.1613963193103;
        Sun, 21 Feb 2021 19:06:33 -0800 (PST)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([209.9.72.215])
        by smtp.gmail.com with ESMTPSA id f2sm18851683pfk.63.2021.02.21.19.06.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Feb 2021 19:06:32 -0800 (PST)
From:   Yehan Xu <yehanxu1@gmail.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, xuyehan <xuyehan@xiaomi.com>
Subject: [PATCH] Documentation/ABI/testing: Fix a spelling error
Date:   Mon, 22 Feb 2021 11:04:43 +0800
Message-Id: <1613963083-29332-1-git-send-email-yehanxu1@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xuyehan <xuyehan@xiaomi.com>

Delete the letter 'e' before 'number'

Signed-off-by: xuyehan <xuyehan@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 3dfee94..21d14fa 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -276,7 +276,7 @@ Date		April 2019
 Contact:	"Daniel Rosenberg" <drosen@google.com>
 Description:	If checkpoint=disable, it displays the number of blocks that
 		are unusable.
-		If checkpoint=enable it displays the enumber of blocks that
+		If checkpoint=enable it displays the number of blocks that
 		would be unusable if checkpoint=disable were to be set.
 
 What:		/sys/fs/f2fs/<disk>/encoding
-- 
2.7.4

