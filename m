Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC988411B60
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 18:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245515AbhITQ56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 12:57:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245711AbhITQyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 12:54:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E70F36137A;
        Mon, 20 Sep 2021 16:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632156643;
        bh=niTFWEk7klu7nPWlyngsrkThD/lS2WUfHlng/Jt+MD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K/ZPHUOAg2WyORp0UVJXohDKDs8lmGwQ0avD0I67ADTwamDidxy/se9F3BVM7kNEN
         NHb0LUA0jK8nqbijoAsAIHC8OPKXsvwFDRLhKdlGj/BitSxeNiwb0iZcLUCR2US9KD
         L7rDdjB5CFTMl0sAqOaMmf5Lqt0puOtvTEscoZUc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>
Subject: [PATCH 4.9 002/175] mtd: nand: atmel_nand: remove build warning in atmel_nand_remove()
Date:   Mon, 20 Sep 2021 18:40:51 +0200
Message-Id: <20210920163918.152400834@linuxfoundation.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210920163918.068823680@linuxfoundation.org>
References: <20210920163918.068823680@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

In the 4.9.y tree, the following build warning keeps showing up:

	drivers/mtd/nand/atmel_nand.c:2337:19: warning: unused variable 'mtd' [-Wunused-variable]

This driver was deleted / restructured in newer kernels so this is a
4.9.y patch only.

Cc: Wenyou Yang <wenyou.yang@atmel.com>
Cc: Josh Wu <rainyfeeling@outlook.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/atmel_nand.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -2334,7 +2334,6 @@ err_nand_ioremap:
 static int atmel_nand_remove(struct platform_device *pdev)
 {
 	struct atmel_nand_host *host = platform_get_drvdata(pdev);
-	struct mtd_info *mtd = nand_to_mtd(&host->nand_chip);
 
 	nand_release(&host->nand_chip);
 


