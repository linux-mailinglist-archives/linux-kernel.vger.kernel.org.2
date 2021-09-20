Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA36410FEA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 09:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbhITHT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 03:19:27 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:49416
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233294AbhITHTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 03:19:25 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E81BC3FE01
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 07:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632122278;
        bh=K975uWTYLGkLbkETM9T3s7Y45GbdozAN4S3IGUhBhMo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=BbbSf2IYQkzLy8pUdFju1wufZSgPWXMAomvadMGdNKyBBalbNIze4cHXOBvWrhknl
         obcC3j4W6gpe8cvCaZ/5iqdoi7YWyjA5CpjLzs8TCr5DYVwVp6iPC5om1Z1XmJ+Fxj
         tRZA2WBxJIQKDxdEpc8gX87DwGobbQTG6Zl14qJ/KYenVQ5o+o9PYzxklQCRkvVu9s
         2hT27PIpwMdf4jiGqbsu/8HM26pVgvotkiXHvcU8n5ty/JfvrbhG5Yf7NTim+y+Buf
         zTH+kHxefhvnCg4YlmLMh5xn/a3aTPbWbgyLxPVtdEy17dSExE96oej2ugdrLnpXsl
         hruUlW7AYCL3w==
Received: by mail-wr1-f69.google.com with SMTP id l9-20020adfc789000000b00160111fd4e8so221370wrg.17
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 00:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K975uWTYLGkLbkETM9T3s7Y45GbdozAN4S3IGUhBhMo=;
        b=dJGu4iCglDJsSNd70FaNNqtvLdczoiWeK1i68aaDbBEO60vgJlidr4qy3k1W8HCdjl
         3G2GUG+82MjAiF0smubEKnuVSV3MINSZFvJVL4PzCwdCk7QFpMyMshDWG2FLCLi6YI2C
         sOkmnGHl8yj3CbY3CNk1XBj84AtV4yOHtOgUJ8eTP50wnUsqeBiqB+j4lNxVwg+LvaSb
         ZRqdNg3WRXAEHhaZPSCqYVVg/8zcP9IzSgFxUbGmjPVEvjLv9hvKbHoYTo5LeRAm+pej
         9EgQWy9hCqb0ctH5OLNWMM1QuXeVVVBq6PBtq+5kNwYEq6rZp3t6PVCwnKuJj7g5n/rO
         Pymw==
X-Gm-Message-State: AOAM532hnvsMlQjnQxZH40wZ7Wx6EoLkAWuyB4denBoq54i7eSx9PNL/
        /0jy32T39v5DiA14h5Ns4Fiw0CSKYuosCrJuS79YOblzC1bL6vzjgfmWDxvz5TVPs7/jRFDOvad
        nIG98oFm46t4DmXAXyuTJ/bhKpFzdxb+Sih6CuQFarA==
X-Received: by 2002:a5d:668c:: with SMTP id l12mr25958806wru.436.1632122278652;
        Mon, 20 Sep 2021 00:17:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzW4RCYsQAwDVi//vMFGQ0H5hMTUOpmow8nulLe+L4fg0CAxTaF+uxW5s557hhH8OPbHt+Sdw==
X-Received: by 2002:a5d:668c:: with SMTP id l12mr25958797wru.436.1632122278512;
        Mon, 20 Sep 2021 00:17:58 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id a202sm6990798wmd.15.2021.09.20.00.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 00:17:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 1/3] devfreq: exynos-ppmu: use node names with hyphens
Date:   Mon, 20 Sep 2021 09:17:51 +0200
Message-Id: <20210920071753.38560-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920071540.38337-1-krzysztof.kozlowski@canonical.com>
References: <20210920071540.38337-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devicetree naming convention requires device node names to use hyphens
instead of underscore, so Exynos5422 devfreq event name
"ppmu-event3-dmc0_0" should be "ppmu-event3-dmc0-0".  Newly introduced
dtschema enforces this, however the driver still expects old name with
an underscore.

Add new events for Exynos5422 while still accepting old name for
backwards compatibility.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/devfreq/event/exynos-ppmu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index 17ed980d9099..541bd13ab61d 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -94,11 +94,16 @@ static struct __exynos_ppmu_events {
 	PPMU_EVENT(d1-general),
 	PPMU_EVENT(d1-rt),
 
-	/* For Exynos5422 SoC */
+	/* For Exynos5422 SoC, deprecated (backwards compatible) */
 	PPMU_EVENT(dmc0_0),
 	PPMU_EVENT(dmc0_1),
 	PPMU_EVENT(dmc1_0),
 	PPMU_EVENT(dmc1_1),
+	/* For Exynos5422 SoC */
+	PPMU_EVENT(dmc0-0),
+	PPMU_EVENT(dmc0-1),
+	PPMU_EVENT(dmc1-0),
+	PPMU_EVENT(dmc1-1),
 };
 
 static int __exynos_ppmu_find_ppmu_id(const char *edev_name)
-- 
2.30.2

