Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFCDC310F89
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbhBEQZw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 5 Feb 2021 11:25:52 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57255 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbhBEQTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:19:32 -0500
X-Originating-IP: 90.89.227.234
Received: from xps13 (lfbn-tou-1-1424-234.w90-89.abo.wanadoo.fr [90.89.227.234])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 4FF89E0017;
        Fri,  5 Feb 2021 18:01:07 +0000 (UTC)
Date:   Fri, 5 Feb 2021 19:01:06 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     mdalam@codeaurora.org
Cc:     richard@nod.at, vigneshr@ti.com, boris.brezillon@collabora.com,
        manivannan.sadhasivam@linaro.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, sricharan@codeaurora.org
Subject: Re: [PATCH] mtd: rawnand: qcom: Update register macro name for 0x2c
 offset
Message-ID: <20210205190106.58bf14dd@xps13>
In-Reply-To: <7ca35f62c4d3ba7833e192cab3a2701d@codeaurora.org>
References: <1612037236-7954-1-git-send-email-mdalam@codeaurora.org>
        <7ca35f62c4d3ba7833e192cab3a2701d@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

mdalam@codeaurora.org wrote on Fri, 05 Feb 2021 23:26:33 +0530:

> On 2021-01-31 01:37, Md Sadre Alam wrote:
> > This change will remove unused register name macro NAND_DEV1_ECC_CFG.
> > Since this register was only available in QPIC version 1.4.20 ipq40xx
> > and it was not used. In QPIC version 1.5 on wards this register got
> > removed.In QPIC version 2.0 0x2c offset is updated with register
> > NAND_AUTO_STATUS_EN So adding this register macro NAND_AUTO_STATUS_EN
> > with offset 0x2c.
> > 
> > Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>  
> 
>    Ping! Is any additional info needed for this patch ?

The patch is fine but we are at -rc6, the NAND PR has already been
sent, I don't plan to add more patches for this release. I will apply
new patches at v5.12-rc1.

Thanks,
Miquèl
