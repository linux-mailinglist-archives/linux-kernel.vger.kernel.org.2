Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746453D6900
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 23:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhGZVL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 17:11:59 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:34420 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbhGZVLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 17:11:54 -0400
Received: by mail-pl1-f181.google.com with SMTP id d1so6078369pll.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 14:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J0YK4Y3cWlHfKVhgQwxQc7f0nm0USIOuPPvy4joujts=;
        b=HGUCf1vn2sPR4W7jA5BwXqguoAJOY0mQrlNoJRAtyMy+p/xVQg67AdKCuMsvCNLmmf
         hfijOi17efOa/LwOZtBOzb7e88xtiyvgZIT5BpGXjmfvRUe31AMn0I4b44LxpbsuCOxb
         LMUKh9P2HcfV/zSV+j+QjDjtV7iLR8iMXQIWoefgYc54+7sPZqr2Z3JAeHVeSOPrY/xN
         kpu7smoT3+5v9Awir7A/+2iPv8bol9eSTr+evbZF2DyFXZ6lykkxmJFQbwG6mY4ZvyJg
         Nc09APwnBJp7cYf29sFdRcr3pGs2KDsCrKF9WmPh+iA/ADv360yQ96wYm4HAg5YXGBTP
         39eQ==
X-Gm-Message-State: AOAM5320+04PN55+zrWi6JaqX4UjoLWJGkyIH482Ih3uojEXHEWk2U14
        8HlUx6osSVd9B8OvZV7O7Wc=
X-Google-Smtp-Source: ABdhPJzPlScepa+9HlcT7xYaL51XosgMAy0kuR0+u06S7/BaR/IUXgvYRBwGonVS6tEKVQ3j49zqpg==
X-Received: by 2002:a62:a507:0:b029:30d:82e1:ce14 with SMTP id v7-20020a62a5070000b029030d82e1ce14mr19880298pfm.29.1627336341704;
        Mon, 26 Jul 2021 14:52:21 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:6048:349e:fe7d:d8c7])
        by smtp.gmail.com with ESMTPSA id 22sm1037562pfo.80.2021.07.26.14.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 14:52:21 -0700 (PDT)
Subject: Re: [PATCH 2/4] configfs: Fix writing at a non-zero offset
To:     Bodo Stroesser <bostroesser@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Yanko Kaneti <yaneti@declera.com>,
        Brendan Higgins <brendanhiggins@google.com>
References: <20210723212353.896343-1-bvanassche@acm.org>
 <20210723212353.896343-3-bvanassche@acm.org>
 <7bee65ce-f5f1-a525-c72d-221b5d23cf3e@gmail.com>
 <d12f24b6-7066-f9bb-1b88-6cc23c9c45c1@acm.org>
 <4055ca70-7669-d00d-7c08-86fe75a3d377@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <618b2bdc-282b-0a1d-1fc5-020cf80d7a7e@acm.org>
Date:   Mon, 26 Jul 2021 14:52:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4055ca70-7669-d00d-7c08-86fe75a3d377@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/21 2:13 PM, Bodo Stroesser wrote:
> On 26.07.21 18:26, Bart Van Assche wrote:
>> On 7/26/21 7:58 AM, Bodo Stroesser wrote:
>>> On 23.07.21 23:23, Bart Van Assche wrote:
>>> Let's say user writes 5 times to configfs file while keeping it open.
>>> On every write() call it writes 1 character only, e.g. first "A", 
>>> then "B", ...
>>>
>>> The original code before the changes 5 times called 
>>> flush_write_buffer for the
>>> strings "A\0", "B\0", ... (with the '\0' not included in the count 
>>> parameter,
>>> so count is 1 always, which is the length of the last write).
>>
>> Isn't that behavior a severe violation of how POSIX specifies that the 
>> write() system call should be implemented?
> 
> Hmm. I'm not sure which detail should violate POSIX spec? Is there any
> definition how data should be flushed from buffer internally? (I'm by
> far not a POSIX expert!)
> 
> I would rather say the new behavior, to call flush_write_buffer during the
> first write() for the data of that write, and then on the second write to
> call flush_write_buffer for the concatenated data of the first and the
> second write, could be a violation of POSIX, because the one times written
> data of the first write is flushed twice.
> 
> I don't like the idea of breaking the "one write, one flush" principle that
> was implemented before. The old comment:
> "There is no easy way for us to know if userspace is only doing a partial
> write, so we don't support them. We expect the entire buffer to come on the
> first write."
> as I interpret it, makes clear that configfs code has to work according to
> that principle. (Or even block all but the first write, but that would even
> more break compatibility to old implementation.)

Hi Bodo,

The private email that you sent me made it clear that you would like to 
keep the behavior from kernel 5.13. That means passing "A\0", "B\0", ... 
to the configfs store callback function if "AB..." is witten one byte at 
a time. What is not clear to me is how a store callback with argument 
"B\0" can know at which offset that write happened? From 
<linux/configfs.h> (I have added argument names):

	ssize_t (*store)(struct config_item *item, const char *page,
                          size_t count);

My understanding of the POSIX specification [1] is that writes should 
happen at the proper offset. If user space software writes "A" at offset 
0 and "B" at offset 1 then the string "AB" should be passed to the 
configfs store callback.

Regarding the "action" attribute from your tcmu patch, how about 
checking the last character of the string written into that attribute 
instead of the first character? Would that be sufficient to write twice 
into that attribute without having to call close() and open() between 
the two write actions?

To me the following comment: "There is no easy way for us to know if 
userspace is only doing a partial write, so we don't support them. We 
expect the entire buffer to come on the first write." means that writing 
"ABCD" by first writing "AB" and next "CD" will trigger two 
item->store() calls. Triggering a single item->store() call for partial 
writes is not supported.

Thanks,

Bart.

[1] https://pubs.opengroup.org/onlinepubs/9699919799/
