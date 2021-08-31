Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787B03FCE30
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 22:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240426AbhHaULl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 16:11:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37139 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232808AbhHaULl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 16:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630440644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KbgJ2Vu8JpD26GA6OCHo87Wy3/ZN8Be3JYXsPNbuv+A=;
        b=AS6VDpPS8aPN4JrzNOP/3jEvQMEa5mihPx32aYRI50pfPt8gJVA7qGmXd74H5S0VMJupfs
        Il7axd2J/Oud1EcRSWKHxQOPW3rnvlQgadVzE3Gs8FZqYpmRLVDQb0xIuaB1bGIwxO0Nsl
        P4CYeYKZS4c5/mnx5PqD2Um7xx2xpnc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-rKcdwF2oMKKq5U-vbn3zdw-1; Tue, 31 Aug 2021 16:10:43 -0400
X-MC-Unique: rKcdwF2oMKKq5U-vbn3zdw-1
Received: by mail-wr1-f70.google.com with SMTP id n1-20020a5d4c41000000b00159305d19baso749wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 13:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KbgJ2Vu8JpD26GA6OCHo87Wy3/ZN8Be3JYXsPNbuv+A=;
        b=ez9LLM9Z7z5svl/KWlxAttxmiC4blLuRUpg4N86wHCJJxrJ73NYy3VasdvpXQmDyRb
         zpGk5aPUqMwVNF3BPgvACmAFIv1t7U2W4/oMkcnJ0JBe4TtBi2ie8gdvTx6qLxLikMqx
         09eD3rYCyit75z0SAU7S7KZjjdtUMXRgdQ8SaaG0qq761UGfzUOe/st25E7/Ffts3178
         vbDzUtkAdpvH9l4dliVqQUx8v4RGIv1JTp3P/ukdu+SbqhnLT3yx7iIIB3keaR5eM/1C
         U/hBswiE2g9LTBqZxiKmxJ1XqVljcpqaguqzFVwU4LxqVZARo2T11ujz7rPEmp3hdULA
         rDGA==
X-Gm-Message-State: AOAM533PKSqFwSNYGYWT2mFqd4Xp9gHtJQCXRWz1KQjoLYwGwWyZJZ3y
        Y1NyO/Ps/+puRff08oB+j6uqH+sAUHOWInRdFTzjYJc/b8gQ9Ms0q6B2/GhLcLlg6jnaw8EiJ0F
        VuR8Ht4fbqWEFnhg4SQFO4p5b
X-Received: by 2002:adf:edc2:: with SMTP id v2mr33398997wro.255.1630440642150;
        Tue, 31 Aug 2021 13:10:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFHxJK6CuUyH4fIACh8WCgho8ld2f48k7iz12CJXT9s8M02Pmju/iUqJTv/KchgQNGbkL+Og==
X-Received: by 2002:adf:edc2:: with SMTP id v2mr33398977wro.255.1630440641934;
        Tue, 31 Aug 2021 13:10:41 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23bf5.dip0.t-ipconnect.de. [79.242.59.245])
        by smtp.gmail.com with ESMTPSA id u23sm3315346wmc.24.2021.08.31.13.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 13:10:41 -0700 (PDT)
Subject: Re: [GIT PULL] virtio: a last minute fix
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     KVM list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>, david@redhat.com,
        dverkamp@chromium.org, hch@lst.de, jasowang@redhat.com,
        liang.z.li@intel.com, mst@redhat.com, tiny.windzz@gmail.com,
        jasowang@redhat.com
References: <20210829115343-mutt-send-email-mst@kernel.org>
 <CAHk-=wjYkPWoQWZEHXzd3azugRO4MCCEx9dBYKkVJLrk+1gsMg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <6aaa0ca9-61ed-7ea3-de61-56dcd04ce88b@redhat.com>
Date:   Tue, 31 Aug 2021 22:10:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjYkPWoQWZEHXzd3azugRO4MCCEx9dBYKkVJLrk+1gsMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.08.21 20:11, Linus Torvalds wrote:
> On Sun, Aug 29, 2021 at 8:53 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> Donnu if it's too late - was on vacation and this only arrived
>> Wednesday. Seems to be necessary to avoid introducing a regression
>> in virtio-mem.
> 
> Heh. Not too late for 5.14, but too late in the sense that I had
> picked this one up manually already as commit 425bec0032f5
> ("virtio-mem: fix sleeping in RCU read side section in
> virtio_mem_online_page_cb()").

Thanks Michael for sending this last minute and thanks Linus for picking 
it up independently early! Awesome :)

-- 
Thanks,

David / dhildenb

