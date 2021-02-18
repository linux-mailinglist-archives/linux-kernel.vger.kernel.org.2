Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19B531E66B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 07:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhBRGp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 01:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhBRGbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 01:31:35 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF4AC061786
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 22:30:51 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d13so705012plg.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 22:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KYip4fwriZ+R8/UL+CCJ++KKQonk0PCFu8VWhzBzWzI=;
        b=f5VT2H4UjeBMIbMTT1Jrl9nCy9MAdnuOgVCayqulGBCNiu4gRgMZgDxYmG+5FjsJXn
         oIQquRxOvcRw6CFw1FXbYdHIFa6rTsIt4tMTBqa7a+VW5HX+di8BQoOfC2UVODKbMC5/
         rBdLvMfcKvQzSM0V/aZqXF6QCzc+oDdoXB6hftvWcY5I0uGfKqkY0RQgJ5AtgPQ6HUI5
         lFHNRe8+uWJOlEM2P3oD/19LbyRjdcuDnBU8QXLq2izH4S9lGRGT0KCddkfxgamKYjUa
         sj4gj7Eq0ou5u6XPILWEiN6yC1pmhnSy6vsTip3BerC3FVXgYs5OyudiJORWtbS4hJO4
         809g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KYip4fwriZ+R8/UL+CCJ++KKQonk0PCFu8VWhzBzWzI=;
        b=kur4a7rw7mZc8RiWCPbw6lkGPyX11VAB8q0ug5pQ6XgV2Mrcxl3N9wM5q56I2TlL1y
         OVL7Io9NNoAJX1idBCk11bZXsArOl7rXINngM3ymfC1CGlfWtgXpRY6uoVYiFLfPWm5Y
         gPYeKiD7L0D/cyI6eM0Vba78TK0+oqkHyckmNq2wx3wiApsn1BqsbxPaS4bfxHMce8tD
         FkzRoFhX51wQuLs/Cb9b5qTVirpxBh16s3p/NNfUAbbhwx1pKzpZI4NU8/8d5tJiAIE7
         uqKQJ1RcYGF4f1amtSaBnOrIRCzFExDVvjaZVokeFm1ArMGawGzBwa94bFyobxtP1loq
         WwvQ==
X-Gm-Message-State: AOAM5339kfb4WZmowcdosM/Zky6aWJSN7IU9sX1Y5CwHpCThCbpvQDgR
        hNn9MdspxFVgzwY7iphwYfk=
X-Google-Smtp-Source: ABdhPJwaiObq10hAQqM6lpbAlOng30r2w2hUC1KZpWjqF4PbSsNIhpL7aX0soYcloPwd6VObRGVi5Q==
X-Received: by 2002:a17:90a:194b:: with SMTP id 11mr2612660pjh.100.1613629851309;
        Wed, 17 Feb 2021 22:30:51 -0800 (PST)
Received: from localhost.localdomain ([27.61.13.38])
        by smtp.gmail.com with ESMTPSA id l25sm4224067pff.105.2021.02.17.22.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 22:30:50 -0800 (PST)
From:   Atul Gopinathan <atulgopinathan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Atul Gopinathan <atulgopinathan@gmail.com>
Subject: [PATCH] staging: comedi: cast to (void __user *)
Date:   Thu, 18 Feb 2021 11:58:40 +0530
Message-Id: <20210218062839.32650-1-atulgopinathan@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolve the following sparse warning:
drivers/staging//comedi/comedi_fops.c:2983:41: warning: incorrect type in argument 1 (different address spaces)
drivers/staging//comedi/comedi_fops.c:2983:41:    expected void [noderef] <asn:1> *uptr
drivers/staging//comedi/comedi_fops.c:2983:41:    got unsigned int *chanlist

cmd->chanlist is of type (unsigned int *) as defined in
"struct comedi_cmd" in file drivers/staging/comedi/comedi.h

The function "ptr_to_compat()" expects argument of type
(void __user *) as defined in include/linux/compat.h

Signed-off-by: Atul Gopinathan <atulgopinathan@gmail.com>
---
 drivers/staging/comedi/comedi_fops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index e85a99b68f31..db483cc698fd 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -2980,7 +2980,7 @@ static int put_compat_cmd(struct comedi32_cmd_struct __user *cmd32,
 	v32.stop_src = cmd->stop_src;
 	v32.stop_arg = cmd->stop_arg;
 	/* Assume chanlist pointer is unchanged. */
-	v32.chanlist = ptr_to_compat(cmd->chanlist);
+	v32.chanlist = ptr_to_compat((void __user *)cmd->chanlist);
 	v32.chanlist_len = cmd->chanlist_len;
 	v32.data = ptr_to_compat(cmd->data);
 	v32.data_len = cmd->data_len;
-- 
2.27.0

