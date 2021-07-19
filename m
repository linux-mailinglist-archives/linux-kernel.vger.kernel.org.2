Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB6E3CEDC0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386907AbhGSTmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 15:42:44 -0400
Received: from mx.ucr.edu ([169.235.156.38]:18565 "EHLO mx-lax3-3.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1385804AbhGSTKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 15:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1626724258; x=1658260258;
  h=from:to:cc:subject:date:message-id;
  bh=MYc29Ou9YlvgD3SQj+KfJB5TjwaCedW7HGkkcEg43K8=;
  b=V1wtTXWMZSxDiRupegP2Z52NNKoYsMFNcApeYaJgU8FQz2SfL6wiy7s3
   dnBQmWWmh3QtlkF2SeQ9HQIshlbUCbaczUlvmCgQLupQSULdoOJj7Lv01
   HzTs1V9Pv+acvg+MJWL/Qiqu14xLc7+OK6E0rzuln97VTF54PyVbJbeis
   eWyeMPpaw+cO/IRJMg934yjOjs/+/dMy+6Ka5Lo+nbWPNhBXFuP8DhmZ9
   IYhfoJsySEC9vjNT2FFEClEZmygA/KboDeJUCeNw5cqPAE+gv/5gu6HNx
   kFVRKjOh44HlaBGxcHBIp9e5pqXLLopr2b7unwe5jFLoI+2IjiJXOF99f
   g==;
IronPort-SDR: qOZlJWHCtCwBrqQhJPfBKDtWvgdrxMzX1junQu1p8vTXRV2gX//0Pnf41IuLyTlxwsld1ZYRFp
 6TjM4vmYzXUbwJHuvbmpWu8vik88GpKUmngLa2E5tTMlnyr7fXMAQz0FY+z6E1du5s15Wx0zK1
 1+IeXT/A0mwGHGbvxjSrGF5cj4TqLAEUj3nsHD28eW+aCmegf9YK45w40Hy/EndzNqPHTiMC4v
 X45ml7+wMg/17y9DTNphknHRBnLAyMViVK0j8sc2XADnbgOvt+1UBSlWNUWLPXWyoj6/UDLBtx
 nZ63hEo3axL+oIFWH7TCZlsI
X-IPAS-Result: =?us-ascii?q?A2F6BADz1vVgf8XSVdFagmKDeVUWjUyHEwEBBoFBin2BA?=
 =?us-ascii?q?oZ8iGaBfAIJAQEBDQEBQQQBAYRXgwACJTQJDgIEAQEBAQMCAwEBAQEBAQMBA?=
 =?us-ascii?q?QYBAQEBAQEFBAEBAhABAYEMC1kLY4FPgXkGBD2COCmDZQsWFVKBFQEFATUiO?=
 =?us-ascii?q?YIWAYJhJpotgQQ9jDEzgQGIBgEJDYFjCQEIgSiIfIUXgRmBEIJQgTN1h2+CU?=
 =?us-ascii?q?ASDFVMoE4JpgRABAQGTUAGoRQEGAoMKHIMRmw5Fg2OCfY5dQpBeAS2QJqo/A?=
 =?us-ascii?q?goHBhAjgTiCFU0lgWwKgUFNAQIBAgEMAgECAQIBAgECCAEBAo1yATUWji1BM?=
 =?us-ascii?q?jgCBgsBAQMJjBMB?=
IronPort-PHdr: A9a23:OLCA7BK59q90U6FLK9mcuLlmWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCFvbM21BSQBtWTq6odzbaP4ua4AS1IyK3CmUhKSIZLWR4BhJdetC0bK+nBN3fGKuX3ZTcxB
 sVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBxrwKxd+KPjrFY7OlcS30P2594HObwlSizexf69+I
 A+4oAnNucUanIVvJ6UswRfNvndEZv5ayGx1KV+XhRrw+tu88Jt++ClMpvwt8NJNX7/ndKoiV
 7xYCzomM2Ex5ML1sBTIUBWC6HgBXGgIixREGwfK4g30UZf3qSv6q/Fy2DKGMs3sTLA7Qiqt4
 qF2QxL1kigHNjo58GbKisxsia9QvRysqwBjz4PSfYqYL+R1cL/DctwGRGpBRsdRWDJHAoOgd
 IsEEu4NMf9Fo4Xhu1cCqB2zBQytBOP00T9Ih3n23aIn2Oo/CA/NwQIgH9MQv3TQsdr+KaMeX
 O6pwKXNyzjMaO9b1Dnh5ITVaxwtveyAVq90fcbMyUQjEgXIhUiSp4P4JTOYzuQDvXaG4eRuV
 uyhjHUqpx1trjW12sshkJXFip4Tx1vZ9St52oE1JdigRUF5YN6lEZtQtzydN4BrRc4jQ2Bpu
 CYgxb0HpZK3YCYHxY86xxHDcfyLaZaH7Q/+VOuIJzpzmX1qdq6liRmo7Uig1vPzVtOy0FtSo
 SdJjNvBuHAR2xHX6saLVPtw80Sv1zuRyQzd6uBJLEIpmKfaKZMsxr89m5sNvEnfHSL6hFn6g
 a2Lekgr5OSm6+LqaajlqJ+EL4J4lB3yP6A0lsG8Aek0KBYCU3WH9eimybHu+U/0TK1XgvA3l
 qTVqo7WKMobq6KjHQNY0Jwv5wihAzqo1tkTgGMJI0hfeB2diojkI1TOIPflAvihm1msizJrx
 +zePr3mH5XNMmDPkLf/crZ57E5R0A8zwspe55JQE70BOPzzVlLouNzWExM0Nw65z/zoCNV60
 YMeVmaPDbGDPKzOtl+I4/ojI+iKZIALpDbwM+Yp6+LqgHMjmlIQfbOl0YUKZHykBPhqPkGUb
 Hj0jtcEC2gKvw4+TOLwiF2FVD5ef3azXqM85j4hCYKqEZvPS462jbycwCi7BIdaaX5bBVCRC
 XvobZmLW+8QaCKOJc9sijgEVbmnS4882hCirQz6xKR9LurS5CIYsYnu1MZ65+LNjxE+7z90A
 NqH02GLUW50mnkERzgs3KBw8gRT0FCGhJl5kfxFEpQH9uFJWwZibcX00udgTd3+R1SSLZ+yV
 F+6T4D+UnkKRdUrzopLPhsVJg==
IronPort-HdrOrdr: A9a23:cOeCDq3cceP+DhupE01bhAqjBLMkLtp133Aq2lEZdPWaSL38qy
 nApoV96faZskdzZJhfo6HnBEDoexq1nv5ICOEqXItKNzOW3FdAQrsSj7cKAAeMJ8Q9zIRgPG
 tbHJSWcOeAdGSSRPyXjjWFLw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="58093677"
Received: from mail-pf1-f197.google.com ([209.85.210.197])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jul 2021 12:50:54 -0700
Received: by mail-pf1-f197.google.com with SMTP id s32-20020a056a0017a0b0290336a8d53a3aso8468441pfg.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 12:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OXOnGGPnlJMlgfJA7I8h06LGQvk/TlSh7ooUa6JcARg=;
        b=c44ghtAGkcjnpZ1nuFIh4mcrUZqBYthhxwrMF9i5smaXhguoBqOM3cdzL2txuO2Fai
         tZGYrDNmdFYXjAMtOwBKHSZU+6K6nlmaukpoo4dgdie6MSdGloeS3PJrQOSp92KLu7QB
         d3yxyOaAVHPKu5GOnzkahoB6uwh1xE49xgzEXwWeSljVXLhYQJn995y2wIwFqJleGgOS
         I4Mz8wotXoitb9wgbsjv6SCFlK5YtE4GCEpopyy85tB+dlBQGSw9FSz2WNy0CYkBM0AE
         HkrOsT23oCqNUBYTBPY4umJusoc06ijxKLcAmXTNthPQy/KzuQUTFrLG7vOUdAAjxsqR
         jX1Q==
X-Gm-Message-State: AOAM531qv2FywqOhqt4cDgWABxhL1WTCeT4WwPvU0IaFow/UN09zmg/X
        p3FYjPANvTQvg4ucbgTafDS9+aDAMplaPFIhsPmXp+6a8DChBF6LuyuzdyDl/vX4xlSFb6/RrTH
        oDECI8opszbPChsmHvUqSbpwAhg==
X-Received: by 2002:a17:90a:5305:: with SMTP id x5mr31068670pjh.135.1626724253095;
        Mon, 19 Jul 2021 12:50:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeoggVNck06c751xfNeJAk9UTizVm33D0WmnP578NV87JKcTcN5mzJ1hVRacMKD2c9/PCsqw==
X-Received: by 2002:a17:90a:5305:: with SMTP id x5mr31068659pjh.135.1626724252863;
        Mon, 19 Jul 2021 12:50:52 -0700 (PDT)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id y4sm299857pjg.9.2021.07.19.12.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 12:50:52 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     Yizhuo <yzhai003@ucr.edu>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: stm32-dfsdm: Fix the uninitialized use if regmap_read() fails
Date:   Mon, 19 Jul 2021 19:53:11 +0000
Message-Id: <20210719195313.40341-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside function stm32_dfsdm_irq(), the variable "status", "int_en"
could be uninitialized if the regmap_read() fails and returns an error
code.  However, they are directly used in the later context to decide
the control flow, which is potentially unsafe.

Fixes: e2e6771c64625 ("IIO: ADC: add STM32 DFSDM sigma delta ADC support")

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 1cfefb3b5e56..d8b78aead942 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1292,9 +1292,11 @@ static irqreturn_t stm32_dfsdm_irq(int irq, void *arg)
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 	struct regmap *regmap = adc->dfsdm->regmap;
 	unsigned int status, int_en;
+	int ret;
 
-	regmap_read(regmap, DFSDM_ISR(adc->fl_id), &status);
-	regmap_read(regmap, DFSDM_CR2(adc->fl_id), &int_en);
+	ret = regmap_read(regmap, DFSDM_ISR(adc->fl_id), &status);
+	if (ret)
+		return IRQ_HANDLED;
 
 	if (status & DFSDM_ISR_REOCF_MASK) {
 		/* Read the data register clean the IRQ status */
@@ -1303,6 +1305,9 @@ static irqreturn_t stm32_dfsdm_irq(int irq, void *arg)
 	}
 
 	if (status & DFSDM_ISR_ROVRF_MASK) {
+		ret = regmap_read(regmap, DFSDM_CR2(adc->fl_id), &int_en);
+		if (ret)
+			return IRQ_HANDLED;
 		if (int_en & DFSDM_CR2_ROVRIE_MASK)
 			dev_warn(&indio_dev->dev, "Overrun detected\n");
 		regmap_update_bits(regmap, DFSDM_ICR(adc->fl_id),
-- 
2.17.1

