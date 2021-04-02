Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C55D3527D2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbhDBJFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBJFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:05:10 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777F7C0613E6;
        Fri,  2 Apr 2021 02:05:08 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id l1so2253541plg.12;
        Fri, 02 Apr 2021 02:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mCA52LnxgW5hjAvuxDGqbFSlZckDKlP65WIWKRvVIMU=;
        b=TaCV4uSnwrBEc8SboS0N1TQdq8jwpEVYiDzgV5Q/c0YHQHpVCNRvIgyrdwveKwTU+I
         ep4cMO5W2F4RfJnybDv/gK0MwddSRNWo3GTxLhM93agea/BZUqBwWd+16kJ7f2zrneDN
         pHby7c88i1xudNizZfIzh8rTXHh89Ig0Aed2I8MOU2KGZptsPQIwpJ/pC0uDJ4Oun7h5
         dUEw2bKQQ2UyyGrPs8FUCGQP2LVFfd32EODNdqmHiEGo/mqN+NmujuF6Lv1BeKFxLZDV
         fwTQupw84ZmUQwqeKtiGxg+jtD4icdRuktt2nBedEQAja9maMTjJuussoT3C8USaR4Wb
         5ojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mCA52LnxgW5hjAvuxDGqbFSlZckDKlP65WIWKRvVIMU=;
        b=SIJ4M8RZm7V0x7jcFTmlu2APzmIgSKUczbElWbng1Iq64vV0IQ9OqNyXkJXEztfAGm
         lgwyI+sA8mwLstV4+rCCA7ugE/U8G89ZwgBEDae22xL3yHPq+YcumYjYCr+uVxDHGJuJ
         8cl0BOdMd1v2Izkf+IFhvPb/6Q84jCOW50KQ1V4euxpfZhN4lcv7P0bNtCMO2lrL4rQS
         oWo7aYJZVgzSize66ejx54WAjY2nkDXul5YPt5HTzJKx2SNfuoWqLzP/G6T08BX7Md8C
         qHEcv29hUVc77PkwXn6ivqMsObc2I/b3bFPB8rJDCmhFn5G/QnchJbrByuUlia1HCv/G
         uQwA==
X-Gm-Message-State: AOAM532HZgF/B+Qtn9cVJdJE/jOERx5GcZn5MGeXQzd/Y0dbMasyLnXz
        f89hCHGmIi9OUEiwaPxbGyG+wf1nwuOseWXX
X-Google-Smtp-Source: ABdhPJwIE6dwJAZoV9M0FQR6LMsf6SjAEgt6wCg4eBQ8RCoATEiQSmZjb26E50hwZ7zQmqh0kHm3yg==
X-Received: by 2002:a17:902:a585:b029:e7:3d46:660d with SMTP id az5-20020a170902a585b02900e73d46660dmr11634771plb.12.1617354308017;
        Fri, 02 Apr 2021 02:05:08 -0700 (PDT)
Received: from localhost.localdomain ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id js16sm7332353pjb.21.2021.04.02.02.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 02:05:07 -0700 (PDT)
From:   Carlis <zhangxuezhi3@gmail.com>
To:     gregkh@linuxfoundation.org, zhangxuezhi1@yulong.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH] staging: fbtft: change snprintf() to scnprintf()
Date:   Fri,  2 Apr 2021 09:05:01 +0000
Message-Id: <20210402090501.152561-1-zhangxuezhi3@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xuezhi Zhang <zhangxuezhi1@yulong.com>

show() must not use snprintf() when formatting the value to
be returned to user space.

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@yulong.com>
---
 drivers/staging/fbtft/fbtft-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft-sysfs.c b/drivers/staging/fbtft/fbtft-sysfs.c
index 26e52cc2de64..7df92db648d6 100644
--- a/drivers/staging/fbtft/fbtft-sysfs.c
+++ b/drivers/staging/fbtft/fbtft-sysfs.c
@@ -199,7 +199,7 @@ static ssize_t show_debug(struct device *device,
 	struct fb_info *fb_info = dev_get_drvdata(device);
 	struct fbtft_par *par = fb_info->par;
 
-	return snprintf(buf, PAGE_SIZE, "%lu\n", par->debug);
+	return scnprintf(buf, PAGE_SIZE, "%lu\n", par->debug);
 }
 
 static struct device_attribute debug_device_attr =
-- 
2.25.1

