Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F530430871
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 13:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245573AbhJQLn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 07:43:28 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:45985 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245557AbhJQLnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 07:43:14 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 350085809EC;
        Sun, 17 Oct 2021 07:41:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 17 Oct 2021 07:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=oVwR6ZNCF0pl35RXfL/Vp70eAL
        gzGMiQJxoZOvGeINU=; b=agE/4yPWgJM2oer54f+GTUXuQPJh3csvRIkLwTGr1Q
        fQwlkVmP9XA7ZmMuLsDRiOw6SqV6mW4Arf+qiGXjaNucO3y0Q1oI9wCrikWGYaxn
        3WKVyAfF4BIFVu/uazbeMnFXVW9xgJW6F5LAA61OwIrvjNLrEudfqYxQn6huT63w
        kD3qzm4q7K7m9fvW7gYIz/yBdp7bXcP//82UEKEVDhWr4QhduGnmMWDo+CYrF84z
        L7fup9piLr6LZBc9s+B4CCAEGQtHvADpA8IEen8/ZlSlzTLn35yRhlE/oYuEaNRD
        hMLUDcJdSoFFiN7WwQBJI7S9xgRKY1C64s46JoUkpGzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=oVwR6ZNCF0pl35RXf
        L/Vp70eALgzGMiQJxoZOvGeINU=; b=dXoLsck6PSFmUmpHXxLay3tG8gxmDrTd9
        pSrcEvwuU+uTIq4ocFY5MBGxdRBjaiENfnmRCoD0/xW7MaXaWYEplxNZw0f6d5/K
        GMD1bJPbX6S8tEu9h5iSYx4u/R3bgLVrfRCZ0gnXVWK+wynvlGAee5jZBkhoM/15
        ttKhGoUuz0oq3gwR8sak8lxfK1lMb/pn5WtJeKxW53fB4HX4ELUTzCwb5EzrH9bF
        4dVc09nmiZKf8kq3ZPif/gMB/hJ4v/FuzPZsSvuiAb8WHfVCRTHYEvj1de1S4tPo
        5QRHqshjZwEfancVbO+TIUSnVKWMu+OpPd4BHLRcjZPJ6592QNk+Q==
X-ME-Sender: <xms:zwtsYf-BPvtvc3eUKfYA3BDJOKrSresVjtHbnpRMuS24GmzjXLs5Lw>
    <xme:zwtsYbuPcmP5wc2UZ4EU-Bevw_05MqGqeqvo6nC-LzyYk_uf9jg7RCelrVnrEu2Uo
    BYIr4sUW_MBh_qh0WU>
X-ME-Received: <xmr:zwtsYdCMreaiZli_UZGgQ1BIbtcsSVioQbkTGdQk7DfS9wZz_K_WXmT5UFS3trCIJ_VoTTpEB0h6wMGFclATn8ZkeHazia1MzNfUwdyPMnEHdh9eZDOiSHU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddukedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
    thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epfeehudeftddvhfehvdduhedtjeejheeuudfftdfgvdekvdelleeuveelgfeflefgnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:zwtsYbdAC5mpN9BibXDfmMcrJU2R_ynn47V_kbVVDpdcaW7FC7a-vg>
    <xmx:zwtsYUO85tzE91pABTf0dtWr_IZ9TMd5GB4ujUBZBa-q4dw7fmUGPw>
    <xmx:zwtsYdn2DIRM-5YziHtdxDoEiKDTVcPlpkzHr7dtUQDG2E3vc4OQXg>
    <xmx:0AtsYTr9XQJG7QD0mV_cSlXwLRLtuZ5phMvswsWZp7zSEAyAbdv2cA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Oct 2021 07:41:02 -0400 (EDT)
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
Subject: [PATCH v3 0/2] Apple Mailbox Controller support
Date:   Sun, 17 Oct 2021 13:40:52 +0200
Message-Id: <20211017114054.67737-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the second version of my series which adds support for the mailbox
controllers found on the Apple M1.

v1: https://lore.kernel.org/lkml/20210907145501.69161-1-sven@svenpeter.dev/
v2: https://lore.kernel.org/lkml/20210916154911.3168-1-sven@svenpeter.dev/

Thanks again to Jassi and Mark for the review. I've addressed your comments with the
following changes from v2 to v3:

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

Sven Peter (2):
  dt-bindings: mailbox: Add Apple mailbox bindings
  mailbox: apple: Add driver for Apple mailboxes

 .../bindings/mailbox/apple,mailbox.yaml       |  79 ++++
 MAINTAINERS                                   |   3 +
 drivers/mailbox/Kconfig                       |  12 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/apple-mailbox.c               | 374 ++++++++++++++++++
 include/linux/apple-mailbox.h                 |  18 +
 6 files changed, 488 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
 create mode 100644 drivers/mailbox/apple-mailbox.c
 create mode 100644 include/linux/apple-mailbox.h

-- 
2.25.1

