Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98F84164FD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 20:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242865AbhIWSPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 14:15:21 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:38147 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242795AbhIWSPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 14:15:03 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1B652580C0B;
        Thu, 23 Sep 2021 14:13:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 23 Sep 2021 14:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=17nVF2rSqd6ZekV9XH0hI/1A94
        LLTlfoYJpIt+y6Cpw=; b=evWJSCa+U2iFGl/OIt0/Warjz9npq5C5hPGgKdyuwY
        Nz4pKcVU6rnMxMAqyYBICfAmm/rwfTiiua6w2aysaDyhgZIamu88SXKL//K5zEf8
        yYv+7Xdf3P05G3ZaEbXy/7hC6FspCAHbvQeqHosDAmHMhQ95US0vsn/3657Xv1nA
        z6HikmA4ErdyxizNX7pCfO4f2YdgOwqMjMprNnLjJU9mQKDyIdAY/xcRYVKijB3g
        NL7LTW1SogAvomJfmT9SWw7Mg2KydRHqlO7dW6coSC8dXAhHL9Yj6L+VUEpnDFF2
        zZ8K27ka7k0cJVZ6nEVEKymaUB+o/oGcl46D+N6hp77A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=17nVF2rSqd6ZekV9X
        H0hI/1A94LLTlfoYJpIt+y6Cpw=; b=ugR7ZLESz8l7GQLGV5bNXeqJuXmkL3FC+
        mkSi9+8VUizOPucCEACDiNbeFz0+b9g+Yc3quCeZSV8ZQuHEYiZV5f8eLqCOAO2w
        yzmePAfrXGwCFg4hXLoHvDtqKadIfAfXDhnhlUCJXxpUfKBnx7cca2LMwha4pkw6
        Hdh1F/xU2+1VdiX8+I+hw2z7mnWcGw3nE1RCejQRQzb1a3zU7plzyvWipHE0tdgw
        F/zi48WxTC9WIGQprqK3xiVwzSJTwiSadzGnAPO5I8zguruupO0ZR1iLCDL5+hPf
        Ky0eYnGxeQjBbgJuYH5YnsxgL16JVdNvqd1hAEM0ZuenmzPJ9jwWQ==
X-ME-Sender: <xms:ysNMYT1BTciIzWosxk_yMw5ysXsGgWxwM-5y200344hKl0BIbY3G_A>
    <xme:ysNMYSGxswPHdVYP060ZSPSdpgH5QNmDSF75dM8hwwEyLioSWuL_tzW1OZnUROpe2
    uKfDzUROrY2nEEtX1w>
X-ME-Received: <xmr:ysNMYT5pcuQfSrkgh51t_sj49zGEhc2H_bEva690ewc7_2hlzueTB2xnQFdWwjI6EuCeW0y8U2WXKc9sWgsfSP8dy2Y1Zn357NN36TggntoF_cQp-cibvL4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeiledguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhvvghnucfr
    vghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrh
    hnpeefhedufedtvdfhhedvudehtdejjeehueduffdtgfdvkedvleelueevlefgfeelgfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:ysNMYY3vTx1X0yFI5jq67UvFhL0CRNOG-9zIcKP0q-utFoNOtTPPWQ>
    <xmx:ysNMYWFxgaTom4NKapNwnBLPq7qB-Rc7W80VueqKMxb1oV9k8IbUww>
    <xmx:ysNMYZ8ITXsug5JpmtTx0N_LT7wXKO2vsyLIe4gLIV0Eajoe2qCLiw>
    <xmx:y8NMYR-BQq_e_et4HFYD8F6iPSFDcv31BWCV0LkbS9cih5oLKvHioA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Sep 2021 14:13:28 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Alexander Graf <graf@amazon.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: [PATCH v2 0/6] usb: typec: tipd: Add Apple M1 support
Date:   Thu, 23 Sep 2021 20:13:15 +0200
Message-Id: <20210923181321.3044-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

v1: https://lore.kernel.org/linux-usb/20210918120934.28252-1-sven@svenpeter.dev/
Thanks again to everyone for your review of the initial version!

This series adds initial support for the Apple CD3217/3218 chip which is also
known as Apple ACE1/2. These chips are used on Apple M1 machines.
They are based on the TI TPS6598x chips with a few differences:

	- The interrupt numbers have been changed
	- The secondary i2c bus and its interrupt controller are connected to the
	  system management controller and must not be disturbed
	- The chip comes up in a low power state and must be booted using the
	  "SPSS" (System Power State Switch maybe) command which is not
	  documented in the TI manual
	- The interrupt mask must be set up explicitly

As suggested bei Heikki, this is now done by creating a separate interrupt handler
for the Apple chips and adding specific setup code to the probe function.
There should be no functional changes for existing TPS chips which is which
I've removed the RFT.

Best,

Sven

Sven Peter (6):
  dt-bindings: usb: tps6598x: Add Apple CD321x compatible
  usb: typec: tipd: Split interrupt handler
  usb: typec: tipd: Add short-circuit for no irqs
  usb: typec: tipd: Add support for Apple CD321X
  usb: typec: tipd: Switch CD321X power state to S0
  usb: typec: tipd: Remove FIXME about testing with I2C_FUNC_I2C

 .../devicetree/bindings/usb/ti,tps6598x.yaml  |   4 +
 drivers/usb/typec/tipd/core.c                 | 229 +++++++++++++++---
 drivers/usb/typec/tipd/tps6598x.h             |  12 +
 drivers/usb/typec/tipd/trace.h                |  23 ++
 4 files changed, 231 insertions(+), 37 deletions(-)

-- 
2.25.1

