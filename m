Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD5F32E589
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 11:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhCEKAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 05:00:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:45336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbhCEKAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 05:00:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1491964ECF;
        Fri,  5 Mar 2021 10:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614938414;
        bh=FOgtTrdDCEE26PV/Hl1URH07csPdNLIDlJ2AYc7h8ww=;
        h=Date:From:To:Cc:Subject:From;
        b=ZfG3ftniQGnEpTwnsBrwvnlRutQjhpfQhx4IpA77vRAKmucAqwLKGWU1JzyHZCJ6C
         dlmD739IVcTRRk48Nni+FuOBZjYHhzyWGVdmqeZKxfMBRTP4Vdpi3TxmyvU+dS7zYm
         Q14JB397bNcpuBgcPshYI2zMQhHcB6m0DEbSKNdbQNpQ1i2gQ9dbyHNCRSy/G6MrD7
         rLEmXhR9Il2BSoIV4DNTixJv2nZN/7SpFZYRvjcmVzEa1JuVdu+lOKw7pOUiDKGYUQ
         lZ1jImIxozKkcCTCUzo4DY/0hsREzAJxUC7vRmweOsegOtnieaY/0lZ178cqX4HzFF
         E/LeOVPIz7ouw==
Date:   Fri, 5 Mar 2021 04:00:12 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH RESEND][next] ide: Fix fall-through warnings for Clang
Message-ID: <20210305100012.GA142349@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/ide/siimage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ide/siimage.c b/drivers/ide/siimage.c
index 198847488cc6..c190dc6dfb50 100644
--- a/drivers/ide/siimage.c
+++ b/drivers/ide/siimage.c
@@ -493,6 +493,7 @@ static int init_chipset_siimage(struct pci_dev *dev)
 	case 0x30:
 		/* Clocking is disabled, attempt to force 133MHz clocking. */
 		sil_iowrite8(dev, tmp & ~0x20, scsc_addr);
+		break;
 	case 0x10:
 		/* On 133Mhz clocking. */
 		break;
-- 
2.27.0

