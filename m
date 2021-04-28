Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CD736DFF0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 21:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241752AbhD1Txt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 15:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbhD1Txr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 15:53:47 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5D8C061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 12:53:01 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id lp8so3318350pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 12:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=t2vjzLo5833TwHRjaoZDQocM21zdHYgMxRE4qSKWBXU=;
        b=HgpbCexYJ8QnHXUVW5h6oIZf6JX8cFOmlVUHI/I8orX+JfuFAmUpjdGyrDEK6GgEsW
         AMSbqcIcd4rTUcHO/roNkGDwhXOH3GOum3NmGSTN/vMHkWWm9peWStWyWxYWinNMvZzv
         keGSIjBl7h7wCkLP6WDknNHZ6Fz4RMPOUJAb918dwYoFwIXOb3PbyAfYFgXf0+1I5qGi
         7Xmm77ndPQGN9PHBkFwN3Qu6fOAFP44PCnbm9xxdJmloDz3s/4lBthSS96gg5klcOyEO
         43ngKjxqCKaooiJgev8eoO+VW7DCEqYomFw/Iwot6pleC6pGAvQnS1vt7sukUXPT1qYj
         ze3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=t2vjzLo5833TwHRjaoZDQocM21zdHYgMxRE4qSKWBXU=;
        b=CZafpQAnFnWMT5Dnyi4WVNru81Q0VbgD3J4U+JClKSQuFflO3qgueqglnLJV7bCkbf
         FmSnfkI/Jdirr/IDTd5BirV1b8/A4yfz8tl8gkuqwQWRZlxHhgtACf3xp8dODVjxO67+
         gzpCF6+fKqv6io2et4/jGEWh8IkjzIJySX2D0qBGxDskIteG+FgGKgKuijYsq1EXc/hT
         TJaxnDcIAgyy20mtmjZuoUDqa+EJOjBdBdHBRBTnjOzSZ4himaC3JViYQEcw4OZunwV4
         gxQcSEs9P1tLGsuC8ZmPhFJSKllRJ4nJShRsHHbr875npabdep8pxdCfwshAL/aXMNnw
         uYwA==
X-Gm-Message-State: AOAM53049iuk2wq7R3NGAm81NRG6knKe3/oaex9Qnc40TFaCAr8WIH6e
        rZ/Tgl59EsRZViN0OOIf9M0=
X-Google-Smtp-Source: ABdhPJwhug9mgcMupt82IsIk5So9b0QVyz3a+s9sFYwAwVC2QShayJbfGKyfdxrjMPmsxxIjso7Pjg==
X-Received: by 2002:a17:902:a614:b029:ed:3d5f:768 with SMTP id u20-20020a170902a614b02900ed3d5f0768mr15502807plq.18.1619639581088;
        Wed, 28 Apr 2021 12:53:01 -0700 (PDT)
Received: from localhost ([115.99.168.181])
        by smtp.gmail.com with ESMTPSA id i14sm448603pgk.77.2021.04.28.12.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 12:53:00 -0700 (PDT)
Date:   Thu, 29 Apr 2021 01:22:56 +0530
From:   Sanjana Srinidhi <sanjanasrinidhi1810@gmail.com>
To:     geoff@infradead.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Add blank line after declarations
Message-ID: <20210428195256.c3tqnrllnid3c3e7@sanjana-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Blank line is added after declarations to maintain code uniformity.

Signed-off-by: Sanjana Srinidhi <sanjanasrinidhi1810@gmail.com>
---
 drivers/ps3/ps3av.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ps3/ps3av.c b/drivers/ps3/ps3av.c
index 9d66257e1da5..c4ea494ce464 100644
--- a/drivers/ps3/ps3av.c
+++ b/drivers/ps3/ps3av.c
@@ -175,6 +175,7 @@ static int ps3av_vuart_write(struct ps3_system_bus_device *dev,
 			     const void *buf, unsigned long size)
 {
 	int error;
+
 	dev_dbg(&dev->core, " -> %s:%d\n", __func__, __LINE__);
 	error = ps3_vuart_write(dev, buf, size);
 	dev_dbg(&dev->core, " <- %s:%d\n", __func__, __LINE__);
-- 
2.25.1

