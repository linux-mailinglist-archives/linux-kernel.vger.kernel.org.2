Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF07C3C7579
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 19:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhGMRIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 13:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhGMRIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 13:08:00 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80380C0613DD;
        Tue, 13 Jul 2021 10:05:09 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id g12so17170395qtb.2;
        Tue, 13 Jul 2021 10:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=GvR1/6TueF+z992PwiFlayujtOABh7wbqOkN8mvwXxU=;
        b=li3hILGWBq+q0HpvaFF5tn1q7vwx0pfsN53ZmVjZvkNQ6rsT0ByNmRTOCmWoXRz26x
         Mr61SIH9mrKzMbtDxv+oTlHqbxcQGPfKn1L2xZNAheclDPNc6/ajRR5WseH6Onqkllyt
         4KUPE5GGQ/dxoY6wZckh053f03FzSo+FxPQMVuz9teaG3KXsG/bOzo5wZ7tFjL+GJwT9
         z6R4B2mDnoJEyhlucwwrQF+MRjhzT6Gg1UlocPMJrnjON7p0lMm6SzY7BenL98kDHigI
         E6vfdrQYsN8nWqv1CiJWLXt3m6Aps7ei0Iqrtzk4dv/J/ibujh43O2shhEeuwDfGy2Oj
         SZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=GvR1/6TueF+z992PwiFlayujtOABh7wbqOkN8mvwXxU=;
        b=U5rl5cb1Rn860ucjQtxNn9T/BE/806DbNJmH6Z4/AXDdxnRTDDMDT+u6XyNgdHFSFu
         QG57YZmVQPof/tj+dGIXkEMhBY5JTJ2qsEp70Jsp9ddGJ03uqgNU2YEBidEIx2UH0ejG
         b1++GG3xez0+a4bTpwInt9rEStVdS7E08EDJxPkPR3x7o3oV6sXdZgQaFcfDYwaYXTIy
         Blaw5sSV9eRNTzhha2UpBn1GXls0DIv4+s/71q/308QM6TIio7jGI+KRSVj/39qXmfMu
         GC70y/olJnOaHnKjyJtuhfOH4PH7BN0oovUSM54q9Os5NXOySIuCm4zelO+7H6AkJ7Un
         jjeQ==
X-Gm-Message-State: AOAM530tMnE6fWtWHHcCONn6jd8b9a5itbOuGvwTEF4lXMIL7q+L5wdF
        9fVaD8vHVsRf9bQOrNWABNk=
X-Google-Smtp-Source: ABdhPJyaetFrbYi8UsiWreJDQwxYoPVbE4j9068ZwyVT6QJR1ilWDWv6DzjCIw5wy1YmXYLvowNrJA==
X-Received: by 2002:ac8:4986:: with SMTP id f6mr4968676qtq.125.1626195908702;
        Tue, 13 Jul 2021 10:05:08 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id 6sm4388309qkv.115.2021.07.13.10.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 10:05:08 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     Joe Perches <joe@perches.com>
Cc:     SeongJae Park <sj38.park@gmail.com>, akpm@linux-foundation.org,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, jgowans@amazon.com, mgorman@suse.de,
        mheyne@amazon.de, minchan@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, riel@surriel.com,
        rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org,
        shakeelb@google.com, shuah@kernel.org, sieberf@amazon.com,
        snu@zelle79.org, vbabka@suse.cz, vdavydov.dev@gmail.com,
        zgf574564920@gmail.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v33 13/13] MAINTAINERS: Update for DAMON
Date:   Tue, 13 Jul 2021 17:05:02 +0000
Message-Id: <20210713170502.7517-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <bf25e7b270fb247475254254fece22cf6abbd0ef.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Hello Joe,

On Tue, 13 Jul 2021 09:49:53 -0700 Joe Perches <joe@perches.com> wrote:

> On Tue, 2021-07-13 at 12:33 +0000, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > This commit updates MAINTAINERS file for DAMON related files.
> > 
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > Reviewed-by: Markus Boehme <markubo@amazon.de>
> > ---
> >  MAINTAINERS | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a61f4f3b78a9..d492ae8b77de 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5114,6 +5114,18 @@ F:	net/ax25/ax25_out.c
> >  F:	net/ax25/ax25_timer.c
> >  F:	net/ax25/sysctl_net_ax25.c
> >  
> > 
> > +DATA ACCESS MONITOR
> > +M:	SeongJae Park <sjpark@amazon.de>
> > +L:	linux-mm@kvack.org
> > +S:	Maintained
> > +F:	Documentation/admin-guide/mm/damon/*
> > +F:	Documentation/vm/damon/*
> > +F:	include/linux/damon.h
> > +F:	include/trace/events/damon.h
> > +F:	mm/damon/*
> > +F:	tools/damon/*
> > +F:	tools/testing/selftests/damon/*
> 
> Using "F:	<path>/*" means that you are maintaining only
> files in that specific path and not any subdirectory of that path.
> 
> Are there subdirectories in these uses of <path>/*
> that you are avoiding?
> 
> If not, the proper use is just a trailing forward slash like
> 
> F:	<path>/
> 
> I believe this should be:
> 
> DATA ACCESS MONITOR
> M:	SeongJae Park <sjpark@amazon.de>
> L:	linux-mm@kvack.org
> S:	Maintained
> F:	Documentation/admin-guide/mm/damon/
> F:	Documentation/vm/damon/
> F:	include/linux/damon.h
> F:	include/trace/events/damon.h
> F:	mm/damon/
> F:	tools/damon/
> F:	tools/testing/selftests/damon/

There is no subdirectory under the paths.  I will update those as you
recommended in the next spin.


Thanks,
SeongJae Park
