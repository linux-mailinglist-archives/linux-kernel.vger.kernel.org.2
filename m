Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF27733DAAE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 18:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239124AbhCPRVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 13:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238812AbhCPRUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:20:13 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2F4C061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 10:20:12 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id jt13so73531557ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 10:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mm86pbCDX19ZA+U6x/Y02/6OFIBGni7DxrIBYj5GsxI=;
        b=yF+V7H1rthM0lVYnnELyZnJDuht+Tlhi6+sl5kJ5fgYafaY8LDDhyRie6yiZxIEgFx
         8Ezslg+3GluQXbO8GsVgB66qTfS5SLvHSkFNGvpvN4ZJYBgNXwYGoopm0i6YQm+Xw/IK
         V5PDoXDUqCYcHd6Aj3GgZ2abxDzPbHQCDx6/xKuTYeElmI4djHL2PcQ64SvID5oiGqul
         Qx/0ea7/1+3Uw4lDOmzBy0OJg0eoq5XM+CL5EE7BYOlQIt5ahRccuoPe5QMhgjBdE1sF
         un6XFT7NFIHcjng5DqwiQ9CXxYfsXresx3bjmMImYYekEycTdG9jRG9Rms2M9nL4V4nc
         j5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mm86pbCDX19ZA+U6x/Y02/6OFIBGni7DxrIBYj5GsxI=;
        b=KIuvSd3gS8bIfDaFYfwNB3m9ya/pRS6Hnkfg8JV393R0qaITdJsTeggAE9ytcf/Mlt
         cgeA6ECv+VoKkJclOGtg2p7XghspULnKvCHvkDHFA8qZCSVY+0NS3Ubi3mIf2YYzn0ni
         trYtUySZKKMJb6ABn8JivJpwCI8FOxqYi1m7HCnYg3DCizXnF8kys01lAFhR3KZjXdU3
         ZU/Ab24c1e3YbQSbKANxsb+82f2z7plVU0Wap3dUi8zuYIzQd/zppsmyO3TzScfuYlIY
         n9jugW+Vvl37t63rEep8D+DIeTIgWbrICjRRsDUaosuX7PkefW2pY7nnNhazqBm6wYmF
         ODzw==
X-Gm-Message-State: AOAM531z+1t9blcD0GlclIDWQJ4Y7Ea+1K352NSBvxoR7FgYvoddLrN6
        a+aNPchgk40MeN4R2gML5QqwLQ==
X-Google-Smtp-Source: ABdhPJxAcj9l5HxEklZsFvnkh7WHLwHZFKiw3/PuMpPMkiHySb37L3OnZtnIq2JE0pl65/UbA9+Lrw==
X-Received: by 2002:a17:906:7f84:: with SMTP id f4mr29990794ejr.525.1615915211716;
        Tue, 16 Mar 2021 10:20:11 -0700 (PDT)
Received: from localhost.localdomain ([37.120.1.234])
        by smtp.gmail.com with ESMTPSA id u1sm10571584edv.90.2021.03.16.10.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 10:20:11 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     robert.foss@linaro.org, todor.too@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, mchehab@kernel.org, robh+dt@kernel.org,
        angelogioacchino.delregno@somainline.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
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
Subject: [PATCH v9 04/22] media: camss: Add CAMSS_845 camss version
Date:   Tue, 16 Mar 2021 18:19:13 +0100
Message-Id: <20210316171931.812748-5-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210316171931.812748-1-robert.foss@linaro.org>
References: <20210316171931.812748-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add enum representing the SDM845 SOC, which incorporates version
170 of the Titan architecture ISP.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Andrey Konovalov <andrey.konovalov@linaro.org>
---


Changes since v5:
 - Andrey: Add r-b



 drivers/media/platform/qcom/camss/camss.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index e29466d07ad2..63b35ea2ca36 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -66,6 +66,7 @@ enum camss_version {
 	CAMSS_8x16,
 	CAMSS_8x96,
 	CAMSS_660,
+	CAMSS_845,
 };
 
 struct camss {
-- 
2.27.0

