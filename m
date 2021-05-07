Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C498376B20
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 22:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhEGU1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 16:27:18 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:37684 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhEGU1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 16:27:17 -0400
Received: by mail-wr1-f41.google.com with SMTP id z6so10462596wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 13:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G5Dj7xf+sVdRQrmQbHMKvBQI4KOrg3DBvLtqt8G7Bcg=;
        b=FgXwfQ8wyuBbflR4zcJjtlzBCvj6HFTARcp8DekdIlVLkN9ovpdklk9j+NR9n/ZcHu
         sCQg95FPXnFQsa92ljUMFkYiSENuaSxoP2V295capT4npbMHe9omTHJlHub1+/qsMW/7
         Bca0wTs4wCz1Y6e+LR52JgwMroJuiIYNMctqH3C01huAmBqRJGct1rELO0xaQ1ybQP0V
         GcTjvJhRPuZMhbk2/9Ai8fDDvHD7YDgs8T16Je2iuF91AxVIGdOFw7lXyfbaZHB1/9ig
         z5En7JCUUTIidkx8CtfEeRX7Mz7N5xmZK0By14CvsHlI7KsNGC/Vp4mFJwdQsIoWQMU3
         DJEQ==
X-Gm-Message-State: AOAM5311WeKf3rdJYmB2vAgRDBDrs6ZdgOdVN4fd7oL9Ut1ruE4n4Lvl
        IS/jdVotpDL7AJ6XWnMNxxA=
X-Google-Smtp-Source: ABdhPJznuHeBi55SYkOi3MFFtmtgE1bb7MfHWenG7VSp9fbCcsC5Rx9QONWy7uDJoihJXl7tzacGFQ==
X-Received: by 2002:adf:f1cf:: with SMTP id z15mr14977362wro.97.1620419176461;
        Fri, 07 May 2021 13:26:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d07b:68ce:2d70:258f? ([2601:647:4802:9070:d07b:68ce:2d70:258f])
        by smtp.gmail.com with ESMTPSA id y21sm14193258wmc.46.2021.05.07.13.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 13:26:15 -0700 (PDT)
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
To:     Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Cc:     "Ewan D. Milne" <emilne@redhat.com>,
        Daniel Wagner <dwagner@suse.de>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
References: <20210301175601.116405-1-dwagner@suse.de>
 <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
 <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
 <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
 <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
 <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
 <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com>
 <756aef10-e693-276f-82ac-514a2832b07f@grimberg.me>
 <492b8393-fc35-f58a-3768-94632a083c93@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3156c563-94a4-4278-3835-b1f56f71869a@grimberg.me>
Date:   Fri, 7 May 2021 13:26:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <492b8393-fc35-f58a-3768-94632a083c93@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> I would also mention, that a crash is not even the scariest issue that
>>>> we can see here, because if the request happened to be reused we are
>>>> in the silent data corruption realm...
>>>
>>> If this does happen, I think we have to come up with some way to
>>> mitigate it. We're not utilizing the full 16 bits of the command_id, so
>>> maybe we can append something like a generation sequence number that can
>>> be checked for validity.
>>
>> That's actually a great idea. scsi needs unique tags so it encodes the
>> hwq in the upper 16 bits giving the actual tag the lower 16 bits which
>> is more than enough for a single queue. We can do the same with
>> a gencnt that will increment in both submission and completion and we
>> can validate against it.
>>
>> This will be useful for all transports, so maintaining it in
>> nvme_req(rq)->genctr and introducing a helper like:
>> rq = nvme_find_tag(tagset, cqe->command_id)
>> That will filter genctr, locate the request.
>>
>> Also:
>> nvme_validate_request_gen(rq, cqe->command_id) that would
>> compare against it.
>>
>>
>> And then a helper to set the command_id like:
>> cmd->common.command_id = nvme_request_command_id(rq)
>> that will both increment the genctr and build a command_id
>> from it.
>>
>> Thoughts?
>>
> 
> Well, that would require a modification to the CQE specification, no?
> fmds was not amused when I proposed that :-(

Why would that require a modification to the CQE? it's just using say
4 msbits of the command_id to a running sequence...
