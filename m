Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37013428194
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 15:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhJJNwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 09:52:47 -0400
Received: from mail-m17638.qiye.163.com ([59.111.176.38]:33546 "EHLO
        mail-m17638.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbhJJNwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 09:52:44 -0400
Received: from amadeus-VLT-WX0.lan (unknown [58.23.36.250])
        by mail-m17638.qiye.163.com (Hmail) with ESMTPA id 3B1A31C0189;
        Sun, 10 Oct 2021 21:50:42 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH v2 0/1] arm64: dts: allwinner: NanoPi R1S H5: Add generic compatible string for I2C EEPROM
Date:   Sun, 10 Oct 2021 21:50:16 +0800
Message-Id: <20211010135017.6855-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUMZGElWTENDS0oYQhgaGk
        keVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pz46Ejo6Oj4XETcJTgFCPxw4
        CD0aCk9VSlVKTUhIQ0xIQ09JTEtDVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWU5D
        VUlIVUhNVUlOS1lXWQgBWUFJSElONwY+
X-HM-Tid: 0a7c6a7850ffd993kuws3b1a31c0189
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ChenYu,

> You should add the atmel compatible as a fallback one, not replace the
> microchip one.

Thanks for correcting, I did it, also upgrade the commit message.

> Please also add a cell representing the MAC address, and hook it up
> to the GMAC. You can find an example here [1].

Frankly speaking, I’m a little confused about this. There is a rtl8153
usb network card on this machine, the original factory seems to store
its mac address on this eeprom. It seems that there is no usb network
card written in dts in the kernel before, and the rtl8152 driver may
also need to be modified accordingly to support reading the mac address
from eeprom.

Sorry for my bad English.

Thanks,
Chukun

Changes from v2:
* Typo fixes for the position format.
* Add a nvmem cell representing the MAC address.

Chukun Pan (1):
  arm64: dts: allwinner: NanoPi R1S H5: Add generic compatible string
    for I2C EEPROM

 .../arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.17.1

