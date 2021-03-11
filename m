Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82DD337C2A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 19:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhCKSL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 13:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhCKSKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 13:10:35 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321D9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 10:10:35 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id r17so48125282ejy.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 10:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tpy6xUUL9qRQqZuAbviQLSx2FJwSSDBmrEW1amUuagg=;
        b=OSkqDMsmZADXoxTIsektu950JdBrbo9IcjmhPNOd9J81LEdZqXO325r3EBx6OZzekf
         DXoR1ScvRzeWL+NrgL2xafgXGcqxM2J+mMGtVOQMB7eXK2wAlNXTH0YOlmjJ/bp9cS1H
         eHmY7i38xdiAI6coBFDIbFC5Po8x5HPFxB44DV1jLZ/49luLAKKENzUKgRv7vA/wXejZ
         vPY00wiQKyfV7oEJiTv2OLcrQ/zBC4FqvNt5QTGUr7E10vMGodNiXguv+mlhUp3dg1hS
         hqwEGZXZAQe3JIcjFxRwTpxE0DhghyXJApViNeCrcvmAFg/TpadMb3AblgEnDwHR6vh8
         eUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tpy6xUUL9qRQqZuAbviQLSx2FJwSSDBmrEW1amUuagg=;
        b=j/e/FAF9fox++2cjdRad2gYybCeaCJEYJi5hXK7nVxUMS90wH8m03hvbvtUiswElX7
         ckrCEk1ftC8RBefKXdOmU4+s/htN6dwlkvmKsE36S7y9iLi6wVX+IlAmuA0y/o3E+67C
         EW81F/mLQFnaUxfhS26+BK/+dG5CgDBHzasX2my1BBaHCMnGH+eg39V4L157KCFOurjU
         cCY55X6as/37C6PticpKj0tz3shzJqAa1mwSs5c16fT1hnX0ZNsNgFomBaTwVos3Mm7c
         tuFL9QkjMvbo3NF7d3hDkQAr+u9rJPz3EphJV7zExpfyzmQJvFVlnMR9xI+Zr+BjWUw/
         Lusg==
X-Gm-Message-State: AOAM53327yxwyvWOSl/AJmrOPTwfmiBXmIPBLQsi0qe46lf1UCTAsmHr
        /eB37jfSrkObCRjQW4YyaQLRxQ==
X-Google-Smtp-Source: ABdhPJzEoR1CquFt1BXoYpCD368hce4zzyQDSJLubU1om7PxHnQiy0ufNK9iJk2zloszM/SgfaW1oQ==
X-Received: by 2002:a17:906:4117:: with SMTP id j23mr4446488ejk.10.1615486233852;
        Thu, 11 Mar 2021 10:10:33 -0800 (PST)
Received: from localhost.localdomain ([2a02:2454:3e3:5f00:8e01:34c:da50:eb7e])
        by smtp.gmail.com with ESMTPSA id a22sm1741290ejr.89.2021.03.11.10.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 10:10:32 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        robert.foss@linaro.org, todor.too@gmail.com, mchehab@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@somainline.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Rob Herring <robh@kernel.org>, Tomasz Figa <tfiga@chromium.org>,
        Azam Sadiq Pasha Kapatrala Syed <akapatra@quicinc.com>,
        Sarvesh Sridutt <Sarvesh.Sridutt@smartwirelesscompute.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Marek <jonathan@marek.ca>
Subject: [PATCH v7 18/22] MAINTAINERS: Change CAMSS documentation to use dtschema bindings
Date:   Thu, 11 Mar 2021 19:09:44 +0100
Message-Id: <20210311180948.268343-19-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210311180948.268343-1-robert.foss@linaro.org>
References: <20210311180948.268343-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the complexity of describing multiple hardware generations
in one document, switch to using separate dt-bindings.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---


Changes since v4
 - Rob: Added r-b



 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85ca831d..7da3e0c74fab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14787,7 +14787,7 @@ M:	Todor Tomov <todor.too@gmail.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/admin-guide/media/qcom_camss.rst
-F:	Documentation/devicetree/bindings/media/qcom,camss.txt
+F:	Documentation/devicetree/bindings/media/*camss*
 F:	drivers/media/platform/qcom/camss/
 
 QUALCOMM CORE POWER REDUCTION (CPR) AVS DRIVER
-- 
2.27.0

