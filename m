Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9733E8778
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 03:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbhHKBBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 21:01:03 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:38809 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbhHKBBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 21:01:03 -0400
Received: by mail-pj1-f53.google.com with SMTP id lw7-20020a17090b1807b029017881cc80b7so6994919pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 18:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c6CO0pA6pVLFZ/vFVu8X+97qV7Slk2RpoxD9Zf89GuU=;
        b=VM80iuxQ2cI/RpAlFM4ueRd1GrPyAOYEiLdvgivKFe/ZGTTYx4+doMswhszVBlq6h2
         5QlPB/iJimBV5lIfYQ16cuNfLYhTTFpCAdXZrAcQlCwUApgVBHQTNKbGwpoTmHK/GZ3I
         jb5xpjS4mw6pwIhLYXCvu4f1mjT2aDsRFV/252dmxb/X/aljyJEU5EtGQxzghjY9PiFm
         UNeGhN8herOg3kYE0Sr6st6MxP637M5EAmlZxuFqIsXFEs1YmnRtV1XYlw3/ep0yO2pH
         Ah8qgMJ/xvgrlyciGQ0wu5SaPZ+aHhSsPoka9WWC/mLgQAebiuy0/SXRfFb6vYWv7+i1
         FgPw==
X-Gm-Message-State: AOAM531OjsWCF39WsCLQxx2drChSGggLeLkJKIxXyxxpukKkG9Dw1igz
        KGSnF3SjTYSblLZrJEgmJ1g=
X-Google-Smtp-Source: ABdhPJxFM5vHQM4W76wTi3b9DPvuMjuqvtkdWYYDU8gJzO4fUKIw/K01uqYv+0HNgfRX4ANvnaKK1w==
X-Received: by 2002:a17:90b:215:: with SMTP id fy21mr33666018pjb.203.1628643640011;
        Tue, 10 Aug 2021 18:00:40 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:61e5:4b9f:b48a:e987? ([2601:647:4802:9070:61e5:4b9f:b48a:e987])
        by smtp.gmail.com with ESMTPSA id y67sm25244197pfg.218.2021.08.10.18.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 18:00:39 -0700 (PDT)
Subject: Re: [PATCH v4 2/8] nvme-tcp: Update number of hardware queues before
 using them
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-3-dwagner@suse.de>
 <8373c07f-f5df-1ec6-9fda-d0262fc1b377@grimberg.me>
 <20210809085250.xguvx5qiv2gxcoqk@carbon>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <01d7878c-e396-1d6b-c383-8739ca0b3d11@grimberg.me>
Date:   Tue, 10 Aug 2021 18:00:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210809085250.xguvx5qiv2gxcoqk@carbon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/9/21 1:52 AM, Daniel Wagner wrote:
> Hi Sagi,
> 
> On Fri, Aug 06, 2021 at 12:57:17PM -0700, Sagi Grimberg wrote:
>>> -	ret = nvme_tcp_start_io_queues(ctrl);
>>> -	if (ret)
>>> -		goto out_cleanup_connect_q;
>>> -
>>> -	if (!new) {
>>> -		nvme_start_queues(ctrl);
>>> +	} else if (prior_q_cnt != ctrl->queue_count) {
>>
>> So if the queue count did not change we don't wait to make sure
>> the queue g_usage_counter ref made it to zero? What guarantees that it
>> did?
> 
> Hmm, good point. we should always call nvme_wait_freeze_timeout()
> for !new queues. Is this what you are implying?

I think we should always wait for the freeze to complete.

> 
> 
>>>    		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
>>>    			/*
>>>    			 * If we timed out waiting for freeze we are likely to
>>> @@ -1828,6 +1822,10 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>>>    		nvme_unfreeze(ctrl);
>>>    	}
>>> +	ret = nvme_tcp_start_io_queues(ctrl);
>>> +	if (ret)
>>> +		goto out_cleanup_connect_q;
>>> +
>>
>> Did you test this with both heavy I/O, reset loop and ifdown/ifup
>> loop?
> 
> Not sure if this classifies as heavy I/O (on 80 CPU machine)
> 
> fio --rw=readwrite --name=test --filename=/dev/nvme16n1 --size=50M \
>      --direct=1 --bs=4k --numjobs=40 --group_reporting --runtime=4h \
>      --time_based
> 
> and then I installed iptables rules to block the traffic on the
> controller side. With this test it is pretty easily to get
> the host hanging. Let me know what test you would like to see
> from me. I am glad to try to get them running.

Lets add iodepth=128

>> If we unquiesce and unfreeze before we start the queues the pending I/Os
>> may resume before the connect and not allow the connect to make forward
>> progress.
> 
> So the unfreeze should happen after the connect call? What about the
> newly created queues? Do they not suffer from the same problem? Isn't
> the NVME_TCP_Q_LIVE flag not enough?

Q_LIVE will protect against the transport itself from queueing, however
when multipath is not used, the transport will return BLK_STS_RESOURCE
which will immediately trigger re-submission, in an endless loop, and
that can prevent forward progress. It is also consistent with what 
nvme-pci does.
