Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFEC35A60D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 20:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbhDISsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 14:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbhDISsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 14:48:02 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3345C061763
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 11:47:43 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id t14so5538862ilu.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 11:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QCxgqS+GIdc01GAi2BBY4vi+QbypofN8DAcQ//bJP/A=;
        b=eOj02iuOehaMaoynUqQfooPaxBNWHAp8bTG5A5IkhvUsfdX+T9CPj4hjEqgDJ7+WMG
         ZWsSHEo0iBr4B+wXExLqUV+UA2y/QJlBU3JXdMEWkORJYpzQa0DRh3L9LuuGRRduwrV/
         fu0AhAbfhSLTNybayB+jVi0xaS4FR3kgy967zTXD2G52cv1GeJvOSmy+XsVzZFqoavmw
         KETq52CpzMokakz0kLs2S+BcpxqQmHETgOwsoIG6qknhQ8/9BZEXeq69ZYlWP6yZf/m6
         DIksoQG14xqmX0uDRdhDpR8Uz2xKPrY6BI9P3dWwDiLsiDmz9UtQH/4PNGbLTTU1K9Mg
         V7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QCxgqS+GIdc01GAi2BBY4vi+QbypofN8DAcQ//bJP/A=;
        b=C9dKteyZ9HQdMs0v42pIrHTyXsQx0nB91WESdaSySY3VZddFsV37KRAlOMzZwT9R2b
         hx5a9JMQGTV1HW01KpjUhJzuo6cxExb7MvXy05PRvctqM/SieHpXs0zklAZyB9E1GA0h
         ktfihq0xMoUBz7W5acsw9JsA2yj+tBevvzUktfolaL3QF9XWmXCaSSCrPc8HZ16mYEue
         cSkATfrL+WbIT/jqhvmX5NWsnTqNha3QKHiLjZuba4bi4DDe5Wn6URLx3L5DNF+sVh8G
         B5xr7OMlm3Otxlk8aQz7Kkfb1Ubn78A4QFVMqiLR+2RzbKp3YkxPQ/LYSubulywQWmHo
         lXfw==
X-Gm-Message-State: AOAM531srBy83YoWSPt0tCaO5bhHvIfk2zNdwQOi2MkvsVJ4BSILJSgM
        57KX8j1v3ijxmRWylvkzprGMKwKsCCGcbH1s5WnhPQ==
X-Google-Smtp-Source: ABdhPJx072OlknUi2iEvkfpvMZPY78ass5Uo72enMkSesF5KKnbz78Uq6W6xvDu5uUt3uhGOseOKXC1h4RHlLASi8Xg=
X-Received: by 2002:a05:6e02:11a9:: with SMTP id 9mr2322814ilj.288.1617994063197;
 Fri, 09 Apr 2021 11:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210401183216.443C4443@viggo.jf.intel.com> <20210401183223.80F1E291@viggo.jf.intel.com>
 <YG7XjTG9tiK29y1j@localhost.localdomain> <CAHbLzkqoaSnuBJMAe_heQt01FuPWODYQHJ955gaJNNojwbUjrw@mail.gmail.com>
 <YG9IthpDC/lri4Qh@localhost.localdomain> <d200de95-c6be-75fd-7302-e5368894d201@intel.com>
In-Reply-To: <d200de95-c6be-75fd-7302-e5368894d201@intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 9 Apr 2021 11:47:31 -0700
Message-ID: <CAAPL-u8W7_9scDT3vRjmfpxu9shoDA5C1VDZKKr3WD3KvLDRbQ@mail.gmail.com>
Subject: Re: [PATCH 04/10] mm/migrate: make migrate_pages() return nr_succeeded
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Oscar Salvador <osalvador@suse.de>, Yang Shi <shy828301@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 9, 2021 at 8:50 AM Dave Hansen <dave.hansen@intel.com> wrote:
> I also considered passing NULL to mean "I don't care about
> nr_succeeded".  I mostly avoided it to reduce churn.  But, looking at it
> here, it does seem cleaner.
>
> Any objections to moving over to Oscar's suggestion?

I like this approach (making *nr_succeeded an optional argument).  No
objection here.
