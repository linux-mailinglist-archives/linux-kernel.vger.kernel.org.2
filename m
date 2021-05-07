Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55423766EB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 16:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237517AbhEGOOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 10:14:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31552 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230306AbhEGOO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 10:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620396807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZYOO3UAjlF+hfKg9yF+CEPnA0Soqks99ZWxEcE/K28Q=;
        b=FqsJVtvD6owY++YzbPhZP6+ko/jwf8ubIAH2RsPZT1FplLrxW5f0o6L/DNvzndcvEkBXp/
        ncALnWWTsf6WFHvTa/oVeSTwrtw5dE+scrjJtsF7kLdtTGRthIB1M/NIW7Z3uQN2puulB/
        3U3QiuLFn3ag2XdHDNwZum9SgFmzjww=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-vZcRFdaSPB6lPGWSSlA-LA-1; Fri, 07 May 2021 10:13:25 -0400
X-MC-Unique: vZcRFdaSPB6lPGWSSlA-LA-1
Received: by mail-qv1-f69.google.com with SMTP id o6-20020a0ccb060000b02901c0933b76e1so6719688qvk.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 07:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZYOO3UAjlF+hfKg9yF+CEPnA0Soqks99ZWxEcE/K28Q=;
        b=jBEGPBS8rHpvQedSIP3l6AtPgUrZlzE6G+9yQ68R4E+fRlEuBZ+Bgt8Zjpw6/mqLRi
         hG4/YbBsr2NN9qANq6JvAHEosdr14Nvg+LO74HFZw38OZwmy9Q+k+cnyOJ7AHMUtjH26
         J8oJrdkfDZqilwGWR0q/5wd42kZbHw0XlFdPwVgVicNrG1bIblz+pVoGKiZGvimbgOsy
         e5vXXSwedA788v85+W8aSDqXQuG+zWVbwrXT8hm9AY0FV/pWFnnSI4jX00vL1/i7grxD
         0gSH/uXqpoKNh6ba7covoVV76dAAwHIHznIGrbl5RrlVdi3UKf8LBpXtFA/Zi6kgjkCi
         Yq/Q==
X-Gm-Message-State: AOAM532O+0B3HMT7Ddd0yY+GV9i1uuOUy8Kx5Z52Px7ijB85d+nXQQqQ
        jMGGngj8aWePSk599fGSYAjWx/nDmOO416OepqLY838b+GDSwAK31zAWhZbqAcc7wLfMz/qmlvk
        JXpoMRqFBydMHoV3+zc3YvK57
X-Received: by 2002:a37:bbc4:: with SMTP id l187mr9631378qkf.153.1620396804604;
        Fri, 07 May 2021 07:13:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybb6hUAjm6c0snSkcA9xF1jcgUFqAKMSK05z3GVbIOoar26/N2ZrzQutQliHhwe/3DHxuWag==
X-Received: by 2002:a37:bbc4:: with SMTP id l187mr9631350qkf.153.1620396804336;
        Fri, 07 May 2021 07:13:24 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id q126sm4704696qkd.48.2021.05.07.07.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 07:13:23 -0700 (PDT)
Date:   Fri, 7 May 2021 10:13:21 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
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
Subject: Re: [PATCH 2/3] mm: gup: allow FOLL_PIN to scale in SMP
Message-ID: <YJVLAXXt2NlhfS9m@t490s>
References: <20210506232537.165788-1-peterx@redhat.com>
 <20210506232537.165788-3-peterx@redhat.com>
 <a270cf3a-ffbf-de77-eff0-4a4da8864978@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a270cf3a-ffbf-de77-eff0-4a4da8864978@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 11:07:32PM -0700, John Hubbard wrote:
> On 5/6/21 4:25 PM, Peter Xu wrote:
> > From: Andrea Arcangeli <aarcange@redhat.com>
> > 
> > has_pinned cannot be written by each pin-fast or it won't scale in
> > SMP. This isn't "false sharing" strictly speaking (it's more like
> > "true non-sharing"), but it creates the same SMP scalability
> > bottleneck of "false sharing".
> > 
> > To verify the improvement a new "pin_fast.c" program was added to
> > the will-it-scale benchmark.
> ...
> > 
> > This commits increases the SMP scalability of pin_user_pages_fast()
> > executed by different threads of the same process by more than 4000%.
> > 
> 
> Remarkable! I mean, yes, everyone knows that atomic writes are
> "expensive", but this is a fun, dramatic example of just *how*
> expensive they can get, once you start doing contended atomic writes.
> 
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> 
> Other notes, that don't have any effect on the above reviewed-by
> tag:
> 
> On the commit log, I will add a "+1" to the idea of deleting the
> pin_fast.c contents from the commit log, and just providing a URL
> instead. No need to put C programs in the commit log, IMHO, especially
> when you have them elsewhere anyway.

I guess it's put there only because it does not exist elsewhere. :)

I didn't run it, but I think it needs to be put into tests/ of if-it-scale repo
and build, something like that.

https://github.com/antonblanchard/will-it-scale/tree/master/tests

But yeah since we've got the 1st patch which can also reproduce this, I'll
reference that instead in the commit mesasge and I'll be able to shrink it.

I'll also start to use parentheses as Linus suggested.  My thanks to both of
you on the quick comments!

-- 
Peter Xu

