Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC6D43B9B4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 20:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238344AbhJZSjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 14:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238341AbhJZSjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 14:39:48 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3A1C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 11:37:24 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id y15-20020a9d460f000000b0055337e17a55so21104494ote.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 11:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forshee.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MMIv9yBqWj19F4j9cz8FHqbcowS96PYR2dCRyNDqEdI=;
        b=OYBybNm/Ypa0I7EEA43Ixtr/lHebvrHBDN/dN2bgf8EyZg/oyr9axB48J3sOppBGVe
         qcF6J6Ym67B6Be8/WFccUxJ1vujQSLx/fwxLJlDowuejuvQaA1niTtcRfx6mOnE2V+bM
         USL9BvsTdoXPxsfmt3gf9f/V7j3V2dBvDkztw7anZfio7IOX7l2i9iJj+/phR4+PWDtc
         exQVbeNben6UJQTazGXxaHPklgwtOXbPH1zZqNWjT8sCmuqcOQZThQy9Q0iK8cJYK/YZ
         86Fnsl6N3fr93kiLtknAh5sbFRKSt8Wp1fAapC6eNgHC1imvQ7fNoquZxPpwWe6t2lQZ
         UrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MMIv9yBqWj19F4j9cz8FHqbcowS96PYR2dCRyNDqEdI=;
        b=uTTkpr0I32zaNm1Pk+G4sTc+Kvi5yTtwbq11XqLGda4WJQH6yuu1WW++IpgI7F60Xy
         8aGj0Fm0wI+Q6aPhbZ7b4eqrqq+Qz8FJIkXdwIL76btIveOgPPu8NUOp2L4r4Wa3F2Qn
         am4rkp4BMisn6Jp59TqtlmiyjaXwc9K/CwZnCEKZXB+BKDOiJqahnrpXhbhq7LHKV3U0
         2tYMjlRHWA8T+znqQYoAO2ZCwfbLgfK+kxbCoy5OiLXNcAMpy76JlBdEDLZbS+hXC6jG
         tBprczA1YnA5KCm+YZ8KNdx19idSPyMrUlR2FgeelVIwf8rIjEn/0IO78LEbnKF3zmX9
         36hw==
X-Gm-Message-State: AOAM531nAASE+Jc4GseTw0XuTE9EAXKUkDZzP2KR+kPlwqLH+U+PlF3I
        tfrMRNA5j35b5/KAfF7BJfgZ2g==
X-Google-Smtp-Source: ABdhPJw1kW+ORDSncXkNIkFOkxu06ErFATerWIpMGCr4CCzzU1jUcOdETKP/1dIT979TsrY/+XFowg==
X-Received: by 2002:a9d:5548:: with SMTP id h8mr8584427oti.241.1635273443100;
        Tue, 26 Oct 2021 11:37:23 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:fca3:95d3:b064:21ae])
        by smtp.gmail.com with ESMTPSA id l24sm4032727oop.4.2021.10.26.11.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 11:37:22 -0700 (PDT)
From:   Seth Forshee <seth@forshee.me>
To:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/1] net: sch: simplify condtion for selecting mini_Qdisc_pair buffer
Date:   Tue, 26 Oct 2021 13:37:21 -0500
Message-Id: <20211026183721.137930-1-seth@forshee.me>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211026130700.121189-1-seth@forshee.me>
References: <20211026130700.121189-1-seth@forshee.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Seth Forshee <sforshee@digitalocean.com>

The only valid values for a miniq pointer are NULL or a pointer to
miniq1 or miniq2, so testing for miniq_old != &miniq1 is functionally
equivalent to testing that it is NULL or equal to &miniq2.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Seth Forshee <sforshee@digitalocean.com>
---
 net/sched/sch_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 24899efc51be..3b0f62095803 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1500,7 +1500,7 @@ void mini_qdisc_pair_swap(struct mini_Qdisc_pair *miniqp,
 	if (!tp_head) {
 		RCU_INIT_POINTER(*miniqp->p_miniq, NULL);
 	} else {
-		miniq = !miniq_old || miniq_old == &miniqp->miniq2 ?
+		miniq = miniq_old != &miniqp->miniq1 ?
 			&miniqp->miniq1 : &miniqp->miniq2;
 
 		/* We need to make sure that readers won't see the miniq
-- 
2.30.2

