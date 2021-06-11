Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A3F3A48E5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhFKS42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:56:28 -0400
Received: from mail-qv1-f46.google.com ([209.85.219.46]:39814 "EHLO
        mail-qv1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhFKS41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:56:27 -0400
Received: by mail-qv1-f46.google.com with SMTP id u14so14176468qvq.6;
        Fri, 11 Jun 2021 11:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=Y/ZcTo0SeQPAtgjpgzgDqa9Nq9jesnYjqbJ3TkY0lSc=;
        b=kHzy5jWy/GdobKT7mZ2Gh/dn9HIf+9/kRQRs4ct9PyD3mXcTm+mPsiG4FeAuejZ59D
         LxYz7jknKf55sXoWgTQxVQfpDpdGCeKYVoGjuARo9mbvlBvraYkmk4eeu2OfS6CBgB0d
         LhUPEnzh0v7mDKbTDkPxDVPVUA7lWuJgs9CwJDTEmA76urvNG/PSn2DzIeTI54bX/15M
         7XeX0D+bj2upd8o6r0kYkEkXcPXi2Qab8LsH3I/gxu8rliPRjfWkX/P2b3Jbb8XCM+DN
         lNrNUqNO9JWSjSlw9Bb+i3fSyivzyOVT1zLFtPegE+EFMtQrJoAsM/1JCt2FLv4OT9mi
         69bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=Y/ZcTo0SeQPAtgjpgzgDqa9Nq9jesnYjqbJ3TkY0lSc=;
        b=tOryshnmxx/P/kt86rymMJRpbN/oDa94aRZh7JpQ7QfvcTYFg0TP0eFcBH9PJyT7Zc
         ximQj/iRHCgTmb5JYEM2i47/4mIQM/A8gQbhkVR/F/KqJ0R80QtH6d90CMLO4IUaIHnO
         TdCDGAOmVfNPJJ8vs8diQJ+rUSd5E2VIImhIMdrxx0kksWnvQehDMjLlqIIQyi0HSI58
         5QZWVNxk23t8D0DVaUa+rhdohIb471XIXK6M4+yHTkY+/d8348eWre3I6dxrC6bR4Cnq
         ouLgEgBtM/FjR2IeVu1iTCIvwojK4+V2NsaRkzTkIxQ9frCvdzV0lD2Xm+fH/CAY+pN1
         t25A==
X-Gm-Message-State: AOAM533Y+IwO6aF3ZXefsIpVf9m3fwjYSivVTPz6G0JR46CX0RWOmTsL
        EhcfnF2R7NIVboh05zbda0k=
X-Google-Smtp-Source: ABdhPJwbEkLd8gp0BWLoTnhfccjnv171fUe1yg21CsnMJFFp4TpK2QGiuPXbUiB4s9InrJr09qXHZw==
X-Received: by 2002:ad4:4e24:: with SMTP id dm4mr6368751qvb.33.1623437594885;
        Fri, 11 Jun 2021 11:53:14 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h22sm779919qkn.87.2021.06.11.11.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 11:53:14 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     "Boehme, Markus" <markubo@amazon.de>
Cc:     "sj38.park@gmail.com" <sj38.park@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Foerster, Leonard" <foersleo@amazon.de>,
        "guoju.fgj@alibaba-inc.com" <guoju.fgj@alibaba-inc.com>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "riel@surriel.com" <riel@surriel.com>,
        "greg@kroah.com" <greg@kroah.com>,
        "linux-damon@amazon.com" <linux-damon@amazon.com>,
        "david@redhat.com" <david@redhat.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "snu@amazon.de" <snu@amazon.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Park, Seongjae" <sjpark@amazon.de>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "zgf574564920@gmail.com" <zgf574564920@gmail.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "amit@kernel.org" <amit@kernel.org>,
        "fan.du@intel.com" <fan.du@intel.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "gthelen@google.com" <gthelen@google.com>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "elver@google.com" <elver@google.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v29 10/13] Documentation: Add documents for DAMON
