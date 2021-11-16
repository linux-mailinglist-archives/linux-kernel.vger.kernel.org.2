Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0059545312E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbhKPLvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbhKPLuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:50:40 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA916C061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:47:40 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso2185779wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5VTKFZ3UHlKVEvhBxdelrrUd+IoBwj07WMlzbJjG60c=;
        b=ZGZPiOSvuZoyHffbMO8UmtX8MH/I7hLxkUcA39bxnARX3XosmvJu8/glDYZYCF14wr
         61XkqY6YUNk4G2dHEY+HM61Qs8xgFi3GIMxFgTK5xch5cr/7dkABSSGWQtwJC0qq+LnA
         m8baZQEE/Kc07KgIrnziMGTXpeL7qeOjMoAU3YEAPm+PYlzf5far+Igu9isPkI4VdjGp
         WI4eD/OsTfBDM8XnlHGEv7mZYC16Wldu3cGh+RwRVYE1qesDOYE/jkadQGuHdk75d4q4
         H4CKa1Um6zTeJhGNZIy2WridZpOEULrFzcgB4DrIqy0/iQM0N7aj7tVlP6c3XXw6I27v
         Kyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5VTKFZ3UHlKVEvhBxdelrrUd+IoBwj07WMlzbJjG60c=;
        b=t4e/JXMGvBETK+iW0FHttCCztSQQlhlg+2x3+rEbQq/zCXQF/Kv/eq1sehm6DgiUPW
         Lrozr4lLZX4+t35tYUvwRgJ9kxv9YmBQPuL3F0TK0127KAS/gh9uPoikxYH1U9hAX8s7
         vI7BK4DMe4rfRoEQlGht1BgIk4JF6zVdOBYDaFqX+g1W5ibit4JJ764VjzmLWL0krher
         it/DXUHfB7RltI7Zy43yr1qWCHCCMMmtclkRtjB1LpeuZru5D+ZXdRtyT5e8CtRz8RxR
         dzglQ5KTKNMwBjCpZfvb+cb/8wg6u1GHnKjvGcd3dM//amRt8ql7JsvzlfLCKutpYv41
         HLvg==
X-Gm-Message-State: AOAM530ZAqPGGXkAc23gU9hO3wuwuBhdImdHDkcG44or+7CNNCZEdjku
        45plQP2Uxj66Bg8P88KFBWFFzYNdmPiPLA==
X-Google-Smtp-Source: ABdhPJzdnugagYt3FM4qtXzfJw+oltqGPDs6tl0+j14MTPcqlp5YEf96GmxgZXA/yY2EEHMnccS5jQ==
X-Received: by 2002:a7b:ce8c:: with SMTP id q12mr6982075wmj.91.1637063259539;
        Tue, 16 Nov 2021 03:47:39 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id l8sm2260523wmc.40.2021.11.16.03.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 03:47:39 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/5] ASoC: qdsp6: fixes and improve error reporting
Date:   Tue, 16 Nov 2021 11:47:16 +0000
Message-Id: <20211116114721.12517-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

During testing on a laptop we found few issues with the existing q6dsp code, 
first 3 patches should fix these issues. Also during debug we found that
some of the errors reported are not very useful, so update error reporting
in two places.

Thanks,
srini

Srinivas Kandagatla (5):
  ASoC: qdsp6: qdsp6: q6prm: handle clk disable correctly
  ASoC: qdsp6: q6routing: Conditionally reset FrontEnd Mixer
  ASoC: qdsp6: q6asm: fix q6asm_dai_prepare error handling
  ASoC: qdsp6: q6adm: improve error reporting
  ASoC: qdsp6: q6routing: validate port id before setting up route

 sound/soc/qcom/qdsp6/audioreach.h |  4 +++
 sound/soc/qcom/qdsp6/q6adm.c      |  4 +--
 sound/soc/qcom/qdsp6/q6asm-dai.c  | 19 +++++++----
 sound/soc/qcom/qdsp6/q6prm.c      | 53 +++++++++++++++++++++++++++++--
 sound/soc/qcom/qdsp6/q6routing.c  | 12 ++++++-
 5 files changed, 81 insertions(+), 11 deletions(-)

-- 
2.21.0

