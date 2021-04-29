Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C38E36E778
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 10:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240203AbhD2I4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 04:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240039AbhD2I4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 04:56:21 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52310C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 01:55:35 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id j6so6242948pfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 01:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ukQSZ/Lw0a5JmFHWRW1SHX/wdlx4IfRVgiKTUtUTktA=;
        b=jHaqROwZosenZVKBcXLRv248L4gWBM2KHrku6ND+hOPFQ7R0Jh0zsO9kznq4tjqr2R
         Zk17i4atC7h6OdrD3Ym/W/cv8VwQFdUzGf7py0msee4adryEiWiJN2x1+kTI+ll89ls3
         xGuWEzP63s6G7naedDRq8WhHmYFMgBgsb3C2nANdX/crqwlcuQCzktXcxImwsx6bfPt7
         3Fkq1CHOp/3oHB6OE1sFwOo5crdNxs3oz0j3nByf9IuGcgQWo9SWkfwLhkYmJAYPq0uK
         V7A8q8oYyLGz8gLN4/6/4z8l/zsl0uGZsCVjrPgWXY631MxKZ+teRCTVdsJbnO2vSSYm
         KVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ukQSZ/Lw0a5JmFHWRW1SHX/wdlx4IfRVgiKTUtUTktA=;
        b=FtDV0q+TidEgFk9vGm0mDPYxuyJpzxF1f0CXL6Ed0775dO9bpMADDukLCQ8S61V8th
         KGjR9qXD5Mr+Yle/2g5tVH9pqx+82hjaJUU65s73uu3+OgJPiUfIkCB4AYGI9PLvpfUy
         hSm5kCCIUEfjFyOQXkbcnxkWdZ8zJ6zVeTnsmWEw36sJbgaRm/blukP4TBHjk4ONvamc
         OkPpTkRfx/qbOzJVb/hqYNjiSrmhsPOCtAmm3sUcX+gVDpRJL6qLFJhCdWJvMiBtmkE/
         HzzGUTomiKlWzMrzQrbOfQzQTA0Nma93Su6eC0XUvbN3zKY7GkRzizNllbv19/CCvk6d
         QdoQ==
X-Gm-Message-State: AOAM531klp9fZoQz+K68x0phZJv7l9v6lpr/Lg4wWpmwjlh9WPJV6+Vu
        aVqmBiRYW63y0RggaLftVkA=
X-Google-Smtp-Source: ABdhPJwVDUX1tUd0pkrX0BOPtgDGr7A0fYLuJxm96Gjf11vVSlcEvPn/MRohpOKyIOGQg7GQBafpRg==
X-Received: by 2002:a63:e515:: with SMTP id r21mr30699986pgh.412.1619686534953;
        Thu, 29 Apr 2021 01:55:34 -0700 (PDT)
Received: from localhost ([115.99.169.0])
        by smtp.gmail.com with ESMTPSA id a16sm1783556pfa.95.2021.04.29.01.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 01:55:34 -0700 (PDT)
Date:   Thu, 29 Apr 2021 14:25:32 +0530
From:   Sanjana Srinidhi <sanjanasrinidhi1810@gmail.com>
To:     linux@dominikbrodowski.net
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Fix indentation of block comments
Message-ID: <20210429085532.djej2ko2dttertt5@sanjana-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trailing */ of block comments is moved to a new line to maintain code uniformity.

Signed-off-by: Sanjana Srinidhi <sanjanasrinidhi1810@gmail.com>
---
 drivers/pcmcia/soc_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index 98b6d96a4435..7a88bd9bd4ed 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -28,7 +28,8 @@
     the provisions above, a recipient may use your version of this
     file under either the MPL or the GPL.
 
-======================================================================*/
+======================================================================
+*/
 
 
 #include <linux/cpufreq.h>
-- 
2.25.1

