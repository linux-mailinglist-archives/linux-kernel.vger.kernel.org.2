Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A46345011D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 10:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237078AbhKOJYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 04:24:05 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:27205 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236866AbhKOJXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:23:50 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Ht3Xr2wWKz8vQt;
        Mon, 15 Nov 2021 17:19:08 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 15 Nov 2021 17:20:45 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 15 Nov 2021 17:20:44 +0800
Subject: Re: [PATCH v3 04/12] ubifs: Add missing iput if do_tmpfile() failed
 in rename whiteout
To:     Sascha Hauer <s.hauer@pengutronix.de>
CC:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <mcoquelin.stm32@gmail.com>, <kirill.shutemov@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20211112121758.2208727-1-chengzhihao1@huawei.com>
 <20211112121758.2208727-5-chengzhihao1@huawei.com>
 <20211115082446.GC25697@pengutronix.de>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <7f521d7d-e269-6668-3e71-fd8ad1f3c080@huawei.com>
Date:   Mon, 15 Nov 2021 17:20:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20211115082446.GC25697@pengutronix.de>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2021/11/15 16:24, Sascha Hauer Ð´µÀ:
Hi Sascha,
>> diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
>> index 2735ad1affed..6503e6857f6e 100644
>> --- a/fs/ubifs/dir.c
>> +++ b/fs/ubifs/dir.c
>> @@ -1334,6 +1334,8 @@ static int do_rename(struct inode *old_dir, struct dentry *old_dentry,
>>   
>>   		err = do_tmpfile(old_dir, old_dentry, S_IFCHR | WHITEOUT_MODE, &whiteout);
>>   		if (err) {
>> +			if (whiteout)
>> +				iput(whiteout);
> 
> Should this rather be done in do_tmpfile() directly?
Yes, I should have done it. Although next patch reconstructs do_rename() 
which makes this ugly judgement disappered. I will fix it along with 
other suggestions from other patches in next iteration. Thanks.
> Sascha
> 

