Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B14E43C373
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 09:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240248AbhJ0HEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 03:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbhJ0HEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 03:04:34 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37458C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 00:02:09 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h193so2051028pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 00:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=wwE2Hfzwdmr3TCQqN87hY4IbZDmFo48GQs2vJluyNr8=;
        b=L+95XKbsyzJZ9UxJUblna4RTYBsM9DsQoMnTnjhBYmUWt4IMAvkG+zyV+LB20PZ8Ti
         JCSICZcQmtlh7l8CKjRVnbJGDQu+iPAOh+Bacy8KyWI7qUSppAIVQI4U+JxxnMaFxUvd
         HmxemA/u0Yr6ajiJwH/8CO/AkSs3K3I1cArr7QPKs0oHrOMQHoSEE4pIUaW1qhzvTbzO
         aOL7S70vudBgy+Ha/v29FRvToNXaHsXkOwJg5IHJ9iyqvjQEwboIWVj0MxIVu4MXSVWm
         LhyFJTCN1LrzCNGWObxAYmPX7TEZq3JdkEbAybzjOUXJcYIxHCW7kxpGAl5172cta6OE
         AUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=wwE2Hfzwdmr3TCQqN87hY4IbZDmFo48GQs2vJluyNr8=;
        b=AnXG2hcldth8C3BXP5FOzdylmy4VUkkUKyFx+xNzUxcBKjRSXzcy83pNuYfCuhU2/W
         s19D+lgT371wiAuJsy8FkmVZjLZbv3MUqvPC4hYrEV4GydW1Z26Hy527jhN8hMNFsMMJ
         y1kHQ2lzHp5RlOH1ftfjeoeCJD/8qTvEeaUx7OuuPm1fH2j0A+z/iXIjlp5AD93Ny/zA
         sF2wkU106lqqjI3+mwxUk2ePs+fS+yR0SJ0AJJAkk2iXhNWFftQKaKYTekIB7v6Zjqrz
         317O28BJZ0pMSvbt64Y/+FjepnzthuPUiW7yjFdYdk8sb8kv72mwmHAM5+4S5q/tWdWF
         nL2w==
X-Gm-Message-State: AOAM5303cnKl+jYxdlqA26bkpB+6hux02X9DY1vCmm2MOgn0HUlYyPjW
        xgYPxRnOwjO34NLZXESaJTo=
X-Google-Smtp-Source: ABdhPJxbADh81uQ5ovJtHRsXq8dTtdjiZafRAjh4IJMrAcFlS5Qau4FGozQmKYPeu7wDOvk2sWv2SA==
X-Received: by 2002:aa7:9212:0:b0:47b:aefd:2cc4 with SMTP id 18-20020aa79212000000b0047baefd2cc4mr30833466pfo.47.1635318128701;
        Wed, 27 Oct 2021 00:02:08 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id f8sm3025859pjq.29.2021.10.27.00.02.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Oct 2021 00:02:08 -0700 (PDT)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm: have kswapd only reclaiming use min protection on memcg
Date:   Wed, 27 Oct 2021 15:01:50 +0800
Message-Id: <1635318110-1905-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

For the kswapd only reclaiming, there is no chance to try again on
this group while direct reclaim has. fix it by judging gfp flag.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/vmscan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 74296c2..41f5776 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2704,7 +2704,8 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 			unsigned long protection;
 
 			/* memory.low scaling, make sure we retry before OOM */
-			if (!sc->memcg_low_reclaim && low > min) {
+			if (!sc->memcg_low_reclaim && low > min
+				&& sc->gfp_mask & __GFP_DIRECT_RECLAIM) {
 				protection = low;
 				sc->memcg_low_skipped = 1;
 			} else {
-- 
1.9.1

