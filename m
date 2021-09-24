Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2735E4176AD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 16:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346702AbhIXOQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 10:16:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52023 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231683AbhIXOP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 10:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632492865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vURCDQqb490vrVUUKxyIgtPmCzQpFb9HmiIOhgqiCwU=;
        b=UYmyaoLgsmAzsp/Eb2U649hatWDPnLmfyVI/zMBHA2OMkVYWNbO2VJDxcr4J7zytk6z6o4
        Sd4GfhtPQYBToBGNvZ+ojw+LNCwvfBUdkA2wtlCN8UWEHY1FNlBRNEj3rgUTHIOdzsSTL5
        l/DGXS5JYO82VAYEh3Y9sVJFRgDdS4c=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-0yeAb8DMMuW31PVzB0l4Ng-1; Fri, 24 Sep 2021 10:14:24 -0400
X-MC-Unique: 0yeAb8DMMuW31PVzB0l4Ng-1
Received: by mail-qt1-f199.google.com with SMTP id 62-20020aed2044000000b002a6aa209efaso28603204qta.18
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 07:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vURCDQqb490vrVUUKxyIgtPmCzQpFb9HmiIOhgqiCwU=;
        b=MO2UkrWuqs6MrmDVAipyGdzjjpBYDy9/igu4OJVwFcr08xC/vC6diaSsU/tvrP9fiU
         To9LvOyJiZCHei2xaGD+lGrFyoAUdlsQJrM+aOnkI18AnbhhGrMG4KHGIXwUIHaGoRWP
         GepnxG4nAsH7nzi89Vx1DnR4OIeHit0FezOjUv+5iR2PrKI5do2bMNIqL1MecDSE6Mff
         ABcc1kAedv4MBhRKiLuINPnR6ded8M+wsloYrvux6kAgwIKgULze25P5+RMmMPiBhivK
         XPx6ahOqmBNkTBskFuRbrGbqZEtoNmBXE+pZ9gGYSagq85ecr2nWD6OrOfbrPieOKm+A
         HxLg==
X-Gm-Message-State: AOAM530IxvjeunPRnISsHvFj31KXhf2uwU6Duhw2f2RY/KJRnUP/aPwV
        QqDMCscdvkye6GsZf0coQmQw8mk30rLsVAj7Vxgrs5+xmAEPluul2OEPYkf6eKoO84r4ftTjIF4
        p1K5iSXwLDypD8L3WLL2avK2J
X-Received: by 2002:a37:6658:: with SMTP id a85mr10875028qkc.34.1632492863541;
        Fri, 24 Sep 2021 07:14:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/FAo093naG96wtcJ0fkUoyMpB/ZaTO5SeisakJVzb4CYFdg7k3z6NELRzuk4IUhVd9yK71g==
X-Received: by 2002:a37:6658:: with SMTP id a85mr10874997qkc.34.1632492863209;
        Fri, 24 Sep 2021 07:14:23 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id v8sm5214030qtk.49.2021.09.24.07.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 07:14:22 -0700 (PDT)
Date:   Fri, 24 Sep 2021 10:14:21 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>, Li Wang <liwan@redhat.com>
Subject: Re: [PATCH] mm/userfaultfd: selftests: Fix memory corruption with
 thp enabled
Message-ID: <YU3dPTsNWVhEo/5y@t490s>
References: <20210923232512.210092-1-peterx@redhat.com>
 <20210923191941.da28da4400c11a3241a07acf@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210923191941.da28da4400c11a3241a07acf@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 07:19:41PM -0700, Andrew Morton wrote:
> On Thu, 23 Sep 2021 19:25:12 -0400 Peter Xu <peterx@redhat.com> wrote:
> 
> > In RHEL's gating selftests we've encountered memory corruption in the uffd
> > event test even with upstream kernel:
> > 
> > ...
> >
> > 
> > We can mark the Fixes tag upon 0db282ba2c12 as it's reported to only happen
> > there, however the real "Fixes" IMHO should be 8ba6e8640844, as before that
> > commit we'll always do explicit release_pages() before registration of uffd,
> > and 8ba6e8640844 changed that logic by adding extra unmap/map and we didn't
> > release the pages at the right place.  Meanwhile I don't have a solid glue
> > anyway on whether posix_memalign() could always avoid triggering this bug,
> > hence it's safer to attach this fix to commit 8ba6e8640844.
> > 
> 
> Thanks.  I added a cc:stable to this.  I don't think we want selftests
> in older kernels to be falsely reporting kernel bugs?

Not sure how we normally handle such case for selftests, but I agree.

Btw, 8ba6e8640844 is merged in 5.14, so the only stable branch that will need
it will be 5.14.y; it can be applied cleanly there.

Thanks,

-- 
Peter Xu

