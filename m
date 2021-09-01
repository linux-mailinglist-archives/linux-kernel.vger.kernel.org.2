Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB47A3FE2BE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 21:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242152AbhIATHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 15:07:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21216 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231137AbhIATHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 15:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630523210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BZhEfohhpWK1WcNGEDwiSiBROpuA4N5Q5WqsIFk2qmM=;
        b=TfbV8oomS+256guvFU6SrsD3B/xWAobsQTgxYJPKEOA8Lt7QtuMAvyn6z739MOlKwr6pjn
        6G15xdVyESrVZDv7pxooRMhGpuDp6IIDdVA23BlFP2eouP44bfmr/DFJaeDxABheP0x9yq
        MNEvyrOpnHAaelATjZgCIgzkw3QHzD8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-RHmZcLxcNke8BlEaSHYFBw-1; Wed, 01 Sep 2021 15:06:49 -0400
X-MC-Unique: RHmZcLxcNke8BlEaSHYFBw-1
Received: by mail-wr1-f72.google.com with SMTP id r11-20020a5d4e4b000000b001575c5ed4b4so219240wrt.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 12:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BZhEfohhpWK1WcNGEDwiSiBROpuA4N5Q5WqsIFk2qmM=;
        b=E29qkXEXw/RY+KCEifiOcrsyPNey0GvcChC2w+Ju0RtQ/m7zYAuJSqk9Y4J0OtNtyD
         vE9HE3xSOCQ4NJaNn0HsxH3Np/Qf44+JH8jJ+e4t2eR34IUkfO18Vb18CCQVZSasjNln
         LhFLFEKxO0hM72XBTkobG5m3QDRZqWIoPmA9FgkdZhX4ip5hyhhOFA8pIQ9byIoY8geH
         h0lTgBaerOwC7S6qszhYv/cAkxU/kYXfM9euzNz309q9NaYxn2o3wjH1UuHnj3nWOooo
         Q/tKxFSre9lzkKFZzdk5h0QLZiaKTpUWVHrlj3OpGcBMWx2GiHEnxIgk2zRXCZG3pnaR
         J2Mw==
X-Gm-Message-State: AOAM532LenYhgnlZxtsjhDncvp6Tx4Vv4zsFjTqJ8Q3sJZAdUBnrNOa3
        QP+8d2gBUxxapCku3KFe5bbzj2YaeRQbl14argR+mKRur2gDVLJ9V4ddhiFaz9gjg56shprFSqu
        xmHIYd6T4HLZZYMX2QBylG5aR
X-Received: by 2002:adf:c54a:: with SMTP id s10mr1018140wrf.125.1630523208322;
        Wed, 01 Sep 2021 12:06:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXISGeHcOCvvlT2nY90XtlYHVxSCBWTZKjSOXfDXgNjhW1sN/hJ1m+7kS7mBkZXLbSnRxaVA==
X-Received: by 2002:adf:c54a:: with SMTP id s10mr1018130wrf.125.1630523208161;
        Wed, 01 Sep 2021 12:06:48 -0700 (PDT)
Received: from krava ([94.113.247.3])
        by smtp.gmail.com with ESMTPSA id n4sm261764wri.78.2021.09.01.12.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 12:06:47 -0700 (PDT)
Date:   Wed, 1 Sep 2021 21:06:45 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH 0/8] x86/ftrace: Add direct batch interface
Message-ID: <YS/PRZR5xjSXnJ9z@krava>
References: <20210831095017.412311-1-jolsa@kernel.org>
 <CAADnVQK6kLef54iCufsJay0SnsTLk1Ta-RmnhZnGk7TqJCWUJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQK6kLef54iCufsJay0SnsTLk1Ta-RmnhZnGk7TqJCWUJQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 08:23:38AM -0700, Alexei Starovoitov wrote:
> On Tue, Aug 31, 2021 at 2:50 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > hi,
> > adding interface to maintain multiple direct functions
> > within single calls. It's a base for follow up bpf batch
> > attach functionality.
> >
> > New interface:
> >
> >   int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
> >   int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
> >   int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
> >
> > that allows to register/unregister/modify direct function 'addr'
> > with struct ftrace_ops object. The ops filter can be updated
> > before with ftrace_set_filter_ip calls
> >
> >   1) patches (1-4) that fix the ftrace graph tracing over the function
> >      with direct trampolines attached
> >   2) patches (5-8) that add batch interface for ftrace direct function
> >      register/unregister/modify
> >
> > Also available at (based on Steven's ftrace/core branch):
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   ftrace/direct
> 
> Steven,
> 
> Could you review and merge this set for this merge window,
> so we can process related bpf bits for the next cycle?

actually I might have sent it out too early, there's still
bpf part review discussion that might end up in interface
change

review would be great, but please hold on with the merge

thanks,
jirka

