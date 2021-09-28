Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC53C41AF6F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240803AbhI1M4X convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Sep 2021 08:56:23 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:54645 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240731AbhI1M4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:56:22 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 0356F20002;
        Tue, 28 Sep 2021 12:54:41 +0000 (UTC)
Date:   Tue, 28 Sep 2021 14:54:40 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     mdalam@codeaurora.org
Cc:     mani@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, sricharan@codeaurora.org
Subject: Re: [PATCH 3/3] mtd: rawnand: qcom: Add support for page scope read
Message-ID: <20210928145440.758ead6b@xps13>
In-Reply-To: <8765976685ca3a04af1c102a69c9ca63@codeaurora.org>
References: <1631699851-12172-1-git-send-email-mdalam@codeaurora.org>
        <1631699851-12172-4-git-send-email-mdalam@codeaurora.org>
        <8765976685ca3a04af1c102a69c9ca63@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

mdalam@codeaurora.org wrote on Tue, 28 Sep 2021 17:51:00 +0530:

> On 2021-09-15 15:27, Md Sadre Alam wrote:
> > QPIC V2.0 onwards QPIC controller support enhanced read mode
> > like page scope read and multi page read.
> > 
> > In QPIC V1, SW is needed to write EXEC_CMD register for each

                the driver needs to (same below)

> > Code word and collect any Status related to that CW before
> > issueing EXEC_CMD for next CW.
> > 
> > Page scope command is truly a page mode command where SW is
> > required to issue EXEC_CMD only once for a page. Controller
> > HW takes care of Codeword specific details and automatically
> > returns status associated with each CW to BAM pipe, dedicated
> > for status deposition.
> > 
> > With this command, SW now can issue one read command for a page
> > and upon receiving completion interrupt, can process status,
> > that have already been deposited in memory through status BAM pipe.
> > 
> > Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> > ---
> >  drivers/mtd/nand/raw/qcom_nandc.c | 77 > ++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 71 insertions(+), 6 deletions(-)
> > 

Thanks,
Miquèl
