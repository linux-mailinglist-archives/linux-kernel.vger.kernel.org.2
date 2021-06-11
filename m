Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C4A3A3ECC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhFKJOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:14:35 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:37748 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhFKJOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:14:34 -0400
Received: by mail-wr1-f53.google.com with SMTP id i94so5255111wri.4;
        Fri, 11 Jun 2021 02:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VEuFNiSp1v0GZ+nWXU0u8Y/+mNOpI/0SZjNmAZkJ91E=;
        b=XI1KnPsgl7gsYPtwUTzcKsJhyha+bIBuAjAxPPu9WZjSPnGz/sI4CdNLxlQrG26JiV
         c9W/YZHtJc2/MBz4pD1LyFWvKHZuzYRMIs0CZXuwmT3GGUI0k9ZfpvSVmieO3l1XZEzs
         VA9lMxJMMwapi/IiMNOa8PzNwypwCm9/iIEHc8ajmVkt0T0Z+02c9jFoimUwjogfrFI2
         Y3nqGxeZ+ioBxAI8UJgtK7YjXCTk2gDg6vVq770H0F6pMVA+Sp+aWHEQbhiVQYTU/tfS
         fWPbc4HrtjgehD9IiTPC5Dq0jbtETvuTnzHJ4gob9tKOSqXZQM8o6RAOltu9XJsP9hQ5
         Vp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VEuFNiSp1v0GZ+nWXU0u8Y/+mNOpI/0SZjNmAZkJ91E=;
        b=D8BhtIfKqUesTc6ryZyh13xOkOuyt+NQTPcuOIO1vKEePrLsUboggl2aOK7WaMHBre
         qedqLSbSdomL4hyr5Lrnv199yI1tQJqf+wPBmoIRAYTmlKcIHXC6pdMTi5O3/s412Twv
         T174akqYDQRQGfu1siJF+amFKzKD5Oeu4bolbumXRe0R5Yk+8yZBHCWoGIFROibojdaG
         c9PvE6JGR6kwFT3doJMSG9ITa2dVXpYmws6Q/c4CGFomGsuh2998YyfGLWl4idP6xNy2
         shVvtpFBPn/eXXurMa6ghylMJdZFbsVbamh3Vu8G6U/18Wla7iAD+JytC+fhOgV2Nxi4
         igzA==
X-Gm-Message-State: AOAM533/omoc6EKVJAAuFZ9swNuoVW9lJs5rAd5XP1pmXEyrPaijZBlE
        +YocZICgoiT/SS4avZ1krv3OBnTxF+o=
X-Google-Smtp-Source: ABdhPJxARn4jCtXBZhIx/d81PUSovtR7q5Jws71rGsJGomOFly/vo2GGvCC8BzJt5+q8Amo4G/ZXdw==
X-Received: by 2002:a05:6000:232:: with SMTP id l18mr2876830wrz.88.1623402695574;
        Fri, 11 Jun 2021 02:11:35 -0700 (PDT)
Received: from localhost.localdomain ([188.24.178.25])
        by smtp.gmail.com with ESMTPSA id l13sm6667737wrz.34.2021.06.11.02.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 02:11:35 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add Ethernet DTS for Actions Semi Owl S500 SoCs
Date:   Fri, 11 Jun 2021 12:11:31 +0300
Message-Id: <cover.1623401998.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the required DTS changes for providing the ethernet
functionality on the Actions S500 SoCs family.

For the moment I have been able to test the Ethernet MAC on the RoseaplePi
SBC only.

Also, please note the patches depend on some clock changes that are
currently under review:
https://lore.kernel.org/lkml/cover.1623354574.git.cristian.ciocaltea@gmail.com/

Thanks,
Cristi

Changes in v2:
- Added Reviewed-by tag from Mani in patch 1/2
- Joined the groups sharing common function "eth_rmii" and switch the
  order of "ref_clk-pinconf" and "phy_clk-pinmux", per Mani's review,
  in patch 2/2

Cristian Ciocaltea (2):
  ARM: dts: owl-s500: Add ethernet support
  ARM: dts: owl-s500-roseapplepi: Add ethernet support

 arch/arm/boot/dts/owl-s500-roseapplepi.dts | 45 ++++++++++++++++++++++
 arch/arm/boot/dts/owl-s500.dtsi            | 10 +++++
 2 files changed, 55 insertions(+)

-- 
2.32.0

