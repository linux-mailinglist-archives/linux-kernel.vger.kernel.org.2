Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB9045A95F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhKWRAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 12:00:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52543 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231629AbhKWRAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 12:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637686623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kBe6B7tioYmsVYZehpfCmsk72UQ7pq5qaHIGMHZWKy0=;
        b=WfYFV05qIqbPCU8HzJVSryvS9YpBRAi3gD49XlF8KZFLFRJNmdQlNLe5bfWU43ffW3GZsP
        XU3KhlgP1J/ccVSn4ngSQlxuIBt1lQLr7m3OEbdYtleoxsJLQcGekCGtyuP1y4N1QTEqiS
        sg9JGbx9eyLjEYpfgwesF7AMiSRgu+8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487--MPIcczRN4auRK4_59jtcA-1; Tue, 23 Nov 2021 11:57:01 -0500
X-MC-Unique: -MPIcczRN4auRK4_59jtcA-1
Received: by mail-wm1-f71.google.com with SMTP id c8-20020a7bc848000000b0033bf856f0easo1509032wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 08:57:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=kBe6B7tioYmsVYZehpfCmsk72UQ7pq5qaHIGMHZWKy0=;
        b=49Q99xaSJkxoW9OzdArV58++H3pUACZGbJ4mJZ8pseV4K+f4YfNMeoQmni89ZtU7YI
         Iz4UxO1AqvDBMwFCKD4/yEyfQhKPWWOnSYOFrxAma9qPbLpmWfCbj+AF1kEdPaWI5YAJ
         qN3ijc3GtHO+JTNY8ZLu0SdBp+DVsjuLEWLiTxxTuE3iq43Q34KHmLz01HvDsEWSGmCG
         QqGlucKu9h4qqMkmSMhetmnLQojrmfnrOtMSGQXpinG50dbiTYdgQIRkPIt/Q0nzC6l5
         HvqK7fF/KfyMkvqB14cCt0+wWc4j06cEsMeZG5vxP+B4A6swf42Ugc1vWm9ao5CDySV7
         zDVQ==
X-Gm-Message-State: AOAM533tvxCF6+WvqAygWdaRycQc9IooMNvdnbM+q0ug8xY+4CUZCQpz
        0WjNZ2aK/GdNn66gEj1x0MY4N5CYj6SfU11Ywn2oAfxVQZtLQw3j8DEbakMVpKdRiBHlnX3sr6b
        BT+npLHxA5PjZ+tkjwVEvZVFi
X-Received: by 2002:a5d:6691:: with SMTP id l17mr8965981wru.227.1637686620017;
        Tue, 23 Nov 2021 08:57:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJye4oqj76B1MxVHvgWDKFfXjG01NzklIImpNF9/LDZIMaoUKCg3jJ1/+KHx39xNy7a836cW9w==
X-Received: by 2002:a5d:6691:: with SMTP id l17mr8965955wru.227.1637686619809;
        Tue, 23 Nov 2021 08:56:59 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6765.dip0.t-ipconnect.de. [91.12.103.101])
        by smtp.gmail.com with ESMTPSA id c5sm12987518wrd.13.2021.11.23.08.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 08:56:59 -0800 (PST)
Message-ID: <92fe0c31-b083-28c4-d306-da8a3cd891a3@redhat.com>
Date:   Tue, 23 Nov 2021 17:56:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
Content-Language: en-US
To:     Shakeel Butt <shakeelb@google.com>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211120201230.920082-1-shakeelb@google.com>
 <25b36a5c-5bbd-5423-0c67-05cd6c1432a7@redhat.com>
 <CALvZod5L1C1DV_DVs9O3xZm6CJnriunAoj89YLDdCp7ef5yBxA@mail.gmail.com>
 <1b30d06d-f9c0-1737-13e6-2d1a7d7b8507@redhat.com>
 <CALvZod5sFQbf3t_ZDW6ob+BqVtezn-c7i1UyOeev6Lwch96=7g@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CALvZod5sFQbf3t_ZDW6ob+BqVtezn-c7i1UyOeev6Lwch96=7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I do wonder which purpose the deferred split serves nowadays at all.
>> Fortunately, there is documentation: Documentation/vm/transhuge.rst:
>>
>> "
>> Unmapping part of THP (with munmap() or other way) is not going to free
>> memory immediately. Instead, we detect that a subpage of THP is not in
>> use in page_remove_rmap() and queue the THP for splitting if memory
>> pressure comes. Splitting will free up unused subpages.
>>
>> Splitting the page right away is not an option due to locking context in
>> the place where we can detect partial unmap. It also might be
>> counterproductive since in many cases partial unmap happens during
>> exit(2) if a THP crosses a VMA boundary.
>>
>> The function deferred_split_huge_page() is used to queue a page for
>> splitting. The splitting itself will happen when we get memory pressure
>> via shrinker interface.
>> "
>>
>> I do wonder which these locking contexts are exactly, and if we could
>> also do the same thing on ordinary munmap -- because I assume it can be
>> similarly problematic for some applications.
> 
> This is a good question regarding munmap. One main difference is
> munmap takes mmap_lock in write mode and usually performance critical
> applications avoid such operations.

Maybe we can extend it too most page zapping, if that makes things simpler.

> 
>> The "exit()" case might
>> indeed be interesting, but I really do wonder if this is even observable
>> in actual number: I'm not so sure about the "many cases" but I might be
>> wrong, of course.
> 
> I am not worried about the exit(). The whole THP will get freed and be
> removed from the deferred list as well. Note that deferred list does
> not hold reference to the THP and has a hook in the THP destructor.

Yes, you're right. We'll run into the de-constructor either way.

-- 
Thanks,

David / dhildenb

