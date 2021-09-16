Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5CF40D7EE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 12:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbhIPK5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 06:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbhIPK5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 06:57:38 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BD0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 03:56:18 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id k4so16843680lfj.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 03:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QpODtz5kNV13zbzrD4XGvb+ecxhxeYMLq4B36itEY0U=;
        b=D2adqWHxzPeaQQ0unEiQknykGlmnp69FWEo3XrUsaNqOpARqkjcKHd3FmED/3Six33
         mpwQJkHApO7HNYsKuG6nGoAGTKTI30fMAp4xMN1pH1GwpB9pLWeRcaJcz54f6tH/Rhf8
         SR24mAIJcKYwHArrvSdiv16k19rfXYrIy0Rv5WVgiHPqZZXvjWzTVCeQf5PjHV6M667V
         ceWzVlG+l4c7BMYSLuWsIrqtooWSh1AJLDc47N4VbLMQ9o1hZVaSsN4JdJYws7lE0lDN
         qmwxY9f94pOvFtvJ8/DpS29/XiDhttQSik8rBgxDq4H3Uz5+ixNqOw6q3PhWghvQByMm
         qvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QpODtz5kNV13zbzrD4XGvb+ecxhxeYMLq4B36itEY0U=;
        b=ZQLwQfYhS7B2vAB8gIOgqc7soBj7fWLbKybN4KfYStmRUPTp8oKV4/Mt+9VXiNJABt
         +4XKTtfwXDGCDjr+QGvCy9ZuZ4av2cFSDm5JfXDmq/CYt3t5oEdZWSt6GYa9VygaDwC9
         +uVePvBBe7lL3mOGB2TcPBzSSSv+7wCHlSaJmCxx5bMxuAMY8phBXzog2Ks4YfhHMn7G
         C3S2imsgRM5CrN9XjxEwB6yvideQ1gpxz/vENAFYJqdzJ1g+PraLl5VT67zyJIlbkB2i
         d7u4FS7MFFmGQRI6pSQ4U4GEcnpjc7tARLdBFiUdsZYX2M3fYpTXlpmlMogciIUdLmnU
         BPlg==
X-Gm-Message-State: AOAM531wD33Oy+SnLthrODbhBSYfLS8379cs+KWj7mfhkGwb+HAxlTJD
        O9OwJDRrmjecg4jLIHUnRyU=
X-Google-Smtp-Source: ABdhPJzK6tbPd35vSKttR5Rtx2/GudKgeXox7HdZQXcvRXSX/X5GlxqevP3nMKNfhmEaBHaARX1EcQ==
X-Received: by 2002:ac2:5f78:: with SMTP id c24mr3804631lfc.554.1631789776513;
        Thu, 16 Sep 2021 03:56:16 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.49])
        by smtp.gmail.com with ESMTPSA id r13sm304820ljh.61.2021.09.16.03.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 03:56:15 -0700 (PDT)
Message-ID: <de0621ea-a7f4-bbb2-1560-7cf4f65d651c@gmail.com>
Date:   Thu, 16 Sep 2021 13:56:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [syzbot] WARNING in internal_create_group
Content-Language: en-US
To:     Joel Stanley <joel@jms.id.au>, Sasha Levin <sashal@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+9937dc42271cd87d4b98@syzkaller.appspotmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Eric Sandeen <sandeen@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <000000000000bd7c8a05c719ecf2@google.com>
 <20210721033703.949-1-hdanton@sina.com> <20210721043034.GB7444@lst.de>
 <39ac87a8-42ac-acf7-11eb-ba0b6a9f4a95@gmail.com>
 <CACPK8XfUWoOHr-0RwRoYoskia4fbAbZ7DYf5wWBnv6qUnGq18w@mail.gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <CACPK8XfUWoOHr-0RwRoYoskia4fbAbZ7DYf5wWBnv6qUnGq18w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/21 09:55, Joel Stanley wrote:
