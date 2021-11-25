Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD67A45D801
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 11:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354512AbhKYKPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 05:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354590AbhKYKNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 05:13:12 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA92C0613ED;
        Thu, 25 Nov 2021 02:09:23 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id b12so10426612wrh.4;
        Thu, 25 Nov 2021 02:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J+AtvgH+7tJCkwntCUuKAinCiI1X+dL5Twz4eHbpnSA=;
        b=HxLT5Q1gn5HUt2NyWHrfdnd+rnUJS949xIcNw6EQXva9nC1+AU8e+oPVbDXQHfJtNZ
         w7vdjVlJZFaxzarDK2i4Wkzhqn+derFY8ugo5Pwu6CAses1ldHNypA3Nm83w6Jzrc7zK
         MBE0JYCC3xwrjXZJQTUQ8G6THa0ljYucoGHQwyyOEEg/eVZAN+0YAH5yn9VMZVvHsiMC
         9xYo+hViPXrQ1xgzlJqpk6foca7iIytbdk/q8elp+QK0RUJC2H4uqAGDvToJl3LueEus
         6mc7lOEVzHfEzf+RrT8NZAfAiGURADZl9U+hX7GAH0IkYWOe2bXNX/gt0c9VQu2JvfdI
         sNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J+AtvgH+7tJCkwntCUuKAinCiI1X+dL5Twz4eHbpnSA=;
        b=QpwQpZXAzoPBy+6XaFlQayjfQasuzSkHU5uz1p/IM8W182CO/ur58l11XYsE/auoCA
         1Aj64SAgVPftBB31k2veHX/fc3QRrx2Ltq/iwVE37bAHxZZauzdDLGztyPjIubRVEsa+
         x9F61vSJnuSVHbmrlXPH91nttYV/VqEFeic39gRCTelJ2jFN5jq/M2CsBFfWCnfaCJR0
         rZkSFeqqZCWbOR2DaeWKT2QJq0szP3k1l+wgIzX9yUPBh3ZDHXhH/HynseAJAvSc+QP7
         9AtJU2SKH8tDzAzl77J/W0OMq0kn9/RZzRnYjlMv2c+TJIwuV9JpH5+BLnUVZzposJvR
         DYDA==
X-Gm-Message-State: AOAM5319xy5nnzMHtuaraCvaLUt0yBpHCUcC6/6lALHSVPNL/rgkJ49L
        tZtJXhzfIfwoXtSONjLykH8=
X-Google-Smtp-Source: ABdhPJx2/KokuDdsW4Y+JnPROVHOSvBpezAOB9oUvI0LHwE9CQPCaZKK4T/lBrFt8o/nUhI3D9vQOg==
X-Received: by 2002:a5d:628f:: with SMTP id k15mr5307647wru.363.1637834962587;
        Thu, 25 Nov 2021 02:09:22 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id l7sm2903533wry.86.2021.11.25.02.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 02:09:22 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] HDMI Audio on RK356x/Quartz64 Model A
Date:   Thu, 25 Nov 2021 11:08:33 +0100
Message-Id: <20211125100836.423808-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables HDMI audio on Quartz64 Model A, and the RK356x SoC in
general. The patches require the VOP2 patchset[1] and my I2S/TDM
controller fix[2] to work.

i2s0 on the RK356x is connected to HDMI, and only has one DMA. I've
confirmed this with the TRM. With [2] the driver now handles this
properly, and does not try to register a capture PCM in this case.

To test this, one needs a video clock, i.e. there is no audio if your
screen is off. I've found that running kmscube momentarily is enough
to make the VOP2 keep the screen turned on indefinitely, which is
a pleasant quirk in this case.

[1]: https://patchwork.kernel.org/project/linux-rockchip/list/?series=581709
[2]: https://patchwork.kernel.org/project/linux-rockchip/patch/20211125084900.417102-1-frattaroli.nicolas@gmail.com/

Nicolas Frattaroli (2):
  arm64: dts: rockchip: rk356x: Add HDMI audio nodes
  arm64: dts: rockchip: Enable HDMI audio on Quartz64 A

 .../boot/dts/rockchip/rk3566-quartz64-a.dts   |  8 +++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 32 +++++++++++++++++++
 2 files changed, 40 insertions(+)

-- 
2.34.0

