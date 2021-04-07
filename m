Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79D4357147
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354039AbhDGQAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353992AbhDGQAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:00:22 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B873C061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 09:00:12 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id z16so6001738pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 09:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ELxvFEQAS2LYZ7enCv9ITtBcG0Ag2jnkItCK6o6mBo=;
        b=SCq6BsUcONoS7teEPjyaOU0HfS8qe7nC7a4Oo5F6Kc5C8g7Y6JECGTp42ypQuEsPbU
         hsAjwXmvWve8HMN9CPDEdpLe9Mcn+NmQLUkc8hxWza+9Vy2JrMY5j3Z/A0lFKDiAs6O6
         wnYA5p1X9n6y0/xfBTDEVu2/TuZtaN072TfZvSmLHgHfBDHW0JkWfcdz7o6v/xMvq7QK
         YWl7gZahHXiU2lNQIYAqJ5lYCb3tm9FJ5PhyZg6iGiZWpKwARZfGZOF1S7i8OKiXD4uX
         tterz2PxotcupVaUli24/Z/135ppbmUFyqYfTWS/C0d6EolfpsU3CyllJL1VXnv9z7G+
         6znw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ELxvFEQAS2LYZ7enCv9ITtBcG0Ag2jnkItCK6o6mBo=;
        b=qJCViF5FeVrqZgoU/XITJOvCakTyxtuDRi/bm7A1pzhAytr03tSovQKJNYC26tXhUO
         kBo25GzeI7S8pcBGOGGufpTuGMMLKiuCqzNGxo5iRxjaR+iSazFyCnQ2yvHnisdFxI2m
         tYVVJflmD9taVXUjuaSsLYmawg6pEKGRgAiwm+tcqRPOT+LoG7hTnHpRItJFDtfX4FAL
         1oyJ/qyfw0a61cQKpjeGULXRwYJpdK/svPWTXWKFoPAO4KGHkt2MARpcPmTORtSAKbnL
         Kjda4HI7vvL6KPT61chtttoK1G2dYpmH2AD0VCZMOsaWP/LpZH6dbXV8DV77Nz1MVvtf
         yzBg==
X-Gm-Message-State: AOAM532YUrFEYqpnoBJe1TrgSymYGEF77fPKxIo6SZzNfPadsfKKVq6R
        6jwHH4h/g8sLEYDPJk7ypFDzPA==
X-Google-Smtp-Source: ABdhPJy4tDOLG93Ps3k4B/mVDlNtvPSX89hd5FZ40mdexsGpTcOnJ78ce8SLA6wJz5ka60E5xEtzLQ==
X-Received: by 2002:a65:480a:: with SMTP id h10mr3879522pgs.63.1617811212058;
        Wed, 07 Apr 2021 09:00:12 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id s22sm21464713pfe.150.2021.04.07.09.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 09:00:11 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] MAINTAINERS: Add CoreSight header files
Date:   Wed,  7 Apr 2021 10:00:07 -0600
Message-Id: <20210407160007.418053-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210407160007.418053-1-mathieu.poirier@linaro.org>
References: <20210407160007.418053-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding CoreSight headers to the list of supported files so that maintainers
can be notified when changes are submitted.

Link: https://lore.kernel.org/r/20210326155431.2011889-1-mathieu.poirier@linaro.org
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6ae3955525a9..aa86b4d0bfce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1764,6 +1764,7 @@ F:	Documentation/devicetree/bindings/arm/coresight.txt
 F:	Documentation/trace/coresight/*
 F:	drivers/hwtracing/coresight/*
 F:	include/dt-bindings/arm/coresight-cti-dt.h
+F:	include/linux/coresight*
 F:	tools/perf/arch/arm/util/auxtrace.c
 F:	tools/perf/arch/arm/util/cs-etm.c
 F:	tools/perf/arch/arm/util/cs-etm.h
-- 
2.25.1

