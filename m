Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F313792EA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 17:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbhEJPkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbhEJPj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 11:39:57 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D240FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 08:38:52 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id p17so10003340pjz.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 08:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TPvcQCXvDX0U7RDZdZH95k1gUsIcweRlVHc3KTXarJk=;
        b=WnjtfBz40ML+d5x7ADRLmiMm02c4xlccwyOfB7T0FwayBGuUM6iJs8p80tPE3oWU9Z
         odiz7lrk8BpAQpTqXOX5PrvaUtObz0ueImqdLyv/ZdhkSMoBTBbe3VXkbXUdDOpw3MRe
         52iLnbOmREYc7yXY44Ns+VBgu9NyYP6NhJgQ7FSsTLXtsNKvXGCueGEbyWxv5/sbXAMY
         LS9ctApBNtOrFPewoFktTYCApjymEO339L8mGvFnIc21e7zr9pM/boKZESypGRjqGzYP
         vmeh36hX6xqOg558QkZuAG+Oc9dK3mu3BDghGEUq1PpvIBXuUwqoxLyTwflreugeZBf9
         iixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TPvcQCXvDX0U7RDZdZH95k1gUsIcweRlVHc3KTXarJk=;
        b=iU4VbjjCZXEBCxltt9EkHqQ1Y8G8trXSLemGj483JzagPDFCVMVKIj8QPXPAQwWl5d
         w9uTEP5Y6M8S/4W5o3+iQ6BZw7RySrr04jo0dKAYURKVg7USBmwO9K1qu4L+OWi5gpFR
         +3SHOYqJbEK8GLa6GQCyusYS26d3E8R+iSN3xZFD5HLo7btTJShaVugrCXJlxw7wVrQX
         gdLZkTW/YOPm/X+XihVtPVcTUT+ussMTv7v8X/h9Y1uEJMjcxN/QO9vMP18hnd1c+13F
         /5qkZxKOVo4c5WVp6wJjZRy4Mh1d0RIec18m4ZujqHJdfpGVmWUyRlxxJPlsr23dwQdj
         85gw==
X-Gm-Message-State: AOAM5339Xq1tjijRJnW6PU+YasSjXGt6k0v+CNsRCG8RNx2r0ZDr1yz1
        fu6zuXqNChOoqdQerXPbauk=
X-Google-Smtp-Source: ABdhPJyynsLokTt/82/HW6Tevuk0fqq3BYQm0YcYjS4dmODSbGZ5VnnetREWJxRuS2iPTVsmiB0VIg==
X-Received: by 2002:a17:90a:55c5:: with SMTP id o5mr27742585pjm.169.1620661132340;
        Mon, 10 May 2021 08:38:52 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
        by smtp.gmail.com with ESMTPSA id 79sm11530219pfz.202.2021.05.10.08.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 08:38:52 -0700 (PDT)
Date:   Tue, 11 May 2021 00:38:46 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: kmalloc_index: make compiler break when size is
 not supported
Message-ID: <20210510153846.GA77398@hyeyoo>
References: <20210508221328.7338-1-42.hyeyoo@gmail.com>
 <YJccjBMBiwLqFrB8@casper.infradead.org>
 <CAB=+i9QyxOu_1QDfX5QA=pOxxnRURPnwd2Y0EbhoO1u0e=irBA@mail.gmail.com>
 <c305ec02-a7d6-dd0c-bfee-e5b571d9ca9a@suse.cz>
 <20210510135857.GA3594@hyeyoo>
 <9d0ffe49-a2e2-6c81-377b-4c8d2147dff8@suse.cz>
 <20210510150230.GA74915@hyeyoo>
 <90591d7e-41e4-9ae5-54ae-ded467c498cf@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90591d7e-41e4-9ae5-54ae-ded467c498cf@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 05:19:58PM +0200, Vlastimil Babka wrote:

> I'd rephrase the subject:
> mm, slub: change run-time assertion in kmalloc_index() to compile-time
>

> "... compiler will generate a run-time BUG() while a compile-time error is also
> possible, and better"

> "there's no need to..."
>       kmalloc-32M


Vlastimil Babka and Christoph Lameter, thank you for reviewing the patch.

I'm not familiar with kernel community yet. should I send patch v3 again,
or can you update it directly?
