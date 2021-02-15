Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E6A31C397
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 22:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhBOVak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 16:30:40 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:45867 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhBOVac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 16:30:32 -0500
Received: by mail-wr1-f42.google.com with SMTP id v7so10696402wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 13:30:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s+MKjbp2tjims7Jwguvyk6qEwa7KWs9qt/eX8yJuFUE=;
        b=ZSOS2NemZMqK+M8G72ADkXCW/4E7keqsLjN+CDUezcEw+vOOUQRjQyP8KmXa69C49R
         buOKbMOiYky0eRebAOK5VCYrMABBA0u7jizL4rBdJzEFwBERaxGMdo0TNjTIXgoNpN7f
         r6CmaT8khKnBVhXbv7a0SKFQX3qR9TVgKgZxMdrXrREpTfJJNJlkeHqo4KaIAlAv5RVj
         RjLpvIS+ZpOGyaBA5ScWTcEP+0B1XUwxJ9QWR/FhNLcK3MqW0S9LX57NrAP1zX/VEVnj
         xxRDKXOjPLKaygS0JzfMYKpWhhT/ucCMYeiHUl/SjpRkpRzDUGPL+lNuvMFLePuAhRgV
         P5FA==
X-Gm-Message-State: AOAM531FVcumLswM6VkWtgi4b6X1q7is4O8IbeuiKp2VtlJaLUilA5WW
        OffPSuU9CM+2c1VgaUBzGo9z7u5Ak2E=
X-Google-Smtp-Source: ABdhPJw81FppzKL8jTGA+041elKQYqU7nKWWWBkvJlCJ0s088DeXwoU+R0hK9cwl1gnpxfN6zAbrRQ==
X-Received: by 2002:a5d:4e41:: with SMTP id r1mr16045804wrt.6.1613424589846;
        Mon, 15 Feb 2021 13:29:49 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e348:9c6c:4cb7:8321? ([2601:647:4802:9070:e348:9c6c:4cb7:8321])
        by smtp.gmail.com with ESMTPSA id j71sm615134wmj.31.2021.02.15.13.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Feb 2021 13:29:49 -0800 (PST)
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
To:     Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210212181738.79274-1-dwagner@suse.de>
 <c3a682d3-58f7-f5cc-caaa-75c36ca464e2@grimberg.me>
 <20210212210929.GA3851@redsun51.ssa.fujisawa.hgst.com>
 <ddf87227-1ad3-b8be-23ba-460433f70a85@grimberg.me>
 <73e4914e-f867-c899-954d-4b61ae2b4c33@suse.de>
 <20210215104020.yyithlo2hkxqvguj@beryllium.lan>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a2064070-b511-ba6d-bd64-0b3abc208356@grimberg.me>
Date:   Mon, 15 Feb 2021 13:29:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210215104020.yyithlo2hkxqvguj@beryllium.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>>> blk_mq_tag_to_rq() will always return a request if the command_id is
>>>>>> in the valid range. Check if the request has been started. If we
>>>>>> blindly process the request we might double complete a request which
>>>>>> can be fatal.
>>>>>
>>>>> How did you get to this one? did the controller send a completion for
>>>>> a completed/bogus request?
>>>>
>>>> If that is the case, then that must mean it's possible the driver could
>>>> have started the command id just before the bogus completion check. Data
>>>> iorruption, right?
> 
> 'during TCP LIF toggles and aggr relocates' testing the host
> crashes. TBH, I do not really know what is happening or what the test
> does. Still trying to figure out what's going on.

Well, I think we should probably figure out why that is happening first.

> I was just very
> surprised how much the code trusts the other side to behave correctly./

What does pci/rdma/fc does differently? What does scsi do here?

>>> Yes, which is why I don't think this check is very useful..
>>
>> I actually view that as a valid protection against spoofed frames.
>> Without it it's easy to crash the machine by injecting fake completions with
>> random command ids.
> 
> In this test scenario it's not even a spoofed frame; maybe just a
> confused controller.

Maybe... I am still not sure how this patch helps here though...
