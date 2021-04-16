Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6268936208A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 15:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243453AbhDPNJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 09:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbhDPNJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 09:09:18 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55AAC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 06:08:53 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id p8so6227412iol.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 06:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=webf+bnhJ1RpkcIsLIGTZ2HgWNgyi1pjs9fB83i3SNk=;
        b=RFTfce115TNAQ3wtPIlNJuE1Wjp/EAqPti28C6Qlr8RLtjenRHDvAvwwWAQ0G7stzr
         vfLr721BuJSJeJzw1nJJdhBqxwGTWsiARO5aavy9HBg3dGpvcFdJC9yazZ0KAhwlON+/
         DxwlhybEkQQI5fsHUdXNNjySmbVeQrwOsG2vXYnFRuU/VD7/JlLuOvIb7cnBEIxEzWL7
         wy0NkDeJIu16N1DFEzh0Xgb86YFDZmnYPQOf1WADYpsk8p29Q5tF14CnwPU76ZoitslY
         vX9NC1bv/RTIxJcHpYDTiHLjrMgXFskB1fMtOo6rQdpP4JL7IUYsiklmrHiiDYVtJdCE
         FGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=webf+bnhJ1RpkcIsLIGTZ2HgWNgyi1pjs9fB83i3SNk=;
        b=slnBSXYKdvq5I8o5QdEtWaeivcGNuWo7yINd1GAH6ETsVbH6WjEbY4uuLbLDqIMp2l
         WnKDtwZuGTFGnG8xC3qpEkbHdN66WHQNl1Ab2Z17zbylRHpRCkb0JU/TNQjme9jydKty
         K1flWAh/+eM+CmMFPXArnSf7kodh5+ys1KEttcyRIHxrYJyclM8H9gDnbnheeEbvwPYr
         Y+d9umTHqxtKMkPW0QskGPnFJ1FhgPLNZXnuOAG8HRHGbZsvRFGd3BTEG1cg2f3l8o7e
         gSY8yhCR8Zfs3X5+6UmI/ZORFNNM5l9laKqSHjMfnOjV+n4opMIBKDJcQlH7vQQi8CfI
         vWTw==
X-Gm-Message-State: AOAM532w6dzRZVULNGe7RAUR06fTyAzi3af2/ozBoRXy7+MHExoXYhHN
        VvzRAPu+thExxYSNjT7/1xU2Ng==
X-Google-Smtp-Source: ABdhPJxVj2dqOjwTTPTz7COtXn4coHxUAtuEuoR4T0S15SvjVEYSWQM2mowSzjciRFjZk1DC8hxxBA==
X-Received: by 2002:a05:6602:1594:: with SMTP id e20mr3273711iow.95.1618578533305;
        Fri, 16 Apr 2021 06:08:53 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id e6sm2713535ilr.81.2021.04.16.06.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 06:08:52 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     robh+dt@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        elder@kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: ipa: allow different firmware names
Date:   Fri, 16 Apr 2021 08:08:48 -0500
Message-Id: <20210416130850.1970247-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ability to define a "firmware-name" property in the IPA DT
node, specifying an alternate name to use for the firmware file.
Used only if the AP (Trust Zone) does early IPA initialization.

					-Alex

Alex Elder (2):
  dt-bindings: net: qcom,ipa: add firmware-name property
  net: ipa: optionally define firmware name via DT

 .../devicetree/bindings/net/qcom,ipa.yaml     | 19 +++++++++++++++
 drivers/net/ipa/ipa_main.c                    | 23 ++++++++++++-------
 2 files changed, 34 insertions(+), 8 deletions(-)

-- 
2.27.0

