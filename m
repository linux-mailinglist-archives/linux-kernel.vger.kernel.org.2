Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016793CCF03
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 10:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbhGSIHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 04:07:04 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:31636 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbhGSIGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 04:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1626681825; x=1658217825;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wSU7TvVNgFf9Bb2J0xruYeNRqcyqT9pn0FXWHBazDzs=;
  b=OZeN1847hE3dI5abA356aZV+UXf/fUjCuS/vFEYSJJX9dXZe9UwQDCwo
   YBWjZSXqAEJaDhBy9c3vttNNRRIsoh3xjL5OoKx93X5mr1y6D0awKW8U6
   hC+5YHnavk2LLF8KaFSJs5trkkyGIsHPocvlgdEkpFYFxqpeWY7cXLZct
   tvnE+syGiT/NAHmhLdOoLdvFLwlhpNEfkYtqIFRBqJxL8Aw7JvAXee9KN
   UvgqskNPQHDLlBKwqZhO8sse5IsUb4YeR9m++fi1KF/l8YZq9cojl2n79
   4yP4M38AKpU/ugUMQAw1w8U8BhuDiplSXj7elN3tJ1eRk+uiWv07i+L4y
   g==;
IronPort-SDR: d8MbJgXUdJSjGil3MjTrIAht8XuUc6qlZVFO2/PWStMq3A8lesunyUlOPY0PHNnLvy0rfE9PBG
 N4haoC1Lr4HTQTAXSXXddFBb6ROxBXcr0WZ508gjul9D55/GJaqM/J7bAZsVT5a+YXIVwtsxvy
 eToUulGhmTF9O9bfZ+Ts7hX9j0zq8UsAhHz5RTbzhriFmULTUslwdVL+nX2SB1JqN7S9dTLoZw
 eMyzWqEXDC3QhtsL3r8mxc/b+IJJLTzyNpwKfSDpb0K+uyjSVCH98hov/PrQazJaDfhSNEw5Yc
 yzT95VnVUNh7WTMeCG9jwRuz
X-IronPort-AV: E=Sophos;i="5.84,251,1620716400"; 
   d="scan'208";a="136432799"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2021 01:03:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 01:03:42 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 19 Jul 2021 01:03:39 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <eugen.hristev@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <sfr@canb.auug.org.au>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/2] ARM: at91: fix compilation errors after SAMA7G5
Date:   Mon, 19 Jul 2021 11:03:15 +0300
Message-ID: <20210719080317.1045832-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fix compilation errors after the merge of AT91 SAMA7G5 SoC
support.

Claudiu Beznea (2):
  ARM: at91: fix link error
  clk: at91: add register definition for sama7g5's master clock

 arch/arm/mach-at91/Kconfig   |  3 +++
 include/linux/clk/at91_pmc.h | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

-- 
2.25.1

