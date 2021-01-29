Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2499308358
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 02:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhA2BnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 20:43:25 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:40984 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhA2BnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 20:43:21 -0500
Received: by mail-wr1-f51.google.com with SMTP id p15so7267205wrq.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 17:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VVjkQneDDFTJ9oTx+Ry+gBBAMhGr8X7DLrSz+t7UhQs=;
        b=PHovcfy/faCY8ZEGvwYBPPIE1Hr1433422IwYwIMlKthKYOrlqOe9HFrr9UIaNolTZ
         EiFgRuWEsV1kauUaghUxj+xQAVXOWhHZbr16gPpUPTZBUhZw5/JVh8KMO9if6NrLb9XI
         B/GpFwkDElQReP7QwHw1X+joxDg0tQms3zUoO9MxnG0E6CgqPG11+tYIAMPKCoAaZoUS
         sh2vrwJcuiHCbtv6BLq+trX0lcilHEERcOoZ7faCkoEpdMKC+xgYlmMJuufhYBoUs6Ar
         9Q4s3ootoahVmpfYqfojJ0SEjK8fnCVySB4lqrlkAqghVFWg9jN4NOtIR7k2CT9wJJI5
         YRBQ==
X-Gm-Message-State: AOAM53178Bs7TbU+KSGxJQdcY8oA2AhBMd9hqM3q+86x6s56qnPgdlIT
        eyOdRuGgEr0WDCmYXKUQwKo=
X-Google-Smtp-Source: ABdhPJzLYsrhEEcInNJ/93BzaKc6zmJA9nPQS58zDjk8/us582gb+RZGVaoI3OxT4S6GC3sKrnzgYg==
X-Received: by 2002:a05:6000:1565:: with SMTP id 5mr1858778wrz.109.1611884558942;
        Thu, 28 Jan 2021 17:42:38 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:3d48:4849:d506:e578? ([2601:647:4802:9070:3d48:4849:d506:e578])
        by smtp.gmail.com with ESMTPSA id p15sm9296563wrt.15.2021.01.28.17.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 17:42:38 -0800 (PST)
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
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <675d3cf7-1ae8-adc5-b6d0-359fe10f6b23@grimberg.me>
Date:   Thu, 28 Jan 2021 17:42:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ebb1d098-3ded-e592-4419-e905aabe824f@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> You can't see exactly where it dies but I followed the assembly to
>> nvme_round_robin_path(). Maybe it's not the initial nvme_next_ns(head,
>> old) which returns NULL but nvme_next_ns() is returning NULL eventually
>> (list_next_or_null_rcu()).
> So there is other bug cause nvme_next_ns abormal.
> I review the code about head->list and head->current_path, I find 2 bugs
> may cause the bug:
> First, I already send the patch. see:
> https://lore.kernel.org/linux-nvme/20210128033351.22116-1-lengchao@huawei.com/ 
> 
> Second, in nvme_ns_remove, list_del_rcu is before
> nvme_mpath_clear_current_path. This may cause "old" is deleted from the
> "head", but still use "old". I'm not sure there's any other
> consideration here, I will check it and try to fix it.

The reason why we first remove from head->list and only then clear
current_path is because the other way around there is no way
to guarantee that that the ns won't be assigned as current_path
again (because it is in head->list).

nvme_ns_remove fences continue of deletion of the ns by synchronizing
the srcu such that for sure the current_path clearance is visible.
