Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2942381E64
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 13:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhEPLBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 07:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhEPLBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 07:01:15 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B51C061573;
        Sun, 16 May 2021 03:59:59 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k10so4905964ejj.8;
        Sun, 16 May 2021 03:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CGj9qzzaMLYMLxf4NzeJuVvuLLfG/hpvWhkYItySrDk=;
        b=PpfoTTovf4OnLbZ2TnCchMOoeh87a/loX5wL9OSYYXTMjtAQheUPtpoKQOv6mV5Bng
         Hr1Cn0QiOJ6x43OuqVtewReMlrAj7aNBayeVR7/BM0ebY10tjcBZQJ6xAHJu0vlcCbT/
         xDkJLv6tIlzHU6utSShMKwOMv++fj3tYYXNERsMz1xK86+hM+HODk1JZaCr3KfVqgeTI
         FNuNAPt7sh39WV9JuXpWH6RvIv0JXEwcsef2syxsZLMP9NZSWrdmxR5BhNOqj2Dp7RdT
         lcAdxAFcVrLsZXawZgeQ0Xg/pZ49ED9+laM47/ZXe5jb5VI3BJrWKhCKTTURjoToOkja
         GN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CGj9qzzaMLYMLxf4NzeJuVvuLLfG/hpvWhkYItySrDk=;
        b=R9KHe3DTj6v/XmDREHsQNrHoeKZlHNJVrw/XUXF3BL8tT1oomP8LzuGINhhk6NLtni
         KYMhNIoBi2xhgHOxaMo5CKfqpZm7fRKxfmAQbQj3RSf4HDWj2HY5hh1S6As+6K/4hjpa
         qp6vMJkuLEn3r+tgetFMBRJdeKfoXQAiA0P5068jyXc7pH18v/mu+jGM4hg16aVz7Q55
         pGSAYeUxtXaYG0NcjVIi/skR4EAHITIs6pzbTHLRb28itTxj3pnu0JoCCO1jBZZ7IFLf
         AWxckvqSzM2JPEHJWg7e+RJQoLze81y89IsoEezovZgqNaqqRwNkDhFydelXd4Mr1nMO
         0o8g==
X-Gm-Message-State: AOAM530wwKOu89W3trQsmwIFP+5KZbP/myS44xJXiaIfKP6E7RpuDU/R
        UZwTu3YIt6kg0BFQj0EUJyc=
X-Google-Smtp-Source: ABdhPJy8w5e1pPfjmSixdIgu8klBFatqxxXcUPKfiXYdOHwD2fVHQrcVHxB9ZuVcL1eUybqdSMRCNw==
X-Received: by 2002:a17:906:1ed1:: with SMTP id m17mr57751038ejj.208.1621162798446;
        Sun, 16 May 2021 03:59:58 -0700 (PDT)
Received: from ubuntu.localdomain (bbcs-125-250.pub.wingo.ch. [144.2.125.250])
        by smtp.gmail.com with ESMTPSA id t22sm8855625edw.29.2021.05.16.03.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 03:59:57 -0700 (PDT)
From:   Chun-Hung Tseng <henrybear327@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chun-Hung Tseng <henrybear327@gmail.com>
Subject: [PATCH v4] Documentation: scheduler: fixed 2 typos in sched-nice-design.rst
Date:   Sun, 16 May 2021 18:59:55 +0800
Message-Id: <20210516105955.120651-1-henrybear327@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixed 2 spelling errors in the documentation.

Signed-off-by: Chun-Hung Tseng <henrybear327@gmail.com>
---
 Documentation/scheduler/sched-nice-design.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/scheduler/sched-nice-design.rst b/Documentation/scheduler/sched-nice-design.rst
index 0571f1b47e64..889bf2b737dc 100644
--- a/Documentation/scheduler/sched-nice-design.rst
+++ b/Documentation/scheduler/sched-nice-design.rst
@@ -60,7 +60,7 @@ within the constraints of HZ and jiffies and their nasty design level
 coupling to timeslices and granularity it was not really viable.
 
 The second (less frequent but still periodically occurring) complaint
-about Linux's nice level support was its assymetry around the origo
+about Linux's nice level support was its asymmetry around the origin
 (which you can see demonstrated in the picture above), or more
 accurately: the fact that nice level behavior depended on the _absolute_
 nice level as well, while the nice API itself is fundamentally
-- 
2.25.1

