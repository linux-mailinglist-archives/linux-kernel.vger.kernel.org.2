Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDAF38C5C6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 13:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhEULgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 07:36:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3469 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhEULgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 07:36:17 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FmkwN5MZjzCsSy;
        Fri, 21 May 2021 19:32:04 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 19:34:52 +0800
Received: from [10.174.179.129] (10.174.179.129) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 21 May 2021 19:34:52 +0800
Subject: Re: [PATCH] char: pcmcia: fix possible array index out of bounds in
 set_protocol()
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <laforge@gnumonks.org>, <arnd@arndb.de>, <akpm@osdl.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20210521100705.28234-1-yukuai3@huawei.com>
 <YKeSdYJiVMO9NKV4@kroah.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <23af0838-07c3-7113-4229-28cc82b07527@huawei.com>
Date:   Fri, 21 May 2021 19:34:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YKeSdYJiVMO9NKV4@kroah.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.129]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/05/21 18:59, Greg KH wrote:
> On Fri, May 21, 2021 at 06:07:05PM +0800, Yu Kuai wrote:
>> The length of array 'pts_reply' is 4, and the loop in set_protocol()
>> will access array element from 0 to num_bytes_read - 1. Thus if
>> io_read_num_rec_bytes() gets 'num_bytes_read' more than 4, it will
>> cause index out of bounds errors.
> 
> And how can num_bytes_read be greater than 4?

Hi

Do you mean num_bytes_read here should never be greater than 4?

544                 io_read_num_rec_bytes(iobase, &num_bytes_read);
545                 if (num_bytes_read >= 4) {
546                         DEBUGP(2, dev, "NumRecBytes = %i\n", 
num_bytes_read);
547                         break;


> 
> Ah, it is tested, but you might want to error out if that happens, as
> obviously something went wrong.
> 
> Do you have this hardware to test these changes?

Sorry we don't have this hardware...

Thanks,
Yu Kuai
> 
> thanks,
> 
> greg k-h
> .
> 