> On Wed, 11 Aug 2021 at 21:39, Pavel Skripkin <paskripkin@gmail.com> wrote:
>>
>> On 7/21/21 7:30 AM, Christoph Hellwig wrote:
>> > On Wed, Jul 21, 2021 at 11:37:03AM +0800, Hillf Danton wrote:
>> >> On Tue, 20 Jul 2021 11:53:27 -0700
>> >> >syzbot has found a reproducer for the following issue on:
>> >> >
>> >> >HEAD commit:    8cae8cd89f05 seq_file: disallow extremely large seq buffer..
>> >> >git tree:       upstream
>> >> >console output: https://syzkaller.appspot.com/x/log.txt?x=116f92ec300000
>> >> >kernel config:  https://syzkaller.appspot.com/x/.config?x=7273c75708b55890
>> >> >dashboard link: https://syzkaller.appspot.com/bug?extid=9937dc42271cd87d4b98
>> >> >syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fc287c300000
>> >> >C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178cbf6a300000
>> >
>> > <snip>
>> >
>> >> >WARNING: CPU: 0 PID: 8435 at fs/sysfs/group.c:116 internal_create_group+0x911/0xb20 fs/sysfs/group.c:116
>> >
>> > <snip>
>> >
>> >> The device_add(ddev) in register_disk() may fail but it proceeds to register
>> >> block queue even at the failure ... this falls in the class of known issue
>> >> given the comment line.
>> >>
>> >>  * FIXME: error handling
>> >>  */
>> >> static void __device_add_disk(struct device *parent, struct gendisk *disk,
>> >
>> > Yes, Luis is working on actually fixing this - but it requires changes
>> > to every single block driver.  How does a cap on the seq_buf size
>> > propagate here, though?
>> >
>>
>> Hi!
>>
>> I've looked into this, and, I think, we can add sanity check for
>> first_minor. If user will pass too big index (syzbot's repro passes
>> 1048576) this value will be shifted to part_shift and then truncated to
>> byte in __device_add_disk() and assigned to dev->devt. User may be
>> confused about why he passed 1048576, but sysfs warns about duplicate
>> creation of /dev/block/43:0
>>
>> So, these type of errors can be handled before passing wrong values to
>> sysfs API like this:
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index c38317979f74..600e9bab5d43 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -1725,7 +1725,17 @@ static int nbd_dev_add(int index)
>>         refcount_set(&nbd->refs, 1);
>>         INIT_LIST_HEAD(&nbd->list);
>>         disk->major = NBD_MAJOR;
>> +
>> +       /* Too big first_minor can cause duplicate creation of
>> +        * sysfs files/links, since first_minor will be truncated to
>> +        * byte in __device_add_disk().
>> +        */
>>         disk->first_minor = index << part_shift;
>> +       if (disk->first_minor > 0xff) {
>> +               err = -EINVAL;
>> +               goto out_free_idr;
>> +       }
>> +
>>         disk->minors = 1 << part_shift;
>>         disk->fops = &nbd_fops;
>>         disk->private_data = nbd;
>>
> 
> This one got backported to v5.10.65, and causes a warning on boot:
> 
> [    7.114976] ------------[ cut here ]------------
> [    7.116811] WARNING: CPU: 0 PID: 1 at block/blk-mq.c:3045
> blk_mq_release+0x84/0x114
> [    7.117510] Modules linked in:
> [    7.118593] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.65 #196
> [    7.118691] Hardware name: Generic DT based system
> [    7.119088] Backtrace:
> [    7.119675] [<8093aff0>] (dump_backtrace) from [<8093b294>]
> (show_stack+0x20/0x24)
> [    7.120052]  r7:00000009 r6:60000153 r5:00000000 r4:80e75938
> [    7.120223] [<8093b274>] (show_stack) from [<80940938>]
> (dump_stack+0xc8/0xe4)
> [    7.120298] [<80940870>] (dump_stack) from [<80123174>] (__warn+0xe8/0x154)
> [    7.120355]  r7:00000009 r6:00000be5 r5:804bc594 r4:80b53c80
> [    7.120415] [<8012308c>] (__warn) from [<8093b9b4>]
> (warn_slowpath_fmt+0x6c/0xe4)
> [    7.120465]  r7:00000009 r6:00000be5 r5:80b53c80 r4:00000000
> [    7.120537] [<8093b94c>] (warn_slowpath_fmt) from [<804bc594>]
> (blk_mq_release+0x84/0x114)
> [    7.120594]  r8:80b53c80 r7:857b7390 r6:00000001 r5:80ea6efd r4:00000000
> [    7.120656] [<804bc510>] (blk_mq_release) from [<804ad65c>]
> (blk_release_queue+0xb8/0x128)
> [    7.120756]  r9:00000001 r8:80eee400 r7:00000000 r6:857b7390
> r5:00000001 r4:857b73d8
> [    7.120836] [<804ad5a4>] (blk_release_queue) from [<8052f87c>]
> (kobject_put+0xc8/0x210)
> [    7.120891]  r7:00000000 r6:00000000 r5:80e751bc r4:857b73d8
> [    7.120948] [<8052f7b4>] (kobject_put) from [<804a9b00>]
> (blk_put_queue+0x1c/0x20)
> [    7.120998]  r7:00000000 r6:857b3800 r5:00000000 r4:857b3860
> [    7.121055] [<804a9ae4>] (blk_put_queue) from [<804c2784>]
> (disk_release+0xb0/0x118)
> [    7.121118] [<804c26d4>] (disk_release) from [<805f717c>]
> (device_release+0x40/0xb4)
> [    7.121168]  r7:00000000 r6:00000000 r5:00000000 r4:857b3860
> [    7.121224] [<805f713c>] (device_release) from [<8052f87c>]
> (kobject_put+0xc8/0x210)
> [    7.121265]  r5:80e81154 r4:857b3860
> [    7.121318] [<8052f7b4>] (kobject_put) from [<804c1c74>] (put_disk+0x24/0x28)
> [    7.121368]  r7:ffffffea r6:00000008 r5:857b3800 r4:857bca00
> [    7.121440] [<804c1c50>] (put_disk) from [<806286f4>]
> (nbd_dev_add+0x214/0x27c)
> [    7.121670] [<806284e0>] (nbd_dev_add) from [<80d22f80>]
> (nbd_init+0xec/0x120)
> [    7.121740]  r10:80ec7000 r9:80c06b34 r8:80d39834 r7:00000000
> r6:80e82aa8 r5:00000009
> [    7.121777]  r4:00000000
> [    7.121842] [<80d22e94>] (nbd_init) from [<80102364>]
> (do_one_initcall+0x50/0x274)
> [    7.121893]  r7:00000000 r6:00000007 r5:8116d180 r4:80d22e94
> [    7.121956] [<80102314>] (do_one_initcall) from [<80d012e8>]
> (kernel_init_freeable+0x1b8/0x240)
> [    7.122005]  r7:80d39854 r6:00000007 r5:8116d180 r4:80d5e788
> [    7.122067] [<80d01130>] (kernel_init_freeable) from [<80947bac>]
> (kernel_init+0x18/0x130)
> [    7.122126]  r10:00000000 r9:00000000 r8:00000000 r7:00000000
> r6:00000000 r5:80947b94
> [    7.122161]  r4:00000000
> [    7.122218] [<80947b94>] (kernel_init) from [<80100168>]
> (ret_from_fork+0x14/0x2c)
> [    7.122413] Exception stack(0x810b7fb0 to 0x810b7ff8)
> [    7.122936] 7fa0:                                     00000000
> 00000000 00000000 00000000
> [    7.123287] 7fc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [    7.123545] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    7.123728]  r5:80947b94 r4:00000000
> [    7.124011] ---[ end trace d69e5842dc8c9352 ]---
> 
> There's been a bit going on in this driver since v5.10, so I assume
> it's missing some dependent changes.
> 

Hi, Joel,

Thank you for report!

Did reverting my commit remove this warning? I don't get how sanity 
check could cause this warning, but I might be missing something.



With regards,
Pavel Skripkin
