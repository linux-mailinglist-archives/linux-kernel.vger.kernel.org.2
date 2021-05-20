Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E0738AF33
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239879AbhETMwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242827AbhETMvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:51:16 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721FFC069170
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:10 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d11so17399708wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Cothg0v196Bf+pLLOIoJxZOPtFsbJ9pjz2Mu1Y+PaQ=;
        b=nSVPPmKfPAQH7vHSSIFa07XIfJifam6NZWD6SwQaHqIOP8KIzIy4ZxMJVR++lWE1fz
         6pRl2RdRko5ZDVV8UYhdbMbr0tjXQ9z3Vn5K18DrF9xiN0JEdqW1q5bihF7A98Bt0xYF
         1sDupp2WBlKk8za/w9G6SsgSvSKxBadCRZiTv641ukd+GXaVf2sIT3eeC48EQ8KTEuR9
         psjm3Vlt0VJwJXNo9FdTPssao7L06t4UqJ+w2nv1gcaJBRxIQcZkO2LKCU5502gsId4x
         bb+u4/eLOfLeTC1dEIYqym/OjbKaWp05i3cRMakypkzL0WFXC/AP2WqKf/vBsn4umLcI
         u+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Cothg0v196Bf+pLLOIoJxZOPtFsbJ9pjz2Mu1Y+PaQ=;
        b=NMgiYP8VuthDs0XOnkVZ1dtM5MQWHgu1GEdlOaGiYeURMgVSal2GgoW9sQ8LipyEQv
         z8X2vtGw+BOKsTPpeS/frBVQkO0pm8vGgto3XCfrI+2eVJ9NNoC0lMCoS89JN5Lgctit
         9ZHvwscVdAO0ZBd1KhVYD7Ld0Z8l40jG0YjTPyhYF3lCQJN/mZQ87vt6PethSKKHpAeT
         rwZtpOcUJU3FTJ5tTJZ5QH/LWgFbS5LMSD/yoqMCwpzfwp7aWvUFGHsnF+lu0uVvaODe
         Nzc7/QgnN13a07M9aVRSywKegpUcg/7NcMhfgbj5TYLwIK2opuoeXyg22CtrONUx8mr2
         wp1g==
X-Gm-Message-State: AOAM53110sq6px0tNtkkhcB3SeaCnX6GKpddC/dHKSLJu+D7hx/os93/
        c+ZazvPR3qLw1186cDgIlLAcGA==
X-Google-Smtp-Source: ABdhPJzLTAVf5bhgmHPZ1rLR6h9ZMlPKM+cm2pcgO1TLUlZvLRt/ilsQtl901XiVZcdT2ng/vFb/oA==
X-Received: by 2002:adf:e506:: with SMTP id j6mr3932251wrm.374.1621512849112;
        Thu, 20 May 2021 05:14:09 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id 61sm3393704wrm.52.2021.05.20.05.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:14:08 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bob Picco <robert.picco@hp.com>
Subject: [PATCH 12/16] char: hpet: Remove unused variable 'm'
Date:   Thu, 20 May 2021 13:13:43 +0100
Message-Id: <20210520121347.3467794-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121347.3467794-1-lee.jones@linaro.org>
References: <20210520121347.3467794-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/char/hpet.c: In function ‘hpet_interrupt’:
 drivers/char/hpet.c:159:17: warning: variable ‘m’ set but not used [-Wunused-but-set-variable]

Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bob Picco <robert.picco@hp.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/char/hpet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index 8b55085650ad0..4e5431f01450b 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -156,12 +156,12 @@ static irqreturn_t hpet_interrupt(int irq, void *data)
 	 * This has the effect of treating non-periodic like periodic.
 	 */
 	if ((devp->hd_flags & (HPET_IE | HPET_PERIODIC)) == HPET_IE) {
-		unsigned long m, t, mc, base, k;
+		unsigned long t, mc, base, k;
 		struct hpet __iomem *hpet = devp->hd_hpet;
 		struct hpets *hpetp = devp->hd_hpets;
 
 		t = devp->hd_ireqfreq;
-		m = read_counter(&devp->hd_timer->hpet_compare);
+		read_counter(&devp->hd_timer->hpet_compare);
 		mc = read_counter(&hpet->hpet_mc);
 		/* The time for the next interrupt would logically be t + m,
 		 * however, if we are very unlucky and the interrupt is delayed
-- 
2.31.1

