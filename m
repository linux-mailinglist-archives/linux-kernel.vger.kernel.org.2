Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CBE34AC06
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhCZPyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhCZPyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:54:33 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89D7C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:54:33 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id w10so574173pgh.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/DPkie9eLDuohw1VDG+K2dY22CMTsVPD15Gq4v7Eqnk=;
        b=DM8PvvsuvfEGWEHcAr9b27QmFBj5pu5rE8d6Thq/38lp3EsLrmfFRPorbGbDODuuc8
         F+JkUHd91UquSIY6nR4EwyftrVi9xJc6nOUvU/koOVwH/AI56TKsC8JvePu/xsMY8mO6
         4oX/pBv+Qy285rF10MQRMJ8aO2s5BXeyyXWQNA3H8K0aE/eBYvb818suMxRfD4N9jAd6
         Pk0iQ8KgNmS0YuYu3KDETgb8dbZ1jVXlGk+BqTgyRGdkPm7uWRLthwCX2YWBwUaPHRqM
         BevW36evOW1hKHeDj7YMnqwXvMlqr1ldHHokvgOKSkUrOFt0A4gDEBx3iRZaV4ExM3Qi
         kNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/DPkie9eLDuohw1VDG+K2dY22CMTsVPD15Gq4v7Eqnk=;
        b=GUGIXpUUP6imc0EoRD/utwdgbNHgM+GuTcwRCA82LikQ2Tc156oWaRFIhXnojjXlIZ
         0MokZPQHWRxGHrjBh7TtfX5dyrKR/08p5J9LAi2dDIffLucqZppf4VnySCqiROdrpC4+
         Yr3592LLZAxYv4QTmc01h1bx3CYloLdhkY6IB9yiY+7KhUNwc0KaKZaQ0wJDc3byXq5Z
         HUfY+G/suu4D3u82rQghjWMktS5p0Tc1hWlqWvVGBnehwLAfmpq0SSmW+AvUBO1HV7SO
         DcUrtpzZlD7Ggmv3/DjHjk9KfuFeFgomTZ8oPWLfuzr1qvQESrlI/mGV7sXG5iQYhpPr
         PqnA==
X-Gm-Message-State: AOAM5300DRl5PQB7ATheRYb+zqYr3wmIA9AqdVhq2DfgqUr6ObCW5r+b
        fd3IdaHDRTbJk9QygtLqnenBIg==
X-Google-Smtp-Source: ABdhPJwIkdPnlN3lKoBKfWjiKDNcTEU9lEeHRfTwUzhQNq9Blzl4hRih1gvdbLDGW/39xF5NdYXfbQ==
X-Received: by 2002:a65:62d9:: with SMTP id m25mr13121361pgv.6.1616774073257;
        Fri, 26 Mar 2021 08:54:33 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id x2sm1206139pfx.41.2021.03.26.08.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:54:32 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     suzuki.poulose@arm.com, mike.leach@linaro.org, leo.yan@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add CoreSight header files
Date:   Fri, 26 Mar 2021 09:54:31 -0600
Message-Id: <20210326155431.2011889-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding CoreSight headers to the list of supported files so that maintainers
can be notified when changes are submitted.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85ca831d..caf7ad0bb12b 100644
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

