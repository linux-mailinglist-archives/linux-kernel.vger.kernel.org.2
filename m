Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E270F33ADAC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 09:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhCOIgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 04:36:14 -0400
Received: from comms.puri.sm ([159.203.221.185]:45092 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhCOIgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 04:36:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 45D1BDF897;
        Mon, 15 Mar 2021 01:36:09 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id f6mHQs1Hb4aO; Mon, 15 Mar 2021 01:36:08 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     martin.kepplinger@puri.sm
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, kernel@puri.sm, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, robh@kernel.org, shawnguo@kernel.org
Subject: [PATCH v2 0/3] Librem 5 phone dts fixes
Date:   Mon, 15 Mar 2021 09:35:28 +0100
Message-Id: <20210315083531.3743183-1-martin.kepplinger@puri.sm>
In-Reply-To: <20210311120259.3310499-1-martin.kepplinger@puri.sm>
References: <20210311120259.3310499-1-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two fixes for the Librem 5 phone descriptions and one resend of
https://lore.kernel.org/linux-arm-kernel/20200915141622.14736-1-festevam@gmail.com/
that enables the hantro vpu staging driver. Feel free to ignore that one
if we want to wait for it to be out of staging.

revision history
----------------
v2: (thanks Shawn)
 * fix commit hash in commit message

v1:
 * https://lore.kernel.org/phone-devel/20210311120259.3310499-1-martin.kepplinger@puri.sm/T/

Fabio Estevam (1):
  arm64: defconfig: Enable the Hantro decoder

Guido Günther (1):
  arm64: dts: imx8mq-librem5: Hog the correct gpio

Sebastian Krzyszkowiak (1):
  arm64: dts: imx8mq-librem5-r3: Mark buck3 as always on

 arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts | 4 ++++
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi   | 3 ++-
 arch/arm64/configs/defconfig                        | 3 +++
 3 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.30.1

