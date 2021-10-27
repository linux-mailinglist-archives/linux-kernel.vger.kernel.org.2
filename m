Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D5943C9BA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 14:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241921AbhJ0Mcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 08:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbhJ0Mcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 08:32:52 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD93BC061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 05:30:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 60743419C2;
        Wed, 27 Oct 2021 12:30:24 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     SoC Team <soc@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Apple SoC DT updates for 5.16 (v2)
Message-ID: <6d41b29c-dafa-9b0e-d9ff-fe01eb6dce82@marcan.st>
Date:   Wed, 27 Oct 2021 21:30:22 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SoC folks,

Second try at the Apple SoC DT changes for 5.16. Sorry for the s-o-b
snafu...

-Hector

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

   https://github.com/AsahiLinux/linux.git tags/asahi-soc-dt-5.16-v2

for you to fetch changes up to e1bebf97815158f16da96f69e9d9bb891a4c69eb:

   arm64: dts: apple: j274: Expose PCI node for the Ethernet MAC address (2021-10-27 21:12:32 +0900)

----------------------------------------------------------------
Apple SoC DT updates for 5.16. Adds pinctrl and PCIe nodes.

----------------------------------------------------------------
Marc Zyngier (3):
       arm64: dts: apple: t8103: Add PCIe DARTs
       arm64: dts: apple: t8103: Add root port interrupt routing
       arm64: dts: apple: j274: Expose PCI node for the Ethernet MAC address

Mark Kettenis (2):
       arm64: apple: Add pinctrl nodes
       arm64: apple: Add PCIe node

  arch/arm64/boot/dts/apple/t8103-j274.dts |  23 ++++
  arch/arm64/boot/dts/apple/t8103.dtsi     | 207 +++++++++++++++++++++++++++++++
  2 files changed, 230 insertions(+)

