Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C1B31DD17
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbhBQQOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbhBQQLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:11:53 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744D3C061793;
        Wed, 17 Feb 2021 08:11:04 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id a207so4130086wmd.1;
        Wed, 17 Feb 2021 08:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kTr1/mv6nsyXy8Axrc2R950ucaShXBUxnX7juCfyHPA=;
        b=C6DSpAXHlLLxXjVjWHfcoboMO3/d7vXGb/RRxrNICrgAGBYz83QKN+q3oimcaPdz1e
         fUZ8WxXje5JniC7Psr6dCBFaw1Q49BCZM1vRaXndiM/0XKkabzcsFrP2XUxQYNWyCbXx
         PNYaxdH9S2U6xXACiQ8zaIvZ6ewB+xUVQSZW1/bsi4HVtmH0B6aXhEbikh5189u4jiqF
         OQWZWk3lNLvsyDRw3b73A3LaEFuWf1LxZY8r5BZVRWjuP1KuNXFbEA67sZ5aS/ZwnQJb
         HcDctmggsIeZu8epoCfKJEkBnOPnyfnz/V31+ITdrZr5zmLyfKuWIT/6RSJAJgSy/hkf
         i0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kTr1/mv6nsyXy8Axrc2R950ucaShXBUxnX7juCfyHPA=;
        b=HsA8BepVrMcPYrnUUlsYTXZHVXOayaW6yxzLR4jnEszPX0nTxD0ik1nxtLy5aY8fV2
         xykzCN47qM3PwD4P2w66VVjb+SHWPtouAKKjFcOCDv+r13/hCBW10G5XNqoF0F1Ziroc
         MhAy9cxsP+hamOjGL4ac4fxeAWPtcID7p0Izgyuv3iA3ZUXrGJAMtDq/YLsJshn634QL
         bTk8eH7DtE2xL6Ma8PejX+9cKbdDSlfbo8sFyqn+xMEXpKjJ3INndtVI51lZir0SaCS3
         ELYHXWmue1OTzrh53nfKrOQk1rVmH3hGafU/pYAj4uPOG3alKjy8qJjllLrlRqjZzW1e
         6/cg==
X-Gm-Message-State: AOAM531yRjFSBj0tl/N5qdYVn0mfVdS0FIHRVvoZO2xyNObdfqKELk41
        9RwQi5wKoHI5031dukPAy9I=
X-Google-Smtp-Source: ABdhPJxN+Iao7V7SU5jNKJEPxJ4F9o4a4joBDqN/6naPT+2koRff5mBW5+pU+Vf35tPrjSWmGrJ4Jw==
X-Received: by 2002:a7b:c055:: with SMTP id u21mr7853133wmc.68.1613578263182;
        Wed, 17 Feb 2021 08:11:03 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd2700605dcea117b1d0f0.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:605d:cea1:17b1:d0f0])
        by smtp.gmail.com with ESMTPSA id e12sm4260260wrv.59.2021.02.17.08.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 08:11:02 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v2 8/8] arm64: defconfig: Enable wm8960 audio driver.
Date:   Wed, 17 Feb 2021 17:10:52 +0100
Message-Id: <20210217161052.877877-9-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210217161052.877877-1-adrien.grassein@gmail.com>
References: <20210217161052.877877-1-adrien.grassein@gmail.com>
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

