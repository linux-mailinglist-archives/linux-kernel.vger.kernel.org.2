Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B784E40A2AA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 03:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbhINBmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 21:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhINBmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 21:42:15 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B8FC061762
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 18:40:59 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j1so7718103pjv.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 18:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=i50eXCIMPdV7KIYFDqVqCxJ2nl6Tna8Sip8wf7VdYRs=;
        b=WycG2898W7Z4ctAx2UYR1U+cmhGLKDlysRStdiZ/ssFCUg48KW4d3R2nTb6MZtNKxU
         LHRD3TbGra7M2Sqiu5tznmNrfNp1BAbBadopb1fAeBGhUMEvDLXcHiKHoqrgtOZ/+NcJ
         yBtEmw/SBop0Q0cGL9BaUbyV+SX43/jdmOLRjXyCY7xXAVftv0/PgvbUvcW8GuUAzAWv
         fkHQh1Sbn+ypO6pNQ5fLBaxbHglvIqLDi8hw4hdzOFFrerLqRBWuTtyU7msneqdwPdCJ
         eKIEh3CLgA1Kqgy+SqJXZrvK9Kq++aET3BlGK21Un5DxtqS9MzGKY4tOwskVm8FNZHtg
         UO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i50eXCIMPdV7KIYFDqVqCxJ2nl6Tna8Sip8wf7VdYRs=;
        b=q2oC8ZXG59IDhc+aTbJbq6cAAsYgdWBP7+X4ba3lb0AKoVEWjMeFWOVbcGIKYAO7FO
         JZ8t6bGcxv0cNRs8fkVE9n+QdK5Tw2ErS6SQi/3+MkT7309h6OOeNXfYD4noyco7zOPd
         b/lJi7VprIbi5y9dEbSJ9d4FP1rlRUZxoR8mtcs3vYnQzsUvzoauxOqjsFz4FE3js/ec
         bOZVVvAxm/q+4DLrOrUbs9LcMkJOM6XStsyXt7kKv/qFWbNXqr1NaGiXVoFhZY4ZqptY
         xnkUzMenImiE333de+gSusUgVruSZq3qVmSyocujrtBMMY+ZNVR8vU771qCrRzQbCC1/
         oItg==
X-Gm-Message-State: AOAM533AwpkFUGD2l0zv4l/tYk1GZKz0kXhLga8gDi1gHi7SIjIUcgyU
        iJQyIXCh3MLu6GNhocgBD5AspQArGyA=
X-Google-Smtp-Source: ABdhPJzUKcT7KSompsa/VD+baaMmMyUw4Saspi9tY7ldMEovaEXUNgmoWIgh5XO43YPCRRWyyu/aOA==
X-Received: by 2002:a17:90a:a787:: with SMTP id f7mr2650269pjq.179.1631583658872;
        Mon, 13 Sep 2021 18:40:58 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id 4sm8037615pjb.21.2021.09.13.18.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 18:40:58 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 0/3] mailbox: Add QCM2290 APCS IPC support
Date:   Tue, 14 Sep 2021 09:40:47 +0800
Message-Id: <20210914014050.28788-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch cleans up msm8994 type apcs_data, and the other two add
QCM2290 APCS IPC support.

Shawn Guo (3):
  mailbox: qcom-apcs-ipc: Consolidate msm8994 type apcs_data
  dt-bindings: mailbox: qcom: Add QCM2290 APCS compatible
  mailbox: qcom-apcs-ipc: Add QCM2290 APCS IPC support

 .../mailbox/qcom,apcs-kpss-global.yaml        |  1 +
 drivers/mailbox/qcom-apcs-ipc-mailbox.c       | 27 +++++--------------
 2 files changed, 7 insertions(+), 21 deletions(-)

-- 
2.17.1

