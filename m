Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984B43D1F3C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 09:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhGVHFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 03:05:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49890 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230048AbhGVHFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 03:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626939946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fQbFrR8ICe6f4hwDSR7XnZ4TZ/I96RPWGlnwYnqKWKc=;
        b=XkcdJa7EkE/1YFXzVPr7HVZFk2Q1REH120LJ76Jl9WMeQgEesPp0XR0arumgDibP3w2Cam
        ePwOkuJRRnsYlL2vSegzX+I7n+jPlnK4nFE/WoJIspKHmdpP16OXIoXLl3bf2o8rax3EoL
        EXp6AcBIQ2HAfAIXpKe9tXI6CBcVEUE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-aJ2eCsUUP7eFcuZjRu4SAA-1; Thu, 22 Jul 2021 03:45:45 -0400
X-MC-Unique: aJ2eCsUUP7eFcuZjRu4SAA-1
Received: by mail-wr1-f70.google.com with SMTP id g9-20020adff3c90000b0290140a25efc6dso2132589wrp.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 00:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fQbFrR8ICe6f4hwDSR7XnZ4TZ/I96RPWGlnwYnqKWKc=;
        b=eDgeBh5nrpF1VpPG6TXH7PqF/yMF5pV92k/jEzEovGRN0j/TjPHbyoPOzMIEGyFBKZ
         7Fpfs40lKBwbNGC8sgPforjEE5zIOYgDGRPHPxNviAZBe5iCh3bDnPkvJ3WecIYXfu5A
         TSkQ5+djp6hTtp0BuNu/Wv8lusy9DY/RwHi4ulT7yYAaC8ulAKVDs3zuHmCk3G6/Z+ki
         G421zYE5vJ4qgNylaMEMwZzJmhfwVQa7qhmFSRL8Z6ZGgCBl3DOSs9dTeVcS1cvvNBjC
         JcyIvv8rWzsco1X1ZC+UfIEwm4Kw/NjBnMnnx6a6Jjf5WZOqc+2A95R8DMLsVxRyGpmV
         XKjA==
X-Gm-Message-State: AOAM533U8S3VjQcs97pqrBwBhGYi9NzsMPtUHg9XlseOYgIOgopSVvC8
        WilKiwEiHMqMUnnYGNIWBUAknhfrheijEyv4eSq5/FAyN5kLip4bS9VjyQKKu6swDze7Rw78Z3d
        GI6exAKTwtWvmAPhfUDfZ9imh
X-Received: by 2002:adf:9bd7:: with SMTP id e23mr47724161wrc.349.1626939944206;
        Thu, 22 Jul 2021 00:45:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyj/MqcBTyAhaFv6JVF9pw5A4aPF8yIJ55K25C05arJo0Ih3l1nU6gs8GsRcD8DSEDIGWRmA==
X-Received: by 2002:adf:9bd7:: with SMTP id e23mr47724149wrc.349.1626939944019;
        Thu, 22 Jul 2021 00:45:44 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6970.dip0.t-ipconnect.de. [91.12.105.112])
        by smtp.gmail.com with ESMTPSA id d24sm1869662wmb.42.2021.07.22.00.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 00:45:43 -0700 (PDT)
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
References: <20210718214134.2619099-1-surenb@google.com>
 <20210718214134.2619099-2-surenb@google.com>
 <6ab82426-ddbd-7937-3334-468f16ceedab@redhat.com>
 <CAJuCfpEGexDf0=Lfc66d8puUOf5FXxO3aUWffMhRFLPsiYs91A@mail.gmail.com>
 <CAJuCfpHWTA+bGfg=aaRzmiszpo1pphJDL2T7=XSzzjfekSgW8w@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/3] mm: introduce process_mrelease system call
Message-ID: <472b91d2-d678-2d54-b2d0-8618f32e6e69@redhat.com>
Date:   Thu, 22 Jul 2021 09:45:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJuCfpHWTA+bGfg=aaRzmiszpo1pphJDL2T7=XSzzjfekSgW8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Getting a hold of the mm and locking the mmap_lock would be sufficient I guess.
> 
> That's exactly what I do here. The simplified sequence is:
> 
>         task_lock
>         if (task_will_free_mem())
>                 mm=mmget()
>         task_unlock
>         if (!mm) return;
> 
>         mmap_read_lock(mm)
>         __oom_reap_task_mm(mm)
>         mmap_read_unlock(mm)
>         mmput(mm)
> 
> Or did I misunderstand your comments?

Oh, sorry, my tired eyes confused "put_task_struct()" with 
"task_unlock()" and even "mmget()" with "mmgrab()" ...

So this is essentially get_task_mm() with an additional 
task_will_free_mem() check.

LGHTM!

:)

-- 
Thanks,

David / dhildenb

