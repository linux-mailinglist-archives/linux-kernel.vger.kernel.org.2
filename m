Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A71B40E5B5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 19:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350896AbhIPROK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 13:14:10 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:59212
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349345AbhIPRGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 13:06:36 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AB8C240261
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 17:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631811914;
        bh=ZHRoqPl1cOVXSfVcApJkxd3VnTYZBp5y1yAkPPBCN0A=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=qTF+EbNI/zArJNagC/G5kFsFXrl5AXtpjoQn6Bp952X7ZukIQGexyzvJ7Cvgl8tpo
         36WYND3k0NZ33xJ+IjOQTfX7pwzklr4RtcF0hzu4J0LFravKBl5SdfWxdi1jCzxRGz
         cuJtwIYo5BvZFjlWrlBRObryvqgNuW+leanKxbNbYTbxljE+3eilk9rfbcAqkd/PCz
         uOgHP1pVNOqYS+DwzMlvgpfcsXfGIHpuhSBnTVQQEcRzlMjecrpyz7edhlKTFE4RS8
         Vwu/yM6nvZuuNS4YQBtsc9SRj7i6DtMOEmUs4cyXs2UCZRgyzQQrNY00C/LcWz6rZl
         fHpbIkOGufJ/Q==
Received: by mail-wr1-f72.google.com with SMTP id z2-20020a5d4c82000000b0015b140e0562so2700585wrs.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 10:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZHRoqPl1cOVXSfVcApJkxd3VnTYZBp5y1yAkPPBCN0A=;
        b=iaZmFkTTt5kf0oXjWA4/7xFkB3DHQKzYot5rrH1W5LIFPbxs97JRHvLQcv7YENYqc2
         JciY5zZwXs51VhVlvxIJo7tKDpDBVZrEk9TT6lPGviSptB1AydMRGFkGIhig2OWDq/7h
         vPDdNHOnHxJtck8lSRs0YYCBwohS1zCB8/aIin+FUyDPjNALlBcZ/pA8mVT6joEnxc+w
         ZWdnBmmPG72UHAqpOX6RihKT5DjBf3mxSwVmt+vwXrZXqQd8ISfRGWiqBkgT2QaFGsN2
         4TGCpVOuZPEgqOfePjfvG5+WFzCuKLNCHFDQQLT2IF6TQ2D9qplaafSp1VzzvRKsa5bg
         MxWQ==
X-Gm-Message-State: AOAM532HjP0Xm4f7bXkGOM8xLz68W06bT6rx7I39uCEzd5oCwb1DlP3b
        0+/RddrcOKSLD/06QmeVd7H6vMaPm9Ds711chRum1ji6sPTmaQ8gPWyyY0Ht/qf8Cirzwue/Mgn
        FPy4SCRHo8agFSsLyq61L67BB0aIC73ic99yqOEIKGQ==
X-Received: by 2002:a1c:403:: with SMTP id 3mr6101159wme.161.1631811914234;
        Thu, 16 Sep 2021 10:05:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwv7qQi8MCpMfWAMFcZfF4aplV7ax8EdJu7wjofiWEf9bor5D979kr8z1OijUkT1SwPR4Ln6Q==
X-Received: by 2002:a1c:403:: with SMTP id 3mr6101135wme.161.1631811914068;
        Thu, 16 Sep 2021 10:05:14 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id l15sm8025724wme.42.2021.09.16.10.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 10:05:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: sdhci-s3c: drop unneeded MODULE_ALIAS
Date:   Thu, 16 Sep 2021 19:05:11 +0200
Message-Id: <20210916170511.137915-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MODULE_DEVICE_TABLE already creates proper alias for platform
driver.  Having another MODULE_ALIAS causes the alias to be duplicated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/mmc/host/sdhci-s3c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 862f033d235d..9085f3932443 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -791,4 +791,3 @@ module_platform_driver(sdhci_s3c_driver);
 MODULE_DESCRIPTION("Samsung SDHCI (HSMMC) glue");
 MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:s3c-sdhci");
-- 
2.30.2

