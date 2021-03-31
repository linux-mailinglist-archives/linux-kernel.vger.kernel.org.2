Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAAF350A2C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 00:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbhCaWZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 18:25:04 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:38886 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbhCaWYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 18:24:53 -0400
Received: by mail-ot1-f46.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so362925otk.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 15:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OZW7ZXqwQfZjqkb90Ox/iujIj7/RYaX8vsIM9kTDCa4=;
        b=Oh3L54U0ltXWoQokDVr3Me4wNMgctHAF8iqOxZgB4jn2Dl1TXS8ACzFrCYRAH7lKTX
         5thqPmsntbWyE32hsKj+ajntVtuL98Q7EygfOwqt2trTjtKkhty3ex5m2hcy0AFfkLEg
         r727cGPihSCkRoBYGSojN7z5H9VyL6O8pfC8qOXeH96ZK7HwEDDLmCnH873n0m6oVF3R
         dlG7jwITvqDOA8uWWkpxeuTTkxf6XBsDZNdHXJZp1k4xmH6mDD9MRV8nvxM2De6pTXmq
         CMsuWRDX/oMH5ua1OOn1V5IvziIRqpXi2NbDx/QE+O+YsnM9EVSXLUkTs6iXzYpI0xqV
         UTPw==
X-Gm-Message-State: AOAM530Wm7+cONNsnLo8F3AwRAa685+ZD7RaWjvm0kG2fh6IQYasjMWE
        4e4iJVjvkZ+jusJGWbCDUhM=
X-Google-Smtp-Source: ABdhPJxWYblKkQ2Rbcl1pEHpKNGN1gKTw5zwYhFckf9cnHZFpl4w5pzn/FHdyv6KV9OS04qRmMBjuA==
X-Received: by 2002:a05:6830:4d:: with SMTP id d13mr4394137otp.295.1617229492582;
        Wed, 31 Mar 2021 15:24:52 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:6302:5415:8f3:c3fc? ([2600:1700:65a0:78e0:6302:5415:8f3:c3fc])
        by smtp.gmail.com with ESMTPSA id n6sm696289oop.48.2021.03.31.15.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 15:24:51 -0700 (PDT)
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
To:     "Ewan D. Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>
References: <20210301175601.116405-1-dwagner@suse.de>
 <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
 <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
 <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
 <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
 <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
 <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com>
 <e4bee13c-647a-55ff-2017-27ccfc314973@suse.de>
 <ad2fcbcd6707de4e219b39b012f6e42cb03dc92d.camel@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5715ef78-eaf1-dcb6-c2a2-f4725e1a01c4@grimberg.me>
Date:   Wed, 31 Mar 2021 15:24:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <ad2fcbcd6707de4e219b39b012f6e42cb03dc92d.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> What we can do, though, is checking the 'state' field in the tcp
>> request, and only allow completions for commands which are in a state
>> allowing for completions.
>>
>> Let's see if I can whip up a patch.
> 
> That would be great.  BTW in the crash dump I am looking at now, it
> looks like pdu->command_id was zero in nvme_tcp_recv_data(), and
> blk_mq_tag_to_rq() returned a request struct that had not been used.
> So I think we do need to check that the tag was actually allocated.

request tag can't be zero? I forget...
