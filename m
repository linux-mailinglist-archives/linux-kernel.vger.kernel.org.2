Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA1138ACE5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243829AbhETLvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:51:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242602AbhETLkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:40:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BB0E6100A;
        Thu, 20 May 2021 11:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621510732;
        bh=OoPV5vZCH1zPDLwjeeIBbZ36/exqVT0YBThB3xstUlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TP8aTqQ91E7wnkhvhtwNLsRShkvecH28cKoJ12pQ3vFSrc6RUSVZ69E0wxa/I+zoo
         glV/ESRjEKcHoP3unFOUGDbmvKSzMHD42JxQLeeexFRyTL9RVNC8EOC0mB4eisZpA9
         xC3XFDLK4iC+5DvEE7WDSpf9aCSVGPYu9ipXBA+g9hs2sMT1CP9CDTQI6cSCBBHzNS
         DK2D045mwRsmuxE+MirR+7wsfjh3SWsUrm4uYvoPDJ9ePGwjJ4BnEx6TcLlWZj4ebt
         lznYweYNKSurQSH7yP8/ak3tokNqlUNi5NTyo+3V/ULStdIe9tW+CqX5OA2J6GhzTa
         NmhY6l6HYo3kw==
Received: by pali.im (Postfix)
        id 517019D1; Thu, 20 May 2021 13:38:50 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 mvebu + mvebu/dt64 0/2] firmware: turris-mox-rwtm: new compatible string
Date:   Thu, 20 May 2021 13:38:42 +0200
Message-Id: <20210520113844.32319-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210308153703.23097-1-kabel@kernel.org>
References: <20210308153703.23097-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches add support for using turris-mox-rwtm driver on any
Armada 3720 board. They are just adding a new compatible string.

Per Andrew's request I have split them from V3 series, so they can be
reviewed separately.

These patches are intended for next merge window.

I suppose that in future these patches may be backported into stable
kernel releases as in my opinion they match stable rules condition:
"New device IDs and quirks are also accepted". New compatible string
is basically new device id. Therefore I put into these patches also
Fixes/CC:stable tags. If you have different opinion on this, let me
know.

Pali Rohár (2):
  firmware: turris-mox-rwtm: add marvell,armada-3700-rwtm-firmware
    compatible string
  arm64: dts: marvell: armada-37xx: move firmware node to generic dtsi
    file

 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 6 ++----
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi           | 8 ++++++++
 drivers/firmware/turris-mox-rwtm.c                     | 1 +
 3 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.20.1

