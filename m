Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E527C35627D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 06:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhDGE02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 00:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhDGE01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 00:26:27 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7885AC06174A;
        Tue,  6 Apr 2021 21:26:16 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e12so3316833wro.11;
        Tue, 06 Apr 2021 21:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/uxm+ddpxxmXnSDmYZVbCjsl1x5gAL/tQbugquJp2r8=;
        b=r4cKC4I/BAIowW7LmjU17k7Swy6+R3wroLgZK/Az1SSdVSjOB0NNm1UNey/goh3ia9
         WUHXq/qqKP/75X2+jpeVeZG0Or/XGCHy1SYyCtztn1F+ABdBhv743hGlYvhJoypNogGB
         Fy63zAyqK4fOZhcotcV1e4Ha9QVjeMJFv6ZCyufaZ2PLADbba7Tcc3YV+y280JMKIbuj
         V89cQMZhcMaGJVjdAguOpnhIQ9kRtfs6Whelg7zNy8nxMxHN7HLlgSeFcX5Qy7MOVwG1
         YrRUuWb9yTM11+upV4GMga89yxEuas1FWsS1UL7K+B43Dy0PgQ4AMYOIwQNy3UuR/IjV
         gbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/uxm+ddpxxmXnSDmYZVbCjsl1x5gAL/tQbugquJp2r8=;
        b=Ro1ciMFUFg9PlMdLx4LnQzt0mItvHG/ZrN55mccWV/fzR9SBTCHy7szRCpSqd6e+Se
         u9tu66KMXINTc+FeP20/vRt/xpBwLDTouFOb7YzDHPulAE4bqS+7wRRleXKVJBMLaiW8
         ColOdH+1UHVBSoxy4+SVKeL6sEIEXwbLKWloRtK6qPS25d7u8f5uBk6020+Sx/yQ6IIZ
         1aWPwMJVXNZQu3rXDwvnc7OlCEh9OiF7jtGM37B+gMgknnlycNSUSr2d3lR8BbFOjMTE
         CZUkbvDHsFzxRD3jcyZrGzidanPqiuYexCPs/mj29QZNHLcurlFHofyynXmJPaw+lEYu
         +9Zw==
X-Gm-Message-State: AOAM533qWHBZTUwMCNahHfmSnxl4Qv1pgZoPOSlwiNwIF1hevjE37hc6
        mOtyoua3I0cuDvqwl7PHv0SJXt/1vhY=
X-Google-Smtp-Source: ABdhPJyROB8SHgsGrI+AyRhKK5dX/qKgDBb8UBGM45a5NvzXKqtanaRc3iLb/RFry6gbomXPk/ApDw==
X-Received: by 2002:adf:c10a:: with SMTP id r10mr1895742wre.40.1617769573901;
        Tue, 06 Apr 2021 21:26:13 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id k3sm16487112wrc.67.2021.04.06.21.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 21:26:13 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 0/3] arm64: dts: meson: misc ODROID-N2/N2+ changes
Date:   Wed,  7 Apr 2021 04:26:06 +0000
Message-Id: <20210407042609.9736-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series cleans-up and submits some minor patches used in HardKernel
Linux 5.10 and 5.11 images for the ODROID N2/N2+, and fixes a stray tab.

Changes since v1:

- Added reviewed-by's on patches 1/3
- Added my Signed-off-by to patches 2/3
- Added missing vref to patch 2
- Rebased on khilman/v5.13/dt64

Christian Hewitt (1):
  arm64: dts: meson: remove extra tab from ODROID N2/N2+ ext_mdio node

Hyeonki Hong (2):
  arm64: dts: meson: add saradc node to ODROID N2/N2+
  arm64: dts: meson: add GPIO line names to ODROID N2/N2+

 .../dts/amlogic/meson-g12b-odroid-n2.dtsi     | 52 ++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

-- 
2.17.1

