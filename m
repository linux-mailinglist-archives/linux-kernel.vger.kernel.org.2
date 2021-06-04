Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E86E39BC8F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhFDQIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 12:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhFDQIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:08:50 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985C0C061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 09:07:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 35E591F43C2D
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel@collabora.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] Initialize debugfs/ksysfs earlier?
In-Reply-To: <YLojEy3wjq2R8Zsa@kroah.com>
References: <20210603125534.638672-1-adrian.ratiu@collabora.com>
 <YLjVYaVfNGEkqPAQ@kroah.com> <87y2bqwwfz.fsf@collabora.com>
 <YLojEy3wjq2R8Zsa@kroah.com>
Date:   Fri, 04 Jun 2021 19:06:58 +0300
Message-ID: <87tumdwr4t.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Jun 2021, Greg Kroah-Hartman 
<gregkh@linuxfoundation.org> wrote:
> On Thu, Jun 03, 2021 at 11:00:00PM +0300, Adrian Ratiu wrote: 
>> Hi and thank you for the quick response!   On Thu, 03 Jun 2021, 
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote: 
>> > On Thu, Jun 03, 2021 at 03:55:33PM +0300, Adrian Ratiu wrote: 
>> > > Hi Greg & all,  I would like to add a new debugfs file like 
>> > > in the next patch but I'm having a problem with commit 
>> > > 56348560d495 ("debugfs: do not attempt to create a new file 
>> > > before the filesystem is initalized"). 
>> >  You should have had a problem before that commit happened as 
>> > well, right?  
>>  Actually no, it works without problems before commit 
>> 56348560d495 and also works if I revert that commit or move the 
>> debugfs_init() and its dependency ksysfs_init() before the 
>> driver core init. 
> 
> And the file shows up properly?  How can that be?  Is it ok to 
> create a file before the superblock is created in the system? 
> For some reason I thought these were just silently failing and 
> no one noticed.  Maybe we should revisit that commit... 

Yes the file shows up and works properly, but I do not know 
why. My tests run after the system boots to an interactive shell 
and by that time everything is initialized and working.

I thought maybe there were some specific corner-cases you wanted 
to guard against by adding that initialization -ENOENT check, but 
honestly since we're not adding a file earlier in the driver core 
anymore, I'd just leave it as is because the check makes sense in 
general.

Thanks again,
Adrian

>
> thanks,
>
> greg k-h
