Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451FD43D828
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 02:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhJ1Agf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 20:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhJ1Age (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 20:36:34 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9E5C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 17:34:08 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id in13so1002574pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 17:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fVsQgIzElJ375BRVjsGpYNFDHgIMXNfuFkBCPjDV6Do=;
        b=cKOJchNn9DvCzQwK9BKwc+fGBhMK/2jxUO9rZUOGjWx6S4ub03Zt1lpcWQ58T6I51r
         u+8FJAViF4o7RfRrZue+nInmxlcvVsOYw5OSi2Cld4GZmamvh8GsnQEuZLu81+PtoGI+
         +c7gCLDMkk9X+OthPAeaYR8DMtTLUnrzftNyp449RLvmJ11EZINZsJIoL4aMk2V3dfcI
         1QiplmZ/wYLiiqmIEpzhrjGunU3cxBgkEPG6EMYxxOrepb0uxHLn8I9iFtRNuxOAPtCT
         HqnhP7vWpXGkN8tBZWuAmR1sejVmVqLcbdb2QzA0MCc7wrJ4/4lGbrAyWRdpz75EUjMa
         /9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fVsQgIzElJ375BRVjsGpYNFDHgIMXNfuFkBCPjDV6Do=;
        b=Iw1NEtNlXHVpjQhvR+mFkzywfOYBcseBKE77K+U7e3rbalb5HjSlcBJDSnZBvz0U6s
         YUnNQJgDbl0drO3aocBGxnpt5LpyjtCxf5RL3va+ztaLqvJuD/mRRDlRt1LQfxVxqzH3
         P68M1IksFDpWRb4Me9+LpKKZLD8DWVPKDj9B7aoP+NxaBfqnAfDnY/xEvM/doEfxbouf
         hnyccBglG4SYPMbEfbtotEQQ9n3xBxbrzS1qHnYXizAP7uG7/nwNjAwJCadEaS0JB7DQ
         q3bBEid2sMeK+YSrkZKosUPr6H5qNy5So3tjiChS5udDRc214ORSAWLbSU07nfwd3GY2
         JFUA==
X-Gm-Message-State: AOAM531mtqxjzJACcPFB0NF80tWYtgtTMSIkNnyfpxZmoccfoGPlO9UA
        aapvndGJD1MJNRpmdUIkesg=
X-Google-Smtp-Source: ABdhPJytJ0jFfL80pxIKzbW8sJbeQs5BhrSj8rcWlMjUVYselgF+SGq5Wd72P6Tzon+gO5cXJ2micQ==
X-Received: by 2002:a17:90a:eb03:: with SMTP id j3mr596066pjz.149.1635381248151;
        Wed, 27 Oct 2021 17:34:08 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n9sm7215411pjk.3.2021.10.27.17.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 17:34:07 -0700 (PDT)
From:   Yang Guang <cgel.zte@gmail.com>
X-Google-Original-From: Yang Guang <yang.guang5@zte.com.cn>
Cc:     Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, linux-kernel@vger.kernel.org
Subject: [PATCH] lib/mpi: use swap() to make code cleaner
Date:   Thu, 28 Oct 2021 00:33:45 +0000
Message-Id: <20211028003345.6970-1-yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using swap() make it more readable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 lib/mpi/ec.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/mpi/ec.c b/lib/mpi/ec.c
index 40f5908e57a4..a2f5694425ee 100644
--- a/lib/mpi/ec.c
+++ b/lib/mpi/ec.c
@@ -1282,14 +1282,12 @@ void mpi_ec_mul_point(MPI_POINT result,
 		sum = &p2_;
 
 		for (j = nbits-1; j >= 0; j--) {
-			MPI_POINT t;
-
 			sw = mpi_test_bit(scalar, j);
 			point_swap_cond(q1, q2, sw, ctx);
 			montgomery_ladder(prd, sum, q1, q2, point->x, ctx);
 			point_swap_cond(prd, sum, sw, ctx);
-			t = q1;  q1 = prd;  prd = t;
-			t = q2;  q2 = sum;  sum = t;
+			swap(q1, prd);
+			swap(q2, sum);
 		}
 
 		mpi_clear(result->y);
-- 
2.30.2

