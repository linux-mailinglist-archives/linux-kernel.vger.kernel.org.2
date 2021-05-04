Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09062373173
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 22:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbhEDUfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 16:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhEDUfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 16:35:39 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712FCC061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 13:34:44 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id m124so3393585pgm.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 13:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xZh5Y3Pycejv1m9DWOP0dUEdTVZDmfy7scOMGuocpyg=;
        b=kP7KQ8L++la08rXy0f24IUWv9yJx2B4qP8piKRHt0V3W7mIVBti15CahRBjU8dIvFk
         EcC5CO7iRcuhDI8NZKAKeIYoSCcwMpDGlyZ7ilXIRDJ+QFfopLO8C/slNQ+ODojZI5+y
         A8TeVg5aJNN2xUsaG7j9Lx/leW8nwtg/JJEi9wBvDx290+Hs7zRVYLK0Oaozl+uoxJrH
         Xf80QGNVe7y6xqGhNoFhXrPXgcHOLiE5qj3lZh0Nex0bG2oqCF+JbQKBbVw33bvsV0RC
         pVKJsUTaAQYZ89MApjbQF/j2uCRXwnu6XTMfh3PuKljhumO9uxD3B6NXoXCAw3qeDUYo
         qXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xZh5Y3Pycejv1m9DWOP0dUEdTVZDmfy7scOMGuocpyg=;
        b=cFcFPbdVnc7dCUmJNTsEZYDGXwwZC4PTDPI8cNW9uEojshfsBmZxLLtWfAHbLilzL6
         ZT1MRT6rtWHehTj9WHjGn5izujkuKTQAk1OWmcyRVBziqiJ//2J2HEcOhC6hT0mZEidD
         XIHN8ZRONctRWEao9/QJC6K8Zl/+3TvfxrSBS7liE2XcAZuKW54AxLPv8+LLvV0GXoTl
         1ugjMDQaoLUVSNTixKSG9rhLGtkFSQmKK5wncMMN7ItPYsL4mPYPWyzaGCybaRhi9tGy
         7bki+z58zOlQ75RCsRg1LJGUZF6RJaimgy7RRS3o2WYShSZWX+tgAtcgjq1TY+GZQSSj
         YibA==
X-Gm-Message-State: AOAM531/oj1cRCDKo/JSlafCxSBQ+eT1GMt7Ix1RkDjgJL+Tb5cd4+r+
        u0kM+ftvU8rr1See6cuJMLKbMw==
X-Google-Smtp-Source: ABdhPJzvj6EcxdAWXmzI3GNIGv4C0d0+HRyWo9CIsE81c0KJW4DU0MMTI9WXnFS7ZU/3/P2i3V7UlQ==
X-Received: by 2002:aa7:8703:0:b029:261:4680:9723 with SMTP id b3-20020aa787030000b029026146809723mr25418581pfo.70.1620160483887;
        Tue, 04 May 2021 13:34:43 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id q27sm7807452pfl.41.2021.05.04.13.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 13:34:42 -0700 (PDT)
Date:   Tue, 4 May 2021 20:34:39 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Peter Shier <pshier@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Subject: Re: [PATCH v2 7/7] KVM: x86/mmu: Lazily allocate memslot rmaps
Message-ID: <YJGv34BOxa8YJvRy@google.com>
References: <20210429211833.3361994-1-bgardon@google.com>
 <20210429211833.3361994-8-bgardon@google.com>
 <YJGqzZ/8CS8mSx2c@google.com>
 <781d2549-bbb1-23a2-44bf-58379ba23054@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <781d2549-bbb1-23a2-44bf-58379ba23054@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021, Paolo Bonzini wrote:
> On 04/05/21 22:13, Sean Christopherson wrote:
> > > +	/*
> > > +	 * If set, the rmap should be allocated for any newly created or
> > > +	 * modified memslots. If allocating rmaps lazily, this may be set
> > > +	 * before the rmaps are allocated for existing memslots, but
> > > +	 * shadow_mmu_active will not be set until after the rmaps are fully
> > > +	 * allocated.
> > > +	 */
> > > +	bool alloc_memslot_rmaps;
> > Maybe "need_rmaps" or "need_memslot_rmaps"?
> > 
> 
> Since we're bikeshedding I prefer "memslots_have_rmaps" or something not too
> distant from that.

Works for me.
