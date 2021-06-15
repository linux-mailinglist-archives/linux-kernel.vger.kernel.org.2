Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADEF3A8797
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhFOReU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhFOReT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:34:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0791EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 10:32:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w14-20020a056902100eb029054d7f164a2fso9813709ybt.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 10:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=O2Nrrj9xXoMKaRCg57APzWi66P/7IsIGYrlkbQqeHys=;
        b=HCTQA3LhOBFMcnebLh802AH4yyFsQaSM6PDKeEem2QGWGHzV0VVbTuWKuA+bIqpFys
         50QmLl73EcryXb+Zcm75cxq4um/MtQl/6GxvecG/HfZnD+hlG9OUbXRQnmenNAca9tVy
         whycFOdCuC2mBl4szs+YanuV3hYvjRc0hBFbb0WbVVaH054Vwvj8X5BAcIeMub6dihFo
         8I6PrsZQZzWzmP20NA5dYNtt2BbXFZ/jYJvodJNHe+BVDysVJTkTzlpRELKRUkB7KyZm
         9iWbQPEieEJWHnTjutDFqkqpqqMkv8QAK5l7Qjxcd7wfYpX4ZwYXnlJQskBNYRAI9fuI
         J+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=O2Nrrj9xXoMKaRCg57APzWi66P/7IsIGYrlkbQqeHys=;
        b=RLmimHxZBDSb4J61bPyzpuIgTdGafjfTYbYkEMP8358dlQqj/d/92EMPNuDwykjII9
         q3MTswUfvB3C8/Oa2se6+gfNyr+ZaVVNroJsZ9EHFvMfNb/5eVXl7fsgVruTKEe8Jldz
         iaBJ1lTQxbtx5p0RtyNxrm8w/prMZsrC8M4JmP6XgV5KAuLmptdA2pgUeiSjZ72JFl/T
         ZFg8p6h5v2KYuuyYzQ3+BeMx/xXBvhNiraAKHb5bsubTFbbL9Ot/djXF+cD8A577OBcv
         bT40jGmiEjDU1eUoTdK+AIKE1PRX1pM1vgGWDjXBNLNmvRQTLj+KgLJrIigOGfv1VR0t
         18Sw==
X-Gm-Message-State: AOAM531yHLhTVSxIapFFNN72a6PJKqgfuTBMjKann8ls6AAFC0i5Ntff
        vyboQyi1snDE38eiZi/d3EU98fc6v6eP
X-Google-Smtp-Source: ABdhPJzHlTT2KEs466gBdtcdD0cKscO5Xry/sQ03CBnORmzZbcRFCJGCP2BmRfKTLuuXIYMZ5fmWBDG0NLMv
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:8824:3d53:8367:ada5])
 (user=kyletso job=sendgmr) by 2002:a5b:ac9:: with SMTP id a9mr329288ybr.475.1623778334010;
 Tue, 15 Jun 2021 10:32:14 -0700 (PDT)
Date:   Wed, 16 Jun 2021 01:32:06 +0800
Message-Id: <20210615173206.1646477-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH] usb: typec: tcpm: Ignore Vsafe0v in PR_SWAP_SNK_SRC_SOURCE_ON state
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In PR_SWAP_SNK_SRC_SOURCE_ON state, Vsafe0v is expected as well so do
nothing here to avoid state machine going into SNK_UNATTACHED.

Fixes: 28b43d3d746b ("usb: typec: tcpm: Introduce vsafe0v for vbus")
Signed-off-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 197556038ba4..e11e9227107d 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5212,6 +5212,7 @@ static void _tcpm_pd_vbus_vsafe0v(struct tcpm_port *port)
 		}
 		break;
 	case PR_SWAP_SNK_SRC_SINK_OFF:
+	case PR_SWAP_SNK_SRC_SOURCE_ON:
 		/* Do nothing, vsafe0v is expected during transition */
 		break;
 	default:
-- 
2.32.0.272.g935e593368-goog

