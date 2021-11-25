Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6845E45D660
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 09:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353609AbhKYIoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 03:44:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53568 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353367AbhKYImg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 03:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637829564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iUYjBkHGKOvo0IUPqV039+uB0R59hc4+zlXw+bbyRX4=;
        b=hnQdIgGxniCD5NvYWfQJAUYzImTvAkQFha0b0H/8gaFmc2s4V2AnbWQftDEAaY+/rQOnss
        gUOdEoD9SH+KnYG2WjDwrmOmdZ8fyLtHEdSL5ZFaGMBwjceE8fCooQknJCoAIscptIyfbv
        SenEa7hH3x7D1bsYFvsDghSJBRa3nng=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-109-fmzte_NjMNylcKZBtl5LsQ-1; Thu, 25 Nov 2021 03:39:21 -0500
X-MC-Unique: fmzte_NjMNylcKZBtl5LsQ-1
Received: by mail-wr1-f71.google.com with SMTP id c4-20020adfed84000000b00185ca4eba36so961884wro.21
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 00:39:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=iUYjBkHGKOvo0IUPqV039+uB0R59hc4+zlXw+bbyRX4=;
        b=pbdI9p7kEPfOmt39sCeMbi1XznokRmoT70+2L9761JPRitZqslLezPIUXTSnCpXr71
         Fe8DAN3iU+GxBAav552Geqqd3TKayHKrjRt55G7vlzuyUsWcRekq8VYlCNwiUqn4X4Py
         6ulsiKDiTrIR+9qeZxzYVrIDS9Iab+yASSVIdt3Pm3KBgXpw0vMhaP9NrIL0IByoVpLS
         kEsIIX1xk7B43SaNL1PkYCRkLpU3288TQJ7HryLEjVDOwT4PIcLBb2GA5GsTl6DmnM+C
         364/D77y/TWGTECEqJdHNC2Lwnb/P0jJ33rNt/xogaTK9O1GbZNMN5ZemsIlDOMvBB3U
         WGGg==
X-Gm-Message-State: AOAM532dSRJpItOZ1sSWcU0xkaQg3YkIyeVkz27XwmS7eK2YJtKk7+re
        x7WnxuamSTfhufdTTJd+IKPYHpyX+m9v6ODoSoAP5XzW0SAXk7yW273iOPzZ18albD9O+ssPnfy
        DZ1af6Qw91KDjbEk7dr6PPf8d
X-Received: by 2002:a05:600c:4e94:: with SMTP id f20mr5035983wmq.119.1637829560174;
        Thu, 25 Nov 2021 00:39:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzo7sO2xOaIAYA/0e+RElMZ67idmGfmI2SrHj7Ck8MGlXcVY6l6jqfyhvPK+/PH/b2vGQiKXw==
X-Received: by 2002:a05:600c:4e94:: with SMTP id f20mr5035959wmq.119.1637829560011;
        Thu, 25 Nov 2021 00:39:20 -0800 (PST)
Received: from [192.168.3.132] (p5b0c679e.dip0.t-ipconnect.de. [91.12.103.158])
        by smtp.gmail.com with ESMTPSA id l5sm2715361wrs.59.2021.11.25.00.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 00:39:19 -0800 (PST)
Message-ID: <e21a3088-e7fc-0601-3171-f710d644b27d@redhat.com>
Date:   Thu, 25 Nov 2021 09:39:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Shakeel Butt <shakeelb@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211125024523.2468946-1-shakeelb@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2] mm: split thp synchronously on MADV_DONTNEED and
 munmap
In-Reply-To: <20211125024523.2468946-1-shakeelb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.11.21 03:45, Shakeel Butt wrote:
> Many applications do sophisticated management of their heap memory for
> better performance but with low cost. We have a bunch of such
> applications running on our production and examples include caching and
> data storage services. These applications keep their hot data on the
> THPs for better performance and release the cold data through
> MADV_DONTNEED to keep the memory cost low.
> 
> The kernel defers the split and release of THPs until there is memory
> pressure. This complicates the memory management of these sophisticated
> applications which then needs to look into low level kernel handling of
> THPs to better gauge their headroom for expansion.
> 
> More specifically these applications monitor their cgroup usage to decide
> if they can expand the memory footprint or release some (unneeded/cold)
> buffer. They uses madvise(MADV_DONTNEED) to release the memory which
> basically puts the THP into defer list. These deferred THPs are still
> charged to the cgroup which leads to bloated usage read by the application
> and making wrong decisions. In addition these applications are very
> latency sensitive and would prefer to not face memory reclaim due to
> non-deterministic nature of reclaim.
> 
> Internally we added a cgroup interface to trigger the split of deferred
> THPs for that cgroup but this is hacky and exposing kernel internals to
> users. This patch solves this problem in a more general way for the users
> by splitting the THPS synchronously on MADV_DONTNEED. This patch does
> the same for munmap() too.
> 

I'll have to defer diving into the code.

Just a comment: It might be good to add that there are still cases where
splitting the compound page can fail -- for example, if the page is
still pinned/referenced.

So if you have a THP and intended to only pin/reference e.g., the first
4k of it (e.g., O_DIRECT, io_uring fixed buffers), MADV_DONTNEED/unmap
e.g., the last 4k of it will not split synchronously.

In addition to explicit user action on a compound page; I remember there
might be other kernel-internal temporary references that could
theoretically block splitting, but maybe most of them are at least for
now limited to !compound pages.

-- 
Thanks,

David / dhildenb

