Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6778030843F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 04:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhA2Daz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 22:30:55 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:45501 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhA2Day (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 22:30:54 -0500
Received: by mail-wr1-f52.google.com with SMTP id m13so7430442wro.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 19:30:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7JvZqZgmo4qIPwsjj069cmI/74kxVP4SSY95ky0J7hY=;
        b=nIEy/lYxmdw85hqEYJhYKENkZSsHHK1m7LB89xG2TEw2BWmS6TtDQDoBxn80aFgyds
         sHjXUKrBpNnzQ9nHbgMiG89q4hy8MS5QC+0DB8/pD4Ndj6Va/ekw3SF+aAed7HVHUoQc
         VB0aouijii+28kmHTKDRWGHR5p+ii5riEukRgyMcAF0Qe0W6v4bFh427IRBtrVJnsqDE
         7ScsyV7hu4TuWI6YJYVAOD7dMQ/8ggfUzZmPh8l/qMbLLh6q/jxtPQ0cAA3naEvTwzog
         OPYy+Y2GPgUqNeIG0U0ad9+6+oFAP/qbks/HHEdetdaqVeoOF5RyMlw9ui1U8aorlvxc
         nOhQ==
X-Gm-Message-State: AOAM5324x6FuJh/qqP9WTMPgIBDPXxfQSkTwI5odU+D7wa4Ng6nq2doT
        2+Ty0As+/ZSMmYb5IOby/2I=
X-Google-Smtp-Source: ABdhPJzqHQHtS4BkI4+Mr8moj9jMrAyizE5539Amfj5VtzBG9cnBzaCDYL3kyzlFCT2lRWq+/3X84Q==
X-Received: by 2002:a5d:5283:: with SMTP id c3mr2038048wrv.319.1611891011977;
        Thu, 28 Jan 2021 19:30:11 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:3d48:4849:d506:e578? ([2601:647:4802:9070:3d48:4849:d506:e578])
        by smtp.gmail.com with ESMTPSA id u14sm7730793wml.19.2021.01.28.19.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 19:30:11 -0800 (PST)
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
To:     Chao Leng <lengchao@huawei.com>, Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20210127103033.15318-1-dwagner@suse.de>
 <db9baae0-547c-7ff4-8b2c-0b95f14be67c@huawei.com>
 <20210128075837.u5u56t23fq5gu6ou@beryllium.lan>
 <69575290-200e-b4a1-4269-c71e4c2cc37b@huawei.com>
 <20210128094004.erwnszjqcxlsi2kd@beryllium.lan>
 <ebb1d098-3ded-e592-4419-e905aabe824f@huawei.com>
 <675d3cf7-1ae8-adc5-b6d0-359fe10f6b23@grimberg.me>
 <59cd053e-46cb-0235-141f-4ce919c93f48@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <dbc39e56-b2bd-a82e-499a-5032c9716855@grimberg.me>
Date:   Thu, 28 Jan 2021 19:30:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <59cd053e-46cb-0235-141f-4ce919c93f48@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> You can't see exactly where it dies but I followed the assembly to
>>>> nvme_round_robin_path(). Maybe it's not the initial nvme_next_ns(head,
>>>> old) which returns NULL but nvme_next_ns() is returning NULL eventually
>>>> (list_next_or_null_rcu()).
>>> So there is other bug cause nvme_next_ns abormal.
>>> I review the code about head->list and head->current_path, I find 2 bugs
>>> may cause the bug:
>>> First, I already send the patch. see:
>>> https://lore.kernel.org/linux-nvme/20210128033351.22116-1-lengchao@huawei.com/ 
>>>
>>> Second, in nvme_ns_remove, list_del_rcu is before
>>> nvme_mpath_clear_current_path. This may cause "old" is deleted from the
>>> "head", but still use "old". I'm not sure there's any other
>>> consideration here, I will check it and try to fix it.
>>
>> The reason why we first remove from head->list and only then clear
>> current_path is because the other way around there is no way
>> to guarantee that that the ns won't be assigned as current_path
>> again (because it is in head->list).
> ok, I see.
>>
>> nvme_ns_remove fences continue of deletion of the ns by synchronizing
>> the srcu such that for sure the current_path clearance is visible.
> The list will be like this:
> head->next = ns1;
> ns1->next = head;
> old->next = ns1;
> This may cause infinite loop in nvme_round_robin_path.
> for (ns = nvme_next_ns(head, old);
>      ns != old;
>      ns = nvme_next_ns(head, ns))
> The ns will always be ns1, and then infinite loop.

Who is being removed? I'm not following
