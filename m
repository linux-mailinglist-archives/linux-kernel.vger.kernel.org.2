Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397B6418786
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 10:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhIZIre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 04:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhIZIrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 04:47:33 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36477C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 01:45:57 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id w8so14728209pgf.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 01:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ixyywPIV+6DgQgfwZcIjPL8CPcYQ0h4CiC/Eg8U6OBY=;
        b=qvnS8pJrMesReK/0WbnpWCOzMI1DNOHZo9ogd00NHpLisWWmCpesAzSbUk86C3ue6V
         tzNboRcENaOoSHUPM6zlpxJAsVCAA4XNBa3RZeaxm+T7pJJ63NmqOfz4cw1FjUoXJnei
         YSCSo+X6KZKvjkZB7f/36sWqi9jTsP8bgMJ9uibuupjjn15gR8NE6GUpyONAC18HJO+2
         9yRWomftLulBu5Fa2ASGdd959WJpXwfyuJ7TpDcaKWOb6rigGFfnp0pWHM9rk4lagClO
         3bToe6KnfO+aKEjHzVY3Y4t6oYjLRRhRs/gt7y/P6ANkQqQEibrBd06krY6FCRwoSN9P
         83+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ixyywPIV+6DgQgfwZcIjPL8CPcYQ0h4CiC/Eg8U6OBY=;
        b=7KZUu5izOkA9qSFUOS2Nzh2Rf2WiHZu4Mi8SzBC9x8rwXcWJdcGaY0xYj865eTDOcY
         8zTrYrDcja53RbFSn7zT3OcZAFNPuc8dANbs/be4LhIXyjeIW1nt9bhuABGgF0sJgOrz
         uqYoPTm/9DuXLnoYP5iQ7zn5IpWt3vcYFXZbAr4piYXlygtSmBpE5kTALRto9HWubbKI
         pxoxCSvoNjg6aZN8UakP5Ur0ov5TGKKAArubwJNHNHN807K/5GVrryluXK7NosJdRLZk
         UKK8/DCuwXQeKfAIcxo5D/DPzoME+M/2bzwQh8vVuVBbo2KXbUV15mJaJpEhvMP9FjuU
         KDwg==
X-Gm-Message-State: AOAM533ZTJKCqaSO192GiDlPOJm9qZz12ne3aO/PCTBJK3ZVBctTBSv2
        d+7K5UNv+sG8bcxozgPZtb/VvA==
X-Google-Smtp-Source: ABdhPJwqjEj0iNDPPyoZeOaSvKoByGRgIuZxkPWmOqsAc4GCZu9Cx+5Q42ztZcBaqN85LlbjiDBmlw==
X-Received: by 2002:a62:19d4:0:b0:43d:1bb7:13ae with SMTP id 203-20020a6219d4000000b0043d1bb713aemr17778982pfz.63.1632645956699;
        Sun, 26 Sep 2021 01:45:56 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id c7sm8940402pfc.104.2021.09.26.01.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 01:45:56 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 0/2] Add PM2250 qcom_smd regulators 
Date:   Sun, 26 Sep 2021 16:45:47 +0800
Message-Id: <20210926084549.29880-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series adds Qualcomm PM2250 smd-rpm regulators support.

Shawn Guo (2):
  dt-bindings: regulator: Document PM2250 smd-rpm regulators
  regulator: qcom_smd: Add PM2250 regulators

 .../regulator/qcom,smd-rpm-regulator.yaml     |  4 ++
 drivers/regulator/qcom_smd-regulator.c        | 49 +++++++++++++++++++
 2 files changed, 53 insertions(+)

-- 
2.17.1

