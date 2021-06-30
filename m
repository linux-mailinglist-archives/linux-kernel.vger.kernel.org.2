Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A3F3B89FA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 23:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbhF3VMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 17:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbhF3VMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 17:12:22 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE39C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 14:09:52 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso4568744pjx.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 14:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zliHdHGG472sIu8ixUkfKUhqE1vaBtcNdSUI7bd2ULM=;
        b=ZInbAOcF/bWPptX9K7BG4muTK2GRM1TyOAjCIFajbG8pSNpLPkh+GEf4zu5didRBgu
         nqe5ArkROxRRSgOVcKZ2g9mcivD16da0D1PUviKDUxosFwf/x167OGeoGK6n0Ly97BrV
         Hm1d1gWqRlFHlcL4gkjmD+PFPnz8SQLyMw4P/63UjVR+OG6iM2GLlwzn9g8TxK0m1ji1
         zCwRnxAIn+KdORyoqhVmap0arTgM/iE/raOmi/4+Ws6F0P/UV+MUAmClTo3rRfCuMKvw
         gO8yXeCRXfNA+75jmu+n/L2X/f2ZtOE6VSDacONss2iF6k9M7SdkAmQ+iinPccSLB37F
         6Alg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zliHdHGG472sIu8ixUkfKUhqE1vaBtcNdSUI7bd2ULM=;
        b=I4gVH9Wc+5dy6Tg8oZfxCpl4uH4oFzJHnggbsLTqBxlR3DSMuApc9eN4dp/BZLuckf
         JI7bleYImrI5fwXnEcAZQWXDozaaP+BF3DFV+Li31Nn+0TkJtL2dbVd3dvFvaEQYMGmh
         RttVbGYur3qpXU1t5qRTb/iaE0cV4/cfn4innS0oEPX6jn65Bu1N4Hj5YNJVmuONqL+I
         F2co0+an0qZZe0qYuwSsjXGC/Xn9/uUmZF7ttS7+gEBG8lsijSAWOO8X5CryusV+Cu+5
         35ktkIb2YA4YIZ0W18QRUMhbcxjYgfD7FZLoZVmnE2p8UYC6u1rv648DrudyvdVT9lDI
         0XhQ==
X-Gm-Message-State: AOAM531m0phdFFsZhC+AyivYbeQaqspijUyIeCXz1sIfC0X/NrgACcne
        wDeqiuMVeurGgAKULXURVVV0TQ==
X-Google-Smtp-Source: ABdhPJydqCEOn2deMKN7lqCp97zhVvtslBQti30JyKwMfzP0zuCEM5QbR2pAjfLPg7FW4QhNSePQsA==
X-Received: by 2002:a17:90b:380a:: with SMTP id mq10mr6092395pjb.79.1625087391352;
        Wed, 30 Jun 2021 14:09:51 -0700 (PDT)
Received: from google.com ([2620:15c:280:201:b405:10e4:843c:2483])
        by smtp.gmail.com with ESMTPSA id o15sm23758482pfd.96.2021.06.30.14.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 14:09:48 -0700 (PDT)
Date:   Wed, 30 Jun 2021 14:09:42 -0700
From:   Paul Burton <paulburton@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Joel Fernandes <joelaf@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing: Resize tgid_map to PID_MAX_LIMIT, not
 PID_MAX_DEFAULT
Message-ID: <YNzdllg/634Sa6Rt@google.com>
References: <20210630003406.4013668-1-paulburton@google.com>
 <20210630003406.4013668-2-paulburton@google.com>
 <20210630083513.1658a6fb@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210630083513.1658a6fb@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Wed, Jun 30, 2021 at 08:35:13AM -0400, Steven Rostedt wrote:
> On Tue, 29 Jun 2021 17:34:06 -0700
> Paul Burton <paulburton@google.com> wrote:
> 
> > On 64 bit systems this will increase the size of tgid_map from 256KiB to
> > 16MiB. Whilst this 64x increase in memory overhead sounds significant 64
> > bit systems are presumably best placed to accommodate it, and since
> > tgid_map is only allocated when the record-tgid option is actually used
> > presumably the user would rather it spends sufficient memory to actually
> > record the tgids they expect.
> 
> NAK. Please see how I fixed this for the saved_cmdlines, and implement
> it the same way.
> 
> 785e3c0a3a87 ("tracing: Map all PIDs to command lines")
> 
> It's a cache, it doesn't need to save everything.

Well sure, but it's a cache that (modulo pid recycling) previously had a
100% hit rate for tasks observed in sched_switch events.

It differs from saved_cmdlines in a few key ways that led me to treat it
differently:

1) The cost of allocating map_pid_to_cmdline is paid by all users of
   ftrace, whilst as I mentioned in my commit description the cost of
   allocating tgid_map is only paid by those who actually enable the
   record-tgid option.

2) We verify that the data in map_pid_to_cmdline is valid by
   cross-referencing it against map_cmdline_to_pid before reporting it.
   We don't currently have an equivalent for tgid_map, so we'd need to
   add a second array or make tgid_map an array of struct { int pid; int
   tgid; } to avoid reporting incorrect tgids. We therefore need to
   double the memory we consume or further reduce the effectiveness of
   this cache.

3) As mentioned before, with the default pid_max tgid_map/record-tgid
   has a 100% hit rate which was never the case for saved_cmdlines. If
   we go with a solution that changes this property then I certainly
   think the docs need updating - the description of saved_tgids in
   Documentation/trace/ftrace.rst makes no mention of this being
   anything but a perfect recreation of pid->tgid relationships, and
   unlike the description of saved_cmdlines it doesn't use the word
   "cache" at all.

Having said that I think taking a similar approach to saved_cmdlines
would be better than what we have now, though I'm not sure whether it'll
be sufficient to actually be usable for me. My use case is grouping
threads into processes when displaying scheduling information, and
experience tells me that if any threads don't get grouped appropriately
the result will be questions.

Thanks,
    Paul
