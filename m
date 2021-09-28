Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6D841B1CE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 16:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241140AbhI1OQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 10:16:14 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39370
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240172AbhI1OQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 10:16:13 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DB836402F6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632838472;
        bh=h8MrqkfxIEKH6PXbKDTwFiG0JUImLj/0uwHBzSWaKXc=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=TmUYL2xfOd598NQMuvwzesGx/S/9z1ha+1J6N/aPgmVvnj0isDIm1XcnIAFGwjufu
         ESSkB6f4HOrFPjopA076jr7eR4oo6oW8uIZXyS5PZCa2fK9NiYuN0ycpobbpuesSJn
         zWrLFsEDsIo7SyIcz1c3NtqwwX2oOP/glbJOtT9qvL/WrAPoQYRtyS2DzPYy26aI6Z
         wsD71CevGdg5CYf1RYcTXER119fswdWN9gQ+Wnv2xuW+OlFYAZh3y/jeuEPAEdUk+o
         kOOElrHfDZOrOyqkZfiCb/wFdmzB5maRUXt0u1dx22jyP2KHLWKDFzMmbaFDpCaN6x
         3xymOtrEbXLGg==
Received: by mail-lf1-f70.google.com with SMTP id z9-20020a0565120c0900b003fce36c1f74so7454511lfu.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 07:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h8MrqkfxIEKH6PXbKDTwFiG0JUImLj/0uwHBzSWaKXc=;
        b=IWcIVbg7OKkrRz+DyE+meBDbRqkkNjqWsm6Wk9y3go0J4FoFIdf5wNNhYcYO+CLH2Q
         3LR8xPGkBtfQDu4vnH3CJ54ulzNFsNE57UcqeeHePVXxmgWHGd5R7SklFKhsFlWHFWs+
         AQrC/J7QHPNeBwrURk0y9L2mtHoxZffta7yzG7zIgAOcTTbQW7l32yqGOKmkcqd8zHpM
         ikIq+Da9gxxQFz5h2KaiCPcZpTNArr0K+vwuVETJzqqJUV556NV03MIfFkzRSOr64wla
         d39ScuKPvnKSH50ReJk6lHUC/fM+20RKpO6EseF5G6leeUVBpcl6/88kc0f1jSl2EnUU
         YPPw==
X-Gm-Message-State: AOAM5329z+4Rt1mTkbF1v5wrnVuNe7cm47PS+N786bDDuXG36j1rYzhg
        rGYka2Y/W7lv8YFBu+gBl1iXaJkyPggIbmvfGHwZFDSknVTakq0kpBkT65GWPxsFWZvh/c05PZr
        Ldi9ERFmeivwsQ5rqJo9/aLlFjqQHjP0z7aOZs1BC6A==
X-Received: by 2002:a05:651c:201e:: with SMTP id s30mr218810ljo.244.1632838471708;
        Tue, 28 Sep 2021 07:14:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlIyVSoE6g9lgr6Y3M0HsgsZLfCq9YnhaWnZnO3VLHcSblRxhjhOqFYEYv0/gKe2YAnWkshQ==
X-Received: by 2002:a05:651c:201e:: with SMTP id s30mr218784ljo.244.1632838471542;
        Tue, 28 Sep 2021 07:14:31 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w19sm2353241ljd.110.2021.09.28.07.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 07:14:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mfd/regulator: dt-bindings: max77686: convert to dtschema
Date:   Tue, 28 Sep 2021 16:13:51 +0200
Message-Id: <20210928141353.112619-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Convert Maxim MAX77686 bindings to dtschema.  The MFD patch (2/2)
depends on regulator, so this should go via one tree, for example Rob's.

Patch 1 (regulator) notes
=========================
Only few regulators support maxim,ena-gpios property. I tried to include
this in dtschema but because of unevaluatedProperties this part is not
actually effective.  Any ideas here would be welcomed.

Clock bindings
==============
Existing Documentation/devicetree/bindings/clock/maxim,max77686.txt are
left untouched. The file is still used/referenced by other Maxim
devices: MAX77620 and MAX77802.

Best regards,
Krzysztof


Krzysztof Kozlowski (2):
  regulator: dt-bindings: maxim,max77686: convert to dtschema
  mfd: dt-bindings: maxim,max77686: convert to dtschema

 .../devicetree/bindings/mfd/max77686.txt      |  26 ----
 .../bindings/mfd/maxim,max77686.yaml          | 124 ++++++++++++++++++
 .../bindings/regulator/max77686.txt           |  71 ----------
 .../bindings/regulator/maxim,max77686.yaml    |  92 +++++++++++++
 MAINTAINERS                                   |   2 +-
 5 files changed, 217 insertions(+), 98 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/max77686.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77686.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/max77686.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77686.yaml

-- 
2.30.2

