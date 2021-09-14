Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C654940B58B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 19:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhINRDS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Sep 2021 13:03:18 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:57911 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhINRDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 13:03:17 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 2FD0B40008;
        Tue, 14 Sep 2021 17:01:57 +0000 (UTC)
Date:   Tue, 14 Sep 2021 19:01:56 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Xin Xiong <xiongx18@fudan.edu.cn>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH] drivers/mtd/nand: fix reference count leaks in
 ebu_nand_probe
Message-ID: <20210914190156.56509462@xps13>
In-Reply-To: <20210910165316.2500-1-xiongx18@fudan.edu.cn>
References: <20210910165316.2500-1-xiongx18@fudan.edu.cn>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

xiongx18@fudan.edu.cn wrote on Sat, 11 Sep 2021 00:53:16 +0800:

> The reference counting issue happens in several error handling paths
> on two refcounted object related to the "ebu_host" object (dma_tx,
> dma_rx). In these paths, the function forgets to balance one or both
> objects' reference count. For example, when request dma tx chan fails,
> the function forgets to decrease the refcount of "ebu_host->dma_rx"
> increased by dma_request_chan(), causing refcount leaks. What's more,
> the "ebu_host->clk" object also need to be handled correctly.
> 
> Fix this issue by keeping the return value and jumping to
> "err_cleanup_dma" label.

I think it has already been fixed upstream:
0792ec82175e ("mtd: rawnand: intel: Fix error handling in probe")

Thanks,
Miquèl
