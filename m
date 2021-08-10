Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349A63E592D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 13:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240124AbhHJLfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 07:35:31 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:13260 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhHJLf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 07:35:29 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GkW8B3h1Yz1CVMy;
        Tue, 10 Aug 2021 19:34:50 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 10 Aug 2021 19:35:03 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 dggema761-chm.china.huawei.com (10.1.198.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 10 Aug 2021 19:35:03 +0800
Subject: Re: [PATCH 1/2] mtd: mtdconcat: Judge callback function existence
 getting from master for each partition
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <richard@nod.at>, <vigneshr@ti.com>, <bbrezillon@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>
References: <20210731023243.3977104-1-chengzhihao1@huawei.com>
 <20210731023243.3977104-2-chengzhihao1@huawei.com>
 <20210806212857.240e0c1f@xps13>
 <27c67e42-f275-fc50-64e5-d80233130f7e@huawei.com>
 <20210807123243.7661e4e3@xps13>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <9955e32c-615a-f02c-abc3-a7b613bf34ee@huawei.com>
Date:   Tue, 10 Aug 2021 19:35:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210807123243.7661e4e3@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema761-chm.china.huawei.com (10.1.198.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2021/8/7 18:32, Miquel Raynal 写道:
Hi Miquel,
> Hi Zhihao,
>
> Zhihao Cheng <chengzhihao1@huawei.com> wrote on Sat, 7 Aug 2021
> 10:15:46 +0800:
>
>> 在 2021/8/7 3:28, Miquel Raynal 写道:
>> Hi Miquel,
>>> Hi Zhihao,
>>>
>>> Zhihao Cheng <chengzhihao1@huawei.com> wrote on Sat, 31 Jul 2021
>>> 10:32:42 +0800:
>>> @@ -721,14 +724,15 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c
>>>    				    subdev[i]->flags & MTD_WRITEABLE;
>>>    		}
>>>    > +		subdev_master = mtd_get_master(subdev[i]);
>>>    		concat->mtd.size += subdev[i]->size;
>>>    		concat->mtd.ecc_stats.badblocks +=
>>>    			subdev[i]->ecc_stats.badblocks;
>>>    		if (concat->mtd.writesize   !=  subdev[i]->writesize ||
>>>    		    concat->mtd.subpage_sft != subdev[i]->subpage_sft ||
>>>    		    concat->mtd.oobsize    !=  subdev[i]->oobsize ||
>>> -		    !concat->mtd._read_oob  != !subdev[i]->_read_oob ||
>>> -		    !concat->mtd._write_oob != !subdev[i]->_write_oob) {
>>> +		    !concat->mtd._read_oob  != !subdev_master->_read_oob ||
>>> +		    !concat->mtd._write_oob != !subdev_master->_write_oob) {
>>> Do you really need this change?
>> I think both "!concat->mtd._read_oob != !subdev[i]->_read_oob" and "!concat->mtd._write_oob != !subdev[i]->_write_oob" need to be modified otherwise concatenating goes failure.
>>
>> I thought there exists two problems:
>>
>>     1. Wrong callback fetching in mtd partition device
>>
>>     2. Warning for existence of _read and _read_oob at the same time
>>
>> so I solved them in two steps to make history commit logs a bit clear.
>>
>> Though these two patches can be combined to one.
> No please keep the split.
>
> What I mean here is that I don't think your fix is valid. Maybe we
> should propagate these callbacks as well instead of trying to hack into
> this condition. I don't see why you should check against subdev[i] for
> half of the callbacks and check for subdev_master for the last two.

I have the following understanding of mtd:

1. The existence of mtd partition device's callbacks(what can mtd do, 
_read, _write, _read_oob, etc.) is decided by mtd master device. All mtd 
common functions (mtd_read, mtd_read_oob) pass master mtd device rather 
than partition mtd device as parameter, because nand_chip(initialized as 
master mtd device) process requests.  So there are two steps in mtd 
common function: fetch master mtd device; invoke master mtd devices's 
callback and pass in master mtd device.

   Propogating callbacks to partition mtd device may bring some 
imperfections:

   A. No adaptions to mtd common functions: partition mtd device's 
callbacks will never be invoked, they are only used to judge whether 
assigin concatenated device's callback while concatenating. Looks weird.

   @@ -86,6 +86,61 @@ static struct mtd_info *allocate_partition(struct 
mtd_info *parent,
         child->part.offset = part->offset;
         INIT_LIST_HEAD(&child->partitions);

+       if (parent->_read)
+               child->_read = parent->_read;
+       if (parent->_write)
+               child->_write = parent->_write;
[...]
+       if (parent->_read_oob)
+               child->_read_oob = parent->_read_oob;
+       if (parent->_write_oob)


   B. Re-import removed partition mtd device's callbacks and adapt mtd 
common functions: Current implemention is simplier than the version 
before 46b5889cc2c54("mtd: implement proper partition handling"). 
Adapting mtd common functions is a risky thing, which could effect other 
modules, should we do that?

+static int part_read(struct mtd_info *mtd, loff_t from, size_t len,
+               size_t *retlen, u_char *buf)
+{
+       struct mtd_part *part = mtd_to_part(mtd);
+       struct mtd_ecc_stats stats;
+       int res;
+
+      stats = part->parent->ecc_stats;
+       res = part->parent->_read(part->parent, from + part->offset, len,
+                                 retlen, buf);
+       if (unlikely(mtd_is_eccerr(res)))
+               mtd->ecc_stats.failed +=
+                       part->parent->ecc_stats.failed - stats.failed;
+       else
+               mtd->ecc_stats.corrected +=
+                       part->parent->ecc_stats.corrected - stats.corrected;
+       return res;
+}

  static int mtd_read_oob_std(struct mtd_info *mtd, loff_t from,
                             struct mtd_oob_ops *ops)
  {
-       struct mtd_info *master = mtd_get_master(mtd);
         int ret;

-       from = mtd_get_master_ofs(mtd, from);
-       if (master->_read_oob)
-               ret = master->_read_oob(master, from, ops);
+       if (mtd->_read_oob)
+               ret = mtd->_read_oob(mtd, from, ops);
         else
-               ret = master->_read(master, from, ops->len, &ops->retlen,
+               ret = mtd->_read(mtd, from, ops->len, &ops->retlen,
                                     ops->datbuf);


2. Checking against subdev[i] for data members and check against 
subdev_master for the callbacks looks weird. I modified it based on the 
assumption that partition mtd device' callbacks inherit from master mtd 
device but data members(name, size) may not. Maybe I should add some 
comment to explain why checking against subdev[i] for data members and 
checking against subdev_master for the callbacks.


So, which method is better? Any other method?

