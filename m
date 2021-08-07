Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013083E34C0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhHGK2h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 7 Aug 2021 06:28:37 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:37613 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbhHGK2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:28:36 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id B41F9C0004;
        Sat,  7 Aug 2021 10:28:15 +0000 (UTC)
Date:   Sat, 7 Aug 2021 12:28:14 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>, <bbrezillon@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>
Subject: Re: [PATCH 2/2] mtd: mtdconcat: Remove concat_{read|write}_oob
Message-ID: <20210807122814.109ec082@xps13>
In-Reply-To: <83cb21c4-0140-40d5-e0f8-7f2a7e781a5f@huawei.com>
References: <20210731023243.3977104-1-chengzhihao1@huawei.com>
        <20210731023243.3977104-3-chengzhihao1@huawei.com>
        <20210806212655.16e4d03d@xps13>
        <83cb21c4-0140-40d5-e0f8-7f2a7e781a5f@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhihao,

Zhihao Cheng <chengzhihao1@huawei.com> wrote on Sat, 7 Aug 2021
10:59:32 +0800:

> 在 2021/8/7 3:26, Miquel Raynal 写道:
> Hi Miquel,
> >>   static int concat_erase(struct mtd_info *mtd, struct erase_info *instr)
> >>   {
> >>   	struct mtd_concat *concat = CONCAT(mtd);
> >> @@ -684,10 +580,6 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c
> >>   	subdev_master = mtd_get_master(subdev[0]);
> >>   	if (subdev_master->_writev)
> >>   		concat->mtd._writev = concat_writev;
> >> -	if (subdev_master->_read_oob)
> >> -		concat->mtd._read_oob = concat_read_oob;
> >> -	if (subdev_master->_write_oob)
> >> -		concat->mtd._write_oob = concat_write_oob;  
> > Actually I am not sure _read|write_oob() is the right callback to
> > remove.
> >
> > Richard, what is your input on this? Shall we remove _read|write()
> > instead? I don't remember the exact rationale behind these two helpers.  
> 
> Oh, I guess I made a mistake. It looks like that reserving _{read|write}_oob is a better method in my limited knowledge to nand driver. For example, nand_do_read_oob() behaves different from nand_do_read_ops(), and calling which function is decided by mtd_oob_ops.databuf.
> Callback _read_oobs() can support both functions, but callback _read() don't support nand_do_read_oob(). So mtd_read_oobs() covers mtd_read()?
> Is my understand right?
> 

Yes please let's drop _read|write() instead.

Thanks,
Miquèl
