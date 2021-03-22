Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B003444B2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbhCVNEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:04:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231895AbhCVMvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:51:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2919619FB;
        Mon, 22 Mar 2021 12:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616417152;
        bh=aoYiavtlJP2pJskaK6NkDrKcbc5G/xS+wV15QxO6LxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xShEBqx/wkzH+RTOsgrDJTgSUSGtoX/NvUF7WyOKw/Wcfe8yjBz9FWSHx6q5dd54j
         s4LG/QuozKysYFrncglTftuUs4A04OTLNc1eJe9RZOtyQkBiZDyNO1YBUrKAiNLcwT
         GIjUwemHmzpWaE13KxXr/f40g8Md29QeR6wKp/9Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.19 13/43] ASoC: fsl_ssi: Fix TDM slot setup for I2S mode
Date:   Mon, 22 Mar 2021 13:28:27 +0100
Message-Id: <20210322121920.356271653@linuxfoundation.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210322121919.936671417@linuxfoundation.org>
References: <20210322121919.936671417@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shiyan <shc_work@mail.ru>

commit 87263968516fb9507d6215d53f44052627fae8d8 upstream.

When using the driver in I2S TDM mode, the _fsl_ssi_set_dai_fmt()
function rewrites the number of slots previously set by the
fsl_ssi_set_dai_tdm_slot() function to 2 by default.
To fix this, let's use the saved slot count value or, if TDM
is not used and the slot count is not set, proceed as before.

Fixes: 4f14f5c11db1 ("ASoC: fsl_ssi: Fix number of words per frame for I2S-slave mode")
Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Link: https://lore.kernel.org/r/20210216114221.26635-1-shc_work@mail.ru
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/fsl/fsl_ssi.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -873,6 +873,7 @@ static int fsl_ssi_hw_free(struct snd_pc
 static int _fsl_ssi_set_dai_fmt(struct fsl_ssi *ssi, unsigned int fmt)
 {
 	u32 strcr = 0, scr = 0, stcr, srcr, mask;
+	unsigned int slots;
 
 	ssi->dai_fmt = fmt;
 
@@ -904,10 +905,11 @@ static int _fsl_ssi_set_dai_fmt(struct f
 			return -EINVAL;
 		}
 
+		slots = ssi->slots ? : 2;
 		regmap_update_bits(ssi->regs, REG_SSI_STCCR,
-				   SSI_SxCCR_DC_MASK, SSI_SxCCR_DC(2));
+				   SSI_SxCCR_DC_MASK, SSI_SxCCR_DC(slots));
 		regmap_update_bits(ssi->regs, REG_SSI_SRCCR,
-				   SSI_SxCCR_DC_MASK, SSI_SxCCR_DC(2));
+				   SSI_SxCCR_DC_MASK, SSI_SxCCR_DC(slots));
 
 		/* Data on rising edge of bclk, frame low, 1clk before data */
 		strcr |= SSI_STCR_TFSI | SSI_STCR_TSCKP | SSI_STCR_TEFS;


