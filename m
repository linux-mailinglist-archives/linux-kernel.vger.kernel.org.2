Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C343E89F4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 07:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbhHKF63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 01:58:29 -0400
Received: from mail-pj1-f49.google.com ([209.85.216.49]:39882 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbhHKF6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 01:58:24 -0400
Received: by mail-pj1-f49.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so7905920pjn.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 22:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MwNzgkEdTWrhCVqzwhsRITEzyhDpcajlmLuENq9JbiQ=;
        b=US7sN85owvl9Fad0e/OO3gOml1vTyhkN9GjY9mPZc1QixvPVowtLGRJmoj2BMhaUQY
         ZPCLaloY9bfyGaabKOkXqsWEEwMjJNdU+AS0M4Ct43WgJ93dY993FoGor7J5WT7sxm4x
         T5uyTStS7G1kxTNb2uxpXUrwLAnJPOfUJJqlMQAYHAj3VjfepcZIPvbarrpJDsoUCf5a
         CdJjMjF25Xx7C6BhDG71MOj596UiJP07UE1v8y1Gg4P5VY8Zaywt+3fDZhIEt0LCK7XL
         bhvzUQC1woGYgpr7PMJaTiWikjvHocSOacYmaqvvDmAa+qMcqgcmIgJYVnxxNTLVu2HX
         AhdA==
X-Gm-Message-State: AOAM533tRJykF9+yPkBS/NpBW+SehiHktse1DyRS3+xaW+1qJi/bpWj2
        zXV5cFFmpMX1BuEbOZOFFcQ=
X-Google-Smtp-Source: ABdhPJy3CprzOEEONMGcGgHCw2bfPm+CGkOj6t9+C8N86i2AfY8AhzexTpeZ5DyXUHzzPIzQNHyPdg==
X-Received: by 2002:a17:90a:804a:: with SMTP id e10mr19156601pjw.12.1628661481165;
        Tue, 10 Aug 2021 22:58:01 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:61e5:4b9f:b48a:e987? ([2601:647:4802:9070:61e5:4b9f:b48a:e987])
        by smtp.gmail.com with ESMTPSA id f4sm31685550pgi.68.2021.08.10.22.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 22:58:00 -0700 (PDT)
Subject: Re: [PATCH v4 2/8] nvme-tcp: Update number of hardware queues before
 using them
To:     Keith Busch <kbusch@kernel.org>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-3-dwagner@suse.de>
 <8373c07f-f5df-1ec6-9fda-d0262fc1b377@grimberg.me>
 <20210809085250.xguvx5qiv2gxcoqk@carbon>
 <01d7878c-e396-1d6b-c383-8739ca0b3d11@grimberg.me>
 <20210811010718.GA3135947@dhcp-10-100-145-180.wdc.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <079108ce-6ca0-800e-e3df-29d015a4530c@grimberg.me>
Date:   Tue, 10 Aug 2021 22:57:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210811010718.GA3135947@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> On 8/9/21 1:52 AM, Daniel Wagner wrote:
>>> Hi Sagi,
>>>
>>> On Fri, Aug 06, 2021 at 12:57:17PM -0700, Sagi Grimberg wrote:
>>>>> -	ret = nvme_tcp_start_io_queues(ctrl);
>>>>> -	if (ret)
>>>>> -		goto out_cleanup_connect_q;
>>>>> -
>>>>> -	if (!new) {
>>>>> -		nvme_start_queues(ctrl);
>>>>> +	} else if (prior_q_cnt != ctrl->queue_count) {
>>>>
>>>> So if the queue count did not change we don't wait to make sure
>>>> the queue g_usage_counter ref made it to zero? What guarantees that it
>>>> did?
>>>
>>> Hmm, good point. we should always call nvme_wait_freeze_timeout()
>>> for !new queues. Is this what you are implying?
>>
>> I think we should always wait for the freeze to complete.
> 
> Don't the queues need to be started in order for the freeze to complete?
> Any enqueued requests on the quiesced queues will never complete this
> way, so the wait_freeze() will be stuck, right? If so, I think the
> nvme_start_queues() was in the correct place already.

Exactly what I was trying to point out (poorly though)
