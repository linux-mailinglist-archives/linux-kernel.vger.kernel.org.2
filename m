Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB46C438F53
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 08:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhJYGYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 02:24:35 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:56069 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230342AbhJYGYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 02:24:34 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 79FC55806AD;
        Mon, 25 Oct 2021 02:22:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 25 Oct 2021 02:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=9RV4sajVRAaiAxkMiEO963Z9/Y
        vQEWTOabZurBq9fI8=; b=kGnE+jYGDXymV4Xiq/7FGXrq+67VDY0XxdLHWYuMtH
        1cKQ1cpf0U8X+B3KInfwu++Mm7WJUBMUSiDBMrE8Jo5ysrfmS7UMrE6SfyqyNLuA
        5Y3xxQU7t07OE2d7cZ7TiSfs33vb5NgTDPxZccpA7VA4/8L5kG4JUpZ/fPNdxIWc
        RKum05p8hqtblBp0BBEwL8zbYIHX/quGV9mthxf9kOe0+S/ZVJhXKmwyMzheuzI2
        eDXPGY2Ky5IP6WIA2dOrTcyjnaI/xMbE8eONIkGFoNuH2yJ0AjHLIRFUKkrn3wTl
        APEYiNf+WKyu54z/0JGFHCKlTqdaXYd0l3bZcEGOqWcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=9RV4sajVRAaiAxkMi
        EO963Z9/YvQEWTOabZurBq9fI8=; b=MGLFb95lUZQ4zLy3lEE6UiV+ce1c1OVLf
        gmW6IucM6BQbnAC5HhqKxKI+k94l45jrJvFhqbQ0BpYqfNcCmiTAmeIigzLSlrG+
        0RIPVSh+D2WCAIFflT2Gn4fEfvV3DXuL8Cq2SKqhaXtT6/pXF+xbH1NUz7lsKGSS
        6ERNQDMOL+W6dUdTrBR0lszjsu7GM4UgffpHWlY9d7rf4EShcxiA5jpjMyZ7k8U1
        1jtRYMphBjzacLBAjr35gRFgrnWYDdoosTpbOdyCaqWxlX9wTwplgooBljtOBuMi
        9h2asNz7FXkT4FoGSKlgigIlOLrUihIJItwCM1dI4T3qiQSYqGUPA==
X-ME-Sender: <xms:EE12YXSA5uhtArjfmMfSHkU3ubPJ1EgWIppZoXGAQdKhVrZ-2Noq2g>
    <xme:EE12YYwFc4xx8aNNXE_iZ2jMpghRIZFi3NYXiKl2QIlSGilbCPt1t7WltrvNEFTVR
    4To_WMSpdNJnT2wN2o>
X-ME-Received: <xmr:EE12Yc18ZaBx6l5oD9mImBmJXqw8Y2Fk3VoNQhxUNCFOok26K2MUTdvs_6kI5aeKNx6YYTrYiKBNFb6Afxm4k3E1ZY2ZudVAFhuuL8FoenvMMfvXo2HwuxM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefgedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhvvghnucfr
    vghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrh
    hnpeefhedufedtvdfhhedvudehtdejjeehueduffdtgfdvkedvleelueevlefgfeelgfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:EU12YXC9NZGR27-MpzgH6PnUgQGFG5J_YtpaJLwnajVh7olnnbpIow>
    <xmx:EU12YQgNmBvo4yDgFT9g2IWRAQuIejR6OzPw1M65JmjI6FsHQF3aRw>
    <xmx:EU12YbpYuc9xX2jhuLHGX144eFMgQL8DxPZB2Cwt4AhorqKc78SHcg>
    <xmx:Ek12YTMa9T0GFJF2IJRGPLUwGm6ZPBjz0sIEQrJyBtSJSVAtpvHlcQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Oct 2021 02:22:07 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Sven Peter <sven@svenpeter.dev>, Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] Apple Mailbox Controller support
Date:   Mon, 25 Oct 2021 08:22:01 +0200
Message-Id: <20211025062204.1517-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the fourth version of my series which adds support for the mailbox
controllers found on the Apple M1.

v1: https://lore.kernel.org/lkml/20210907145501.69161-1-sven@svenpeter.dev/
v2: https://lore.kernel.org/lkml/20210916154911.3168-1-sven@svenpeter.dev/
v3: https://lore.kernel.org/lkml/20211017114054.67737-1-sven@svenpeter.dev/

Changes from v3 to v4:
 - dropped minItems: 4 from the bindings
 - added back of_xlate since the mailbox core only supports #mbox-cells = <1>
   but this mailbox uses #mbox-cells = <0>
 - Split of the MAINTAINERS changes to a separate file since we have quite a few
   changes in flight and there will likely be conflicts once the pull requests
   from various subsystems are sent to Linus

Changes from v2 to v3:
 - removed dma barriers since the mbox client will take care of these
 - moved the of_device_id table and related code to the bottom of the file
 - removed of_xlate
 - dropped clock handling from the code and the binding since we now understand
   that these are actually power domains

Changes from v1 to v2:
 - switched to txdone_irq instead of introducing a new mode
 - switched to a threaded interrupt handler for receiving messages
 - added co-processor examples to the device tree binding
 - reformatted the register defines and clarified multiple comments

Best,

Sven

Sven Peter (3):
  MAINTAINERS: Add Apple mailbox files
  dt-bindings: mailbox: Add Apple mailbox bindings
  mailbox: apple: Add driver for Apple mailboxes

 .../bindings/mailbox/apple,mailbox.yaml       |  77 ++++
 MAINTAINERS                                   |   3 +
 drivers/mailbox/Kconfig                       |  12 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/apple-mailbox.c               | 384 ++++++++++++++++++
 include/linux/apple-mailbox.h                 |  19 +
 6 files changed, 497 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
 create mode 100644 drivers/mailbox/apple-mailbox.c
 create mode 100644 include/linux/apple-mailbox.h

-- 
2.25.1

