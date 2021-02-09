Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF853145EE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 02:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhBIB6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 20:58:02 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13458 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhBIB6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:58:00 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6021ebfe0000>; Mon, 08 Feb 2021 17:57:18 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 01:57:17 +0000
Received: from [10.2.50.67] (172.20.145.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb 2021
 01:57:17 +0000
Subject: Re: [PATCH v2] mm: cma: support sysfs
To:     Minchan Kim <minchan@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <surenb@google.com>,
        <joaodias@google.com>, <willy@infradead.org>
References: <20210208180142.2765456-1-minchan@kernel.org>
 <e01c111b-fb20-0586-c7a9-dd6d922c0e57@nvidia.com>
 <YCHLAdabGmm7kqSH@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <43cd6fc4-5bc5-50ec-0252-ffe09afd68ea@nvidia.com>
Date:   Mon, 8 Feb 2021 17:57:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <YCHLAdabGmm7kqSH@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612835838; bh=TmWlGqblZEYg2VnL9TBzJ93nhtvBxMB2q5NR8/muxgA=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=GZC4fYWY5zvT4CvBDxJ5FY2X4iw19zYC8Ozp7ueA+gPrXS+vSrfPeM/t25SmazXcJ
         x0G7V6p3vzgqWBH5o1mMV6jdmNVRoCK7yJn5VXw3G013mQRWmPRRbu2nXSfOF5NF+n
         RSm5pHL5tq3mZuUTT4uNGdDcPuKG72KoXLxwVcf7semCBcD9YihYBvxP0EjmwzHFmF
         ZB1Hau+nD+4kDG0UVgNwh92D4p+RCv878y+05YzQBjwU0VD3WIkj468IzBf/h6q1Mq
         +cBVLpYuZCFzU1t4wxWcVETMTUCkYMe5wioHvUTtyQlsgSUFJdyahErGmBXz16742/
         rNxBwZ5d/jSdA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/21 3:36 PM, Minchan Kim wrote:
...
>>>    	char name[CMA_MAX_NAME];
>>> +#ifdef CONFIG_CMA_SYSFS
>>> +	struct cma_stat	*stat;
>>
>> This should not be a pointer. By making it a pointer, you've added a bunch of pointless
>> extra code to the implementation.
> 
> Originally, I went with the object lifetime with struct cma as you
> suggested to make code simple. However, Greg KH wanted to have
> release for kobj_type since it is consistent with other kboject
> handling.

Are you talking about the kobj in your new struct cma_stat? That seems
like circular logic if so. I'm guessing Greg just wanted kobj methods
to be used *if* you are dealing with kobjects. That's a narrower point.

I can't imagine that he would have insisted on having additional
allocations just so that kobj freeing methods could be used. :)


thanks,
-- 
John Hubbard
NVIDIA
