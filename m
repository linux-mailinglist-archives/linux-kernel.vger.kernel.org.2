Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29DB3627C6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 20:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239767AbhDPSeH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 16 Apr 2021 14:34:07 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:40121 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236085AbhDPSeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 14:34:05 -0400
X-Originating-IP: 90.89.138.59
Received: from xps13 (lfbn-tou-1-1325-59.w90-89.abo.wanadoo.fr [90.89.138.59])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 8C4C7C0003;
        Fri, 16 Apr 2021 18:33:37 +0000 (UTC)
Date:   Fri, 16 Apr 2021 20:33:36 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>, <kyungmin.park@samsung.com>,
        <michael@walle.cc>, <p.yadav@ti.com>, <jean-philippe@linaro.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: core: Constify buf in mtd_write_user_prot_reg()
Message-ID: <20210416203336.388878ad@xps13>
In-Reply-To: <20210403060931.7119-1-tudor.ambarus@microchip.com>
References: <20210403060931.7119-1-tudor.ambarus@microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

Tudor Ambarus <tudor.ambarus@microchip.com> wrote on Sat, 3 Apr 2021
09:09:31 +0300:

> The write buffer comes from user and should be const.
> Constify write buffer in mtd core and across all _write_user_prot_reg()
> users. cfi_cmdset_{0001, 0002} and onenand_base will pay the cost of an
> explicit cast to discard the const qualifier since the beginning, since
> they are using an otp_op_t function prototype that is used for both reads
> and writes. mtd_dataflash and SPI NOR will benefit of the const buffer
> because they are using different paths for writes and reads.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Applied on top of mtd/next after the merge of all our internal PR's.

Thanks,
Miquèl
