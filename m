Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC2B427D72
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 22:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhJIUvH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 9 Oct 2021 16:51:07 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:55034 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhJIUuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 16:50:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8AE3761B8F4E;
        Sat,  9 Oct 2021 22:48:54 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id IfQSoEYup1iB; Sat,  9 Oct 2021 22:48:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D57EE61B8F4F;
        Sat,  9 Oct 2021 22:48:53 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KxUwAN7OS5P4; Sat,  9 Oct 2021 22:48:53 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id AB09E61B8F4E;
        Sat,  9 Oct 2021 22:48:53 +0200 (CEST)
Date:   Sat, 9 Oct 2021 22:48:53 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     schaecsn <schaecsn@gmx.net>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stefan Schaeckeler <sschaeck@cisco.com>
Message-ID: <67641638.55077.1633812533457.JavaMail.zimbra@nod.at>
In-Reply-To: <20211004055758.C52AD899CC4@corona.crabdance.com>
References: <20210907214034.11676-1-schaecsn@gmx.net> <20210907214034.11676-2-schaecsn@gmx.net> <1815586081.32955.1633291105033.JavaMail.zimbra@nod.at> <20211004055758.C52AD899CC4@corona.crabdance.com>
Subject: Re: [PATCH 1/1] ubifs: ubifs to export filesystem error counters
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF93 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: ubifs to export filesystem error counters
Thread-Index: UO676Xgz4Y0Avo+u3Pw5FRWRm0S/nw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan,

----- Ursprüngliche Mail -----
> Von: "schaecsn" <schaecsn@gmx.net>
> An: "richard" <richard@nod.at>
> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "Stefan Schaeckeler"
> <sschaeck@cisco.com>
> Gesendet: Montag, 4. Oktober 2021 07:57:58
> Betreff: Re: [PATCH 1/1] ubifs: ubifs to export filesystem error counters

