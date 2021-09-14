Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2149340B719
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 20:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhINSna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 14:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhINSn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 14:43:27 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242D1C061574;
        Tue, 14 Sep 2021 11:42:10 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id d207-20020a1c1dd8000000b00307e2d1ec1aso246250wmd.5;
        Tue, 14 Sep 2021 11:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SSna1bEaXtn8m7SSEUg3SHS/YUvgM9x34Z5EWR+22QI=;
        b=SzyTWssUaWOYbYidrB26dISRs1wym5Iw58QSGGFaGGuHB8g0U3UHKKF/8TmZciMoQE
         tT8Z63Qs1y4s5QTCtWx4QVZu2kDp4OARcxgVk14pd2ra9pGiD94z7YOxdOsyGFIFxJbH
         v3nMo2BvyQ8BwTpfQFQuQDlHmDfiMQahFMNaOko8DBWG8VPsooCWK5zTZUQh3KPoubvq
         WWrItAfk8PauLRMcTRB3VS5YXBj7ULV8uOjUysYjb6KoGiqB9IRLk06oWfswI61E2g0D
         ZxXs5e+1JOArTmmCKXDXtXfdKtnoj09/abHj2fM1oAW56s3nEL6BZurUlZT3KjG1HXJd
         TMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SSna1bEaXtn8m7SSEUg3SHS/YUvgM9x34Z5EWR+22QI=;
        b=j2QsIKSxGi8LvCdoJCobmqtQ4ITaQ/BKG8nk4KdELqcWIFYlMx9JCbJwzcUfP0DBiz
         bm+bocn8sOa4q6+66RiylAWbBVp/fTScPtEA9XOrZl/m09tuti31H7lLxy7QWKOSP0d4
         kzn14DS24EQSZMnzhY6ELj8AXW4WfpVgaiOzMkChzgmYMitj7F5tC2zwBorxtbZPzXv0
         lL3GEvsgVyYNNXEILCt0hIVtJtRlcHdI8i8RUmTlPatb4dP7ocSPfDnlturRB33esOp3
         gz89VMKGsO5pk9y1ZkzbXa41pcW/gHD1hfzNtToiPs3Ed8dtcKNUDYj+9zMnWQIo+daM
         /ISw==
X-Gm-Message-State: AOAM532wFuh3TwVljySFS+wgb9y6IeJK1jBvN9g88XKiCWzhHXpY3KuS
        zEs9+tFsdbtkArt81QNhcF8j3GdAajM=
X-Google-Smtp-Source: ABdhPJyp9YNb3Mn/aWtXM24TtfjFR2LXgLSLY6nngvb47buscOrJ5HOVI/aOjgm2BKxlfnP0aQklOw==
X-Received: by 2002:a1c:7713:: with SMTP id t19mr528445wmi.162.1631644928473;
        Tue, 14 Sep 2021 11:42:08 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id f1sm10566247wri.43.2021.09.14.11.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 11:42:08 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] ARM: mstar: Mark timer with arm,cpu-registers-not-fw-configured
Date:   Tue, 14 Sep 2021 20:41:39 +0200
Message-Id: <20210914184141.32700-2-romain.perier@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914184141.32700-1-romain.perier@gmail.com>
References: <20210914184141.32700-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vendor u-boot does not configure the arch timer correctly on
MStar, let Linux do it.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index 2273295e140f..982dba9d28eb 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -39,6 +39,7 @@ arch_timer {
 		 * u-boot is broken
 		 */
 		clock-frequency = <6000000>;
+		arm,cpu-registers-not-fw-configured;
 	};
 
 	pmu: pmu {
-- 
2.33.0

