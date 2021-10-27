Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D57A43C3B3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 09:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240428AbhJ0HWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 03:22:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240407AbhJ0HWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 03:22:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C60060F9B;
        Wed, 27 Oct 2021 07:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635319175;
        bh=xYwMf51d28hk5TR1VW3DBk886gb6GjjMAgeCIGsfQ/U=;
        h=From:To:Cc:Subject:Date:From;
        b=ODLqzzasnDimwgDtWtKNu9hT6dPgeSdJtAKWXvDDAoOv0aVpUiPUxzm3pDoGVv8YW
         ghr5wmkumyVyxjT9Cte+bQAASoEwIZ4+CJnAoTXZu1lqYtT2SAHscrVG/a34EGfHVC
         m/sCmvcf4CcRiQBk3RvNhxDv0NvNQ9o9E5QkOL+Jzdlv6H93QIY/YI83quYZiWM+Cs
         TQfNsWnjZwttz6H2++hW+DTNx8LKvrbrHZZRfAVD/2/uCqxcPAemAMn9KWvEgbd4oD
         +IreYWS8wEk4Bu10xh0c3+M3ZdYxqCUdXqTCJYl/ghWHrBJN4fZXkvHKVHkr00LCmI
         EAKk8lYrlp8zA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mfdDg-00CV5I-K6; Wed, 27 Oct 2021 08:19:32 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] DTS support for PCIe on HiKey970
Date:   Wed, 27 Oct 2021 08:19:24 +0100
Message-Id: <cover.1635318674.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xuwei,

All drivers needed to support PCIe on HiKey 970 were merged
for Kernel 5.16:

	- The PHY driver went via PHY tree;
	- The pcie-kirin changes went via PCI-DWC tree;
	- The dt-bindings documentation went via DT tree.

The only missing piece of the puzzle is the DTS file.

It follows the documentation at:

	https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml

and it is pratically identical[1] to the second example there.

[1] The only difference is that, on the example, I had to use a
     different address to avoid conflicts with the HiKey960 
     example - as - on both hardware - the pcie is at f4000000.

Manivannan Sadhasivam (1):
  arm64: dts: HiSilicon: Add support for HiKey 970 PCIe controller
    hardware

 arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 107 ++++++++++++++++++++++
 1 file changed, 107 insertions(+)

-- 
2.31.1


