Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523C4312C3B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 09:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhBHIuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 03:50:19 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18401 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhBHIk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 03:40:28 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6020f8d40000>; Mon, 08 Feb 2021 00:39:48 -0800
Received: from [10.2.50.67] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 8 Feb
 2021 08:39:47 +0000
Subject: Re: [PATCH] mm: cma: support sysfs
To:     Pintu Agarwal <pintu.ping@gmail.com>,
        Minchan Kim <minchan@kernel.org>
CC:     Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Dias <joaodias@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <71c4ce84-8be7-49e2-90bd-348762b320b4@nvidia.com>
 <YBzU5uUbwa+QIwBQ@google.com>
 <34110c61-9826-4cbe-8cd4-76f5e7612dbd@nvidia.com>
 <YBzkjh5nnuNiGb6Q@google.com>
 <f6e41e39-d60b-764d-0af4-8e6977663821@nvidia.com>
 <YB1vIrgI9S/5CDxL@google.com>
 <269689b7-3b6d-55dc-9044-fbf2984089ab@nvidia.com>
 <YB24YXMJOjwokDb5@google.com>
 <CAJuCfpEaQqgsyGtzRvovpuLOELR0iRNvNF0rnih1bq0HQCTuww@mail.gmail.com>
 <cbd30192-6f9f-845c-6b1c-e21ed737781d@nvidia.com>
 <YB3K9rx7E9qMf6Is@google.com>
 <CAOuPNLj9kKFFOS_56KkJ4w3jD51WOZ+d=nubcQQeihpk4B_-Ng@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <06f8d7c5-ba77-363e-344a-8816c5017d3f@nvidia.com>
Date:   Mon, 8 Feb 2021 00:39:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <CAOuPNLj9kKFFOS_56KkJ4w3jD51WOZ+d=nubcQQeihpk4B_-Ng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612773588; bh=pjWWiYIgvZ4zvrt3wVUeVX1ZIwdnAzVgsTlJnj3ko0I=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=aBJhc2TJZBD8f19Gx4rn+hDyVHQqY6v1Fqw/Wx32sQLGyS6DniKIp/ohCnB4Yeuzh
         3K6UGB+V7v3LNGlgFgwGCUWeVpZYZJTO0GO0pNDIQEQUvcxli5DbxR3NXqAdG2qK5Q
         8nBChUOckll1fI4BUvoYLwEHJ8kK2XtdDsjrI797SLkNKzBH5iULIkEnIpsxxH8q0J
         eQw2egyAsojWUNIWratlhW+tYLV0zJZ3fBH5geVqXyAX8xHMn8Hvj0XeabZ+3QSeoE
         sOmZP8xIvaS0QUTFoXX9XAjiXi4b29CP6sx8hBGBX+hXNLnj0X85RxrrJ8MNfcm60N
         F14yC4rCD0R7w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/21 9:08 AM, Pintu Agarwal wrote:
...
>> # cat meminfo | grep -i cma
>> CmaTotal:        1048576 kB
>> CmaFree:         1046872 kB
> 
> This CMA info was added by me way back in 2014.
> At that time I even thought about adding this cma alloc/fail counter in vmstat.
> That time I also had an internal patch about it but later dropped
> (never released to mainline).
> If required I can re-work again on this part.
> 
> And I have few more points to add here.
> 1) In the past I have faced this cma allocation failure (which could
> be common in small embedded devices).
> Earlier it was even difficult to figure if cma failure actually happened.
> Thus I added this simple patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.11-rc6&id=5984af1082f3b115082178ed88c47033d43b924d
> 
> 2) IMO just reporting CMA alloc/fail may not be enough (at times). The
> main point is for which client/dev is this failure happening ?
> Sometimes just tuning the size or fixing the alignment can resolve the
> failure if we know the client. For global CMA it will be just NULL
> (dev).
> 
> 3) IMO having 2 options SYSFS and DEBUGFS may confuse the
> developer/user (personal experience). So are we going to remove the
> DEBUGFS or merge it ?
> 

It is confusing to have a whole bunch of different places to find data
about a system. Here, I think the key is to add to the Documentation/
directory. So far, the documentation I see is:

     admin-guide/mm/cma_debugfs.rst: only covers debugfs
     admin-guide/kernel-parameters.txt:602: for CMA kernel parameters

If we add sysfs items then we will want a new .rst document that covers
that, and lists all the places to look.

So anyway, the underlying guidelines for which fs to user are approximately:

* sysfs: used for monitoring. One value per item, stable ABI, production.

* debugfs: *theoretically* not a stable ABI (we hope no one locks us in
by doing obnoxious things that break userspace if the debugfs APIs change).
The intention is that developers can put *anything* in there.

debugfs has a firm place in debugging, and is probably a keeper here.

I originally thought we should combine CMA's sysfs and debugfs items,
but Minchan listed an example that seems to show a pretty clear need
for monitoring of CMA areas, in production systems, and that's what
sysfs is for.

So it looks like we want both debugfs and sysfs for CMA, plus a new
overall CMA documentation that points to everything.

> 4) Sometimes CMA (or DMA) allocation failure can happen even very
> early in boot time itself. At that time these are anyways not useful.
> Some system may not proceed if CMA/DMA allocation is failing (again
> personal experience).
> ==> Anyways this is altogether is different case...
> 
> 5) The default max CMA areas are defined to be 7 but user can
> configure it to any number, may be 20 or 50 (???)
> 
> 6) Thus I would like to propose another thing here.
> Just like we have /proc/vmallocinfo, /proc/slabinfo, etc., we can also
> have: /proc/cmainfo
> Here in /proc/cmaminfo we can capute more detailed information:
> Global CMA Data: Alloc/Free
> Client specific data: name, size, success, fail, flags, align, etc
> (just a random example).
> ==> This can dynamically grow as large as possible
> ==> It can also be enabled/disabled based on CMA config itself (no
> additional config required)
> 
> Any feedback on point (6) specifically ?
> 

Well, /proc these days is for process-specific items. And CMA areas are
system-wide. So that's an argument against it. However...if there is any
process-specific CMA allocation info to report, then /proc is just the
right place for it.


thanks,
-- 
John Hubbard
NVIDIA