Date:   Fri, 11 Jun 2021 18:53:08 +0000
Message-Id: <20210611185308.10727-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <c0758ac4a7f2dae75799c79b12a6a14d3fe8bec3.camel@amazon.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Fri, 11 Jun 2021 17:44:18 +0000 "Boehme, Markus" <markubo@amazon.de> wrote:

> On Thu, 2021-05-20 at 07:56 +0000, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > This commit adds documents for DAMON under
> > `Documentation/admin-guide/mm/damon/` and `Documentation/vm/damon/`.
> > 
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> >  Documentation/admin-guide/mm/damon/guide.rst | 158 +++++++++++++
> >  Documentation/admin-guide/mm/damon/index.rst |  15 ++
> >  Documentation/admin-guide/mm/damon/plans.rst |  29 +++
> >  Documentation/admin-guide/mm/damon/start.rst | 114 +++++++++
> >  Documentation/admin-guide/mm/damon/usage.rst | 112 +++++++++
> >  Documentation/admin-guide/mm/index.rst       |   1 +
> >  Documentation/vm/damon/api.rst               |  20 ++
> >  Documentation/vm/damon/design.rst            | 166 +++++++++++++
> >  Documentation/vm/damon/eval.rst              | 232 +++++++++++++++++++
> >  Documentation/vm/damon/faq.rst               |  58 +++++
> >  Documentation/vm/damon/index.rst             |  31 +++
> >  Documentation/vm/index.rst                   |   1 +
> >  12 files changed, 937 insertions(+)
> >  create mode 100644 Documentation/admin-guide/mm/damon/guide.rst
> >  create mode 100644 Documentation/admin-guide/mm/damon/index.rst
> >  create mode 100644 Documentation/admin-guide/mm/damon/plans.rst
> >  create mode 100644 Documentation/admin-guide/mm/damon/start.rst
> >  create mode 100644 Documentation/admin-guide/mm/damon/usage.rst
> >  create mode 100644 Documentation/vm/damon/api.rst
> >  create mode 100644 Documentation/vm/damon/design.rst
> >  create mode 100644 Documentation/vm/damon/eval.rst
> >  create mode 100644 Documentation/vm/damon/faq.rst
> >  create mode 100644 Documentation/vm/damon/index.rst
> > 
> > [...]
> >
> > diff --git a/Documentation/admin-guide/mm/damon/start.rst b/Documentation/admin-guide/mm/damon/start.rst
> > new file mode 100644
> > index 000000000000..f5bbf1e36836
> > --- /dev/null
> > +++ b/Documentation/admin-guide/mm/damon/start.rst
> > @@ -0,0 +1,114 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +===============
> > +Getting Started
> > +===============
> > +
> > +This document briefly describes how you can use DAMON by demonstrating its
> > +default user space tool.  Please note that this document describes only a part
> > +of its features for brevity.  Please refer to :doc:`usage` for more details.
> > [...]
> > +
> > +
> > +Prerequisites
> > +=============
> > +
> > +Kernel
> > +------
> > +
> > +You should first ensure your system is running on a kernel built with
> > +``CONFIG_DAMON_*=y``.
> > +
> > +
> > +User Space Tool
> > +---------------
> > +
> > +For the demonstration, we will use the default user space tool for DAMON,
> > +called DAMON Operator (DAMO).  It is available at
> > +https://github.com/awslabs/damo.  For brevity, below examples assume you set
> > +``$PATH`` to point it.  It's not mandatory, though.
> 
> "The examples below assume ``damo`` is on your ``$PATH``."?

That's much better for readability.  I will update so in the next spin.

> 
> > +
> > +Because DAMO is using the debugfs interface (refer to :doc:`usage` for the
> > +detail) of DAMON, you should ensure debugfs is mounted.  Mount it manually as
> > +below::
> > +
> > +    # mount -t debugfs none /sys/kernel/debug/
> > +
> > +or append below line to your ``/etc/fstab`` file so that your system can
> > +automatically mount debugfs from next booting::
> > +
> > +    debugfs /sys/kernel/debug debugfs defaults 0 0
> > +
> > +
> > [...]
> > diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
> > new file mode 100644
> > index 000000000000..ea3fa6e55f8b
> > --- /dev/null
> > +++ b/Documentation/admin-guide/mm/damon/usage.rst
> > @@ -0,0 +1,112 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +===============
> > +Detailed Usages
> > +===============
> > [...]
> > +
> > +Tracepoint for Monitoring Results
> > +=================================
> > +
> > +DAMON provides the monitoring results via a tracepoint,
> > +``damon:damon_aggregated``.  While the monitoring is turned on, you could
> > +record the tracepoint events and show results using tracepoint supporting tools
> > +like ``perf``.  For example::
> > +
> > +    # echo on > monitor_on
> > +    # perf record damon:damon_aggregated &
> 
> I think that needs to be "-e damon:damon_aggregated".

