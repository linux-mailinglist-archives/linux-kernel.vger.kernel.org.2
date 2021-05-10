Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686C1379195
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbhEJO4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:56:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33575 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237999AbhEJOyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620658380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r3F85XZzjNHLRburwhBXkleEvJxBouqVwWLwoQqGQIQ=;
        b=dI1E2SzRWKpehGTtOXQsTs22YXLrLtT3CFiJQTXKbYPFf3JbAHOkXk0gc4knhgTbbNgM9a
        en0eMNyFBV5N7tAm9/0onb7Q6WpnDR8b1NL8hTfiWXb+WbgXo6T7Q7UxU4gASPdA4Q+tvZ
        k3cTM0O9+Ka8TlGA2Cm1vEcb1CfCyRY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-Vkl04R8uNHSXMgpEKnjl3Q-1; Mon, 10 May 2021 10:52:59 -0400
X-MC-Unique: Vkl04R8uNHSXMgpEKnjl3Q-1
Received: by mail-ej1-f71.google.com with SMTP id p25-20020a1709061419b0290378364a6464so4856437ejc.15
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 07:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=r3F85XZzjNHLRburwhBXkleEvJxBouqVwWLwoQqGQIQ=;
        b=m7TchnklWiQqPpZCHfzGtylTWr+k/dUuZjtIoPXyW/0kGNHtlASXaE+i/NHVYA0LO3
         0jf+d+zxPBzBf+q282+VUvhqMhod9RPEtUKexaFRbHDExtTIsngF01TMTIgmb9T5ECTj
         /UNuE+DzcHkzl2KVwjKqRkvs0BTULFp0jwwGLSwj4wvtNrY2wNpbLJp/w4qKh0f0KYDB
         jgsdsRSFctRS0tuunk3DmyXyT8rjKCwSAEBZFfWxaX4Zi0+tlApO7U/xsfsExU10S66o
         couSSljQABZWe6Ox6BTL68z6XNsJEFmSfRV+lWaSmAkUjfLYpJshlSeV88VogDHziB+4
         kMpg==
X-Gm-Message-State: AOAM531x4IvmDMvWX+hjSXnrW2HxWqStnYZRoKtLlDWInR1uU50ad3P7
        FZu+1IaFJkrArX0Sf/vpU1YHN5gUrxGO+Q6oo3A9kMmq6B16684ONuir0UdVUCKX9KcA8OsV4KT
        Qrz60ed5M7DiBHOnH0GQGNB0a
X-Received: by 2002:a17:906:4c5a:: with SMTP id d26mr26911029ejw.353.1620658378039;
        Mon, 10 May 2021 07:52:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzufxfdZUWjdIZ/nOsKy6x6eC3yTNUojQQY26UL0d5i1D2Ys7+JmehWAMQcO1ct85KkfBxw3A==
X-Received: by 2002:a17:906:4c5a:: with SMTP id d26mr26911000ejw.353.1620658377805;
        Mon, 10 May 2021 07:52:57 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c676a.dip0.t-ipconnect.de. [91.12.103.106])
        by smtp.gmail.com with ESMTPSA id k5sm13003545edk.46.2021.05.10.07.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 07:52:57 -0700 (PDT)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Chris Zankel <chris@zankel.net>,
        Dave Hansen <dave.hansen@intel.com>,
        Helge Deller <deller@gmx.de>, Hugh Dickins <hughd@google.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jann Horn <jannh@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Peter Xu <peterx@redhat.com>, Ram Pai <linuxram@us.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        Rik van Riel <riel@surriel.com>,
        Rolf Eike Beer <eike-kernel@sf-tec.de>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20210419135443.12822-1-david@redhat.com>
 <20210509212105.d741b7026ca6dca86bdb56d2@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 0/5] mm/madvise: introduce MADV_POPULATE_(READ|WRITE)
 to prefault page tables
Message-ID: <79bb75e1-4ee9-5fe2-e495-577518956e1f@redhat.com>
Date:   Mon, 10 May 2021 16:52:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210509212105.d741b7026ca6dca86bdb56d2@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.05.21 06:21, Andrew Morton wrote:
> On Mon, 19 Apr 2021 15:54:38 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>> Excessive details on MADV_POPULATE_(READ|WRITE) can be found in patch #2.
> 
> I grabbed the series, but some additional review would help things
> along here..

Thanks -- indeed, while there have been some comments to previous 
versions that improved the series as a whole, there are no explicit acks 
or rbs. Fortunately, we still have some time until the next merge window 
opens :)

> 
> Did patch #2 actually make it to linux-mm?  It's missing from my
> archive.

Ehm, good point. I punch out everything via " git send-email  --to 
linux-kernel@vger.kernel.org  --cc "linux-mm@kvack.org" ..." and don't 
remember any bounces.

Doesn't seem to appear on linux-mm:

https://lore.kernel.org/linux-mm/20210419135443.12822-1-david@redhat.com/

But it did make it to lkml as well:

https://lore.kernel.org/lkml/20210419135443.12822-3-david@redhat.com/

> https://lkml.kernel.org/r/20210419135443.12822-3-david@redhat.com lands
> on the linux-api@vger copy.

Weird, looks like linux-mm is swallowing mails.

I can just resend the series, thoughts?

-- 
Thanks,

David / dhildenb

