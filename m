Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556383E9A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 23:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbhHKVhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 17:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhHKVhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 17:37:36 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0674FC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 14:37:12 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id m18so7029020ljo.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 14:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jlhPvL1pTZas78T3qv8b+qHoylDGSRdqzrlJr+n3/Y0=;
        b=nAa5reK/4eNwWG8JZGY+tuJ86dVHO2ir+xCPAWj/cAFS/EzHS1qrtEoMRVVP/iicCW
         28lsI1DPW2rmperEEhF0KNJmNwroa4mlKLcA1PNlWkOI3g4hpwx/7/66BpoRMc0yJVaw
         B/uHxCGO/7T+sNLrNBtiCgDUC/W5Nsp7pifc3xnH8sk2WPMSpHZIy8RW1GMyJw1ar4ib
         VYDmgkx4YWsLh8vOI0rSkS1+5nYxGK9Azqtuhyyil30yEwe2RC6bcXvlZoyC+WfCQj6L
         vQ5D6oJDvLYOncwrYM1aM7npFdff1MDzWpU2sbAtl8tUCyN98rjHgDERDm7A6lQ74Nd2
         LDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jlhPvL1pTZas78T3qv8b+qHoylDGSRdqzrlJr+n3/Y0=;
        b=HVCODq1TIaWgk684zQq+NzNkWfuuxfkQFJax9gg/6evLuwtl7S6lJvlqtQ+qI9T9i1
         0kbhFzqGM8PGnK5RhrbBTAsfpMNU8e8dfz6+jE6KyYtU1JYD59deBKTIsLmKdTfwW3Ec
         kO/xAobPrC0NbKwgwk3K/BuevL2hKYYz03DYvbZ3mHnpEWtWn7DwOkl92mOPNjNUN9sA
         48fIXy9Iw6KyQWWZe9S8Lil/ZR6wcgWrDu+ElAs48mH5eZfKbWJDME0PCEnwKjIVXYuk
         8WWhpdDjBjfmsyJOJqvooxhxT8XtDcybwc0G4otuFK+lyByA5FNAQJeeA5OKkdV6NezB
         frXg==
X-Gm-Message-State: AOAM533/uwPhUvY3NPmnPyvN8JftMjevGF2HSgYljzwPtXXj4v9FyMct
        UlN/r/bkPkIblWF+kF1aPrk=
X-Google-Smtp-Source: ABdhPJwjTvsoB04hsfViN8oOIcpSAKFaMhVtU5OnzD69Rjw+2toBNHvo6OPpDHFpbExgdtqRpZzngg==
X-Received: by 2002:a2e:9593:: with SMTP id w19mr503895ljh.323.1628717830296;
        Wed, 11 Aug 2021 14:37:10 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.232])
        by smtp.gmail.com with ESMTPSA id p5sm53044lfs.99.2021.08.11.14.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 14:37:09 -0700 (PDT)
Subject: Re: [syzbot] WARNING in internal_create_group
To:     Christoph Hellwig <hch@lst.de>, Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+9937dc42271cd87d4b98@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Eric Sandeen <sandeen@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <000000000000bd7c8a05c719ecf2@google.com>
 <20210721033703.949-1-hdanton@sina.com> <20210721043034.GB7444@lst.de>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <39ac87a8-42ac-acf7-11eb-ba0b6a9f4a95@gmail.com>
Date:   Thu, 12 Aug 2021 00:37:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210721043034.GB7444@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/21 7:30 AM, Christoph Hellwig wrote:
> On Wed, Jul 21, 2021 at 11:37:03AM +0800, Hillf Danton wrote:
>> On Tue, 20 Jul 2021 11:53:27 -0700
>> >syzbot has found a reproducer for the following issue on:
>> >
>> >HEAD commit:    8cae8cd89f05 seq_file: disallow extremely large seq buffer..
>> >git tree:       upstream
>> >console output: https://syzkaller.appspot.com/x/log.txt?x=116f92ec300000
>> >kernel config:  https://syzkaller.appspot.com/x/.config?x=7273c75708b55890
>> >dashboard link: https://syzkaller.appspot.com/bug?extid=9937dc42271cd87d4b98
>> >syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fc287c300000
>> >C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178cbf6a300000
> 
> <snip>
> 
>> >WARNING: CPU: 0 PID: 8435 at fs/sysfs/group.c:116 internal_create_group+0x911/0xb20 fs/sysfs/group.c:116
> 
> <snip>
> 
>> The device_add(ddev) in register_disk() may fail but it proceeds to register
>> block queue even at the failure ... this falls in the class of known issue
>> given the comment line.
>> 
>>  * FIXME: error handling
>>  */
>> static void __device_add_disk(struct device *parent, struct gendisk *disk,
> 
> Yes, Luis is working on actually fixing this - but it requires changes
> to every single block driver.  How does a cap on the seq_buf size
> propagate here, though?
> 

Hi!

I've looked into this, and, I think, we can add sanity check for 
first_minor. If user will pass too big index (syzbot's repro passes 
1048576) this value will be shifted to part_shift and then truncated to 
byte in __device_add_disk() and assigned to dev->devt. User may be 
confused about why he passed 1048576, but sysfs warns about duplicate 
creation of /dev/block/43:0

So, these type of errors can be handled before passing wrong values to 
sysfs API like this:

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index c38317979f74..600e9bab5d43 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1725,7 +1725,17 @@ static int nbd_dev_add(int index)
  	refcount_set(&nbd->refs, 1);
  	INIT_LIST_HEAD(&nbd->list);
  	disk->major = NBD_MAJOR;
+
+	/* Too big first_minor can cause duplicate creation of
+	 * sysfs files/links, since first_minor will be truncated to
+	 * byte in __device_add_disk().
+	 */
  	disk->first_minor = index << part_shift;
+	if (disk->first_minor > 0xff) {
+		err = -EINVAL;
+		goto out_free_idr;
+	}
+
  	disk->minors = 1 << part_shift;
  	disk->fops = &nbd_fops;
  	disk->private_data = nbd;


What to do you think about it?


With regards,
Pavel Skripkin
