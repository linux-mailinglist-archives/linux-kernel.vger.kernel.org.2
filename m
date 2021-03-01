Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F4E327E87
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 13:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbhCAMok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 07:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbhCAMof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:44:35 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D3BC061756;
        Mon,  1 Mar 2021 04:43:54 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id dj14so410747qvb.1;
        Mon, 01 Mar 2021 04:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C04ypYxERhliPvMoWcsTnuHO+a7l/cXwZ/KEzieBKkQ=;
        b=utNEGGbEbBR5UrfH2veFzik8HZe8Hnj/6uAMTHNa5xILiWXZOzcA0oNXy3+SvzjCYo
         CTQ/mRNFQkjmZZ38wqe6ocOTPrtljzZF3MOiS9LZIe4oQzWVvfUyE8Wr+3tVFHZfy6YK
         fFjWFZSQGIzAZ+mVVrdHg5z53MDBonHfR5m5uQIsRSIKu1wafupYgN8tVg52Z+pRqxHL
         Hm7RzuWqs2VwwXLpsEgNXWiVtHFN4usYJcha3b55EVwYGB/kneAIF6pJ5bUjzjO13bTA
         WqJaEc+Jk2LKjw/rdP2R+76mmCbYgfs/p2ejILRhez/nQjPdknb5otXU1vuvcTNsRtlr
         +WCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C04ypYxERhliPvMoWcsTnuHO+a7l/cXwZ/KEzieBKkQ=;
        b=mxVJvWpBRsPccOepV4wEe2HDEaamXfQErqQ2rhuhLWBn5felgxqE83zYINSbvtsht+
         /BGwUTbjPxBRhyGz0Lfb4/Ek0NbqAdl3A1KapTbHH4+oxgrGm+Khjf/+VGpWA2oDZ2Q/
         iLm/vLZwUzERxaYxbjXNF9R6m/eAU2IvHxV9ybsGnsESiccomzvgtEX96F9hlQsu3Ox3
         tqUzm32ghHYfF1Z6xsEW71LvR+4sRjBMLn7V2+2CfYo2q0YmWxH8PuMkrXDeAX3MXpVK
         8QvrG5YsaZwVSxSP78oMaRkE6uR5mUmzX79h/DWufFdb3mLOt3n+6BLbnNh9Z64VpnZN
         r+aA==
X-Gm-Message-State: AOAM530TpM2QFzjUBiqEgUo7reruOZCHnrMdvQwfPEHLBCtE5xtQBVDl
        Pvm2ZyXLNS5mebeKSGEOGB8=
X-Google-Smtp-Source: ABdhPJz8tvFt8lapkOzODyleso3eRYVd84fZ/pm++bGw6oOGYAi4YlUD8FcwIyvEioxLazvKo2c0qA==
X-Received: by 2002:a0c:a0c6:: with SMTP id c64mr2576614qva.57.1614602634147;
        Mon, 01 Mar 2021 04:43:54 -0800 (PST)
Received: from localhost.localdomain ([138.199.13.198])
        by smtp.gmail.com with ESMTPSA id y1sm12327345qkf.55.2021.03.01.04.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 04:43:53 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] docs: sphinx: Fix couple of spellings in the file rstFlatTable.py
Date:   Mon,  1 Mar 2021 18:11:36 +0530
Message-Id: <20210301124136.11602-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



s/automaticly/automatically/
s/buidler/builder/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/sphinx/rstFlatTable.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/sphinx/rstFlatTable.py b/Documentation/sphinx/rstFlatTable.py
index 2019a55f6b18..386c435e479c 100755
--- a/Documentation/sphinx/rstFlatTable.py
+++ b/Documentation/sphinx/rstFlatTable.py
@@ -22,7 +22,7 @@ u"""

     * *auto span* rightmost cell of a table row over the missing cells on the
       right side of that table-row.  With Option ``:fill-cells:`` this behavior
-      can changed from *auto span* to *auto fill*, which automaticly inserts
+      can changed from *auto span* to *auto fill*, which automatically inserts
       (empty) cells instead of spanning the last cell.

     Options:
@@ -171,7 +171,7 @@ class ListTableBuilder(object):
         for colwidth in colwidths:
             colspec = nodes.colspec(colwidth=colwidth)
             # FIXME: It seems, that the stub method only works well in the
-            # absence of rowspan (observed by the html buidler, the docutils-xml
+            # absence of rowspan (observed by the html builder, the docutils-xml
             # build seems OK).  This is not extraordinary, because there exists
             # no table directive (except *this* flat-table) which allows to
             # define coexistent of rowspan and stubs (there was no use-case
--
2.26.2

