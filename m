Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E2B44E3A2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 10:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbhKLJLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 04:11:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58002 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234711AbhKLJLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 04:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636708111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ujeVOJaP3l3Agh5Fd01V+TO1YiXBRY47fAbGw6BqApM=;
        b=IP61uZCXgCyr6llBpq4ygb3rGQ0DSZV/WxxMa8d/i70dRbVlJdC0RdtmsJCI1KYEm8WDiN
        lfQ1zc8X1cEeTjAGuuureteiIv0GUHWTcjRLMtDLSwPcvsdMj6EudCf02JyGGXfVlLAr+J
        uZLP+Eq4Ok9Zh/73e+kv8EHd59yTXbI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-BQosB3tdOCmrRmjcgTns-g-1; Fri, 12 Nov 2021 04:08:28 -0500
X-MC-Unique: BQosB3tdOCmrRmjcgTns-g-1
Received: by mail-lj1-f198.google.com with SMTP id f6-20020a2e9e86000000b00211349f9ce3so2892353ljk.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 01:08:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ujeVOJaP3l3Agh5Fd01V+TO1YiXBRY47fAbGw6BqApM=;
        b=K7moxPeL/v+EPVKBiwAYqLFWRW8tHC14xPUp8BzV5VAqMFXxyhrYALX6XPKkGDHhf/
         GypQiDHochOqCFzZwkfNo/XiM4q4n7aEQjmRDsZnZmJKXhYxVegKx8s2YjUJrTX52rRZ
         d7VVb33ars0vIDeKx9GJ+Lbs0h6cI2Gjfu66Gklja/e+qDeLUG6hp3Hr6EuL/ebpD7Rl
         JnonXtvdbnoBCtytUIbGjlIcx20NxlUOR3apJA4M9antQj7gwTfia7ISJVyVIA27TD6/
         HEDftqQ7iQ2+7y8DXhBNJ0EfAk5mdmjxxI3qxWRNo4FLdRySIUIFValUHSIly2BI7fqt
         CZJw==
X-Gm-Message-State: AOAM5328AmfsTfUZ7yc7MA42qMjIQGpsUh5G6GrOhP6O3XAY5JtAYIqs
        EWgnYi3GHfZy0zDoWD1yiplsknF8F0lpXVOGGLtLDGtcIJp3QoBKpkPgUCprxLeUvQjpAiQgbmw
        ZmkfuKxZjlRaZqwyprh+F6fDvUqozgMur4Q5dovOH
X-Received: by 2002:ac2:4341:: with SMTP id o1mr12750433lfl.297.1636708106671;
        Fri, 12 Nov 2021 01:08:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwCc2uOBlvYGYG6DZyxhxuF39PB33M8nb2w4etD6lIMHAvP93dNADJAYeJYTDPnFUoiH+M+IkY/35BQGVeyOL4=
X-Received: by 2002:ac2:4341:: with SMTP id o1mr12750368lfl.297.1636708106001;
 Fri, 12 Nov 2021 01:08:26 -0800 (PST)
MIME-Version: 1.0
References: <20211111191800.21281-1-david@redhat.com> <20211112070113.GA19016@MiWiFi-R3L-srv>
 <21bdcecd-127c-f70e-0c7d-cb1b97caecb0@redhat.com> <20211112090116.GC19016@MiWiFi-R3L-srv>
In-Reply-To: <20211112090116.GC19016@MiWiFi-R3L-srv>
From:   David Hildenbrand <david@redhat.com>
Date:   Fri, 12 Nov 2021 10:08:14 +0100
Message-ID: <CADFyXm7uS3GN1AnF-iLpUZMFK=MwF3=NGwSZFqXPA+kK182-cQ@mail.gmail.com>
Subject: Re: [PATCH v1] proc/vmcore: fix clearing user buffer by properly
 using clear_user()
To:     Baoquan He <bhe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > "that allows supervisor mode programs to optionally set user-space
> > memory mappings so that access to those mappings from supervisor mode
> > will cause a trap. This makes it harder for malicious programs to
> > "trick" the kernel into using instructions or data from a user-space
> > program"
>
> OK, probably. I thought it's triggered in access_ok(), and tried to
> figure out why. But seems we should do something to check this in
> access_ok(), otherwise the logic of clear_user/_clear_user is not so
> reasonable. Anyway, I have learned it, thanks a lot for digging it out.
>
> By the way, I can't open above wiki article, found below commit from
> hpa. Maybe we can add some into log to tell this, not strong opinin,
> leave it to you.

Yes, now that we know the root cause I'll add some more details to the
patch description and resend -- thanks Baoquan!

