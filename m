Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41B23CC93D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 15:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbhGRND1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 09:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbhGRNDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 09:03:25 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED89C061762
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 06:00:26 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id p14-20020a17090ad30eb02901731c776526so12194737pju.4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 06:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bSHPvZPfRYSth2tUS+kE5c7yrjHQorfQj9Klu2G123E=;
        b=OpqE0H0U5nfLqCRHzHbS+ZQGBFRXp+bI+2tX5Dy7QRgE7IvktgkCO7I9dZhm2AKHxP
         iDiuZWQsDxSkO6e91VDaDww/y1KUEiNSNxeB6HrFz4q8mxeIFX21SrlEzUZ9DM2Gl3Mn
         XjumSj5KB7+pIVTVUdkDaSC0yM2Itb72Yt6YmkOU5WTamXI1b0vBWzXRtWL/Sa0+/Aem
         jujlYPO2FTT1fFKPUXlEu1pLbwYqqrG4qjLAldfEw53q2avgQsssPRyyw74B0gVghJyw
         zrXRsQi00i3vKFv5iqQpwwjBHJqxacVk96dP2s9nh8B458z4BuNAOkHQoiQV0orQFyVD
         zGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bSHPvZPfRYSth2tUS+kE5c7yrjHQorfQj9Klu2G123E=;
        b=hPzjFhthdIK8ii9pBPLZ7NS4Luw36O877bxQopPcpvzs50MCmUYJvSytF4a8i9gfKT
         fK1uJaSWHXmCcyODmxgAaxJupgtQjgyIq82NWOzKWtGAkVIkPpA4qtq1vBYAl1C64Bsw
         jZ/ArmKFUsCZRi2JEi1tQLqiLbWRJV/wACFiLNKCypgVwEyp2ufykgCmMAaCm3ld9n94
         k70sqX8qLbDW9wbVDt9rx3n7cjJcoelgxB71Y7s1jrzlJvVLhX0L2bvrnC80mQdjGGLn
         V5I94em3vg+7jZ6HMOcBP1u4Xb3nqGdmnaVBH8Ed26Gymp+1i1XXrW12n076hFgqO8o5
         GXqQ==
X-Gm-Message-State: AOAM533e3N1TkmnidDIMD5AasGAaRgcUXU7GZSlyHCpZ609wflkoKSWi
        Zy03CoBeEfqPhdMaSuQMDoE=
X-Google-Smtp-Source: ABdhPJyc4TURBaVcefqAvMJ8wxvNKyyrcz3F/gG1Y83mxlRblAoDgsW4fteOvaj/zfxbh/jzRcvQnQ==
X-Received: by 2002:a17:902:b717:b029:11a:fae3:ba7c with SMTP id d23-20020a170902b717b029011afae3ba7cmr15048651pls.28.1626613225856;
        Sun, 18 Jul 2021 06:00:25 -0700 (PDT)
Received: from localhost.localdomain ([49.37.52.138])
        by smtp.gmail.com with ESMTPSA id n123sm17698981pga.69.2021.07.18.06.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 06:00:25 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
        apw@canonical.com, Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH v2] checkpatch: remove obsolete check for __dev* section markers
Date:   Sun, 18 Jul 2021 18:30:15 +0530
Message-Id: <20210718130015.8903-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 54b956b90360 ("Remove __dev* markings from init.h"),
the check for __dev* section markers in checkpatch is obsolete
as no new instances of these markers can be introduced in the
kernel.

Remove this obsolete check from checkpatch.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---

Changes in v2:
- Reword commit message as suggested by Lukas
  https://lore.kernel.org/lkml/CAKXUXMyvOh0GvpEf4uX5iFJYOJLo43tmO16Uf34j4i6XD0vBcg@mail.gmail.com/

 scripts/checkpatch.pl | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 461d4221e4a4..e29c0961b25e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4023,12 +4023,6 @@ sub process {
 			     "CVS style keyword markers, these will _not_ be updated\n". $herecurr);
 		}
 
-# check for old HOTPLUG __dev<foo> section markings
-		if ($line =~ /\b(__dev(init|exit)(data|const|))\b/) {
-			WARN("HOTPLUG_SECTION",
-			     "Using $1 is unnecessary\n" . $herecurr);
-		}
-
 # Check for potential 'bare' types
 		my ($stat, $cond, $line_nr_next, $remain_next, $off_next,
 		    $realline_next);
-- 
2.28.0

