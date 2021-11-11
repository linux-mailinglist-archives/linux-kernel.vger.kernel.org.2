Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3427C44D499
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 11:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhKKKEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 05:04:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51458 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232764AbhKKKE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 05:04:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636624897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CNcPNFwkNZzPAAuuM2VldGNI2vkzqJbh7gXLQwgsqaU=;
        b=hvPzXCvPHr3ou++F0wk0GzrkUJPQnk31FefPh/EefgUMcYNkJrK6Z5GCq9u5Ngj291GWJy
        kz+uq6hSC8Xk/c50OU3VA8joNTEFYknkCXrMWLMPuaJIkh8jdJkQYgxnIEcbHxonMvSgJY
        Zomftnkrl9HHYkLEUBBC5Fu9B37WHNc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-0StJi0FwO8GjUGDcq-cwHA-1; Thu, 11 Nov 2021 05:01:35 -0500
X-MC-Unique: 0StJi0FwO8GjUGDcq-cwHA-1
Received: by mail-wm1-f72.google.com with SMTP id l6-20020a05600c4f0600b0033321934a39so2438432wmq.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 02:01:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=CNcPNFwkNZzPAAuuM2VldGNI2vkzqJbh7gXLQwgsqaU=;
        b=cm3SRQ4WMzuXTJSkmi/S0xA7YpfyBWEaMb426SKuIsXKtRIKAKnzR0JL6k2IEJ8j6S
         5rpyyDCRpfKma4PkNarZ37ehHsjX8VtqISf1x8jEaprXXbwD4dJIy7yfqd//swpniGKA
         TSPN3WFoQokWIAt40U4KfcgLj8hTkg5n7PhOJaclt8iLnNprs2QfZpZfCLpx+Mzc5Pq/
         /OBnM8xCYwEiL2TN4joE8bpkdnLtMQ6qjnFxH7eS+JXRxKHK/cBB7tSmf0IqZScTzRYw
         nObrXzllw7uTxMKyhhctJPyg8MT8U/8nv+WGqGk70gwvx3uIzzFejjp8YDGjGjvM1Rlu
         nXFQ==
X-Gm-Message-State: AOAM531z0L3u4cq0hK0XTXeIYW1svW1jjNUeSxF84HwtBd4yyx6bcbRo
        3LDFnLnF6+P7SHveV8Oz8ecx6syndt669oxM0DzVsWnwibpLXP++TPIUTlv37YeEGUwk42kU3WI
        sHhjGnanGWxMgQAKDm9Cei2T4
X-Received: by 2002:a1c:f601:: with SMTP id w1mr24132438wmc.112.1636624894455;
        Thu, 11 Nov 2021 02:01:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+YnB30s3H7o5szg4rvm692l/bAna1bgr0sO3KWz/TpfPh1f2WsLYXFlxrtbeUq96NmLkNQw==
X-Received: by 2002:a1c:f601:: with SMTP id w1mr24132395wmc.112.1636624894177;
        Thu, 11 Nov 2021 02:01:34 -0800 (PST)
Received: from [192.168.3.132] (p4ff23ee8.dip0.t-ipconnect.de. [79.242.62.232])
        by smtp.gmail.com with ESMTPSA id a22sm2227713wme.19.2021.11.11.02.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 02:01:33 -0800 (PST)
Message-ID: <794ecf14-a25e-8222-9f9c-7a77796fff6d@redhat.com>
Date:   Thu, 11 Nov 2021 11:01:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 3/7] drivers/infiniband: use get_task_comm instead of
 open-coded string copy
Content-Language: en-US
To:     Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        oliver.sang@intel.com, lkp@intel.com,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>
References: <20211108083840.4627-1-laoar.shao@gmail.com>
 <20211108083840.4627-4-laoar.shao@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211108083840.4627-4-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.11.21 09:38, Yafang Shao wrote:
> Use get_task_comm() instead of open-coded strlcpy() to make the comm always
> nul terminated. As the comment above the hard-coded 16, we can replace it
> with TASK_COMM_LEN, then it will adopt to the comm size change.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Michal Miroslaw <mirq-linux@rere.qmqm.pl>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Petr Mladek <pmladek@suse.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

