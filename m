Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB17C35329A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 06:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbhDCErq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 00:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbhDCErp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 00:47:45 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70FAC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 21:47:42 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id y5so6906577qkl.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 21:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TekMjkgaWQi0sIeSwp8iDKdyw1q0V3gj1ztNBm6VfsI=;
        b=DrEBip6XbeO4LxD0AvEsDWu+9HjAJTaFdImDIlKqlB1uUUj4a+cQ8bBgAAwh9wQQ3X
         CUqSGCeM4RwmAHm9F+T1hwcgsioNYqYyAJocd35PXHvFAV4xqY/H03ShdKLKgFpdRT1g
         hkjgbXpmctm4BNtYHz9sGIwHdc4Mk3x+zk1KR9GXjBtM8FEpSyvDUEEf6wcRsFvKaYJ2
         Rg22UI4oAyEEeieCjzG/qs+JXdXOYWJzWHm6t7tiSBnjJUNzkU0pdjpsOaXdV0uLNG70
         t/KfvaLXr2AaST+lZ2F59Trvhzo08WwEHa9mvpgnL4K1QVGMhYeQaHJQ0VAPAJ71vSG1
         tjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TekMjkgaWQi0sIeSwp8iDKdyw1q0V3gj1ztNBm6VfsI=;
        b=amdMUISMaZRc+jt11WRBdzeLHd3fukHY8unpwpk/QR/ZBBhU5SM0vU1VjZEJxv9PPA
         X40la1FvI457NGYK4dq1vnT7dKpEtM8lnLi88R6H/Uf69sGWdscNFr8fsekUw1FpQHsr
         31XK0BACpxYVlEj5FWOHx7xMaIXRbYImuSDYd7wgX/oe+L9P17wBnBUQ1QG7rvQnS/Ka
         hDCJ1lHpMwu9lSvwdPg6avHQg041fC25rYZVHAvcs3Eb9rnlWHKUs9aBYvNFpsMdX7b7
         QLJLjGMJGSSkQ19+qEhDD/FngtDLrwE+iqrh07qw5XV+LYUzBgDKP8vYjO8ydfL4oxuI
         m8/g==
X-Gm-Message-State: AOAM530TM5fivErt6eZKJAwXorFY4pld+mOTuYTOugjHDblA/tckSdPi
        NdZWO5Oc4v6/YSConfjvKhI=
X-Google-Smtp-Source: ABdhPJznSTQD0bEPhQOEWOlv0P7iKK/qg6YLHeH5NR9IAiA0lEz7O3JRnUkqhF8+jZySXFjojfXz6w==
X-Received: by 2002:a05:620a:210a:: with SMTP id l10mr15553013qkl.398.1617425262154;
        Fri, 02 Apr 2021 21:47:42 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5cd3:8f4f:bad9:1dc4:19d9:7ce3])
        by smtp.gmail.com with ESMTPSA id k126sm8800598qkb.4.2021.04.02.21.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 21:47:42 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v3 3/9] w1: ds2438: fixed a coding style issue
Date:   Sat,  3 Apr 2021 01:48:15 -0300
Message-Id: <20210403044821.390485-3-sampaio.ime@gmail.com>
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
index a5bb53042c93..eca50cec304f 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -338,9 +338,9 @@ static ssize_t temperature_read(struct file *filp, struct kobject *kobj,
 	if (!buf)
 		return -EINVAL;
 
-	if (w1_ds2438_get_temperature(sl, &temp) == 0) {
+	if (w1_ds2438_get_temperature(sl, &temp) == 0)
 		ret = snprintf(buf, count, "%i\n", temp);
-	} else
+	else
 		ret = -EIO;
 
 	return ret;
-- 
2.30.1

