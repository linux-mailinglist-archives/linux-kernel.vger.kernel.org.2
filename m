Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B65032CA32
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbhCDBvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:51:38 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13122 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhCDBvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 20:51:22 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DrYgY3pcrz16G7N;
        Thu,  4 Mar 2021 09:48:57 +0800 (CST)
Received: from DESKTOP-2DH7KI2.china.huawei.com (10.67.102.237) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Mar 2021 09:50:29 +0800
From:   Chengsong Ke <kechengsong@huawei.com>
To:     <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>
Subject: Re: [v2] ubifs: Fix read out-of-bounds in ubifs_jnl_write_inode()
Date:   Thu, 4 Mar 2021 09:50:29 +0800
Message-ID: <20210304015029.32100-1-kechengsong@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20201223121536.6244-1-kechengsong@huawei.com>
References: <20201223121536.6244-1-kechengsong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.102.237]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

>> Reproducer:
>> 0. config KASAN && apply print.patch
>> 1. mount ubifs on /root/temp
>> 2. run test.sh
> 
> What does test.sh do?
Go to Link: https://bugzilla.kernel.org/show_bug.cgi?id=210865.
test.sh creates a very long path file test_file, and then create a 
symbol link link_file for test_file, so ubifs inode for link_file will 
be assigned a big value for ui->data_len.
When we change atime for link_file, ubifs_jnl_write_inode will be 
executed by wb_writeback. By this way, write_len could be not aligned 
with 8 bytes.
> 
>> 3. cd /root/temp && ls // change atime for link_file
>> 4. wait 1~2 minutes
>>
>> In order to solve the read oob problem in ubifs_wbuf_write_nolock, just align
>> the write_len to
>> 8 bytes when alloc the memory. So that this patch will not affect the use of
>> write_len in other
>> functions, such as ubifs_jnl_write_inode->make_reservation and
>> ubifs_jnl_write_inode->ubifs_node_calc_hash.
> 
> I gave this a second thought and I'm not so sure anymore what exactly is going on.
> The problem is real, I fully agree with you but I need to dig deeper into
> the journal and wbuf code to double check that we really fix the right thing
> and not just paper other something.
> 
> Thanks,
> //richard
> .
>
