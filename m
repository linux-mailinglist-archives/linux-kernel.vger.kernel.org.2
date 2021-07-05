Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5B33BBD89
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 15:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbhGENhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 09:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhGENha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 09:37:30 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C829FC061760
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 06:34:53 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id c28so9101517lfp.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 06:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hTlomlxaU2sZDcUx321lrReHqUzaJljTL1EttP6LrNg=;
        b=wATVQJOBTwBPm0B91WkEXJvOkVJloSHXKQoNIvaLvL4299yOzDpUCRUthmaoiyz72P
         H8sOI5Tc18OtIml6K87TOhDCm1EruLas5coOZLshkz8uKpYlzZV1lyjo1CAoWb7R4+fb
         LD/OlwAOPPxF4xk95pnXK07/hsKD48j4IZ2MCVPa/h8fvZNAWN043plC6HtOXnWLfXQV
         oiAu9Y7RtnqpzfNZZeXHJC2+YDbLyfBX7MKDz7bWL21coatjiIrw1k+ShsaaTx7g4W6N
         nmgviV+ruMF6i8gmY3up+NzKg8h4NAMui1zVYCA4l92mckGAJQwofh2k510g0RSO6jyA
         AmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hTlomlxaU2sZDcUx321lrReHqUzaJljTL1EttP6LrNg=;
        b=QDNyIYyYLIAoAdsh09N87JQir4FVTV9NCcDDgLGo85DwjaOFaIEW0xyRQe8z+ocJIp
         e88D3lvuSukigE1XNZBbHqbLflhFwVsH9BK7vAGolSruFY4WYETbLwQQKeWJjnLjvO0+
         mRfle/kjaMSQV0D1FX4Toqr2jxzj3YOeDPoYD8SOdgaFCtAdViOw4FiN2dy/Y0LbilEM
         RbzB1SWRlY+WCdz4hvAdlqehXwj6oKNiGqGs+FrDJ9lQqmYEdERimWdL0BaouSBcqeZr
         5rvSVcJQhoPXD4uKc6SGqUFDm+SsEEEtYUIGmINFS5JG4FRsVNQJbRMD35n2zDuv7bHX
         gLmg==
X-Gm-Message-State: AOAM531/kXtVTKaRtLSSRgQzv4bAJqHCjyRJqvBwYZGr82ebe+ZBQeZI
        uoqperZ7/6nyk4dgDdRIdMzd5A==
X-Google-Smtp-Source: ABdhPJyGviPHrfmMtlEwyrVqsKtlbk8XSe4QwRB8Mq7TXi+VXzE3hHehjkoeOXMewOH+58O+KB7YMw==
X-Received: by 2002:a19:f104:: with SMTP id p4mr10381901lfh.630.1625492091905;
        Mon, 05 Jul 2021 06:34:51 -0700 (PDT)
Received: from localhost.localdomain (81-227-43-49-no2784.tbcn.telia.com. [81.227.43.49])
        by smtp.gmail.com with ESMTPSA id a5sm1167860lfj.190.2021.07.05.06.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 06:34:50 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] regulator: fixed: Mark regulator-fixed-domain as deprecated
Date:   Mon,  5 Jul 2021 15:34:41 +0200
Message-Id: <20210705133441.11344-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A power domain should not be modelled as a regulator, not even for the
simplest case as recent discussions have concluded around the existing
regulator-fixed-domain DT binding.

Fortunately, there is only one user of the binding that was recently added.
Therefore, let's mark the binding as deprecated to prevent it from being
further used.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 .../devicetree/bindings/regulator/fixed-regulator.yaml          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
index 8850c01bd470..9b131c6facbc 100644
--- a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
@@ -57,12 +57,14 @@ properties:
     maxItems: 1
 
   power-domains:
+    deprecated: true
     description:
       Power domain to use for enable control. This binding is only
       available if the compatible is chosen to regulator-fixed-domain.
     maxItems: 1
 
   required-opps:
+    deprecated: true
     description:
       Performance state to use for enable control. This binding is only
       available if the compatible is chosen to regulator-fixed-domain. The
-- 
2.25.1

