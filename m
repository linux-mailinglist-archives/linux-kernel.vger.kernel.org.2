Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7598645A5F8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 15:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbhKWOrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 09:47:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51841 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229814AbhKWOrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637678648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+b7hniopIn0+NuG/R150d+pf5Z8VHz5+FBwlDcbPWE0=;
        b=hSD2LUTkdHW7KGOTKnHxfV5wsIhNwubEcqI2ZDpwgplO7juoU7PbuUC/25USsy/MHKnhIo
        nBz+uldqgPkzWC0A2JmWeG3EbLCA2ZYsUuuEm//2VsBguOy0M3tuxAd1SEjMl+u1kuiaDp
        tcxwhF6eqXoUxX9YXWejRzWmy8TDckY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-hSjBlr5RN2yphUNkQb9tSg-1; Tue, 23 Nov 2021 09:44:06 -0500
X-MC-Unique: hSjBlr5RN2yphUNkQb9tSg-1
Received: by mail-wm1-f72.google.com with SMTP id a64-20020a1c7f43000000b003335e5dc26bso2979408wmd.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 06:44:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=+b7hniopIn0+NuG/R150d+pf5Z8VHz5+FBwlDcbPWE0=;
        b=fzth1TT9WYZp8VuWZ9dBY/mIVjI9V6ioozBWJONGmtVI0z1f4o8rehMkLeUw/GpaSA
         BDdWwjZo7kSM/UVB+X+ypJS2gdft/rXL+Grv1pnA0vuRWm1baVOGxd3jjR9EQ/i6fK3Y
         F0i8ZCs0kdIUeDGwgGx+NHCIRh9yuaDXRvRYfmWtkh4X1gMd4PJht5yfQtghTbs5M2U2
         orTKftpNAaQ9QfmyQb89mf88ZnVM/LYWbUIb7Jf6p4+bdAAhRNVH3Qwljq4ybWQa4Y17
         m0LJCwT2fwv8JT3hUlrVBp95S2czQWwyvgVQjPVMxtbVuTgeZUeyDnhLAiplw+LqYkUW
         3l6w==
X-Gm-Message-State: AOAM532TZOAaPUhUW5BmPGR2SoC2ZjhOHGox6ntzNqiTANnTVsnQvXZ8
        wdV912eZK7SBaQNWHxDvlNRzBWlwsIFk2PgNPt8Hg4XgvDj3zaCU58sBTpLF1cveV6OGrlfXG6E
        WmW4mxUMCRDge/yOCL3F1tnQX
X-Received: by 2002:a05:600c:1e27:: with SMTP id ay39mr3789368wmb.84.1637678645513;
        Tue, 23 Nov 2021 06:44:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXHlUChmsYKu5C0L7zYHRrKMd0CHdQq3Ns4Q1cTolIpJelDb2DU4YulsCILGh7hPoTHzta5A==
X-Received: by 2002:a05:600c:1e27:: with SMTP id ay39mr3789337wmb.84.1637678645296;
        Tue, 23 Nov 2021 06:44:05 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6765.dip0.t-ipconnect.de. [91.12.103.101])
        by smtp.gmail.com with ESMTPSA id g13sm1408508wmk.37.2021.11.23.06.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 06:44:04 -0800 (PST)
Message-ID: <e4d7d211-5d62-df89-8f94-e49385286f1f@redhat.com>
Date:   Tue, 23 Nov 2021 15:44:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Andrew Dona-Couch <andrew@donacou.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Drew DeVault <sir@cmpwn.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        io_uring Mailing List <io-uring@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>, linux-mm@kvack.org
References: <20211116114727.601021d0763be1f1efe2a6f9@linux-foundation.org>
 <CFRGQ58D9IFX.PEH1JI9FGHV4@taiga>
 <20211116133750.0f625f73a1e4843daf13b8f7@linux-foundation.org>
 <b84bc345-d4ea-96de-0076-12ff245c5e29@redhat.com>
 <8f219a64-a39f-45f0-a7ad-708a33888a3b@www.fastmail.com>
 <333cb52b-5b02-648e-af7a-090e23261801@redhat.com>
 <ca96bb88-295c-ccad-ed2f-abc585cb4904@kernel.dk>
 <5f998bb7-7b5d-9253-2337-b1d9ea59c796@redhat.com>
 <20211123132523.GA5112@ziepe.ca>
 <10ccf01b-f13a-d626-beba-cbee70770cf1@redhat.com>
 <20211123140709.GB5112@ziepe.ca>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] Increase default MLOCK_LIMIT to 8 MiB
In-Reply-To: <20211123140709.GB5112@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.11.21 15:07, Jason Gunthorpe wrote:
> On Tue, Nov 23, 2021 at 02:39:19PM +0100, David Hildenbrand wrote:
>>>
>>>> 2) Could be provide a mmu variant to ordinary users that's just good
>>>> enough but maybe not as fast as what we have today? And limit
>>>> FOLL_LONGTERM to special, privileged users?
>>>
>>> rdma has never been privileged
>>
>> Feel free to correct me if I'm wrong: it requires special networking
>> hardware and the admin/kernel has to prepare the system in a way such
>> that it can be used.
> 
> Not really, plug in the right PCI card and it works

Naive me would have assumed that the right modules have to be loaded
(and not blacklisted), that there has to be an rdma service installed
and running, that the NIC has to be configured in some way, and that
there is some kind of access control which user can actually use which
NIC. For example, I would have assume from inside a container it usually
wouldn't just work.

But I am absolutely not a networking and RDMA expert, so I have to
believe what you say and I trust your experience :) So could as well be
that on such a "special" (or not so special) systems there should be a
way to restrict it to privileged users only.

> 
> "special" is a bit of a reach since almost every NIC sold in the > 100GB
> segment supports some RDMA.


-- 
Thanks,

David / dhildenb

