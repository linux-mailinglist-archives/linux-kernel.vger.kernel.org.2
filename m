Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E303714A4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 13:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbhECL7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 07:59:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233159AbhECL7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 07:59:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68BE361221;
        Mon,  3 May 2021 11:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620043132;
        bh=ID78MFxrUiC5tIJYM+g9KowxlkdvhD2172JDC5tp2OM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=raFrpboPoYnvqOobF5RzcOMl4jjlphsBwb0N8P2cST7isaoYnzpDONk1Vdn/WrinK
         p7bNUpOSF5MzFogp1Z+LuAWFPoW3KQvbYY5ErGC9Naj0mHDYjROC3M3ctPT6+P7gnU
         LuVr5QB+JoJp9CrwYCoeOAGgiPBviMB03ACI9H4s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 01/69] Revert "crypto: cavium/nitrox - add an error message to explain the failure of pci_request_mem_regions"
Date:   Mon,  3 May 2021 13:56:28 +0200
Message-Id: <20210503115736.2104747-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9fcddaf2e28d779cb946d23838ba6d50f299aa80 as it was
submitted under a fake name and we can not knowingly accept anonymous
contributions to the repository.

This commit was part of a submission "test" to the Linux kernel
community by some "researchers" at umn.edu.  As outlined at:
	https://www-users.cs.umn.edu/%7Ekjlu/papers/full-disclosure.pdf
it was done so as an attempt to submit a known-buggy patch to see if it
could get by our review.  However, the submission turned out to actually
be correct, and not have a bug in it as the authors did not understand
how the PCI driver model works at all, and so the submission was
accepted.

As this change is of useless consequence, there is no loss of
functionality in reverting it.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/cavium/nitrox/nitrox_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
index facc8e6bc580..d385daf2c71c 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_main.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
@@ -442,7 +442,6 @@ static int nitrox_probe(struct pci_dev *pdev,
 	err = pci_request_mem_regions(pdev, nitrox_driver_name);
 	if (err) {
 		pci_disable_device(pdev);
-		dev_err(&pdev->dev, "Failed to request mem regions!\n");
 		return err;
 	}
 	pci_set_master(pdev);
-- 
2.31.1

