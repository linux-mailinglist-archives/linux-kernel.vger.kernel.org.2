Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C0F3779EA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 03:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhEJBnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 21:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhEJBns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 21:43:48 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDB4C061574;
        Sun,  9 May 2021 18:42:44 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 5129C2A8;
        Sun,  9 May 2021 18:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1620610963;
        bh=fTY1Or3lLvDzUlgv4eo2/CcR45q88eZ2rtCXzIFSd8c=;
        h=From:To:Cc:Subject:Date:From;
        b=eOIizJlGxOiK02IBxlm/VQd7RbnvQcvMuC/WiRQQUwOfZbc13rQ9/U6sGkRPqmSOy
         3EPBMu5Btyrw/hIjXYzwfhCY1MFgztvs1AgUUtS0bB+GVwzSBhJEx1a/yUWR5SQQ0S
         BWG1wXtbCgnWgAu9rxDEmqPsgcUAXFeNuqrBVEus=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     openbmc@lists.ozlabs.org, Zev Weiss <zev@bewilderbeest.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] serial: 8250_aspeed_vuart: fix duplicate __release_region() on unbind
Date:   Sun,  9 May 2021 20:42:28 -0500
Message-Id: <20210510014231.647-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series addresses a bug reported by Andrew Jeffery [0] wherein the
aspeed-vuart driver triggers a "Trying to free nonexistent resource"
warning from __release_region() when unbound from a device.  The first
two patches provide some preparatory refactoring and cleanups; the
actual fix is in the final patch.

Joel, note that this series has a dependency on the "generalized DT
properties" series [1] (specifically the second patch), which has been
merged upstream but is not yet in the OpenBMC dev-5.10 tree.

[0] https://github.com/openbmc/linux/issues/203
[1] https://lore.kernel.org/openbmc/20210412034712.16778-1-zev@bewilderbeest.net/

Zev Weiss (3):
  serial: 8250_aspeed_vuart: factor out aspeed_vuart_{read,write}b()
    helper functions
  serial: 8250_aspeed_vuart: initialize vuart->port in
    aspeed_vuart_probe()
  serial: 8250_aspeed_vuart: use UPF_IOREMAP to set up register mapping

 drivers/tty/serial/8250/8250_aspeed_vuart.c | 50 +++++++++++----------
 1 file changed, 27 insertions(+), 23 deletions(-)

-- 
2.31.1

