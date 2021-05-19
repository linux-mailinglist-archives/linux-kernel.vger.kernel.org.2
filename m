Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93ABF3890F6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354308AbhESOdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354054AbhESOcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:32:43 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57B2C061344
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:31:15 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n8so1910726plf.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q78A6AyR4otkcBAEkBIo9qmnIjV1Nb+H3oDCE4IqCeQ=;
        b=dk1ZdNXVfQKhoxoV566tbhH8A/Vm5G5muFFzInXVyLCirIpXak1AELLnVkrrMahI/a
         q6MxIrXu1qfZeZBrMwuppT1phAq5lkeDE6I6+c/1Y4nO47M8YOAf3456KRR3kVi2TCgj
         oJRGiqgCTwJNjaoVqdWeUopl53rJC2yORKK1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q78A6AyR4otkcBAEkBIo9qmnIjV1Nb+H3oDCE4IqCeQ=;
        b=SrsdaDX7Lu/mLD6ybQOImhVdOsp34fkORQCfTTKECqiXyJFh1LMUMHhsNs9I+AFfVY
         uZv4je6eCEikeoG3mu0vnQppKR/QwPZQO8SzD9f+gQ6IvUgFUgO2UcpJCboBkyRCts8x
         57jM1iA7YN7tA/l6WbDixtbOvBQPj1hYmgfQxHGk2OGAlL90mSy6nbKrs4OXdDIIIo6d
         I0qSgyxV8lgSO17cCuJ5KuNImQK4A0/Pq79hPsNQgnrpDeIuxWGKlzLaQJXFlmYMmnjw
         lSLqOkhpibyAVv86pFHSOTO9/2a+LfRVrfq/kGuKiBfDrA4Es/b725w9o9+8g5cjDVMw
         3I9w==
X-Gm-Message-State: AOAM53350nJL/uhNmA3nJ8W3myCWVvlGv6J2CpSN0SzbvVaS77abNnSj
        Jfa1C99+nEedkE+2bqc++hF+SQ==
X-Google-Smtp-Source: ABdhPJwdDn/dz5IGtknH9kB+SXI4eNzO99AciIpqZ19tsCC7zIo+J+5hsaypxdt1S8opgVpNUKirRA==
X-Received: by 2002:a17:90a:2ec6:: with SMTP id h6mr11572585pjs.103.1621434675194;
        Wed, 19 May 2021 07:31:15 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:87ab:ff82:1544:697])
        by smtp.gmail.com with ESMTPSA id 3sm14337661pff.132.2021.05.19.07.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:31:14 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Courbot <acourbot@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 13/14] dt-bindings: media: document mediatek,mt8183-vcodec-dec
Date:   Wed, 19 May 2021 23:30:10 +0900
Message-Id: <20210519143011.1175546-14-acourbot@chromium.org>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
In-Reply-To: <20210519143011.1175546-1-acourbot@chromium.org>
References: <20210519143011.1175546-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8183's decoder is instantiated similarly to MT8173's.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/media/mediatek-vcodec.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
index 06db6837cefd..a2a2a9e2ade3 100644
--- a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
+++ b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
@@ -9,6 +9,7 @@ Required properties:
   "mediatek,mt8173-vcodec-enc" for mt8173 avc encoder.
   "mediatek,mt8183-vcodec-enc" for MT8183 encoder.
   "mediatek,mt8173-vcodec-dec" for MT8173 decoder.
+  "mediatek,mt8183-vcodec-dec" for MT8183 decoder.
 - reg : Physical base address of the video codec registers and length of
   memory mapped region.
 - interrupts : interrupt number to the cpu.
-- 
2.31.1.751.gd2f1c929bd-goog

