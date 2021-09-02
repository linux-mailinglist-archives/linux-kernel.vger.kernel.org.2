Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE50D3FED41
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 13:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343991AbhIBL4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 07:56:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343826AbhIBL41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 07:56:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4066F610E6;
        Thu,  2 Sep 2021 11:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630583729;
        bh=cIayGiEKsNoO8odnoHVw3BqroBAASJ2qygN8Kcar4ns=;
        h=From:To:Cc:Subject:Date:From;
        b=ZUWZqa9xfSVAZY04KnVJfLPHMSjwMmd+R5hrGIefQnzFYNo+jXHXwIzUpGJPWGJD9
         5ZTi7uPF3j+rtlu7GNtjLFPdclUuJUzWejtGeZF0eFkvharjLVRJzg5b/c7Hf/y6a+
         dKw2v+XPVDE/1MBkT/zNevX5WtzaQbDaLhe+Cqv88evajLyD3DdiEt2fqisDvd/Zoy
         30buoPXf/R08PqmJTRqHMr2YacT1edHLTz1MIztA1H56RFdbhlky58E489AMoTRZ+u
         OllkgeGRINIIkL7afLbx369tUHlbCxwk0ZjSKTeZ/tNBO6sW/42/gcvQupX3ZAOEGg
         DLTjSUycKw9zg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mLlJX-0006rL-6q; Thu, 02 Sep 2021 13:55:27 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add DTS bits to enable USB3 PHY on HiKey970
Date:   Thu,  2 Sep 2021 13:55:22 +0200
Message-Id: <cover.1630583382.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

Now that the Hi6421v600 PMIC together with its DT schema schema got
merged upstream, we can merge the PMIC and the USB3 PHY support for
HiKey 970 DTS.

Please merge those two via HiSilicon tree.

-

It should be noticed that there's one last component needed for USB3 to
work: the DT schema for the in-board USB HUB. I'll submit this in
separate, as such patch series is still under review:

	https://lore.kernel.org/lkml/cover.1630581434.git.mchehab+huawei@kernel.org/T/#t

Regards,
Mauro	

Mauro Carvalho Chehab (2):
  arm64: dts: hisilicon: Add support for Hikey 970 PMIC
  arm64: dts: hisilicon: Add support for Hikey 970 USB3 PHY

 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 105 ++++++++++++++----
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  58 +++++++++-
 .../boot/dts/hisilicon/hikey970-pmic.dtsi     |  86 ++++++++++++++
 3 files changed, 229 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi

-- 
2.31.1


