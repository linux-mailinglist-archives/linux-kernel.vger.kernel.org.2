Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC71352F30
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 20:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbhDBS1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 14:27:37 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:59501 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbhDBS1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 14:27:36 -0400
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id DF25F198;
        Fri,  2 Apr 2021 11:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1617388054;
        bh=EmzzfcJVSKVGid8As+ydFJ/nm/0ABTjPReRqCy089W4=;
        h=From:To:Cc:Subject:Date:From;
        b=l5/BpoOziTT93wf6YOTwKdbhUJ62JvwAYVD0DiR1UOGPfAMwwf5fe2+zkfhv1CGcC
         Wc401LvUGkYVN6aobRnjJX3FZHqcnyAP6tBbbQRppZTpujSaRObK3VySPrQcMG7X+M
         TYPMwL6ebNFYKiJpI7AsPHPiBvzDC1wFma5BLOLo=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Joel Stanley <joel@jms.id.au>
Cc:     openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Zev Weiss <zev@bewilderbeest.net>
Subject: [PATCH v4 0/4] aspeed-vuart: generalized DT properties
Date:   Fri,  2 Apr 2021 13:27:20 -0500
Message-Id: <20210402182724.20848-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series generalizes the aspeed-vuart driver's device tree
properties to cover all the attributes it currently exposes via sysfs.

The aspeed,sirq-polarity-sense property was a bit of a design mistake
in that it ties Aspeed VUART SIRQ polarity to SCU register bits that
aren't really inherently related to it; the first patch in this series
deprecates it (though we hope to eventually remove it).

The rest of the series adds two new properties, aspeed,lpc-io-reg and
aspeed,lpc-interrupts.  The latter allows describing the SIRQ polarity
(along with the interrupt number) directly, providing a simpler
replacement for aspeed,sirq-polarity-sense.


Changes since v3 [2]:
 - renamed properties to match aspeed,ast2400-kcs-bmc

Changes since v2 [0]:
 - expanded to also handle sirq number and lpc address in addition to
   sirq polarity
 - added default settings if DT properties not specified
 - refactored existing sysfs code slightly, adding range checks
 - cleaned up 'make dt_binding_check' warnings

Changes since v1 [1]:
 - deprecate and retain aspeed,sirq-polarity-sense instead of removing it
 - drop e3c246d4i dts addition from this series


[0] https://lore.kernel.org/openbmc/20210401005702.28271-1-zev@bewilderbeest.net/
[1] https://lore.kernel.org/openbmc/20210330002338.335-1-zev@bewilderbeest.net/
[2] https://lore.kernel.org/openbmc/20210402004716.15961-1-zev@bewilderbeest.net/


Zev Weiss (4):
  dt-bindings: serial: 8250: deprecate aspeed,sirq-polarity-sense
  drivers/tty/serial/8250: refactor sirq and lpc address setting code
  drivers/tty/serial/8250: add aspeed,lpc-io-reg and
    aspeed,lpc-interrupts DT properties
  dt-bindings: serial: 8250: add aspeed,lpc-io-reg and
    aspeed,lpc-interrupts

 .../devicetree/bindings/serial/8250.yaml      | 28 +++++-
 drivers/tty/serial/8250/8250_aspeed_vuart.c   | 95 +++++++++++++++----
 2 files changed, 103 insertions(+), 20 deletions(-)

-- 
2.31.1

