Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609FA305EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbhA0OwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbhA0Out (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:50:49 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5D1C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 06:50:09 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id j13so2785134edp.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 06:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m6jdKU1G+/Gba6Pdo2VNljOQ104HqrrC2plW0O0vdBw=;
        b=Y3wRiNkO0eRdZuqN6nQa7Bop3pdChuehs4CoEt77BXkeBlwu0KLg+bwJ8pLHgYfJvb
         kdNtAxXTznUccdIIhJmz7gGfiJ/xIzFmAw+2oOut4y2c82XpvGq3UKSknNEgk1fyh8Bm
         nVy9j8h6lzZUM16Q/N36pJN53+yWZMSBrZvFGhkxqoDzkRPGAITVBcIJef5MSPkkCOBk
         E2YFT6ODB7tQxn/Xi+VN+86IN1vUVNuNsHecD3gMKjcd9h3bXEMfjDeVV4Sh6KELH/br
         CkTuedszKqybrSTgZ1TLlSWPp9zAznsbn3rPHwQOGuVq9tyALZ3VP1+GMHNuKBohydVL
         qZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m6jdKU1G+/Gba6Pdo2VNljOQ104HqrrC2plW0O0vdBw=;
        b=tqg2UNv/O2DY5f/ucC5ic8dtd3XfGpMliCqrqvHJJ2gslreDiahEYXNW08r3S/GAHF
         x+TiWPOE6Kb4j/k/r2/H1B8MvKqeHdgnWOSiud8hoHcIlwcEY3XghhLzHxE7YZrLxE3K
         AFKsIuFCDBxewx5VmKvxR/9/dKCbLL4RJXy9oNgOYtajBRC7iTu83zcO0sheCEVGhVpW
         8z2JVL39GxUr0HeR4zyIVLQVhGdvp7SYF3jbSNF1hv3yVhKC7F97sbb2vIFLtUOUNOvE
         qYx4OafToJgRPEffLAHKW18ZekbgQNwt98PFst5UDfYWYM2SpgIW5nJ8ooUfTytF13MX
         60HA==
X-Gm-Message-State: AOAM531zJyQxZyRg/lVKjIqw2dvfsJdWq6Lc8NuyBwMQ31Swh1Z7DMQ6
        xW8qSuPn3kMdJVu6P8IA4CqIOQ==
X-Google-Smtp-Source: ABdhPJw4XmnuKzCltcAzdBToOg4LdXzGCnpftdE89RYXXfBUrhi5lWOqkwJ2oJ55z+KvaZM2YaBAww==
X-Received: by 2002:aa7:d54c:: with SMTP id u12mr6189069edr.338.1611759008027;
        Wed, 27 Jan 2021 06:50:08 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:102f:d6a:62e7:589a:1625:7acc])
        by smtp.gmail.com with ESMTPSA id ah12sm947799ejc.70.2021.01.27.06.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 06:50:07 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        robert.foss@linaro.org, todor.too@gmail.com, mchehab@kernel.org,
        robh+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, leoyang.li@nxp.com, geert+renesas@glider.be,
        arnd@arndb.de, Anson.Huang@nxp.com, michael@walle.cc,
        agx@sigxcpu.org, max.oss.09@gmail.com,
        angelogioacchino.delregno@somainline.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Azam Sadiq Pasha Kapatrala Syed <akapatra@quicinc.com>,
        Sarvesh Sridutt <Sarvesh.Sridutt@smartwirelesscompute.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Marek <jonathan@marek.ca>
Subject: [PATCH v3 01/22] media: camss: Fix vfe_isr_comp_done() documentation
Date:   Wed, 27 Jan 2021 15:49:09 +0100
Message-Id: <20210127144930.2158242-2-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210127144930.2158242-1-robert.foss@linaro.org>
References: <20210127144930.2158242-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function name is comment is wrong, and was changed to be
the same as the actual function name.

The comment was changed to kerneldoc format.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---

Changes since v1
 - Bjorn: Fix function doc name & use kerneldoc format

 drivers/media/platform/qcom/camss/camss-vfe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index fae2b513b2f9..94c9ca7d5cbb 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -1076,8 +1076,8 @@ static void vfe_isr_wm_done(struct vfe_device *vfe, u8 wm)
 	spin_unlock_irqrestore(&vfe->output_lock, flags);
 }
 
-/*
- * vfe_isr_wm_done - Process composite image done interrupt
+/**
+ * vfe_isr_comp_done() - Process composite image done interrupt
  * @vfe: VFE Device
  * @comp: Composite image id
  */
-- 
2.27.0

