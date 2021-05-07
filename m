Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1493737669C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 16:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbhEGOFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 10:05:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53759 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233689AbhEGOFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 10:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620396258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cBC+Gvt3dKL/d3xZzU0Jm6gFzpZLfTG7TS3XvNjDT8I=;
        b=EhOOP8liF2fPZIo7i+vXuAGPlrnNj0KgC9Lc4EgGY+wzUf0Vkfu3wwOpMbK9nWZVcfgzZc
        CCY+QWQ4w7OZGQJRKYy3eG9saTm1u6sMtKrAhHTzyiZUFlUpYm5nzptWyhm2oPEEVG9PKL
        W8CZ2APr8IGKhuIBqQ5Gh8C1SvCUZiI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-sUyLBJgcOSaLvw9o4r6QYA-1; Fri, 07 May 2021 10:04:16 -0400
X-MC-Unique: sUyLBJgcOSaLvw9o4r6QYA-1
Received: by mail-qk1-f197.google.com with SMTP id h15-20020a37de0f0000b029029a8ada2e18so6172081qkj.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 07:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cBC+Gvt3dKL/d3xZzU0Jm6gFzpZLfTG7TS3XvNjDT8I=;
        b=cyy50W8qpk+poXPuGwoNDt1/LJJ7WqnUAwVlTVhAY+vlH/uOB3G6z4wN0CMpwbYVok
         p4/tg7192WpxzaC5EmeGfN15/gvBbOuEei6RRjWNTzhN9WbAjVkZkchIGLoKAGEDEGHh
         y+o2FwbtE7Nl3zcCtxvhcLKnNvrubXy79FLWOgld8YupOfpGzlIQNzq9xthIV7zNxqA5
         5Bc6rjTDVWiZKPqiII2vbKINNiuqSCO3PJMEzS5c0hsLOZCfOnjJGxWyL3hkH6xmvE9e
         j2pDlng+8+PcmzGyRsHXX4bc63Nqoe9/DVE5Fg+e1CkrBZ6kp3v3v/i59kQxIaiWLI0B
         tJ1w==
X-Gm-Message-State: AOAM532ORJn6WbTlMFPjzORomIWijGnLU13d+tSesDkVkx7D9tCs1IbD
        A9l4XPEeX6XB7ynYimHahH+9bgbaHq7Y6YJFY4ZK0UtyOQ5NVJO4O3KCrmHnd5X3RKQNwqbe3P4
        lNW1B9Mn3wcacivibjd2M5/OA
X-Received: by 2002:a0c:a404:: with SMTP id w4mr10394303qvw.45.1620396256075;
        Fri, 07 May 2021 07:04:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOU6EDGLDyPbm7YRcFnuUL8IbLs3W/+/YQMxJsr1/Qu8M9wehAyCoyxry7oCtPzmn1uD1nuw==
X-Received: by 2002:a0c:a404:: with SMTP id w4mr10394272qvw.45.1620396255835;
        Fri, 07 May 2021 07:04:15 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id q7sm4857441qki.17.2021.05.07.07.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 07:04:15 -0700 (PDT)
Date:   Fri, 7 May 2021 10:04:13 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 1/3] mm/gup_benchmark: Support threading
Message-ID: <YJVI3QAqT2TruTjq@t490s>
References: <20210506232537.165788-1-peterx@redhat.com>
 <20210506232537.165788-2-peterx@redhat.com>
 <a631bb81-a8a7-0423-4e7c-e0cf213e932b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a631bb81-a8a7-0423-4e7c-e0cf213e932b@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 09:37:37PM -0700, John Hubbard wrote:
> On 5/6/21 4:25 PM, Peter Xu wrote:
> > Add a new parameter "-j N" to support concurrent gup test.
> 
> I had a long-standing personal TODO item that said, "decide if it's
> worth it, to add pthread support to gup_test". So now, at least one
> other person has decided that it *is* worth it, and you've also written
> the patch. OK, then. Sweet! :)
> 
> This looks correct to me. I have a couple of minor comments below, but
> either way you can add:

I'll address them.

> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Thanks!

-- 
Peter Xu

