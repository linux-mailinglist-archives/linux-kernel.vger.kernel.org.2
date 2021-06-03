Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E99439AB31
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 22:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhFCUBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 16:01:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52746 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCUBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 16:01:50 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 155A81F434F7
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel@collabora.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] Initialize debugfs/ksysfs earlier?
In-Reply-To: <YLjVYaVfNGEkqPAQ@kroah.com>
References: <20210603125534.638672-1-adrian.ratiu@collabora.com>
 <YLjVYaVfNGEkqPAQ@kroah.com>
Date:   Thu, 03 Jun 2021 23:00:00 +0300
Message-ID: <87y2bqwwfz.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi and thank you for the quick response!

On Thu, 03 Jun 2021, Greg Kroah-Hartman 
<gregkh@linuxfoundation.org> wrote:
> On Thu, Jun 03, 2021 at 03:55:33PM +0300, Adrian Ratiu wrote: 
>> Hi Greg & all,  I would like to add a new debugfs file like in 
>> the next patch but I'm having a problem with commit 
>> 56348560d495 ("debugfs: do not attempt to create a new file 
>> before the filesystem is initalized"). 
> 
> You should have had a problem before that commit happened as 
> well, right? 
>

Actually no, it works without problems before commit 56348560d495 
and also works if I revert that commit or move the debugfs_init() 
and its dependency ksysfs_init() before the driver core init.

All these 3 cases work without issues while testing, but none of 
them seem to be viable ideas and especially moving debugfs init 
earlier just to add this new attr file to the driver core is some 
thin reasoning, so that's why I asked via this RFC. :)
 
>>  The problem is debugfs is initialized after the driver core, 
>> during the core initcall, so I get an -ENOENT failure due to 
>> the above commit.   My first reaction is to move the 
>> ksysfs_init() and debugfs_init() calls before the driver core 
>> init which works. Would that be ok?   An alternative would be 
>> to create the new debugfs file somewhere else than the driver 
>> core, but I'm not sure where would be a good location, maybe in 
>> debugfs_init()? Doesn't seem right. 
> 
> I don't really want the driver core to be messing with debugfs 
> at all, why is that needed?  I'll respond on your patch...

KernelCI maintainers asked me to add some tests for driver probe() 
results similar to how the -EPROBE_DEFER is tested via the 
existing  debugfs devices_deferred and at the same time to add a 
new debugfs interface similar to devices_deferred to avoid parsing 
the printk buffer for non-EPROBE_DEFER results.

If you think adding such an interface is a bad idea, please just 
tell me so and I will use it as amunition to push back and get the 
info from printk. :) 

>
> thanks,
>
> greg k-h
