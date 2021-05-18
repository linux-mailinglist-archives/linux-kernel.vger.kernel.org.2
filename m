Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D84387F2C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351415AbhERSDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:03:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52484 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344188AbhERSC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621360900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oue7U1wjftn7xVwPmUZCJccBeCJY9jE5A9d8yc2+hO4=;
        b=IDwGlXLr1PcmK2OfwCyfdYEBBpzgJOsiKuEmyVxaqjfIfHY2MkQlUvjwaDu7QQazRbmaaK
        zvTp6oimEI/VPZhXN2pvQfl9DhDLT8XWfw9P7igvy8xreA4vPZgGt/RjNos13fd/bq1dI5
        YUzLGRrQuMX4koV2pUkeWcQ0t9Uw3sc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-9dtl-DaMPjiw5p7i7wfXGA-1; Tue, 18 May 2021 14:01:39 -0400
X-MC-Unique: 9dtl-DaMPjiw5p7i7wfXGA-1
Received: by mail-qk1-f197.google.com with SMTP id v1-20020a05620a1221b02902ea88445e01so7755359qkj.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 11:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Oue7U1wjftn7xVwPmUZCJccBeCJY9jE5A9d8yc2+hO4=;
        b=ZpMuWrMQyLFkOEL8Wh0HRKcLmcD8/3Z3E786G8clVqzqyqlvDiNgwUbVFljpuAK9x3
         5HPxbRLwlzs79qKP2NUkMbM0Bb9RRoNRLuUnPXaYTbrnUAv0PM+0xR0GaraeLaZsDObJ
         kOXSPApVJTQ9yMeiG4RKr2z8VzlvTcumX6vPB1Of/8yrWa1FZHKkxEjhtgDLsyaY8W6U
         h4JQogo8OfQ/V2pTwolYSwaxWLnPQhYX1E5SH20hokWm885OXuXLOaw/4tSLm+SmXEOo
         6IR5HlmFVrQRzUXkPDAO9HUGdILkznleNXRzYSge7m6SwPEEw/UybxOtm5tWho2q8Xg5
         vgVA==
X-Gm-Message-State: AOAM531emcWLQTqpAZhh2Fx0jdfI6PsIrIjbpMUmVySdCaTcQS7dMthn
        uA1JAFHggh/aNZVonX0IOGzfeqCDbVEME4MCSU460RlC+Z52BXuS3smU3WrZprZ2JPC4JNcDhx5
        FFc4r3fqd3PSKqlVPQU5jCCNN
X-Received: by 2002:ac8:a49:: with SMTP id f9mr6060393qti.157.1621360898457;
        Tue, 18 May 2021 11:01:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTICgj8/egwsE0Ivgqvw8kGv1T8HxyWhbScHPLgGtw0FYHBEe8vymzLu/hxY0OnGRaALaW5w==
X-Received: by 2002:ac8:a49:: with SMTP id f9mr6060354qti.157.1621360898147;
        Tue, 18 May 2021 11:01:38 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id b23sm1488671qtp.7.2021.05.18.11.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 11:01:37 -0700 (PDT)
Date:   Tue, 18 May 2021 14:01:36 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, bskeggs@redhat.com,
        akpm@linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        jhubbard@nvidia.com, rcampbell@nvidia.com, jglisse@redhat.com,
        hch@infradead.org, daniel@ffwll.ch, willy@infradead.org,
        bsingharora@gmail.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 5/8] mm: Device exclusive memory access
Message-ID: <YKQBACJCjsxeM3ro@t490s>
References: <20210407084238.20443-1-apopple@nvidia.com>
 <20210407084238.20443-6-apopple@nvidia.com>
 <YKMhorngO2DVrxac@t490s>
 <47694715.suB6H4Uo8R@nvdebian>
 <YKP5Dj4Q/riGGc43@t490s>
 <20210518173334.GE1002214@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210518173334.GE1002214@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 02:33:34PM -0300, Jason Gunthorpe wrote:
> On Tue, May 18, 2021 at 01:27:42PM -0400, Peter Xu wrote:
> 
> > I also have a pure and high level question regarding a process fork() when
> > there're device exclusive ptes: would the two processes then own the device
> > together?  Is this a real usecase?
> 
> If the pages are MAP_SHARED then yes. All VMAs should point at the
> same device_exclusive page and all VMA should migrate back to CPU
> pages together.

Makes sense.  If we keep the anonymous-only in this series (I think it's good
to separate these), maybe we can drop the !COW case, plus some proper installed
WARN_ON_ONCE()s.

> 
> > Indeed it'll be odd for a COW page since for COW page then it means after
> > parent/child writting to the page it'll clone into two, then it's a mistery on
> > which one will be the one that "exclusived owned" by the device..
> 
> For COW pages it is like every other fork case.. We can't reliably
> write-protect the device_exclusive page during fork so we must copy it
> at fork time.
> 
> Thus three reasonable choices:
>  - Copy to a new CPU page
>  - Migrate back to a CPU page and write protect it
>  - Copy to a new device exclusive page

IMHO the ownership question would really help us to answer this one..

If the device ownership should be kept in parent IMHO option (1) is the best
approach. To be explicit on page copy: we can do best-effort, even if the copy
is during a device atomic operation, perhaps?

If the ownership will be shared, seems option (3) will be easier as I don't see
a strong reason to do immediate restorinng of ptes; as long as we're careful on
the refcounting.

Thanks,

-- 
Peter Xu

