Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6599D39A25B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhFCNlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:41:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24081 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229957AbhFCNlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622727559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SA7kk4GuCt9QFLH5/3wDPsFvRhVEbhYlaqmjy8ZBvG4=;
        b=iexNL8HmEbP748dBY3HfJCJHyj1XvOzAHzv7ew+7t8xWrX3U8PSe1c82PUS1QzE6pdofxv
        3IjxzYvNtkFCyzvgLhI3RP3etSsrVAeDqZ19tByYu8HCVvakYUk7u+4I/0Ua0jSCCqLcLH
        RIyAxgUWk6/CHpZpkKh0+j1GZQ8eBDM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-tO9JgV6EP6Ge8RD6rgoDWg-1; Thu, 03 Jun 2021 09:39:18 -0400
X-MC-Unique: tO9JgV6EP6Ge8RD6rgoDWg-1
Received: by mail-qt1-f197.google.com with SMTP id a12-20020ac8108c0000b029023c90fba3dcso3110037qtj.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 06:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SA7kk4GuCt9QFLH5/3wDPsFvRhVEbhYlaqmjy8ZBvG4=;
        b=HwFCtyxFC2dBMzuUh23a8KmU4hj6e6uhHWVqt2gYNAHXhRyrQp5kyx/th9E8riOZjX
         y4HyqGDayis2ZLVw7CAQPIsS7POAz18CFmBdRbO0lJWOmlIjcb3EX9ZO6r9nfp1ZKBCw
         F6aIgLqJQaSLfUayArmUJrhvQNmlJilx/153E2GeOzucwYI//Q0/26cRq0o9FOT4Ni8P
         80NbUhMuvww5wgLRX/h5Wgxbw0ALYU2rU93QnDbHRU6uq/JK4zbg60x4cMlp7dvWG0uh
         oiuMVuEPMu+3qFdPmTfaeZAAk5WOgxFW2BqbWxxA2LxFLf5WcuFqv3LAAPmjBFtcVt4k
         2Dcw==
X-Gm-Message-State: AOAM532US7kMUDVsFo/51wHApdOB9k4gf6kzY/cPhvL4C3NQvmkKEzfD
        cOR5WlOrkGuTm0Lgx5YEOKEKWuSPXkBlUEWLvFp+NoImTvDigqqyOY3Gp7ULXILchVe1aoSNV29
        TXIEwPS7WiF4iKos6Ov6XVXts
X-Received: by 2002:a37:b9c7:: with SMTP id j190mr7807893qkf.234.1622727557328;
        Thu, 03 Jun 2021 06:39:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFP191PEiGc2JTyRmAZaeTTddu15ECZ8TyOyq5IjYv34kMomQFMcGsMsiaLWwy+NuX8g5Vyg==
X-Received: by 2002:a37:b9c7:: with SMTP id j190mr7807872qkf.234.1622727557135;
        Thu, 03 Jun 2021 06:39:17 -0700 (PDT)
Received: from treble ([68.52.236.68])
        by smtp.gmail.com with ESMTPSA id d136sm2017547qkg.9.2021.06.03.06.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 06:39:16 -0700 (PDT)
Date:   Thu, 3 Jun 2021 08:39:14 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        syzbot <syzbot+84fe685c02cd112a2ac3@syzkaller.appspotmail.com>,
        bp@alien8.de, hpa@zytor.com, inglorion@google.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [syzbot] KASAN: stack-out-of-bounds Read in profile_pc
Message-ID: <20210603133914.j2aeadmvhncnlk5q@treble>
References: <00000000000030293b05c39afd6f@google.com>
 <20210602230054.vyqama2q3koc4bpo@treble>
 <527ad07e-eec2-a211-03e7-afafe5196100@linux.intel.com>
 <YLjZYvXnuPnbXzOm@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YLjZYvXnuPnbXzOm@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 03:30:10PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 02, 2021 at 04:35:11PM -0700, Andi Kleen wrote:
> 
> > > We could just use ORC to unwind to the next frame.  Though, isn't
> > > /proc/profile redundant, compared to all the more sophisticated options
> > > nowadays?  Is there still a distinct use case for it or can we just
> > > remove it?
> > 
> > It's still needed for some special cases. For example there is no other
> > viable way to profile early boot without a VM
> > 
> > I would just drop the hack to unwind, at least for the early boot profile
> > use case locking profiling is usually not needed.
> 
> Surely we can cook up something else there and delete this thing? ftrace
> buffers are available really early, it shouldn't be hard to dump some
> data in there during boot.

True, ftrace does have function profiling (function_profile_enabled).

Steve, is there a way to enable that on the kernel cmdline?

-- 
Josh

