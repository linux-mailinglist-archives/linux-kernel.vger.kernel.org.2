Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7694242BFE3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbhJMM1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:27:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35136 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233169AbhJMM1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634127934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8YOBHg2cxN8ogGYoOT/g9xYB/0smdgUNl3MS2jFXUKQ=;
        b=BtgGU5Sg89iZZaxuHn9+E6juxRyitvV/Lppzy6B27WU9b/yxbU0b+/t039MC1fs/AlCIdn
        eEcaOkJWXyFSduVcj5w6WT9AJNBPVx9jmk74nL71FxuPsOHY2XD9XDze4TpjE480KKDH8C
        MEm1W+j/aCioiQYTjCc2aKDFKvewuZI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-fu3g3y1GOPCqfoJd0HIegw-1; Wed, 13 Oct 2021 08:25:32 -0400
X-MC-Unique: fu3g3y1GOPCqfoJd0HIegw-1
Received: by mail-wr1-f70.google.com with SMTP id c4-20020a5d6cc4000000b00160edc8bb28so1839582wrc.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8YOBHg2cxN8ogGYoOT/g9xYB/0smdgUNl3MS2jFXUKQ=;
        b=0ZHv3oldKF4EK2ORB7ZDdaBql2Z1bHNsQZBq38p25N/dJitXTDcj3jpGKSojl7YVfL
         Q5p+VWc0OlyCg86/GacY6DLEmSv//hCPoA9+44Y1FGhiAZuxsTZMvDxc2LDHjWe1WE7e
         h5jYKQ8HR3bzwkdVRmTFMZys8lfU2djERU6c4uSA4J+AZMWMHx7gUH7rt8WWP2KWqsb8
         YW5H8rJJNjUfEZ23p37kty9szQ5EOWvbrNz9M6obXTGRNDVYdIlFKh3NYsjQsYQ4BOqf
         XcGTeXScQwTn6irCSmSKkJnbCxQgJJLmY8L3cGuTepYBb2zFwmMedE2AaWX/ld/Zne+v
         HSCQ==
X-Gm-Message-State: AOAM532BQ8L6ecO0FK+BSH8ndwx4eqBVfOnxk6TigbD8Luruefu8nvhd
        wO/RYxYPm4zetnNPOCkjwPU+NzQ7WVAWETTvU+bcqB5XF28cY/P0aTmHnBhqmY9sWRgw70Cx6cn
        H2Vb299sZPmOnVhsc2KjgEHQ8
X-Received: by 2002:a05:600c:b5a:: with SMTP id k26mr12480609wmr.172.1634127931587;
        Wed, 13 Oct 2021 05:25:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4Fm6ZpRgEuTdDHvgL6ziG2Yey+Xu8fBe+Ruq1ZnFYz4uNmvgF6gyg91uSbPPP/dPPTadUjQ==
X-Received: by 2002:a05:600c:b5a:: with SMTP id k26mr12480583wmr.172.1634127931404;
        Wed, 13 Oct 2021 05:25:31 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id m4sm5367957wrz.45.2021.10.13.05.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 05:25:31 -0700 (PDT)
Date:   Wed, 13 Oct 2021 14:25:29 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCHv2 0/8] x86/ftrace: Add direct batch interface
Message-ID: <YWbQObW70Vuju9hY@krava>
References: <20211008091336.33616-1-jolsa@kernel.org>
 <YWagbqm4wtYqpBt/@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWagbqm4wtYqpBt/@osiris>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 11:01:34AM +0200, Heiko Carstens wrote:
> On Fri, Oct 08, 2021 at 11:13:28AM +0200, Jiri Olsa wrote:
> > hi,
> > adding interface to maintain multiple direct functions
> > within single calls. It's a base for follow up bpf batch
> > attach functionality.
> ...
> > ---
> > Jiri Olsa (6):
> >       x86/ftrace: Remove extra orig rax move
> >       tracing: Add trampoline/graph selftest
> >       ftrace: Add ftrace_add_rec_direct function
> >       ftrace: Add multi direct register/unregister interface
> >       ftrace: Add multi direct modify interface
> >       ftrace/samples: Add multi direct interface test module
> > 
> > Steven Rostedt (VMware) (2):
> >       x86/ftrace: Remove fault protection code in prepare_ftrace_return
> >       x86/ftrace: Make function graph use ftrace directly
> > 
> >  arch/x86/include/asm/ftrace.h        |   9 +++-
> >  arch/x86/kernel/ftrace.c             |  71 +++++++++++++++---------------
> >  arch/x86/kernel/ftrace_64.S          |  30 +------------
> >  include/linux/ftrace.h               |  26 +++++++++++
> >  kernel/trace/fgraph.c                |   6 ++-
> >  kernel/trace/ftrace.c                | 268 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
> >  kernel/trace/trace_selftest.c        |  54 ++++++++++++++++++++++-
> >  samples/ftrace/Makefile              |   1 +
> >  samples/ftrace/ftrace-direct-multi.c |  52 ++++++++++++++++++++++
> >  9 files changed, 420 insertions(+), 97 deletions(-)
> >  create mode 100644 samples/ftrace/ftrace-direct-multi.c
> 
> FWIW, Steven pointed me to this thread since I posted
> DYNAMIC_FTRACE_WITH_DIRECT_CALL support for s390 here:
> https://lore.kernel.org/all/20211012133802.2460757-1-hca@linux.ibm.com/
> 
> Since Jiri asked for it: please feel free to add
> Tested-by: Heiko Carstens <hca@linux.ibm.com>
> to all non-x86 patches.
> 

thanks,
jirka

