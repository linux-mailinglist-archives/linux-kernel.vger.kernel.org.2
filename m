Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F503353299
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 06:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhDCErp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 00:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhDCEro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 00:47:44 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEFAC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 21:47:40 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 7so6917376qka.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 21:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IxUwJprpafXvqxQ24FtKstnVbwXECMiYhwtxCk/m/jg=;
        b=HS/Jf+I77+YiYunNcfy/1iCa8bEIaz/Z3gfHneKly1ME8uSwZxMJo0MG86NjZ5THSF
         6sBwJ2/JhKITyaY0eOId5yMdqFZojAPeFiT6+x/G4BQEMXWYXG/0tPsVh1I1V7JguaiF
         dyj5JvTL1d++s1j4FpEVFbJUYM+rluEhC14+YlIC8I9/aEj4IExSQz6EMyWoADPOx6Pp
         4GtHRNVZB810qJQE4cphgtWxBPLR/XE38BLy9SXPjo3MyHhL5WAqDQ7ozTiv0gGOd2gS
         oSaMlWyW0OqNAduv9rGr4NO6vI2H0kKKHPo104FlPghn2cwheZLuN6t/vvc2Bg9XL6pn
         cZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IxUwJprpafXvqxQ24FtKstnVbwXECMiYhwtxCk/m/jg=;
        b=SldZ89vUYgERZ9A4fTBCAWzvbF9PK5CDoBRNGyOogOlLrPRrAlEixVNnHUtGLBaYs/
         pddIQOU2JK/hHxbVTdn55YhaP5gJtKDaVBG4vGUDzyHuwoG4VrqXU1Qpuw+TpCLOcLTH
         sMpnGDpi1Hp4YTx5arFx7yN4Mo8VPtuIKZ9ZNadA1Z1MoPF2yZT8rBauGJ7N4TtjP1fu
         n/F0hydqoolBY75gcVE7+vIp+Ytov/R2dY0WG3p0llVjMio0d61/QhMHdhCK9b/nIZD4
         I+i6kaBrweUZ1MnJGU4T3ltMhbpzjcqyPnUIb8wzDHIPACAKA08foDU+7sZD4riUa61x
         7Fgg==
X-Gm-Message-State: AOAM531PDmabj+NTjjLR/34LE3aIvjopBSK2KrgfzLkNxA3TeY8QOCC0
        XVGH8ye4QcEBwKjWa/YEQHQ=
X-Google-Smtp-Source: ABdhPJwH/jmSl0qutvadOH6zkxpher8Fe/N0hLTkT7ypQ3JN5G0JyhCZasY3O4P9jqr7vF2H7RgGoQ==
X-Received: by 2002:a37:9547:: with SMTP id x68mr14251701qkd.474.1617425260000;
        Fri, 02 Apr 2021 21:47:40 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5cd3:8f4f:bad9:1dc4:19d9:7ce3])
        by smtp.gmail.com with ESMTPSA id k126sm8800598qkb.4.2021.04.02.21.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 21:47:39 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v3 2/9] w1: ds2438: fixed a coding style issue
Date:   Sat,  3 Apr 2021 01:48:14 -0300
Message-Id: <20210403044821.390485-2-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210403044821.390485-1-sampaio.ime@gmail.com>
References: <20210403044547.390226-1-sampaio.ime@gmail.com>
 <20210403044821.390485-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there is only one statement inside the if clause, no brackets
are required.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 drivers/w1/slaves/w1_ds2438.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index 148921fb9702..a5bb53042c93 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -287,9 +287,9 @@ static ssize_t iad_read(struct file *filp, struct kobject *kobj,
 	if (!buf)
 		return -EINVAL;
 
-	if (w1_ds2438_get_current(sl, &voltage) == 0) {
+	if (w1_ds2438_get_current(sl, &voltage) == 0)
 		ret = snprintf(buf, count, "%i\n", voltage);
-	} else
+	else
 		ret = -EIO;
 
 	return ret;
-- 
2.30.1

