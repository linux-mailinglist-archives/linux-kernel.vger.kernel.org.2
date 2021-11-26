Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8143745EFD9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 15:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352302AbhKZO3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 09:29:42 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:53003 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbhKZO12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 09:27:28 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 71906FF80A;
        Fri, 26 Nov 2021 14:24:13 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>
Cc:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [RESEND v6 0/3] ARM: dts: TI AM437X ADC1
Date:   Fri, 26 Nov 2021 15:24:10 +0100
Message-Id: <20211126142413.354770-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, as part of a very big series, support for the AM437X ADC1 has
been merged in v5.16-rc1. It involved quite a few changes in the MFD and
IIO subsystems, as well as the acknowledgment of new bindings:
https://lkml.org/lkml/2021/10/15/217

Now that everything is upstream, it's time to merge the device tree
changes which I am resending today (already Acked-by Tony but not taken
by anybody yet).

BTW I received a robot report which will be fixed by this series:
https://lkml.kernel.org/lkml/202111210737.L4TuykRK-lkp@intel.com/T/

Thanks,
Miquèl

Miquel Raynal (3):
  ARM: dts: am437x-cm-t43: Use a correctly spelled DT property
  ARM: dts: am43xx: Describe the magnetic reader/ADC1 hardware module
  ARM: dts: am437x-gp-evm: enable ADC1

 arch/arm/boot/dts/am437x-cm-t43.dts  |  2 +-
 arch/arm/boot/dts/am437x-gp-evm.dts  |  8 +++++++
 arch/arm/boot/dts/am437x-l4.dtsi     | 31 ++++++++++++++++++++++++++--
 arch/arm/boot/dts/am43xx-clocks.dtsi |  7 +++++++
 4 files changed, 45 insertions(+), 3 deletions(-)

-- 
2.27.0

