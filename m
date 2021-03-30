Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F2A34DD0A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 02:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhC3AcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 20:32:18 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:54781 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhC3Ab7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 20:31:59 -0400
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id D037B18F;
        Mon, 29 Mar 2021 17:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1617063847;
        bh=fIyo5Z9zNHuQ1sE64Jzum374jTuO69a6cFL9RIBAmuo=;
        h=From:To:Cc:Subject:Date:From;
        b=MCAxh5WQ+FIdaywXSnS6heqIjLTjVSc8vnUIUKk09fJp8wy8VEc+BqjGRurVWWfLc
         A2mfuEXdKwx8rMggd6kuzHdut3VAbajZYYBD1dlywn6vGH2vRNHxCwzw+344lF9PJk
         UTfJaVB/Qyf1rpQe3kn+16HF8J2v1sCsT9JSzPZA=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Joel Stanley <joel@jms.id.au>
Cc:     openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Zev Weiss <zev@bewilderbeest.net>
Subject: [PATCH 0/3] simplify Aspeed VUART SIRQ polarity DT config, add e3c246d4i BMC dts
Date:   Mon, 29 Mar 2021 19:23:35 -0500
Message-Id: <20210330002338.335-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series reworks the existing aspeed,sirq-polarity-sense DT
property as a simple boolean (aspeed,sirq-active-high) so as to
disentangle the interrupt polarity from the eSPI/LPC strapping and
updates the documentation accordingly.

The third patch adds an in-tree consumer of this property
(aspeed,sirq-polarity-sense never really had one) in the form of a
device tree for the ASRock E3C246D4I BMC, an OpenBMC target in
progress at Equinix Metal (formerly known as Packet).


Zev Weiss (3):
  drivers/tty/serial/8250: simplify Aspeed VUART SIRQ polarity DT config
  dt-bindings: serial: 8250: update for aspeed,sirq-active-high
  ARM: dts: aspeed: add ASRock E3C246D4I BMC

 .../devicetree/bindings/serial/8250.yaml      |  14 +-
 .../boot/dts/aspeed-bmc-asrock-e3c246d4i.dts  | 188 ++++++++++++++++++
 drivers/tty/serial/8250/8250_aspeed_vuart.c   |  39 +---
 drivers/tty/serial/8250/Kconfig               |   1 -
 4 files changed, 196 insertions(+), 46 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts

-- 
2.31.1

