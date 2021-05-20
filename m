Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0694938AF75
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243470AbhETNBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243533AbhETNAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:00:02 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6965C07E5F4
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:25:52 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id z130so9071137wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CHE4FrpvWmn1xETsx6wMZCpX2p+W9NijrEn/a5922eU=;
        b=ymt+kxEo4Rj2NYcvKnr950GFyI/v6xkXfktBI/5pWqtpzfJ7P+cpdewnQ124XyKJZ+
         h9M1VxGuKTe5oaS8ti3z1UTf4je9C8ncoG7PVqFQriSwVg5HqO7kFUYgRMg8HeTj5F33
         ZS6tJY64sEDig6WSc9JN3CEd4k92sRolMyyK+tL/f+Ie5W7tQL7iXZLvX2/9/sWVq9E6
         PHhYAQr28bM67QXrniJiTC4L8eTi6/237GXL9dC4zbtibVDBLj/+AOhoz1Om1PChwDpI
         ZZbCRHIygicTN6q63spQRmKMM8jCcWJOBcSMkcm3WiQ+B542J/qo3EGXMw804s4fNEcH
         n/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CHE4FrpvWmn1xETsx6wMZCpX2p+W9NijrEn/a5922eU=;
        b=rb5Qn1Eh5ipQv2KY56ABjzYWEN8fVtA0eszpKbe14DRtkjG15UJQmGHILyCx4Q8fqN
         MKExC5BLUr+nNBwTa0yDZdLESL81EziPCJ7hMfWfiqCjNCRYrp0hqgiLexZi/6ypnT8A
         B1kAVlToxgzM9RhpGoQ1/li88ZMs+pMzRgyxChFDY97OmtP/yXNRQRT2d7WMMEabGdzG
         +CvscXzMTLCm9x60GYb8w654+aHIRFoP6D9MKHVwwQ6H3X5FjxfDGoAxyFdMVr30zEmC
         E6m1aY8ugAG5HbgQaBIA7gT1mRQS5+wfPjzOhfzDjrdWNZxpzBBubCzS+kVq/Rakermy
         V1Wg==
X-Gm-Message-State: AOAM532LzZzqSqsg6Rhwvdabi31aTpkJp+xPbvY8U3UQektWw4KztaNE
        QcGnbFe1sDQpPm3vHl89JezPlQ==
X-Google-Smtp-Source: ABdhPJxlSftqe7BKSqJDusQuxb/WYxPtWBvUtDcpoceB65hC+a+sIx4y6AOEr+FOnVEXew079vNmIw==
X-Received: by 2002:a7b:c157:: with SMTP id z23mr3506163wmi.148.1621513551319;
        Thu, 20 May 2021 05:25:51 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id i11sm3205643wrq.26.2021.05.20.05.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:25:50 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "David A. Schleef" <ds@schleef.org>,
        Mori Hess <fmhess@users.sourceforge.net>,
        Truxton Fulton <trux@truxton.com>,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org
Subject: [PATCH 5/6] comedi: drivers: ni_mio_common: Move 'range_ni_E_ao_ext' to where it is used
Date:   Thu, 20 May 2021 13:25:37 +0100
Message-Id: <20210520122538.3470259-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520122538.3470259-1-lee.jones@linaro.org>
References: <20210520122538.3470259-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... and mark it as __maybe_unused since not all users of the
header file reference it.

Fixes the following W=1 kernel build warning(s):

 drivers/staging/comedi/drivers/ni_mio_common.c:163:35: warning: ‘range_ni_E_ao_ext’ defined but not used [-Wunused-const-variable=]

Cc: Ian Abbott <abbotti@mev.co.uk>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: "David A. Schleef" <ds@schleef.org>
Cc: Mori Hess <fmhess@users.sourceforge.net>
Cc: Truxton Fulton <trux@truxton.com>
Cc: linux-staging@lists.linux.dev
Cc: linux-pwm@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/comedi/drivers/ni_mio_common.c | 9 ---------
 drivers/comedi/drivers/ni_stc.h        | 9 ++++++++-
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/comedi/drivers/ni_mio_common.c b/drivers/comedi/drivers/ni_mio_common.c
index 4f80a4991f953..37615b4e2c10d 100644
--- a/drivers/comedi/drivers/ni_mio_common.c
+++ b/drivers/comedi/drivers/ni_mio_common.c
@@ -160,15 +160,6 @@ static const struct comedi_lrange range_ni_M_ai_628x = {
 	}
 };
 
-static const struct comedi_lrange range_ni_E_ao_ext = {
-	4, {
-		BIP_RANGE(10),
-		UNI_RANGE(10),
-		RANGE_ext(-1, 1),
-		RANGE_ext(0, 1)
-	}
-};
-
 static const struct comedi_lrange *const ni_range_lkup[] = {
 	[ai_gain_16] = &range_ni_E_ai,
 	[ai_gain_8] = &range_ni_E_ai_limited,
diff --git a/drivers/comedi/drivers/ni_stc.h b/drivers/comedi/drivers/ni_stc.h
index fbc0b753a0f59..0822e65f709dd 100644
--- a/drivers/comedi/drivers/ni_stc.h
+++ b/drivers/comedi/drivers/ni_stc.h
@@ -1137,6 +1137,13 @@ struct ni_private {
 	u8 rgout0_usage;
 };
 
-static const struct comedi_lrange range_ni_E_ao_ext;
+static const struct comedi_lrange __maybe_unused range_ni_E_ao_ext = {
+	4, {
+		BIP_RANGE(10),
+		UNI_RANGE(10),
+		RANGE_ext(-1, 1),
+		RANGE_ext(0, 1)
+	}
+};
 
 #endif /* _COMEDI_NI_STC_H */
-- 
2.31.1

