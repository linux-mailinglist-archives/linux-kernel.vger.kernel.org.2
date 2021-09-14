Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3030940BA5D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 23:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbhINVhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 17:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbhINVhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 17:37:32 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593EBC061766
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 14:36:13 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id jo30so642092qvb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 14:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TM7n1dna53Y+KIAaPOy7ZFMjIdGf78aBP+tCGyC56Vg=;
        b=DAC1/pVsNhGIcvBmDc9SeGCceDyR50hfxd+iKWA/tz5Vo1SNNSZT0AAOBvDUjXQra3
         eZvPTp9ko9mZyp64jH3sdV5Dht380B+OfR0YsRKUguudovbd7d/DIgkfrRBT+KkpQZJh
         9TITi118J4Ah3TXRLEZmM0HYFPCL66PLUjAW2j+VWmooUta6tHTi6clOy4FLp8oHfRLO
         IiSbHzatBpg8dIv05lja0Ank4V56S6OSBNxEdAneqVRcC3O1yPzQ5HYhhAzyIW4EsGP7
         idqPpGhEJmhugxPKOGzL85st/rmX3qXO/5AuDoCENlbRti0m628kg3uBUt+ukVqkxC5S
         mJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TM7n1dna53Y+KIAaPOy7ZFMjIdGf78aBP+tCGyC56Vg=;
        b=OS+XOeiEZlBDSF9sP0N8uM6RhN5gohEHqNlfmUrmXSDVOQ0A23evkeLM8+/G0MCO0S
         Kwx/Q4HpjyeGg2BHl/F/hk1EG5aGmDK9jTI91Yif2dIcnfCz5RJmwrwbErr4ncNyusfz
         XIfbMKwzKs2XMst0NATFhA+HqzP5OGGpilIeoX7E3U0Tu/9oNwopc0zX+GOSVhGNz9Hv
         Xl6IBfTTTuwj2Se7IpkopMKIs69mvfS2xygfzhjYGjK8e4qfkGwcA8jyCfFDHxEoIb1K
         AaEU63E6efahQqk6x+PoBMRkyfmjxWe7e0J2zOeTtw+//zRH6YFgbt4wPfwbqW/yT1tC
         j14A==
X-Gm-Message-State: AOAM530GwqPS9bM2fB1jXi4zC0gNEZSfMmSnI1AUZihHfG7RwWvRMHr5
        XgD/F3fjv2LLt8zdRHSApYLpkNLhz8Gleg==
X-Google-Smtp-Source: ABdhPJz2Zop7j8KONtVZ0sRJ5q7df0Ka9HDAi4ufXlIgii5Kyy9dx1qoT8OkUBU9HJovOF8haJu1VQ==
X-Received: by 2002:a05:6214:12eb:: with SMTP id w11mr7840443qvv.10.1631655372329;
        Tue, 14 Sep 2021 14:36:12 -0700 (PDT)
Received: from localhost.localdomain ([191.84.239.65])
        by smtp.gmail.com with ESMTPSA id o7sm6716611qtw.87.2021.09.14.14.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 14:36:12 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 1/8] staging: vchiq_arm: replace sleep() with usleep_range()
Date:   Tue, 14 Sep 2021 18:35:26 -0300
Message-Id: <20210914213532.396654-1-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usleep_range() should be used instead of sleep() when sleepings range
from 10 us to 20 ms, [1].

Reported by checkpatch.pl

[1] Documentation/timers/timers-howto.txt
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index b25369a13452..0214ae37e01f 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -824,7 +824,7 @@ vchiq_bulk_transmit(unsigned int handle, const void *data, unsigned int size,
 		if (status != VCHIQ_RETRY)
 			break;
 
-		msleep(1);
+		usleep_range(1000, 1100);
 	}
 
 	return status;
@@ -861,7 +861,7 @@ enum vchiq_status vchiq_bulk_receive(unsigned int handle, void *data,
 		if (status != VCHIQ_RETRY)
 			break;
 
-		msleep(1);
+		usleep_range(1000, 1100);
 	}
 
 	return status;
-- 
2.33.0

