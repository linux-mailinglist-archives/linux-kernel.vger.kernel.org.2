Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640F53457EC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 07:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCWGoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 02:44:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13663 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhCWGnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 02:43:37 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F4MFs022sznV7F;
        Tue, 23 Mar 2021 14:41:05 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 23 Mar
 2021 14:43:29 +0800
Subject: Re: [PATCH] f2fs: fix to avoid out-of-bounds memory access
To:     butt3rflyh4ck <butterflyhuangxx@gmail.com>
CC:     <jaegeuk@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20210322114730.71103-1-yuchao0@huawei.com>
 <CAFcO6XMak8GSRqQbZ3nPdGvV_eM6DL0+P0z1X2y0G9hkrccaCg@mail.gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <beff8953-d91a-c677-f50a-3aba27c15dde@huawei.com>
Date:   Tue, 23 Mar 2021 14:43:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFcO6XMak8GSRqQbZ3nPdGvV_eM6DL0+P0z1X2y0G9hkrccaCg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi butt3rflyh4ck,

On 2021/3/23 13:48, butt3rflyh4ck wrote:
> Hi, I have tested the patch on 5.12.0-rc4+, it seems to fix the problem.

Thanks for helping to test this patch.

Thanks,

> 
> Regards,
>   butt3rflyh4ck.
> 
> 
> On Mon, Mar 22, 2021 at 7:47 PM Chao Yu <yuchao0@huawei.com> wrote:
>>
>> butt3rflyh4ck <butterflyhuangxx@gmail.com> reported a bug found by
>> syzkaller fuzzer with custom modifications in 5.12.0-rc3+ [1]:
>>
>>   dump_stack+0xfa/0x151 lib/dump_stack.c:120
>>   print_address_description.constprop.0.cold+0x82/0x32c mm/kasan/report.c:232
>>   __kasan_report mm/kasan/report.c:399 [inline]
>>   kasan_report.cold+0x7c/0xd8 mm/kasan/report.c:416
>>   f2fs_test_bit fs/f2fs/f2fs.h:2572 [inline]
>>   current_nat_addr fs/f2fs/node.h:213 [inline]
>>   get_next_nat_page fs/f2fs/node.c:123 [inline]
>>   __flush_nat_entry_set fs/f2fs/node.c:2888 [inline]
>>   f2fs_flush_nat_entries+0x258e/0x2960 fs/f2fs/node.c:2991
>>   f2fs_write_checkpoint+0x1372/0x6a70 fs/f2fs/checkpoint.c:1640
>>   f2fs_issue_checkpoint+0x149/0x410 fs/f2fs/checkpoint.c:1807
>>   f2fs_sync_fs+0x20f/0x420 fs/f2fs/super.c:1454
>>   __sync_filesystem fs/sync.c:39 [inline]
>>   sync_filesystem fs/sync.c:67 [inline]
>>   sync_filesystem+0x1b5/0x260 fs/sync.c:48
>>   generic_shutdown_super+0x70/0x370 fs/super.c:448
>>   kill_block_super+0x97/0xf0 fs/super.c:1394
>>
>> The root cause is, if nat entry in checkpoint journal area is corrupted,
>> e.g. nid of journalled nat entry exceeds max nid value, during checkpoint,
>> once it tries to flush nat journal to NAT area, get_next_nat_page() may
>> access out-of-bounds memory on nat_bitmap due to it uses wrong nid value
>> as bitmap offset.
>>
>> [1] https://lore.kernel.org/lkml/CAFcO6XOMWdr8pObek6eN6-fs58KG9doRFadgJj-FnF-1x43s2g@mail.gmail.com/T/#u
>>
>> Reported-by: butt3rflyh4ck <butterflyhuangxx@gmail.com>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>   fs/f2fs/node.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>> index caf43970510e..8311b2367c7c 100644
>> --- a/fs/f2fs/node.c
>> +++ b/fs/f2fs/node.c
>> @@ -2790,6 +2790,9 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
>>                  struct f2fs_nat_entry raw_ne;
>>                  nid_t nid = le32_to_cpu(nid_in_journal(journal, i));
>>
>> +               if (f2fs_check_nid_range(sbi, nid))
>> +                       continue;
>> +
>>                  raw_ne = nat_in_journal(journal, i);
>>
>>                  ne = __lookup_nat_cache(nm_i, nid);
>> --
>> 2.29.2
>>
> .
> 
