Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881C73ED7D3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 15:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237361AbhHPNoh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Aug 2021 09:44:37 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:34077 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239572AbhHPNo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 09:44:27 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id D145B240004;
        Mon, 16 Aug 2021 13:43:53 +0000 (UTC)
Date:   Mon, 16 Aug 2021 15:43:52 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>, <bbrezillon@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>
Subject: Re: [PATCH 1/2] mtd: mtdconcat: Judge callback function existence
 getting from master for each partition
Message-ID: <20210816154352.54237a67@xps13>
In-Reply-To: <9955e32c-615a-f02c-abc3-a7b613bf34ee@huawei.com>
References: <20210731023243.3977104-1-chengzhihao1@huawei.com>
        <20210731023243.3977104-2-chengzhihao1@huawei.com>
        <20210806212857.240e0c1f@xps13>
        <27c67e42-f275-fc50-64e5-d80233130f7e@huawei.com>
        <20210807123243.7661e4e3@xps13>
        <9955e32c-615a-f02c-abc3-a7b613bf34ee@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhihao,

Zhihao Cheng <chengzhihao1@huawei.com> wrote on Tue, 10 Aug 2021
19:35:02 +0800:

> 在 2021/8/7 18:32, Miquel Raynal 写道:
> Hi Miquel,
> > Hi Zhihao,
> >
> > Zhihao Cheng <chengzhihao1@huawei.com> wrote on Sat, 7 Aug 2021
> > 10:15:46 +0800:
> >  
> >> 在 2021/8/7 3:28, Miquel Raynal 写道:
> >> Hi Miquel,  
> >>> Hi Zhihao,
> >>>
> >>> Zhihao Cheng <chengzhihao1@huawei.com> wrote on Sat, 31 Jul 2021
> >>> 10:32:42 +0800:
> >>> @@ -721,14 +724,15 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c
> >>>    				    subdev[i]->flags & MTD_WRITEABLE;
> >>>    		}  
> >>>    > +		subdev_master = mtd_get_master(subdev[i]);  
> >>>    		concat->mtd.size += subdev[i]->size;
> >>>    		concat->mtd.ecc_stats.badblocks +=
> >>>    			subdev[i]->ecc_stats.badblocks;
> >>>    		if (concat->mtd.writesize   !=  subdev[i]->writesize ||
> >>>    		    concat->mtd.subpage_sft != subdev[i]->subpage_sft ||
> >>>    		    concat->mtd.oobsize    !=  subdev[i]->oobsize ||
> >>> -		    !concat->mtd._read_oob  != !subdev[i]->_read_oob ||
> >>> -		    !concat->mtd._write_oob != !subdev[i]->_write_oob) {
> >>> +		    !concat->mtd._read_oob  != !subdev_master->_read_oob ||
> >>> +		    !concat->mtd._write_oob != !subdev_master->_write_oob) {
> >>> Do you really need this change?  
> >> I think both "!concat->mtd._read_oob != !subdev[i]->_read_oob" and "!concat->mtd._write_oob != !subdev[i]->_write_oob" need to be modified otherwise concatenating goes failure.
> >>
> >> I thought there exists two problems:
> >>
> >>     1. Wrong callback fetching in mtd partition device
> >>
> >>     2. Warning for existence of _read and _read_oob at the same time
> >>
> >> so I solved them in two steps to make history commit logs a bit clear.
> >>
> >> Though these two patches can be combined to one.  
> > No please keep the split.
> >
> > What I mean here is that I don't think your fix is valid. Maybe we
> > should propagate these callbacks as well instead of trying to hack into
> > this condition. I don't see why you should check against subdev[i] for
> > half of the callbacks and check for subdev_master for the last two.  
> 
> I have the following understanding of mtd:
> 
> 1. The existence of mtd partition device's callbacks(what can mtd do, _read, _write, _read_oob, etc.) is decided by mtd master device. All mtd common functions (mtd_read, mtd_read_oob) pass master mtd device rather than partition mtd device as parameter, because nand_chip(initialized as master mtd device) process requests.  So there are two steps in mtd common function: fetch master mtd device; invoke master mtd devices's callback and pass in master mtd device.
> 
>    Propogating callbacks to partition mtd device may bring some imperfections:
> 
>    A. No adaptions to mtd common functions: partition mtd device's callbacks will never be invoked, they are only used to judge whether assigin concatenated device's callback while concatenating. Looks weird.
> 
>    @@ -86,6 +86,61 @@ static struct mtd_info *allocate_partition(struct mtd_info *parent,
>          child->part.offset = part->offset;
>          INIT_LIST_HEAD(&child->partitions);
> 
> +       if (parent->_read)
> +               child->_read = parent->_read;
> +       if (parent->_write)
> +               child->_write = parent->_write;
> [...]
> +       if (parent->_read_oob)
> +               child->_read_oob = parent->_read_oob;
> +       if (parent->_write_oob)
> 
> 
>    B. Re-import removed partition mtd device's callbacks and adapt mtd common functions: Current implemention is simplier than the version before 46b5889cc2c54("mtd: implement proper partition handling"). Adapting mtd common functions is a risky thing, which could effect other modules, should we do that?
> 
> +static int part_read(struct mtd_info *mtd, loff_t from, size_t len,
> +               size_t *retlen, u_char *buf)
> +{
> +       struct mtd_part *part = mtd_to_part(mtd);
> +       struct mtd_ecc_stats stats;
> +       int res;
> +
> +      stats = part->parent->ecc_stats;
> +       res = part->parent->_read(part->parent, from + part->offset, len,
> +                                 retlen, buf);
> +       if (unlikely(mtd_is_eccerr(res)))
> +               mtd->ecc_stats.failed +=
> +                       part->parent->ecc_stats.failed - stats.failed;
> +       else
> +               mtd->ecc_stats.corrected +=
> +                       part->parent->ecc_stats.corrected - stats.corrected;
> +       return res;
> +}
> 
>   static int mtd_read_oob_std(struct mtd_info *mtd, loff_t from,
>                              struct mtd_oob_ops *ops)
>   {
> -       struct mtd_info *master = mtd_get_master(mtd);
>          int ret;
> 
> -       from = mtd_get_master_ofs(mtd, from);
> -       if (master->_read_oob)
> -               ret = master->_read_oob(master, from, ops);
> +       if (mtd->_read_oob)
> +               ret = mtd->_read_oob(mtd, from, ops);
>          else
> -               ret = master->_read(master, from, ops->len, &ops->retlen,
> +               ret = mtd->_read(mtd, from, ops->len, &ops->retlen,
>                                      ops->datbuf);
> 
> 
> 2. Checking against subdev[i] for data members and check against subdev_master for the callbacks looks weird. I modified it based on the assumption that partition mtd device' callbacks inherit from master mtd device but data members(name, size) may not. Maybe I should add some comment to explain why checking against subdev[i] for data members and checking against subdev_master for the callbacks.
> 
> 
> So, which method is better? Any other method?
> 

I see your point, actually my concern was about checking half of the
*callbacks* from a particular device, and the other half from another
device (eg. the master) but as you stated it here, we check the
callbacks of the master but the "data members" as you call them from
the subdevice, which I think is fine. So I guess I'll take these
changes as they currently are.

Thanks,
Miquèl
