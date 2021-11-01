Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFBB441D7D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 16:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbhKAPlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 11:41:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48778 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232504AbhKAPlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 11:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635781156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iRI95qdOAcL5v8a/aKW8bCbN0VeLXjbnx7SMPocoLlY=;
        b=I+v+P7iBMkW4HjIR/XJxXPK9hSIqqlkWudZQp/xBR09FmQH74OfGU8rd+OLPqISXspZonz
        ly0fHCmI5MpVGLhl8owQ7BZeR4gxIHnam+TPc+OsZEL7XS3AuM2UuD9m2gzpsKLm6Z08Jb
        ZAhNpyP8QZRGomlroEcY7EqfDhFpw40=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-d6DPnBTEPGesXdBpN67Quw-1; Mon, 01 Nov 2021 11:39:13 -0400
X-MC-Unique: d6DPnBTEPGesXdBpN67Quw-1
Received: by mail-ed1-f70.google.com with SMTP id h16-20020a05640250d000b003dd8167857aso15973847edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 08:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iRI95qdOAcL5v8a/aKW8bCbN0VeLXjbnx7SMPocoLlY=;
        b=74Xx2eb3MBaS7rETwomZd2aJn2FrI/fNthU9dO0+QJiFNsjVj1ty6o/Hta/5sI8jT4
         tXhcyDphxewT3LD6FezHqBtGt6LJFMenMcCm49F/0WvM4O1DL1IsFB4rOf3pJVr7a0Pz
         jN1LOaevVMTFMQZnpScyQUla8stuHHkd1aN8xFNrRd9L8TOf6sV/D1zPzpqu471ZQT5m
         D9DGleXdY8HWgU7ZPwzZWrGp8RzJzQq/Bt7HtaKTUERdjsv2ViUqkEnNJ+vcT8c6NWuT
         nW0gAAGIYs+1/TPG6/igjtavSUZnui87vAOsRblzG4AeZQMwX8WKN4TNKkn7ysNSLIkS
         lPDw==
X-Gm-Message-State: AOAM531eCGbxVuZ7Mzh242P4v15ohGFW8u/2eCMOv7cth55lgXmehtcZ
        huJPi5zZLvsrRDqwvDGpnYt5CuU3MaUCZIHls7qj8UiF6tr2q7U/aN6IhzWvpzp13IjqYeWR0Kw
        JGnre9c9aIDhqnS7GgLUR28r2
X-Received: by 2002:aa7:c1c6:: with SMTP id d6mr2399213edp.203.1635781152386;
        Mon, 01 Nov 2021 08:39:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEvHDSmmod0HzuwETSBkZ9quuFCLhUaa2+vhojqXfGxYL18PqIU7dfTFW6rn4iZ3vJZnUaZQ==
X-Received: by 2002:aa7:c1c6:: with SMTP id d6mr2399198edp.203.1635781152257;
        Mon, 01 Nov 2021 08:39:12 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id y15sm8409301edd.58.2021.11.01.08.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 08:39:11 -0700 (PDT)
Date:   Mon, 1 Nov 2021 16:39:10 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, kernel test robot <lkp@intel.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace/samples: Add missing prototype for my_direct_func
Message-ID: <YYAKHmoAVmolnqjE@krava>
References: <20211101152002.376369-1-jolsa@kernel.org>
 <20211101113127.19148268@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101113127.19148268@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 11:31:27AM -0400, Steven Rostedt wrote:
> On Mon,  1 Nov 2021 16:20:02 +0100
> Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > There's compilation fail reported kernel test robot for W=1 build:
> > 
> >   >> samples/ftrace/ftrace-direct-multi.c:8:6: warning: no previous  
> >   prototype for function 'my_direct_func' [-Wmissing-prototypes]
> >      void my_direct_func(unsigned long ip)
> > 
> > The inlined assembly is used outside function, so we can't make
> > my_direct_func static and pass it as asm input argument.
> > 
> > However my_tramp is already extern so I think there's no problem
> > keeping my_direct_func extern as well and just add its prototype.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Fixes: 5fae941b9a6f ("ftrace/samples: Add multi direct interface test module")
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  samples/ftrace/ftrace-direct-multi.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
> > index 2a5b1fb7ac14..e0ccf43da0c9 100644
> > --- a/samples/ftrace/ftrace-direct-multi.c
> > +++ b/samples/ftrace/ftrace-direct-multi.c
> > @@ -10,6 +10,7 @@ void my_direct_func(unsigned long ip)
> >  	trace_printk("ip %lx\n", ip);
> >  }
> >  
> > +extern void my_direct_func(unsigned long ip);
> >  extern void my_tramp(void *);
> 
> Except that I believe that the prototype must come before it is used.
> 
> I don't think this will fix the warning.

ugh, sry.. v2 posted

jirka

> 
> -- Steve
> 
> 
> >  
> >  asm (
> 

