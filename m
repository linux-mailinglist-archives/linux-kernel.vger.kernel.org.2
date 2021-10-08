Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F4142659B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 10:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbhJHIHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 04:07:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60393 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233313AbhJHIHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 04:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633680340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TF4BujFSeQ5kOB+yaF3TDp1qX43Am50rZssymfHLv4g=;
        b=BALTjwHYUak61f0g1VNR5TpQqDHxuZGoj362MF3RrhB1eczwTIQXYpCVQIj1PZ5Qx0dhBd
        HSWMzThy6m8BZ1UMUrjxlU9S6Cvwe5q44Gy6FSFTBUDo4Yrj2uEK1zjdOSeFTscF4mTBNz
        fe484o5YmqlZ9Qf6Cc5Nb4jf1nnVMjU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-he8ImKi9MHqAB9jSXfJMBg-1; Fri, 08 Oct 2021 04:05:39 -0400
X-MC-Unique: he8ImKi9MHqAB9jSXfJMBg-1
Received: by mail-wr1-f72.google.com with SMTP id l9-20020adfc789000000b00160111fd4e8so6683832wrg.17
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 01:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TF4BujFSeQ5kOB+yaF3TDp1qX43Am50rZssymfHLv4g=;
        b=ppjCok0zXbPYRnny50E4pQNBC9ZHQucSenRPR0/gZKqXgoVg8BhreTa2/9vjV+7iYa
         n6EaC3VpzUYkwQpZfq3k3U8r8iiNp59eb5P7qBmDYPCM2HP1qsORSHDamM27g+6Lj11O
         epMZwnIps1W2p1cSclEYgkgwlw/6iaI6gT2R6j5mFnLTPRqCQDDIP7IrM/caIf4U93Hx
         B4dJfjOyHymjkJURj/G2NeotwoUBOu0cv5niFtfZhv9f0JIqLD3/z5exN1J9XfP5zkDv
         uwk/U8zJImdItx8z2kyhGdRcA0eDreYAHXj6hNxy9Hu5HgEcJmOUsipMZe4TTLvsriGF
         Vb0w==
X-Gm-Message-State: AOAM532omwTnNqDBIjx547sHBAHjJ/xD4vJGkdJs7XDIpVseSUp1rFOs
        B5pW/okel/U+IbGGNMKjlKegldpqkUcL6hD56ZdqKJ5iyIG4jIiNLUZjnctCFL+K/npqkqdaCOt
        NJ6r681/BHiqJo8oh2IsacAwS
X-Received: by 2002:a1c:2b85:: with SMTP id r127mr834456wmr.134.1633680338000;
        Fri, 08 Oct 2021 01:05:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0n6ilNdp7Wy9iR8wZmeJdLnDy4XTbFxhcWRg9/5MjxxWYBVQf1jYwMpPIUJV3qF0MIQ1dOw==
X-Received: by 2002:a1c:2b85:: with SMTP id r127mr834441wmr.134.1633680337829;
        Fri, 08 Oct 2021 01:05:37 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c676e.dip0.t-ipconnect.de. [91.12.103.110])
        by smtp.gmail.com with ESMTPSA id r18sm1744195wrs.47.2021.10.08.01.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 01:05:37 -0700 (PDT)
To:     Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jan Kara <jack@suse.cz>, stable@vger.kernel.org
References: <20211007235055.469587-1-namit@vmware.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/userfaultfd: provide unmasked address on page-fault
Message-ID: <d5a244e9-a04e-8794-e55f-380db5e8c6c4@redhat.com>
Date:   Fri, 8 Oct 2021 10:05:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211007235055.469587-1-namit@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.10.21 01:50, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> Userfaultfd is supposed to provide the full address (i.e., unmasked) of
> the faulting access back to userspace. However, that is not the case for
> quite some time.
> 
> Even running "userfaultfd_demo" from the userfaultfd man page provides
> the wrong output (and contradicts the man page). Notice that
> "UFFD_EVENT_PAGEFAULT event" shows the masked address.
> 
> 	Address returned by mmap() = 0x7fc5e30b3000
> 
> 	fault_handler_thread():
> 	    poll() returns: nready = 1; POLLIN = 1; POLLERR = 0
> 	    UFFD_EVENT_PAGEFAULT event: flags = 0; address = 7fc5e30b3000
> 		(uffdio_copy.copy returned 4096)
> 	Read address 0x7fc5e30b300f in main(): A
> 	Read address 0x7fc5e30b340f in main(): A
> 	Read address 0x7fc5e30b380f in main(): A
> 	Read address 0x7fc5e30b3c0f in main(): A
> 
> Add a new "real_address" field to vmf to hold the unmasked address. It
> is possible to keep the unmasked address in the existing address field
> (and mask whenever necessary) instead, but this is likely to cause
> backporting problems of this patch.

Can we be sure that no existing users will rely on this behavior that 
has been the case since end of 2016 IIRC, one year after UFFD was 
upstreamed? I do wonder what the official ABI nowadays is, because man 
pages aren't necessarily the source of truth.

I checked QEMU (postcopy live migration), and I think it should be fine 
with this change.

If we don't want to change the current ABI behavior, we could add a new 
feature flag to change behavior.

@Peter, what are your thoughts?

-- 
Thanks,

David / dhildenb

