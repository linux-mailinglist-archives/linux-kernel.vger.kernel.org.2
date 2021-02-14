Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C1431E175
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 22:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhBQVfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 16:35:02 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46569 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232339AbhBQVeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 16:34:46 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D4BFF5C00F9;
        Wed, 17 Feb 2021 16:33:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 17 Feb 2021 16:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id:in-reply-to:references; s=fm2;
         bh=0DPt8T+IrQKOkEiQ1EPlTZOferGKmocm4fwWAE5D5bs=; b=bKvX3COYgLTR
        sXoB8fJlRlnbjvYP/Ed8QRLW1Z2ischDqBdgHvzSHQhgMCD7W5BW2kyMvt1UUsvU
        ssf5YV98UoOQzn7c0JkJbwzFJyi9zQTNVzfMZ6reThTFBFXwcTvcaLD2R7lvTZvt
        vw9EUfWzSgjOyIfSaEl2K75O86KkrdwkzoIPjaR2qfzFWWX84TwpiUMIPkhHoZ6h
        gSoZVaVV+AbWH5O3rVMscVlV03/h6kKo55g2XJyElbEpVys+dxznw3noPVfpncsY
        +aH7MKixmfpQb2/I95Vp0UGn855y2jesvDm8WQBKf7UAQ/38inAG+tey/4wJ9X3m
        6wElwJJhHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=0DPt8T+IrQKOkEiQ1EPlTZOferGKm
        ocm4fwWAE5D5bs=; b=PxhZSFhPJxer46Xo1H2DS/cDc3nDPTQrq24dqB6PRrCkC
        yjjLnt20xKYJVnNLAEWR7UGLNLMgZPnx+JnDh+vxk29lU1ruEgB++qCua0Zak/mt
        5JDgq7rFKe2w6radFwCbTtbUuh9wBmU3PcnJ+bOBtJVZrdAukmPPKsCWDcFRK4XR
        pWBOBEGkIpTZ7/C2fw6lGbjUfxrtE8SUjT1MMlnKFRnViagkZ5I1bpzqvpdXjZx6
        IE0w9ZcORGF6qByIehHKljItKdSfrDmN59SlZT4r2shvTPv4y7eyY+Ts+ntXpRnI
        d/6BfRQooVtYWLDZFJG1rG0BiqBWzUEUZIvAbJdxQ==
X-ME-Sender: <xms:wostYIL1aQ-UdEwPtAyTZpu87wtuuq9hBA5kfdjLjH3ai-4aXvuUFw>
    <xme:wostYO6kS1VKDqcmxXLaeC9OSKTS3gV0iQPWqUHdAmvpMlbDMzCKreURItStQy5M3
    bkTtHYR-JFOTrKzDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrjedvgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfsedttdertdertddtnecuhfhrohhmpeghihhllhhirghm
    ucffuhhrrghnugcuoeifihhllhdoghhithesughrnhgurdhmvgeqnecuggftrfgrthhtvg
    hrnhepfffgkeduffdtieeltddtgeetgfdujeekhfegfeegudduffffgedtvddufeelveev
    necukfhppedvudejrddvfeekrddvtdekrdejgeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeifihhllhdoghhithesughrnhgurdhmvg
X-ME-Proxy: <xmx:wostYKftfuljmnLLipbBGMkb9dZ5nLsV-FSWq_ExArwHHqXZf66pyA>
    <xmx:wostYBEPoeNmDBAbEJbZO-JeardBbE0LeL2_RxaaV6NPSTukvED86Q>
    <xmx:wostYLRlVU6rHExCkExRfJ9yQ5vFzKmEcPlgEzl9EAw0Ueu2b8Hb0g>
    <xmx:wostYAs0ErD68Y_OljXZLovZSndulMUdip46yXNjGogQE-1mW1b8jw>
Received: from vagrant.vm (pd9eed04a.dip0.t-ipconnect.de [217.238.208.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5FD3A240057;
        Wed, 17 Feb 2021 16:33:54 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] staging: rtl8192e: rename FragNum to frag_num in sequence_control union
Date:   Sun, 14 Feb 2021 14:03:31 +0000
Message-Id: <20210214140332.16175-3-will+git@drnd.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210214140332.16175-1-will+git@drnd.me>
References: <20210214140332.16175-1-will+git@drnd.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a checkpatch CHECK message.

Signed-off-by: William Durand <will+git@drnd.me>
---
 drivers/staging/rtl8192e/rtl819x_BA.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BA.h b/drivers/staging/rtl8192e/rtl819x_BA.h
index 34d66b8f5155..3e5bd3fc78ce 100644
--- a/drivers/staging/rtl8192e/rtl819x_BA.h
+++ b/drivers/staging/rtl8192e/rtl819x_BA.h
@@ -22,7 +22,7 @@
 union sequence_control {
 	u16 short_data;
 	struct {
-		u16	FragNum:4;
+		u16	frag_num:4;
 		u16	SeqNum:12;
 	} field;
 };
--
2.17.1