> Hello Richard,
> 
>> > Not all ubifs filesystem errors are propagated to userspace.
>> >
>> > Export bad magic, bad node and crc errors via sysfs. This allows userspace
>> > to notice filesystem errors:
>> >
>> > /sys/fs/ubifs/ubiX_Y/errors_magic
>> > /sys/fs/ubifs/ubiX_Y/errors_node
>> > /sys/fs/ubifs/ubiX_Y/errors_crc
>> >
>> > The counters are reset to 0 with a remount. Writing anything into the
>> > counters also clears them.
>>
>> I think this is a nice feature. Thanks for implementing it.
>> Please see some minor nits below.
>>
>> Is there a specific reason why you didn't implement it via UBIFS's debugfs
>> interface?
> 
> These error counters are not meant for aiding debugging but for userspace to
> monitor the sanity of the filesystem. Also ext4 exports error counters via
> sysfs - it's probably a good idea to be consistent with them.
> 
> $ dir /sys/fs/ext4/sdb2/*error*
> -r--r--r-- 1 root root 4096 Oct  3 13:46 /sys/fs/ext4/sdb2/errors_count
> -r--r--r-- 1 root root 4096 Oct  3 13:46 /sys/fs/ext4/sdb2/first_error_block
> -r--r--r-- 1 root root 4096 Oct  3 13:46 /sys/fs/ext4/sdb2/first_error_errcode
> -r--r--r-- 1 root root 4096 Oct  3 13:46 /sys/fs/ext4/sdb2/first_error_func
> -r--r--r-- 1 root root 4096 Oct  3 13:46 /sys/fs/ext4/sdb2/first_error_ino
> -r--r--r-- 1 root root 4096 Oct  3 13:46 /sys/fs/ext4/sdb2/first_error_line
> -r--r--r-- 1 root root 4096 Oct  3 13:46 /sys/fs/ext4/sdb2/first_error_time
> -r--r--r-- 1 root root 4096 Oct  3 13:46 /sys/fs/ext4/sdb2/last_error_block
> -r--r--r-- 1 root root 4096 Oct  3 13:46 /sys/fs/ext4/sdb2/last_error_errcode
> -r--r--r-- 1 root root 4096 Oct  3 13:46 /sys/fs/ext4/sdb2/last_error_func
> -r--r--r-- 1 root root 4096 Oct  3 13:47 /sys/fs/ext4/sdb2/last_error_ino
> -r--r--r-- 1 root root 4096 Oct  3 13:46 /sys/fs/ext4/sdb2/last_error_line
> -r--r--r-- 1 root root 4096 Oct  3 13:46 /sys/fs/ext4/sdb2/last_error_time
> --w------- 1 root root 4096 Oct  3 13:46 /sys/fs/ext4/sdb2/trigger_fs_error

ext4 is not the reference design for filesystems in Linux.
e.g. btrfs has an ioctl for such stats.

> 
>> sysfs is ABI, so we cannot change much anymore.
> 
> Judging by the filesystem permissions above, ext4 does not seem to allow
> resetting error counters. If you worry about unchangable ABIs then we could
> play it safe and don't support write callbacks for resetting the error counters
> in an initial version of the ubifs sysfs. What do you think?

Ack.

> When we are at it, in the current code, writing anything into a sysfs node
> resets the corresponding counter. One could fine-tune that to set the counter
> to whatever non-negative integer is passed.
> 
> 
>> > +		if (c->stats)
>> > +			c->stats->magic_errors++;
>>
>> Please wrap this into a helper function.
> 
> Ack.
> 
> 
>> > +		if (c->stats)
>> > +			c->stats->node_errors++;
>>
>> Same.
> 
> Ack.
> 
> 
>> > +		if (c->stats)
>> > +			c->stats->crc_errors++;
>>
>> Same.
> 
> Ack.
> 
> 
>> > +#define UBIFS_ATTR_FUNC(_name, _mode) UBIFS_ATTR(_name, _mode, _name)
>> > +
>> > +UBIFS_ATTR_FUNC(errors_magic, 0644);
>> > +UBIFS_ATTR_FUNC(errors_crc, 0644);
>> > +UBIFS_ATTR_FUNC(errors_node, 0644);
>>
>> I'm not sure whether everyone should be allowed to read these stats.
>> dmesg is also restricted these days. An unprivileged user should not see the
>> errors he can indirectly trigger.
> 
> I don't mind 600, but having error counters world-readable is consistent with
> ext4 (see dir above) and so I suggest to keep 644.
> 

Ok.
 
>> > +	case attr_errors_crc:
>> > +		return snprintf(buf, PAGE_SIZE, "%u\n",
>> > +				sbi->stats->crc_errors);
>>
>> Please use sysfs_emit().
> 
> Ack.
> 
> 
>> > +	if (n == UBIFS_DFS_DIR_LEN) {
>> > +		/* The array size is too small */
>> > +		ret = -EINVAL;
>> > +		goto out_last;
>>
>> Where is c->stats released in case of an error?
> 
> My fault. Will be fixed.
> 
> 
>> > diff --git a/fs/ubifs/sysfs.h b/fs/ubifs/sysfs.h
>> > new file mode 100644
>> > index 000000000000..a10a82585af8
>> > --- /dev/null
>> > +++ b/fs/ubifs/sysfs.h
>>
>> Do we really need a new header file?
>> Usually most run-time stuff of UBIFS is part of ubifs.h.
> 
> I wanted to be consistent with debugfs where fs/ubifs/debug.c comes with its
> own header fs/ubifs/debug.h.

debug.h is not just about debugfs. It is about debugging/developing UBIFS.
That's why it is kind of special.

> 
> I'll send out a new patch once we agree on all changes. To recap:
> 
> - write callbacks: do we remove them? If not, do we keep them as is or do we
>  fine-tine them by letting a non-negative integer set the counter?

I'd go for read-only first.

> - 644 (world-readable) counters to be consistent with ext4?

Ack.

> - keep sysfs.h to be consistent with debugfs?

Please remove sysfs.h.

Thanks,
//richard
