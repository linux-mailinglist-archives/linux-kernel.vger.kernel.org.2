Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870B045EA93
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 10:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376403AbhKZJpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 04:45:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20077 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353248AbhKZJnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:43:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637919595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d+MbKzbSxHjIA6t9o3YVjZnz5SQmDgr1fFtyjFIixQk=;
        b=XWkpyBbL080tTOdD2VogMdxcfEwJ4+yM4PAd1MceW2LmJNUkN4mtM1i9okL2qh0uLa+ocT
        gVwBs5cmSlPLE7T8oi8Awnvm/58YkgV0/eYuwP7GGp3LNpvCXlg4TM247VStW3ZhA5yjZF
        maOYzrz/7KiDST2jtzmQmIsGrWEoRLk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-432-0KoB5agONaSjt1GCZvcy7w-1; Fri, 26 Nov 2021 04:39:53 -0500
X-MC-Unique: 0KoB5agONaSjt1GCZvcy7w-1
Received: by mail-pl1-f197.google.com with SMTP id m17-20020a170902db1100b001421cb34857so3650480plx.15
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 01:39:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d+MbKzbSxHjIA6t9o3YVjZnz5SQmDgr1fFtyjFIixQk=;
        b=E/adeWAmjXxSQKUNTiK/hGf86lQqieF/AALMFaJ0aw/znY85L8YkLZrpfnSRdwedLI
         +zAKyHYDcziq8JxMmIBS0LSZqJgzsNN6in67xVM0Zz34TcemTTZZCvtSe33fR2t0+8O+
         TNDXCgvWE4hBg4chLwo+85OckvkwMOJbYTljuAoTF8V6tNZZSqmqt+XFdNdxBlqOUbSf
         PLyro6mDDZI0SP+JBBipLxaqF5LhdlFt7IbSs03cokPLA/5KkdarRH2dRR1Dt4Ltr16w
         Ptg5lplEXCGyfKxu+AgqZPkA+i7qCxUwZA5BHr6bmelxaUwHKR3z6WDnE5yYA2ZhnPNN
         at0w==
X-Gm-Message-State: AOAM530Lt2XUZ2Rp6pRF+ROeTGtC+B6hRFJHDFsBAkLetL4X7g+OHyHz
        RwV0VQD4b1v9Z/x1IR5ctlIwTCmxanVS3Alm5RBPBcM2y6u0kruaN7+kdlvjZoRJzUKnUb2/wBO
        W9nseRMVj8VIpcWb8EwLeYLk5
X-Received: by 2002:a17:902:e8d7:b0:143:a088:7937 with SMTP id v23-20020a170902e8d700b00143a0887937mr36888392plg.63.1637919592460;
        Fri, 26 Nov 2021 01:39:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhAaWz6qVEk6a5PHY+htZMsnPH6WwZ9AVOyMjn7a/QhQ/1gMqqgr7b1Bt6aLWFwOp8G0sbqQ==
X-Received: by 2002:a17:902:e8d7:b0:143:a088:7937 with SMTP id v23-20020a170902e8d700b00143a0887937mr36888349plg.63.1637919591880;
        Fri, 26 Nov 2021 01:39:51 -0800 (PST)
Received: from xz-m1.local ([94.177.118.150])
        by smtp.gmail.com with ESMTPSA id f21sm7165609pfc.85.2021.11.26.01.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 01:39:51 -0800 (PST)
Date:   Fri, 26 Nov 2021 17:39:45 +0800
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
Message-ID: <YaCrYaTpdK45Y2s5@xz-m1.local>
References: <20211120201230.920082-1-shakeelb@google.com>
 <25b36a5c-5bbd-5423-0c67-05cd6c1432a7@redhat.com>
 <CALvZod5L1C1DV_DVs9O3xZm6CJnriunAoj89YLDdCp7ef5yBxA@mail.gmail.com>
 <YZ9kUD5AG6inbUEg@xz-m1.local>
 <CALvZod7L5Ga2xZOy_hgocsTxSuOYs840TiviOAhRwz59ATubWg@mail.gmail.com>
 <YaBevbuNuR+ToJ1o@xz-m1.local>
 <f464115b-f332-9f13-89c4-81bf6b282975@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f464115b-f332-9f13-89c4-81bf6b282975@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 10:16:58AM +0100, David Hildenbrand wrote:
> Would this really apply to MADV_DONTNEED on shmem, and would deferred
> splitting apply on shmem? I'm constantly confused about shmem vs. anon,
> but I would have assumed that shmem is fd-based and we wouldn't end up
> in rmap_walk_anon. For shmem, the pagecache would contain the THP which
> would stick around and deferred splits don't even apply.

Good point..  when split on shmem we just clear pmd, so yeah I don't think
we'll ever add it into the deferred list.

> User space can trigger a split manually using some MADV hackery. But it
> can only be used for the use case here, where we actually want to zap a
> page.
> 
> 1. MADV_FREE a single 4k page in the range. This will split the PMD->PTE
>    and the compound page.

Seems to be a very implicit but working solution indeed.

> 2. MADV_DONTNEED either the complete range or the single 4k page.

Is this what this patch is working on?

Thanks,

-- 
Peter Xu

