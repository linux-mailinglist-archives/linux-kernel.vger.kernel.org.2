Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44833315AC0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbhBJAK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:10:57 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11828 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbhBIUkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:40:05 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6022ec690000>; Tue, 09 Feb 2021 12:11:21 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 20:11:21 +0000
Received: from [10.2.50.67] (172.20.145.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb 2021
 20:11:21 +0000
Subject: Re: [PATCH v2] mm: cma: support sysfs
To:     Greg KH <gregkh@linuxfoundation.org>,
        Minchan Kim <minchan@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, <surenb@google.com>,
        <joaodias@google.com>, <willy@infradead.org>
References: <20210208180142.2765456-1-minchan@kernel.org>
 <e01c111b-fb20-0586-c7a9-dd6d922c0e57@nvidia.com>
 <YCHLAdabGmm7kqSH@google.com>
 <43cd6fc4-5bc5-50ec-0252-ffe09afd68ea@nvidia.com>
 <YCIoHBGELFWAyfMi@kroah.com>
 <7cc229f4-609c-71dd-9361-063ef1bf7c73@nvidia.com>
 <cd33f8b9-89e0-05bd-2b16-85855f7541bb@nvidia.com>
 <YCIyHuOX3E+tP+AO@kroah.com> <YCKwjz0uDPBhbFr5@google.com>
 <YCLLKDEQ4NYqb5Y5@kroah.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <09e60732-6a46-dd00-f9d5-4ef17ee685c8@nvidia.com>
Date:   Tue, 9 Feb 2021 12:11:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <YCLLKDEQ4NYqb5Y5@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612901481; bh=2AO1RfSdot2l4/kEHEEeNwPcUFdS4l5FvkUJO30yA5w=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=eX8YLtu+rXVa6V/RAb+Nce5VU6xVaHO0SVuW0vo8cmNnZnwOwWv9Krx45hYgXWVRw
         cK+9crYqCJAjfvjRw6rVrWc95c4rbA9p5jP0JnkM8O9HT2JTpe+MNOEJPdUS/lfVok
         golIF49EEy587Dxoy2I3sf9XPh16r7foNdNox2b8PWbngG9VpMXrrbFf0P1WGJaGbX
         ZXFwHLRkximsTmFiaW2MAV8ZIsShk5frVKh3YsT1YSD65vEI+c6vV0GQxvxhHascBy
         bXfiEctIjVp3IKYcMioWq5q8Uiw9cQAaSYklHJ+405rp3X8WRFpgv7udteoQB32Ww0
         3aGF2CVtpk75A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/21 9:49 AM, Greg KH wrote:
>>> That's fine if you want to add it to the parent.  If so, then the
>>> kobject controls the lifetime of the structure, nothing else can.
>>
>> The problem was parent object(i.e., struct cma cma_areas) is
>> static arrary so kobj->release function will be NULL or just
>> dummy. Is it okay? I thought it was one of the what you wanted
>> to avoid it.
> 
> No, that is not ok.
> 
>>> Either is fine with me, what is "forbidden" is having a kobject and
>>> somehow thinking that it does not control the lifetime of the structure.
>>
>> Since parent object is static arrary, there is no need to control the
>> lifetime so I am curious if parent object approach is okay from kobject
>> handling point of view.
> 
> So the array is _NEVER_ freed?  If not, fine, don't provide a release
> function for the kobject, but ick, just make a dynamic kobject I don't
> see the problem for something so tiny and not very many...
> 

Yeah, I wasn't trying to generate so much discussion, I initially thought it
would be a minor comment: "just use an embedded struct and avoid some extra
code", at first.

> I worry that any static kobject might be copied/pasted as someone might
> think this is an ok thing to do.  And it's not an ok thing to do.
> 

Overall, then, we're seeing that there is a small design hole: in order
to use sysfs most naturally, you either much provide a dynamically allocated
item for it, or you must use the static kobject, and the second one sets a
bad example.

I think we should just use a static kobject, with a cautionary comment to
would-be copy-pasters, that explains the design constraints above. That way,
we still get a nice, less-code implementation, a safe design, and it only
really costs us a single carefully written comment.

thanks,
-- 
John Hubbard
NVIDIA
