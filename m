Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8487F31FB02
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 15:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhBSOga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 09:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbhBSOdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 09:33:33 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58772C0617A7;
        Fri, 19 Feb 2021 06:30:43 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id n8so8762342wrm.10;
        Fri, 19 Feb 2021 06:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kTr1/mv6nsyXy8Axrc2R950ucaShXBUxnX7juCfyHPA=;
        b=t88LcLHteis949B5uVW1zBZUZAlG27ufw5MxoV20tXzEsuscKM1hvlZ6lPsJkzn/Jl
         gAuoikLxan6FUYfNp3pqjcRtEXgIlwq2iSP4acq4BJzQNEKNRvc5Oq0jQxsQEwkKBZbC
         nTEHtvIyhHT9wBtHxSOwNeCh6S0rqWEv93iey5opiOhK66SfKAKepZ/j8+UzMD36ah/K
         GSksSDLvvkU1e5V1MZz6fpWUyyHkvI4765fCkvXqHpUTBNtKBqsuJrgx2oiD+nxVE+AY
         jnSJgKV1iWE3Z+oyXm7Ch51xrqAAB1RaqkdvmYfOkFVRzKaI6EsERfe4vXSlR9uW6E/S
         sydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kTr1/mv6nsyXy8Axrc2R950ucaShXBUxnX7juCfyHPA=;
        b=Ncf2RB7NFPC0ltfM3RxvEGECy89LnNqVu8B2wQiToq0pEIHkmB/C3R7BK8E5HAH0e5
         BC4Kt2AUezrKrPns3uAdoZ8VMgsu528l36B4AL35a7eGHSbKIGz4/zKMLnBlAzfo4Wq/
         ilDJEEB4vFs/2MmwPa+8u+n7K/afgsgnHyRzfobMvMdgY5zxuyY4JPaa6TlZCG7E/5gO
         hyH1ipYs/nhDsrfvmZhDKQ4EmGWpqQaN6SODzd68rqqOeINfk3aTQ24Fvmfs/ppoxRK/
         rue9/OB5eMmUak979aUsed25/I8NfnQHV7uThWeWegESo+vJPbLj4uDlUvnNGz20JaPc
         RKJA==
X-Gm-Message-State: AOAM5325zKfITGDPTKMti1o6WHZ9l1dpVdqyj2BBgQ1/6Me1kRks7qok
        ffCQ07i5FzRk2c5bjocdEJo=
X-Google-Smtp-Source: ABdhPJyTknvkyvkH4w21Y5QGLaXRS8XwiK13m1rvqXAW5hWkEPUj7fDH4Ax/3xzKFGEdKk4HOwa72g==
X-Received: by 2002:adf:d239:: with SMTP id k25mr9806163wrh.308.1613745042106;
        Fri, 19 Feb 2021 06:30:42 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd27003cf54d240f3b36ef.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:3cf5:4d24:f3b:36ef])
        by smtp.gmail.com with ESMTPSA id v9sm8348215wrn.86.2021.02.19.06.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 06:30:41 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v3 9/9] arm64: defconfig: Enable wm8960 audio driver.
Date:   Fri, 19 Feb 2021 15:30:28 +0100
Message-Id: <20210219143028.207975-10-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219143028.207975-1-adrien.grassein@gmail.com>
References: <20210219143028.207975-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is used by the Nitrogen8m Mini SBC.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 292c00f893fc..bd310e91d4ed 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -764,6 +764,7 @@ CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
 CONFIG_SND_SOC_TAS571X=m
 CONFIG_SND_SOC_WCD934X=m
 CONFIG_SND_SOC_WM8904=m
+CONFIG_SND_SOC_WM8960=m
 CONFIG_SND_SOC_WM8962=m
 CONFIG_SND_SOC_WSA881X=m
 CONFIG_SND_SOC_LPASS_WSA_MACRO=m
-- 
2.25.1

