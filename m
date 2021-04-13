Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5BD35E490
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347033AbhDMRGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347022AbhDMRGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:06:17 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83117C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 10:05:57 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id j12so799798ils.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 10:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iOm07S/wajD7g23zOB3ZEcsrN/M8kl3CFdTNNyqjaLA=;
        b=HyYkrLJ3u6Wz37Oo9YC1D0fFB2KhiFMUZU5uB3UmYoOdQxQqv0vPEt6dfo+vMfTW3R
         1O8aCL2MXdSTOmpZ1MmeTP4dt0RfI30T3rDDJ/ejijX8CyWzyf5fwPynKBTjft+lm2j1
         mYxxJkxM6VNhgVpvCUMCdeS0pPYt6D3geYItk/YJzJVEsO+Vwx+s8x3Z9KNBJ/mEsCCv
         t6goAVF4a7us7Lap8+znNerqbthFVX2xqsn9A34gchBX+7Occzk2LAyXBy7CPnPN+w6X
         VnxWeLXaHf8btbijG1bP+rW07/in+AobZUhgInlANxAvg6ra/BggCtDWJlv6XRRUQzMa
         Xnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iOm07S/wajD7g23zOB3ZEcsrN/M8kl3CFdTNNyqjaLA=;
        b=OGBrWpBj+Q7VkQs2FBM0ckqwiZ2t7r8r4SV1C+OQXkKn54N8Z3/6n93yWK6xp4Rz59
         wmhnszAO8TNUl/G3MXIQztC+dJ/aeBxKkPmPExCd7f21KHSe4AepolnNVJ/Rn0lPFE/g
         2KNU7L7cWE1YuLk92mGWesiG+SSeXlysMQ7bVjOk2BoWo5+jU18wLgmoCpPC1DdF2aG+
         ecvJaC1Oisr8kq+OXfOxBMkAylFK1t9eSIAW9mZZO1zzzyuBITTnkglaYSGRWm665eCA
         9BPSvBW2bzucJM7XDo7fvZVd1Ua3Om2hoimWqACSGXgaV7AyCSQKG6CM/I9MFiS0zpwF
         Atjw==
X-Gm-Message-State: AOAM533W5S229a25NMkMbjl8toQUPlvRn67ed6rRoy3Zw4+Bi/Cp/Gxe
        TIWNF+HlHZ1yxlEM2gLMNKOH6A==
X-Google-Smtp-Source: ABdhPJzNpvW6BAS7H2u4IBytcTcEKMhsFD6VIG2z0ep74UXsy5loutKOJhBNg1sbCXiIrAMeZlDYLA==
X-Received: by 2002:a92:a301:: with SMTP id a1mr7852842ili.41.1618333556943;
        Tue, 13 Apr 2021 10:05:56 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id 23sm7495842iog.45.2021.04.13.10.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 10:05:56 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org
Cc:     robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] arm64: dts: qcom: enable SM8350
Date:   Tue, 13 Apr 2021 12:05:51 -0500
Message-Id: <20210413170553.1778792-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IPA-related information to "sm8350.dtsi", and enable IPA for the
SM8350 MTP platform.

					-Alex

Alex Elder (2):
  arm64: dts: qcom: sm8350: add IPA information
  arm64: dts: qcom: sm8350-mtp: enable IPA

 arch/arm64/boot/dts/qcom/sm8350-mtp.dts |  6 +++
 arch/arm64/boot/dts/qcom/sm8350.dtsi    | 51 +++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

-- 
2.27.0

