Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADD5408515
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 09:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbhIMHFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 03:05:10 -0400
Received: from linux.microsoft.com ([13.77.154.182]:32958 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237492AbhIMHFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 03:05:09 -0400
Received: from [192.168.1.87] (unknown [223.184.74.135])
        by linux.microsoft.com (Postfix) with ESMTPSA id A817120B713A;
        Mon, 13 Sep 2021 00:03:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A817120B713A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1631516634;
        bh=oXUTh+VKtreR97Vl7n/nyzvuA6UQzHaEaikohl+yWtk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NQyfVnOQqcKtcvA4uC2JlSAWZB9hx351ivJX5BvOG6Xd3oA/3Pp20BkZ3v9Nu0whv
         NT5qReB1X+niABOU7qQ25ajY9RDiTn+PR9gTVLEFvcqKs+DViyoYLpNKunoZeiXAHD
         KrgBryp+5URNYe9xFboyBsi2mAF/pzqcZ1TMZ4sw=
Subject: Re: [PATCH] blk-mq: export blk_mq_submit_bio symbol
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        schakrabarti@linux.microsoft.com, lalita.muppana@microsoft.com
References: <20210909053653.144360-1-kumarpraveen@linux.microsoft.com>
 <7e80b65b-51a4-3ca1-da43-e87612b8ca5f@nvidia.com>
 <f7add831-ecf0-6599-158b-cd2f15543da5@linux.microsoft.com>
 <YT7rL4PhovDOHfHO@infradead.org>
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
Message-ID: <75f77917-a8ba-0138-750b-8dedd8f7ce7d@linux.microsoft.com>
Date:   Mon, 13 Sep 2021 12:33:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YT7rL4PhovDOHfHO@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-09-2021 11:39, Christoph Hellwig wrote:
> On Mon, Sep 13, 2021 at 09:54:54AM +0530, Praveen Kumar wrote:
>>>> +EXPORT_SYMBOL_GPL(blk_mq_submit_bio);
>>>>
>>>
>>> Where is the code that used this API ?
>>>
>>
>> Thanks Chaitanya for your response. Please check my response to Christoph.
>> That should give overall understanding of the use-case.
> 
> Which really doesn't matter, while you keep ingoring the relevant
> question.  If you code is not upstream or at least actively being
> submitted upstream your questions have no relevance whatsoever.
> If you do not undertand that basic fact your are in the wrong place
> here.
> 

Hi Christoph,

The upstream activity is being planned and will take sometime to reach to
that state as we have to make it ready for latest kernel.

To achieve the same, we were finding some solutions to handle latest changes.
If you have scanned my previous email where I have provided a detail what the driver
is doing, I did mention that we plan to use "blk_mq_submit_bio" but failed to do
so, as code is not exported. So, to the specific answer, this API is NOT being
used anywhere as of now.

However, as you mentioned, the API cannot be exported for any specific driver,
is there any solution or way if a custom driver wants to hook the existing bio path
and massage it and then fall back to original flow ?

Regards,

~Praveen.
