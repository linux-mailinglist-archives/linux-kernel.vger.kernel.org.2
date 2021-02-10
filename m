Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C68E316064
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 08:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbhBJHwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 02:52:41 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18963 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbhBJHv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 02:51:27 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B602390540000>; Tue, 09 Feb 2021 23:50:44 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Feb
 2021 07:50:44 +0000
Received: from [10.2.50.67] (172.20.145.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Feb
 2021 07:50:44 +0000
Subject: Re: [PATCH v2] mm: cma: support sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, <surenb@google.com>,
        <joaodias@google.com>, <willy@infradead.org>
References: <7cc229f4-609c-71dd-9361-063ef1bf7c73@nvidia.com>
 <cd33f8b9-89e0-05bd-2b16-85855f7541bb@nvidia.com>
 <YCIyHuOX3E+tP+AO@kroah.com> <YCKwjz0uDPBhbFr5@google.com>
 <YCLLKDEQ4NYqb5Y5@kroah.com>
 <09e60732-6a46-dd00-f9d5-4ef17ee685c8@nvidia.com>
 <YCL67QzPiyRhhbor@google.com> <YCOAmXqt6dZkCQYs@kroah.com>
 <YCOHRAAijtCbN+pr@google.com>
 <e7ea55b9-a5f6-0daf-843b-e25d8c70e980@nvidia.com>
 <YCOKpM9lufhD/myy@kroah.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <2abc0258-d71a-56f2-3682-cc178f3ce4c4@nvidia.com>
Date:   Tue, 9 Feb 2021 23:50:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <YCOKpM9lufhD/myy@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612943444; bh=iNqKH1Wegy4bMKSeTt/OdLSXygaDObEBfKoj2FFuyeQ=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=TG95RuDP7QHPJKOOXQN8PEWJs/F8BoQ7P41GOaT3m7QGHMVwNv7RHUzeQg6U7vWlN
         SIEDB66Amt+58PB1nQNhsztX+MSYfK87kPEr1R2VnFSDB/eq7u+wkCHuLw+lMkGFR2
         RbFY4APtQWV0HZV7A9kUH8TQ59VF7ePzOzVYRAN2zKoKZEyNbJkpwktrbn6xydK4RM
         wf07embo/TouTNkxvpxH71LbyPQMAldhVi88rbCVZgTgf3siqrl5YCo0bA5JsPse22
         u7dJvh2luPxgiSUKxn5THcgi10yUf3vPnwYVwryEEjnWoh9F4sHr96GIVQ5JvH+1j1
         xqgNzglWUw7Dw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/21 11:26 PM, Greg KH wrote:
...
>> I just am not especially happy about the inability to do natural, efficient
>> things here, such as use a statically allocated set of things with sysfs. And
>> I remain convinced that the above is not "improper"; it's a reasonable
>> step, given the limitations of the current sysfs design. I just wanted to say
>> that out loud, as my proposal sinks to the bottom of the trench here. haha :)
> 
> What is "odd" is that you are creating an object in the kernel that you
> _never_ free.  That's not normal at all in the kernel, and so, your wish
> to have a kobject that you never free represent this object also is not
> normal :)
> 

OK, thanks for taking the time to explain that, much appreciated!


thanks,
-- 
John Hubbard
NVIDIA
