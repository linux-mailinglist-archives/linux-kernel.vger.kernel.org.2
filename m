Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED6737FADD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 17:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbhEMPhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 11:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbhEMPh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 11:37:28 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653C9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 08:36:17 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id i13so1522223edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 08:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snejp.pl; s=gmail;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vfqqUPPm4LRq9XH1UyFkkLurE047vpEpu2TMxeSoHug=;
        b=Dv4G6L9f+ffBOVU+akjB7GkzTfa91b+9zrdTuBevCH+/c9q5Z24slXdRAlsJQPqkrP
         Egw98MJEh8gAj8sf4g+BBWquD3IeR4raDGXDyznoWi1eFKBRB7XrFvhNOSabHn04Exx6
         aFPkdZiSw+1yBYAsumsnukBtUPKJ5h5HU9hMGsckGxHJvbwpnhtrP4uzdr7y9jFem9vS
         Ew8r6Njmb2GT96JO7fOwHo6x9aRk335KYp0uT4R5S/conARxuoI9qQ2q7tNwu1quewPc
         fNwvXbyY+B4NTwvXxL2y/J60KlnSo4lgI5e7LlebKvPCuScva/3m/ou4xf02v3ayCB9l
         iHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vfqqUPPm4LRq9XH1UyFkkLurE047vpEpu2TMxeSoHug=;
        b=T8RFSHuInAewGN7LhkD6XAJ8VWut3JFOIy+21/I2E8IqHtYcU0fFL/6kVJVA0jLJ9C
         6+Bfxb1XnzLYjr1rBAo1GMxqALL4HffEy9QNb91HtHv2dZiauBTzz7NKD1iVUlmspA3I
         aJTzKPH7eWUVZzks11th6qLn99Rp1ESnucB/KR43nJ4WwqAdHOzsbIHbT8z3saUM8Qh3
         /iFqAw7NbZQ/bcYUC6BC9dKlHoPaV68lW0HsSxMNZXANxhDYV7Bihl9BT3PQMUx0K8JH
         FR+N55+D1xEhjKsytD3mXdR3cbcR/SrqiuwlxERIRGSuVlMc5hhVzfsfdZIvjcip7ekM
         yewg==
X-Gm-Message-State: AOAM5307whucbfRUFynMtf+Gf/5iX4PVZiXJiPuhxvHxb93ixwSENJgD
        lLpHSiv+vvtOfdYmAlsW8kMqCg==
X-Google-Smtp-Source: ABdhPJxHLnbUfbwiED2T3AqLYF2SEiPKMFALZ1DS8jHYcbXzFFygmt4l2rSsOOpyXs/WwxgXjr9Mbw==
X-Received: by 2002:a05:6402:50d2:: with SMTP id h18mr16501671edb.10.1620920176142;
        Thu, 13 May 2021 08:36:16 -0700 (PDT)
Received: from PackardBell (192038133011.mbb.telenor.dk. [192.38.133.11])
        by smtp.googlemail.com with ESMTPSA id r17sm2544496edt.33.2021.05.13.08.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 08:36:15 -0700 (PDT)
Received: from localhost (PackardBell [local])
        by PackardBell (OpenSMTPD) with ESMTPA id 77f17b1f;
        Thu, 13 May 2021 15:35:48 +0000 (UTC)
From:   Bartosz Dudziak <bartosz.dudziak@snejp.pl>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        David Sterba <dsterba@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] arm: qcom: Add SMP support for Cortex-A7
Date:   Thu, 13 May 2021 17:34:40 +0200
Message-Id: <20210513153442.52941-1-bartosz.dudziak@snejp.pl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SMP support for a Cortex-A7 CPU in Qualcomm Snapdragon 200 SoCs:
  - MSM8210, MSM8610. MSM8212, MSM8612, MSM8909
and in Snapdragon 400 SoCs:
  - APQ8026, MSM8x26, MSM8x28

Bartosz Dudziak (2):
  dt-bindings: arm: Document qcom,cpss-acc
  arm: qcom: Add SMP support for Cortex-A7

 .../devicetree/bindings/arm/cpus.yaml         |  7 +-
 .../bindings/arm/msm/qcom,cpss-acc.yaml       | 41 +++++++++++
 arch/arm/mach-qcom/platsmp.c                  | 72 +++++++++++++++++++
 3 files changed, 117 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,cpss-acc.yaml

-- 
2.25.1

