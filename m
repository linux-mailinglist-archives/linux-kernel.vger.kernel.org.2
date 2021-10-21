Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5390435B93
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 09:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhJUHXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 03:23:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25026 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229499AbhJUHXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 03:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634800883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xbiMCdPk4CEnFtd1xtVopkXI3HjYso6lcRUCflFZfhw=;
        b=Xj89OuZLdpZM4RX4ZtfJeoxb29hnbohpm9JXbGthKLyxmPeDUUXX7zT4sV0QMcP5bEe80W
        ncmw1NAKxNObnF0ALnzAJyjCTPo0W68auxJMFGKLtJfj4PftSOOz4tJJOEQNyeJCEsCRW+
        xWD+6EL6juq80qL5f0TEzJEzxEQ/E5g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-NaAeV1utMdWYOfIHfRG2nA-1; Thu, 21 Oct 2021 03:21:19 -0400
X-MC-Unique: NaAeV1utMdWYOfIHfRG2nA-1
Received: by mail-wr1-f69.google.com with SMTP id y12-20020a056000168c00b00160da4de2c7so10999933wrd.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 00:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=xbiMCdPk4CEnFtd1xtVopkXI3HjYso6lcRUCflFZfhw=;
        b=a3HdTwlrXpvWh5S1goa5JrChPvGXfWUSrlOGlRWOpRSqkfus/CLWjlSCTJvLkW7389
         aSq3DzTLIOlqHzWQmCBSm0QrqEjDU2k1S51pGUjcPD4yUSMvuE/PWjDohCSEsvgWyiT2
         bmndX7BkotSXREuTMxkpN7ADF86PpBBfuyO9zEnOK84dRhQLfiesCZnn0ODH1+kA1eRR
         quxZCKod4ePRZ8d2zkXqiVjdVhZN3PpOGssLgu83HUM5v0o1wf8ToSq4s5u4wVDKV2xZ
         GBUppV8Oa2emVwAU9OIDRpWVSpNYxJ1jpfXMVffeEHUQeXpTcp86QY0iaFiDd3LFOxHC
         TxDA==
X-Gm-Message-State: AOAM531IhIQUESwwKI1qydIzpAYCFoA7ABZBcKSbJJDSzYeiX9/gYy1Q
        xxzr9p9t2zT4YWDWV0DkY+EygtKPmtBFV7SNX/+9MbEc7P7Apuw2NMLWemfTHkWno+hI5xy9o4/
        NQYgO8nBV8BpBRuN/1PU1qw11
X-Received: by 2002:a5d:5989:: with SMTP id n9mr1793763wri.8.1634800878870;
        Thu, 21 Oct 2021 00:21:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxxym2D+JRIWHIru6Ae9Fw3KKewTwDtEVGqqzNoEEwHXfYycIoHeYKsjh4hMZVx/AHj6lPGg==
X-Received: by 2002:a5d:5989:: with SMTP id n9mr1793737wri.8.1634800878636;
        Thu, 21 Oct 2021 00:21:18 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23aba.dip0.t-ipconnect.de. [79.242.58.186])
        by smtp.gmail.com with ESMTPSA id u16sm6265534wmc.21.2021.10.21.00.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 00:21:18 -0700 (PDT)
Message-ID: <f31af20e-245d-a8f1-49fa-e368de9fa95c@redhat.com>
Date:   Thu, 21 Oct 2021 09:21:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>
References: <YUtHCle/giwHvLN1@cmpxchg.org>
 <YWpG1xlPbm7Jpf2b@casper.infradead.org> <YW2lKcqwBZGDCz6T@cmpxchg.org>
 <YW28vaoW7qNeX3GP@casper.infradead.org> <YW3tkuCUPVICvMBX@cmpxchg.org>
 <20211018231627.kqrnalsi74bgpoxu@box.shutemov.name>
 <YW7hQlny+Go1K3LT@cmpxchg.org>
 <996b3ac4-1536-2152-f947-aad6074b046a@redhat.com>
 <YXBRPSjPUYnoQU+M@casper.infradead.org>
 <436a9f9c-d5af-7d12-b7d2-568e45ffe0a0@redhat.com>
 <YXEOCIWKEcUOvVtv@infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YXEOCIWKEcUOvVtv@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.10.21 08:51, Christoph Hellwig wrote:
> On Wed, Oct 20, 2021 at 08:04:56PM +0200, David Hildenbrand wrote:
>> real): assume we have to add a field for handling something about anon
>> THP in the struct page (let's assume in the head page for simplicity).
>> Where would we add it? To "struct folio" and expose it to all other
>> folios that don't really need it because it's so special? To "struct
>> page" where it actually doesn't belong after all the discussions? And if
>> we would have to move that field it into a tail page, it would get even
>> more "tricky".
>>
>> Of course, we could let all special types inherit from "struct folio",
>> which inherit from "struct page" ... but I am not convinced that we
>> actually want that. After all, we're C programmers ;)
>>
>> But enough with another side-discussion :)
> 
> FYI, with my block and direct I/O developer hat on I really, really
> want to have the folio for both file and anon pages.  Because to make
> the get_user_pages path a _lot_ more efficient it should store folios.
> And to make that work I need them to work for file and anon pages
> because for get_user_pages and related code they are treated exactly
> the same.

Thanks, I can understand that. And IMHO that would be even possible with
split types; the function prototype will simply have to look a little
more fancy instead of replacing "struct page" by "struct folio". :)

-- 
Thanks,

David / dhildenb

