Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC4D3A509B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 22:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhFLUzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 16:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhFLUzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 16:55:51 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FB8C061766
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 13:53:51 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id og14so9831186ejc.5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 13:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snejp.pl; s=gmail;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mv3/cnpvRbvAJeQa0MiDYgvPXPyU1vXJHZuXEP0Ro0w=;
        b=lvhykrj8XeuOw/I8vR+vifVvDfEgyqY+T8z2eWHUIW7GB1uICnrTfzs254s+9tJt5T
         AuTRAtD0bIrOfu0iB8qKE4uaJSnGoofS0Xs73e5cLSowFBneNRguEQVD9LbNVHVbKMQK
         vu1FmvLDRMUyU9QQkd9uXvLY+vzJYDn+YGHWbDw2oC8biBOZombrwgCGI3gTYxlK8f+F
         I9G/Elf8cyzbGeYmNqwKTLhrpl0S+9rOwW+8iSGaSNtWWxE+7cJQcYUpVU/YlFQhgUs1
         Z4mog+Svmswr1mLcw/uKqPosS+GcBRrVhiG1J6c7jlceSi2jxYQTDwTqOUh7J8ypRmGh
         4VGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mv3/cnpvRbvAJeQa0MiDYgvPXPyU1vXJHZuXEP0Ro0w=;
        b=hS50oLnE0jHnz1mfz44dtlQpfv97gHK7bbpXiqy/i2OYJOVI81pBn+TtdgXWWn8les
         7yhyXJDjMb0dSRnLTRWSBtK2ZmnOBu/JA9RPWdFW5y2jtxxxvs6hDln6cULSzDT10X/9
         KUXQFBfSxekfEI8wXIQh7WBsRDTC9I/2MJlqyVm5AAYsHNG4YhNZWZy/J/EgnjPALjVC
         ImXIv3gGGH3PKujBQUT+e0/4KgIbW/x+BfQPhl//GKssAkk64v2X290RpRulJoSIscvf
         4WJSGyLbuOwJ4FlvZ+vSQl/a1VCz38QVzBF4eDvkt+m6G1ih1/Op13ysv9Hhkxp4xa5t
         fX5A==
X-Gm-Message-State: AOAM530LUzvfCqifC/Zy/UormApPeS50vqhgMjOwkOMIQ6FUsFokzDXS
        V/X9hF9fwcAGO5l8WMe/qNmRmA==
X-Google-Smtp-Source: ABdhPJxkYIoeEEqaY6OBy2UBJJuSKZHPbSXjyqfT6ueqR3X1U5RO+zM4UexRST61zS/G23rG6QyT1Q==
X-Received: by 2002:a17:907:33d0:: with SMTP id zk16mr8945400ejb.144.1623531230324;
        Sat, 12 Jun 2021 13:53:50 -0700 (PDT)
Received: from PackardBell (192038129059.mbb.telenor.dk. [192.38.129.59])
        by smtp.googlemail.com with ESMTPSA id a2sm3574362ejp.1.2021.06.12.13.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 13:53:49 -0700 (PDT)
Received: from localhost (PackardBell [local])
        by PackardBell (OpenSMTPD) with ESMTPA id 061171b6;
        Sat, 12 Jun 2021 20:53:45 +0000 (UTC)
From:   Bartosz Dudziak <bartosz.dudziak@snejp.pl>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Sterba <dsterba@suse.com>, Jens Axboe <axboe@kernel.dk>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Bartosz Dudziak <bartosz.dudziak@snejp.pl>
Subject: [RESEND PATCH v2 0/2] cpuidle: qcom: Add SPM register data for MSM8226
Date:   Sat, 12 Jun 2021 22:53:33 +0200
Message-Id: <20210612205335.9730-1-bartosz.dudziak@snejp.pl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SPM register data sequence for MSM8226 SoC and enable SAW2 power
controller for it.

Changes in v2:
 - Removed APQ8026 SoC support

Bartosz Dudziak (2):
  dt-bindings: arm: msm: Add SAW2 for MSM8226
  cpuidle: qcom: Add SPM register data for MSM8226

 .../devicetree/bindings/arm/msm/qcom,saw2.txt      |  1 +
 drivers/cpuidle/cpuidle-qcom-spm.c                 | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

-- 
2.25.1