Good catch, I will fix in the next spin!

> 
> > +    # sleep 5
> > +    # kill 9 $(pidof perf)
> > +    # echo off > monitor_on
> > +    # perf script
> > 
> > [...]
> >
> > diff --git a/Documentation/vm/damon/design.rst b/Documentation/vm/damon/design.rst
> > new file mode 100644
> > index 000000000000..727d72093f8f
> > --- /dev/null
> > +++ b/Documentation/vm/damon/design.rst
> > @@ -0,0 +1,166 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +======
> > +Design
> > +======
> > +
> > [...]
> > +
> > +Reference Implementations of Address Space Specific Primitives
> > +==============================================================
> > +
> > +The low level primitives for the fundamental access monitoring are defined in
> > +two parts:
> > +
> > +1. Identification of the monitoring target address range for the address space.
> > +2. Access check of specific address range in the target space.
> > +
> > +DAMON currently provides the implementation of the primitives for only the
> > +virtual address spaces. Below two subsections describe how it works.
> > +
> > +
> > +PTE Accessed-bit Based Access Check
> > +-----------------------------------
> > +
> > +The implementation for the virtual address space uses PTE Accessed-bit for
> > +basic access checks.  It finds the relevant PTE Accessed bit from the address
> > +by walking the page table for the target task of the address.  In this way, the
> > +implementation finds and clears the bit for next sampling target address and
> > +checks whether the bit set again after one sampling period.  This could disturb
> > +other kernel subsystems using the Accessed bits, namely Idle page tracking and
> > +the reclaim logic.  To avoid such disturbances, DAMON makes it mutually
> > +exclusive with Idle page tracking and uses ``PG_idle`` and ``PG_young`` page
> > +flags to solve the conflict with the reclaim logic, as Idle page tracking does.
> > +
> > +
> > +VMA-based Target Address Range Construction
> > +-------------------------------------------
> > +
> > +Only small parts in the super-huge virtual address space of the processes are
> > +mapped to the physical memory and accessed.  Thus, tracking the unmapped
> > +address regions is just wasteful.  However, because DAMON can deal with some
> > +level of noise using the adaptive regions adjustment mechanism, tracking every
> > +mapping is not strictly required but could even incur a high overhead in some
> > +cases.  That said, too huge unmapped areas inside the monitoring target should
> > +be removed to not take the time for the adaptive mechanism.
> > +
> > +For the reason, this implementation converts the complex mappings to three
> > +distinct regions that cover every mapped area of the address space.  The two
> > +gaps between the three regions are the two biggest unmapped areas in the given
> > +address space.  The two biggest unmapped areas would be the gap between the
> > +heap and the uppermost mmap()-ed region, and the gap between the lowermost
> > +mmap()-ed region and the stack in most of the cases.  Because these gaps are
> > +exceptionally huge in usual address spaces, excluding these will be sufficient
> > +to make a reasonable trade-off.  Below shows this in detail::
> > +
> > +    <heap>
> > +    <BIG UNMAPPED REGION 1>
> > +    <uppermost mmap()-ed region>
> > +    (small mmap()-ed regions and munmap()-ed regions)
> > +    <lowermost mmap()-ed region>
> > +    <BIG UNMAPPED REGION 2>
> > +    <stack>
> > +
> 
> Nit: I'd swap these sections so they match the ordered list in the
> section overview.

Good point!  I will do so in the next spin!

> 
> > [...]
> 
> I skipped the files you mentioned would be dropped from the next
> revision.

Thanks, hope it didn't distracted you.


Thanks,
SeongJae Park

[...]
