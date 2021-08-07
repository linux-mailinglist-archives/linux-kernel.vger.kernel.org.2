Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC9C3E34CB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhHGKdG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 7 Aug 2021 06:33:06 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:54603 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbhHGKdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:33:03 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id C80EB60002;
        Sat,  7 Aug 2021 10:32:44 +0000 (UTC)
Date:   Sat, 7 Aug 2021 12:32:43 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>, <bbrezillon@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>
Subject: Re: [PATCH 1/2] mtd: mtdconcat: Judge callback function existence
 getting from master for each partition
Message-ID: <20210807123243.7661e4e3@xps13>
In-Reply-To: <27c67e42-f275-fc50-64e5-d80233130f7e@huawei.com>
References: <20210731023243.3977104-1-chengzhihao1@huawei.com>
        <20210731023243.3977104-2-chengzhihao1@huawei.com>
        <20210806212857.240e0c1f@xps13>
        <27c67e42-f275-fc50-64e5-d80233130f7e@huawei.com>
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
10:15:46 +0800:

> 在 2021/8/7 3:28, Miquel Raynal 写道:
> Hi Miquel,
> > Hi Zhihao,
> >
> > Zhihao Cheng <chengzhihao1@huawei.com> wrote on Sat, 31 Jul 2021
> > 10:32:42 +0800:
> > @@ -721,14 +724,15 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c
> >   				    subdev[i]->flags & MTD_WRITEABLE;
> >   		}  
> >   > +		subdev_master = mtd_get_master(subdev[i]);  
> >   		concat->mtd.size += subdev[i]->size;
> >   		concat->mtd.ecc_stats.badblocks +=
> >   			subdev[i]->ecc_stats.badblocks;
> >   		if (concat->mtd.writesize   !=  subdev[i]->writesize ||
> >   		    concat->mtd.subpage_sft != subdev[i]->subpage_sft ||
> >   		    concat->mtd.oobsize    !=  subdev[i]->oobsize ||
> > -		    !concat->mtd._read_oob  != !subdev[i]->_read_oob ||
> > -		    !concat->mtd._write_oob != !subdev[i]->_write_oob) {
> > +		    !concat->mtd._read_oob  != !subdev_master->_read_oob ||
> > +		    !concat->mtd._write_oob != !subdev_master->_write_oob) {
> > Do you really need this change?  
> 
> I think both "!concat->mtd._read_oob != !subdev[i]->_read_oob" and "!concat->mtd._write_oob != !subdev[i]->_write_oob" need to be modified otherwise concatenating goes failure.
> 
> I thought there exists two problems:
> 
>    1. Wrong callback fetching in mtd partition device
> 
>    2. Warning for existence of _read and _read_oob at the same time
> 
> so I solved them in two steps to make history commit logs a bit clear.
> 
> Though these two patches can be combined to one.

No please keep the split.

What I mean here is that I don't think your fix is valid. Maybe we
should propagate these callbacks as well instead of trying to hack into
this condition. I don't see why you should check against subdev[i] for
half of the callbacks and check for subdev_master for the last two.


Thanks,
Miquèl
