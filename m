Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1956836887B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 23:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239440AbhDVVTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 17:19:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26378 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239028AbhDVVT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 17:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619126333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WL2DjbQuTq/EcUdymB75wSg7jJRF6qAH0Wk/CKq5EIY=;
        b=NaVMIVqip12907fMyjNg1oofPerixidc38we8+ysPVLusmnIkVC6dOHjhwQmtg20sVEomZ
        fZRNvoSR+A7zismXSnUhonSTTab9sMGtBW5MZRg1ymMMqMXiUeqRnUyQI6Pn9PmOgbF5Of
        hwpUCWvaLuKO2pXqp1+Weezj3n3luQY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511--gu7ZoZ1PdOQL69Q3TCMBw-1; Thu, 22 Apr 2021 17:18:51 -0400
X-MC-Unique: -gu7ZoZ1PdOQL69Q3TCMBw-1
Received: by mail-qv1-f71.google.com with SMTP id y14-20020a0cf14e0000b029019ff951fd16so15799351qvl.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 14:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WL2DjbQuTq/EcUdymB75wSg7jJRF6qAH0Wk/CKq5EIY=;
        b=DDRQjK6zXYFB4xVpxWdgCx44GrQHGew136l6tjs9/SmUIAF6Uif8hxHowHVTggb572
         G68JH0ks71AZ/rPbQKLfhrUOPtZstWmZxMQP4elbHx0XIo4B0viczc7WLcAPR4YAfBtk
         lc1k7Yygtk7qn7neaYpTa1Gi1Wb4lMO9C0HobJ5g3ElpJW/lHUU5PX1Dm1DqcFzN6jVd
         aYTJ1wawYcHn5rc0BZ3ot8gP6cdrwYdRnNamSBZbpvrXKAiZkDjNA4FeuHgHzuiP9JgJ
         NolfplXbFbBRNjAxPmxUzUaqp+MqhoTOQPH7xeaPfoFsoQKe1wG5W3lwfBqNjxr9HMqQ
         OYPQ==
X-Gm-Message-State: AOAM531hKWZQT6CN3gbitJ59C3xPYr2A1+fY9HXcXISfdXK4MWOynKcm
        /zSZQj6Yg/IlfHCjCpcR9ZyBLs9HQeo5iAnqE3yHzjSgxWQWV+5Q9MJh9yPpvjbaeLXYDl4wzw3
        ZVnuiYk7ttuUh3bwZceq1d52S
X-Received: by 2002:ac8:4793:: with SMTP id k19mr453047qtq.373.1619126330844;
        Thu, 22 Apr 2021 14:18:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPK39d5FeudQjLH1XVuvAUd8EB5opbfb/Nov9VNsvcjW/X3rbs5nsCsgqxO6li0RTX/w4dHA==
X-Received: by 2002:ac8:4793:: with SMTP id k19mr453015qtq.373.1619126330602;
        Thu, 22 Apr 2021 14:18:50 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id g135sm3084697qke.8.2021.04.22.14.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 14:18:49 -0700 (PDT)
Date:   Thu, 22 Apr 2021 17:18:47 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v4 03/10] userfaultfd/shmem: support UFFDIO_CONTINUE for
 shmem
Message-ID: <20210422211847.GF6404@xz-x1>
References: <20210420220804.486803-1-axelrasmussen@google.com>
 <20210420220804.486803-4-axelrasmussen@google.com>
 <CAJHvVchQk1zrgah08n_P3sHUVzQLZUXHSMbkpd9rG-w5jUGNdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVchQk1zrgah08n_P3sHUVzQLZUXHSMbkpd9rG-w5jUGNdw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Axel,

On Thu, Apr 22, 2021 at 01:22:02PM -0700, Axel Rasmussen wrote:
> > +       if (page_in_cache)
> > +               page_add_file_rmap(page, false);
> > +       else
> > +               page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
> > +
> > +       /*
> > +        * Must happen after rmap, as mm_counter() checks mapping (via
> > +        * PageAnon()), which is set by __page_set_anon_rmap().
> > +        */
> > +       inc_mm_counter(dst_mm, mm_counter(page));
> 
> Actually, I've noticed that this is still slightly incorrect.
> 
> As Hugh pointed out, this works for the anon case, because
> page_add_new_anon_rmap() sets page->mapping.
> 
> But for the page_in_cache case, it doesn't work: unlike its anon
> counterpart, page_add_file_rmap() *does not* set page->mapping.

If it's already in the page cache, shouldn't it be set already in e.g. one
previous call to shmem_add_to_page_cache()?  Thanks,

-- 
Peter Xu

