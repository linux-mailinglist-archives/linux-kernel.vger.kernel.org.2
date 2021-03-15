Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2392D33C3F4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 18:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbhCORQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 13:16:23 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:42928 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235774AbhCORQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:16:16 -0400
Received: by mail-pl1-f180.google.com with SMTP id e2so10371766pld.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 10:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NW+eXND38mNlb3ZqG2dmVqWyYEV8WBK57NAHmFqZFYY=;
        b=grZZm1XXabzI0FIG8zAtzUpWbaQPDwJtpkxcZPL41OSYgt7NQsD8Xo1JazDIUdgDTK
         6e6OvQb9Bt7sv7zV4HHiLZyYrKLF2PX6I3y0dhtsvvk6boEZSHCkUyPa42ZMg05em9Qr
         kFr74BxTPuTOhyM2ZEc2ff8q2tw9L2FP3bKQcw1F47o8GbJOQEI+qJ7PBDmMwJh/xIkC
         NX6AKLYeH+wfKEfJp2PVHhC5CwU1+47Y3Phu04cXzdj6G5RZMEY8W74OmItEWo0ZfY4F
         E8wpazNjMqn+8Mg+00b3710Nqy5zphHmOlIWppwIkmZjb2rwkNmK+9iYvJ6UoL4JFCoI
         SKNA==
X-Gm-Message-State: AOAM532pKNxtmkbQkHCXJH38J9gbAnwxqsR5RP4GayWEEZWAoDrPXAaq
        wmb3ovwOqdm0Qu0ArX4RTnM=
X-Google-Smtp-Source: ABdhPJwiobUzDkmGkjLB6bhTKEQ8DPqu3/A1XDIavy2tRuDicMt3YJjAzVpVPxhLi0MBkjEYjwBYSA==
X-Received: by 2002:a17:902:8217:b029:e6:2875:b1d9 with SMTP id x23-20020a1709028217b02900e62875b1d9mr12202035pln.70.1615828575563;
        Mon, 15 Mar 2021 10:16:15 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4faf:1598:b15b:7e86? ([2601:647:4802:9070:4faf:1598:b15b:7e86])
        by smtp.gmail.com with ESMTPSA id bg16sm188680pjb.43.2021.03.15.10.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 10:16:14 -0700 (PDT)
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20210301175601.116405-1-dwagner@suse.de>
 <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
 <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
Date:   Mon, 15 Mar 2021 10:16:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi Sagi,
> 
> On Fri, Mar 05, 2021 at 11:57:30AM -0800, Sagi Grimberg wrote:
>> Daniel, again, there is nothing specific about this to nvme-tcp,
>> this is a safeguard against a funky controller (or a different
>> bug that is hidden by this).
> 
> As far I can tell, the main difference between nvme-tcp and FC/NVMe,
> nvme-tcp has not a FW or a big driver which filter out some noise from a
> misbehaving controller. I haven't really checked the other transports
> but I wouldn't surprised they share the same properties as FC/NVMe.
> 
>> The same can happen in any other transport so I would suggest that if
>> this is a safeguard we want to put in place, we should make it a
>> generic one.
>>
>> i.e. nvme_tag_to_rq() that _all_ transports call consistently.
> 
> Okay, I'll review all the relevant code and see what could made more
> generic and consistent.
> 
> Though I think nvme-tcp plays in a different league as it is exposed to
> normal networking traffic and this is a very hostile environment.

It is, but in this situation, the controller is sending a second
completion that results in a use-after-free, which makes the
transport irrelevant. Unless there is some other flow (which is unclear
to me) that causes this which is a bug that needs to be fixed rather
than hidden with a safeguard.
