Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805003FD780
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 12:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbhIAKTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 06:19:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42004 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232662AbhIAKTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 06:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630491497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pfADcfJ+X6OH5HhkKuNHIMe8xl+JwSPkUuOE45UHKJk=;
        b=jQ9/tBGG0UWBc1e8Wjlfvn3h9EITfwFkYGAd1yaa4QiKMHFYz3OztXnVbSqE+s7xdlUBmE
        X629/OEIRU2GinLOoknRzKI4ht3o+I5SXGAwPhVx86Iq7ebHpfBYeXG9tdIVLvpJOAG/7+
        /jkQ6ZXd8oVW8hpKRi57+v0v4Diltnc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-77K9f22YPhm-keHrKYAVLg-1; Wed, 01 Sep 2021 06:18:16 -0400
X-MC-Unique: 77K9f22YPhm-keHrKYAVLg-1
Received: by mail-wr1-f69.google.com with SMTP id h6-20020a5d4fc6000000b00157503046afso630062wrw.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 03:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pfADcfJ+X6OH5HhkKuNHIMe8xl+JwSPkUuOE45UHKJk=;
        b=s5cz5ELB04FjFvD3dB8n76rWO/3wzEPcbxGwhqqWRUNOV34ZBFqOS5Dr5XOy6pCEuW
         XNlnqSkoawg4Q0E4xMxkVxyRtDwx7OZSXxQzRC56XmQtHuUuF0Gb6oJB/tI9ZaC4gyWK
         Fkrcx7Zh6O9DgIqYGIzwqfawEWjcALwtMce2DLKDvxZPikgrVFrXOlpjOUOGuZ57lTXn
         VkB+3/givhDwPrTR3UMK683CeBpj4PItWvX25oaGDl203CD9EvGYD1kXtsIRecASWH7Z
         hp2elfKfocTR9T8+d/rkykQjwnR6TPz/A6y3DovyB/WaMZBDItrcb4KoiA2hcBXi1M4l
         nHMA==
X-Gm-Message-State: AOAM5326xQ+kurag9ho/TX2tufYfJR/RHtONrcuhTeYogTcgUZUZ1TYD
        cbVRB3/9UKt1QQQYiQgMRMnXu8ZxJFjifiwyS/FIV53lf28SJr3UboUyskCDIFHZS5bDCQ40Hve
        hVW4KT1DrJYNj+grVy0XhkmSpGTno42j8QcHsRlBXDXAk6W6Y5aZ9i51Yf2YqB4pGvMLUL/BZ
X-Received: by 2002:adf:ded1:: with SMTP id i17mr36067484wrn.303.1630491495246;
        Wed, 01 Sep 2021 03:18:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBQ2JXSxWqoEFQjgI3t+tVxFgFMPLx+PPKEC08FLlesLGiXIaz3K39pW+9UMEpvpCe4gfxaA==
X-Received: by 2002:adf:ded1:: with SMTP id i17mr36067455wrn.303.1630491494984;
        Wed, 01 Sep 2021 03:18:14 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23f71.dip0.t-ipconnect.de. [79.242.63.113])
        by smtp.gmail.com with ESMTPSA id b24sm4670541wmj.43.2021.09.01.03.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 03:18:14 -0700 (PDT)
To:     David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3285174.1630448147@warthog.procyon.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: Folios: Can we resolve this please?
Message-ID: <3c0833bd-4731-aeb2-e9d4-bd480276ae6c@redhat.com>
Date:   Wed, 1 Sep 2021 12:18:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3285174.1630448147@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.21 00:15, David Howells wrote:
> Hi Linus, Andrew, Johannes,
> 
> Can we come to a quick resolution on folios?  I'd really like this to be
> solved in this merge window if at all possible as I (and others) have stuff
> that will depend on and will conflict with Willy's folio work.  It would be
> great to get this sorted one way or another.
> 
> As I see it, there are three issues, I think, and I think they kind of go like
> this:
> 
>   (1) Johannes wants to get away from pages being used as the unit of memory
>       currency and thinks that folios aren't helpful in this regard[1].  There
>       seems to be some disagreement about where this is heading.
> 
>   (2) Linus isn't entirely keen on Willy's approach[2], with a bottom up
>       approach hiding the page objects behind a new type from the pov of the
>       filesystem, but would rather see the page struct stay the main API type
>       and the changes be hidden transparently inside of that.
> 
>       I think from what Linus said, he may be in favour (if that's not too
>       strong a word) of using a new type to make sure we don't miss the
>       necessary changes[3].
> 
>   (3) Linus isn't in favour of the name 'folio' for the new type[2].  Various
>       names have been bandied around and Linus seems okay with "pageset"[4],
>       though it's already in minor(-ish) use[5][6].  Willy has an alternate
>       patchset with "folio" changed to "pageset"[7].
> 
> With regard to (1), I think the folio concept could be used in future to hide
> at least some of the paginess from filesystems.
> 
> With regard to (2), I think a top-down approach won't work until and unless we
> wrap all accesses to struct page by filesystems (and device drivers) in
> wrapper functions - we need to stop filesystems fiddling with page internals
> because what page internals may mean may change.
> 
> With regard to (3), I'm personally fine with the name "folio", as are other
> people[8][9][10][11], but I could also live with a conversion to "pageset".
> 
> Is it possible to take the folios patchset as-is and just live with the name,
> or just take Willy's rename-job (although it hasn't had linux-next soak time
> yet)?  Or is the approach fundamentally flawed and in need of redoing?

Whatever we do, it would be great to get it out of -next one way (merge) 
or the other (drop) ASAP, as it's a lot of code churn, affecting various 
subsystems.

But merging it in a (for some people) suboptimal state just to get it 
out of -next might not necessarily be what we want.

-- 
Thanks,

David / dhildenb

