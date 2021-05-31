Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1A7396750
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbhEaRpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:45:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50742 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233828AbhEaRov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 13:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622482989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=K8nNOkX4zuqczQHURLREmFQOVbuEo/yfo6wOnioYIqU=;
        b=fxAcZbIDy/OkLv8bIW6zR9yRm6KQovgsmUVCP9TIJhZpNEBNTAlkJPayDn3FpRA2bJHXfn
        1yb8hKGMIUYMOJplBzFMzME7yr7TnpUnpfppKU+OC8QWatWR8S6Z4pWLSOdZGwN+SBAGex
        A8i6taOfCSEVL92XBUStIt0sRiNMp70=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-cnewyOg8NhCIqnBDTC_FjQ-1; Mon, 31 May 2021 13:43:06 -0400
X-MC-Unique: cnewyOg8NhCIqnBDTC_FjQ-1
Received: by mail-ot1-f70.google.com with SMTP id 59-20020a9d0dc10000b02902a57e382ca1so7202682ots.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 10:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K8nNOkX4zuqczQHURLREmFQOVbuEo/yfo6wOnioYIqU=;
        b=Z79/Jz7kTuW7lVLLH5b77biB2Jih9aqp2kHQ4IE6nVTUdIDqlDbGUQvqzWSTj5qc+V
         vz8Q/sVMoBdkLt+Q3qwZNrlJobhJVqIAsp6U2iy/9oIbG+xEOED3e3P71py4rcVi3z7T
         C9wqPfZ6iFet94sD33NZEEfbAKXJQ/M7nfF1ejGD074Zvm92ftzhR1KUSH5AFi2cZz7M
         m4Bzjaea5XE+xjY3WL7OQqqX0iK52s31tscTC/mf4dBLJqWCRcSRB3A+UVbMhx7t67tK
         47iSa9pwngAvnesbC/M5J8k4geWGp/EjBjdCkuh8yrd46myA8XGx28+UIe8GVu3NsjHS
         fFbA==
X-Gm-Message-State: AOAM530if2lLii1juOFpKQC/glXCufGxulJYh0B4CUgbaLUtySpzoFq6
        WK1Tdwg+95iW8hKLvRZ0Yeg3mPWGZmstsYJ4iUm5EZl/YFfCjlIx24UzhDIHGDKaV053v3UwcSw
        VpBsxoH7+w6xYd6R3+mK3UEdh
X-Received: by 2002:a05:6830:1d64:: with SMTP id l4mr17260140oti.95.1622482985552;
        Mon, 31 May 2021 10:43:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylhACZOWlRSSP56Xe+/shqCqK0nGlc+aQdIrngGYo9DVADhn8bqhxQrwJTGkiF1rvA1tn1sA==
X-Received: by 2002:a05:6830:1d64:: with SMTP id l4mr17260135oti.95.1622482985395;
        Mon, 31 May 2021 10:43:05 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i4sm2943902oih.13.2021.05.31.10.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 10:43:05 -0700 (PDT)
From:   trix@redhat.com
To:     rmfrfs@gmail.com, laurent.pinchart@ideasonboard.com,
        slongerbeam@gmail.com, p.zabel@pengutronix.de, mchehab@kernel.org,
        gregkh@linuxfoundation.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] media: imx: imx7_mipi_csis: convert some switch cases to the default
Date:   Mon, 31 May 2021 10:43:00 -0700
Message-Id: <20210531174300.2594109-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Static analysis reports this false positive
imx7-mipi-csis.c:1027:2: warning: 4th function call argument is
  an uninitialized value

The variable 'align' is falsely reported as uninitialized.
Even though all the cases are covered in the
	switch (csis_fmt->width % 8) {

Because there is no default case, it is reported as uninialized.

Improve the switch by converting the most numerous set of cases
to the default and silence the false positive.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/staging/media/imx/imx7-mipi-csis.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/imx/imx7-mipi-csis.c b/drivers/staging/media/imx/imx7-mipi-csis.c
index d573f3475d28..330f283030ec 100644
--- a/drivers/staging/media/imx/imx7-mipi-csis.c
+++ b/drivers/staging/media/imx/imx7-mipi-csis.c
@@ -1016,10 +1016,8 @@ static int mipi_csis_set_fmt(struct v4l2_subdev *sd,
 	case 6:
 		align = 2;
 		break;
-	case 1:
-	case 3:
-	case 5:
-	case 7:
+	default:
+		/* 1, 3, 5, 7 */
 		align = 3;
 		break;
 	}
-- 
2.26.3

