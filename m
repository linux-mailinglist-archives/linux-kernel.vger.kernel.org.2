Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7998402B29
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 16:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344099AbhIGO42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 10:56:28 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:36779 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235265AbhIGO41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 10:56:27 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id D65D3580E7F;
        Tue,  7 Sep 2021 10:55:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 07 Sep 2021 10:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=tr3rAne2mxvJdDMSmiNoM/kTe5
        3cOj7AacnE9RSwub8=; b=NPisbDDCJyXec9+Izt2ILl+GYv6oGQHVoQotbxN2In
        LWjrapdigidirvIzigOfPkh1VxpqCSWHsT87JGaYQNrMHw7EF0aIKwEkXOkdRcuA
        DTGHUW7kdSSXmsjl6W2AAmH8wcJr1KmUV//6d+t4VMVcYpy+QPwczMGvh8e25UkK
        +OLHZB1Wm6IqP61FRKXuosk7DKjVylNJzcrfgql1ek7H/iVKLHHxfnx3iLAjEIen
        opqizuIF8cjBJ7tM+5LhpWfdBkFSyCOsrIpsRm69vZI3wXvZAGZVI/YE610zLNhT
        4/CPFzd/nSIYPNXgafMgH9ang8dqBGSWJZ+BQjcubLSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=tr3rAne2mxvJdDMSm
        iNoM/kTe53cOj7AacnE9RSwub8=; b=AI796OQoTbjMCduu4/84/NMmjtBQStayZ
        Ex8jcBwhAf8nsjQywECUodWsynTtc+5DFvLOs/Tif3ExMGgr+LIgaRtWxs9lr+pb
        vsApvy1n50pPFHiR3gWeEsM9UiMoit3ONH6GXicUEXQmLJrv2xw0JMXcPPc8upCa
        9bTO5RXsUcDnDT2V9znBhmeYM12LSxlheGVVJamdW4Y+zyTeNw2fTGL2CawcVYkk
        vZ8y1wRQBzqCEkeXWUJudp/fxAdnpI2289Lf0dPUYf12fi0NbC28RZtLc+EADDCZ
        Ky3DEykVfT3RVQ04MQC1z/U8cEbpmRitkLrx7OIpV0p+AcAmQAVAg==
X-ME-Sender: <xms:V303Yc6jkkV1dq7khpxJ9Eccd8926nXtj0Ayc4xDpJg7TgOCoL9sag>
    <xme:V303Yd7ueEysSYSfNwganGQGtyJx9Pic_dx7FMXuPfcqO9ninzh-zmCC-fBjlvIFo
    PSaMW3koVY7VAPoDzY>
X-ME-Received: <xmr:V303YbeAIeZCVeQhngvf4xqJgAujo6jFqy3JZgPDAitC0rZB9e9Xej0WvUl0EMVc3fHjs-vxkAK7spofVharX_uAPP6sHqrEZypLkmM8JmmnuavVm-NAX9j8VvTOkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefhedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
    thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epuefgleekvddtjefffeejheevleefveekgfduudfhgefhfeegtdehveejfefffffgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnse
    hsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:V303YRKkf7XBA1YVEx_q7PTE7cot4zVVdzwNc8mPGj7ZKR4hM4oVIQ>
    <xmx:V303YQLMnA1QXPSBdPkJ_9O8JWvim9P0N5boSJ0-PnhFQyT_xcQ9Tw>
    <xmx:V303YSxFy_lBvNZTM7ruj8-Y-v2ouB0jvRCrD36-vYMM-XEPz5vaoA>
    <xmx:WH03YVXt7UkmlcH2reTeNwR_NCHh0FTzDhvFep9-5eGHo7vKnmQD9A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Sep 2021 10:55:17 -0400 (EDT)
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
Subject: [PATCH 0/3] Apple Mailbox Controller support
Date:   Tue,  7 Sep 2021 16:54:58 +0200
Message-Id: <20210907145501.69161-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for the mailbox HW found in the Apple M1. These SoCs
have various co-processors controlling different peripherals (NVMe, display
controller, SMC (required for WiFi), Thunderbolt, and probably more
we don't know about yet). All these co-processors communicate with the main CPU
using these mailboxes. These mailboxes transmit 64+32 bit messages, are
backed by a hardware FIFO and have four interrupts (FIFO empty and FIFO not
empty for the transmit and receive FIFO each).

The hardware itself allows to send 64+32 bit message using two hardware
registers. A write to or read from the second register transmits or receives a
message. Usually, the first 64 bit register is used for the message itself and 
8 bits of the second register are used as an endpoint. I originally considered
to have the endpoint exposed as a mailbox-channel, but finally decided against
it: The hardware itself only provides a single channel to the co-processor and
the endpoint bits are only an implementation detail of the firmware. There's
even one co-processor (SEP) which uses 8 bits of the first register as its
endpoint number instead.
There was a similar discussion about the BCM2835 / Raspberry Pi mailboxes
which came to the same conclusion [1].

These mailboxes also have a hardware FIFO which make implementing them with the
current mailbox a bit tricky: There is no "transmission done" interrupt because
most transmissions are "done" immediately. There is only a "transmission fifo
empty" level interrupt. I have instead implemented this by adding a fast-path to
the core mailbox code as a new txready_fifo mode.
The other possibilities (which would not require any changes to the core mailbox
code) are to either use the polling mode or to enable the "tx fifo empty"
interrupt in send_message and then call txready from the irq handler before
disabling it again. I'd like to avoid those though since so far I've never seen
the TX FIFO run full which allows to almost always avoid the context switch when
sending a message. I can easily switch to one of these modes if you prefer to
keep the core code untouched though.


Best,

Sven

Sven Peter (3):
  mailbox: Add txdone_fifo
  dt-bindings: mailbox: Add Apple mailbox bindings
  mailbox: apple: Add driver for Apple mailboxes

 .../bindings/mailbox/apple,mailbox.yaml       |  81 ++++
 MAINTAINERS                                   |   3 +
 drivers/mailbox/Kconfig                       |  12 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/apple-mailbox.c               | 432 ++++++++++++++++++
 drivers/mailbox/mailbox.c                     |  66 ++-
 drivers/mailbox/mailbox.h                     |   1 +
 include/linux/apple-mailbox.h                 |  18 +
 include/linux/mailbox_controller.h            |  15 +
 9 files changed, 621 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
 create mode 100644 drivers/mailbox/apple-mailbox.c
 create mode 100644 include/linux/apple-mailbox.h

-- 
2.25.1

