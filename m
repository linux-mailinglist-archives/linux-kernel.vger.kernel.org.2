Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4977383825
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 17:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344245AbhEQPt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 11:49:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245034AbhEQPcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 11:32:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEC0561CD0;
        Mon, 17 May 2021 14:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621262324;
        bh=3Cu1OXbJy1z94skw+RnA2z/mEj1mqpDx2oIFxIyBWKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RA5PwA4XtBSz59MZje7DOburV+BrSumfk3fZbZC7XuBHj8toTuCklF0TNVgNpfAx0
         W4UCNKY2+w4wRH7kAi4Hqj95q5tZupuqmPFeEYNr0V016IvXEYda8cP97I2FpzBqQM
         d2F1rGxBxLU9JrhDE5f/ou7aXlbV45dEmxU02dB8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ramesh Babu B <ramesh.babu.b@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 161/289] net: stmmac: Clear receive all(RA) bit when promiscuous mode is off
Date:   Mon, 17 May 2021 16:01:26 +0200
Message-Id: <20210517140310.542818861@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517140305.140529752@linuxfoundation.org>
References: <20210517140305.140529752@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramesh Babu B <ramesh.babu.b@intel.com>

[ Upstream commit 4c7a94286ef7ac7301d633f17519fb1bb89d7550 ]

In promiscuous mode Receive All bit is set in GMAC packet filter register,
but outside promiscuous mode Receive All bit is not cleared,
which resulted in all network packets are received when toggle (ON/OFF)
the promiscuous mode.

Fixes: e0f9956a3862 ("net: stmmac: Add option for VLAN filter fail queue enable")
Signed-off-by: Ramesh Babu B <ramesh.babu.b@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index ced6d76a0d85..16c538cfaf59 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -617,6 +617,7 @@ static void dwmac4_set_filter(struct mac_device_info *hw,
 	value &= ~GMAC_PACKET_FILTER_PCF;
 	value &= ~GMAC_PACKET_FILTER_PM;
 	value &= ~GMAC_PACKET_FILTER_PR;
+	value &= ~GMAC_PACKET_FILTER_RA;
 	if (dev->flags & IFF_PROMISC) {
 		/* VLAN Tag Filter Fail Packets Queuing */
 		if (hw->vlan_fail_q_en) {
-- 
2.30.2



