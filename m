Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D98630AC7C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 17:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhBAQSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 11:18:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:32955 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229793AbhBAQSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:18:40 -0500
IronPort-SDR: SE9hoT4m542b9hxBWr8sIuPLmGLpbUmDz7BCG9n0CQPjeqUusTGdqJf5ilSXjxdLHQUn4rzAbC
 5dYCp+fa9tdQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="160475422"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="160475422"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 08:16:53 -0800
IronPort-SDR: 5OS2hvGD0EL98Cah3aGcdogh6ZTv9w4OG1i4fDRsCEPoQPk45SQePQi8lGL/DCPID9RiZwTvLV
 WzeK5bwYQnQA==
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="479141559"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 08:16:46 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l6bsY-001AhJ-AH; Mon, 01 Feb 2021 18:16:42 +0200
Date:   Mon, 1 Feb 2021 18:16:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Christoph Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 3/3] vsprintf: dump full information of page flags in
 pGp
Message-ID: <YBgpavcZD4VXZri6@smile.fi.intel.com>
References: <20210201115610.87808-1-laoar.shao@gmail.com>
 <20210201115610.87808-4-laoar.shao@gmail.com>
 <YBgBxaFSy8P/nrcH@smile.fi.intel.com>
 <CALOAHbAUPCUfZp_58QbVzvbP2UqoPqHAzzsgk1UTZ95v1rtqTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbAUPCUfZp_58QbVzvbP2UqoPqHAzzsgk1UTZ95v1rtqTw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 09:49:59PM +0800, Yafang Shao wrote:
> On Mon, Feb 1, 2021 at 9:27 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Feb 01, 2021 at 07:56:10PM +0800, Yafang Shao wrote:

...

> > > - Before the patch,
> > > [ 6343.396602] Slab 0x000000004382e02b objects=33 used=3 fp=0x000000009ae06ffc flags=0x17ffffc0010200(slab|head)
> > >
> > > - After the patch,
> > > [ 6871.296131] Slab 0x00000000c0e19a37 objects=33 used=3 fp=0x00000000c4902159 flags=0x17ffffc0010200(Node 0,Zone 2,Lastcpupid 0x1fffff,slab|head)
> > >
> > > The Documentation and test cases are also updated.
> >
> > Thanks for an update, my comments below.
> >
> > ...
> >
> > > -     %pGp    referenced|uptodate|lru|active|private
> > > +     %pGp    Node 0,Zone 2,referenced|uptodate|lru|active|private
> >
> > Since of the nature of printf() buffer, I wonder if these should be at the end.
> > I.o.w. the question is is the added material more important to user to see than
> > the existed one?
> >
> 
> The existing one should be more important than the added one.
> But the order of output will not match with the value for page->flags.
> E.g.
>     flags=0x17ffffc0010200(slab|head,Node 0,Zone 2,Lastcpupid 0x1fffff)
> It may be strange to compare the value with the string.

More I'm looking at it, more I'm thinking it should have different specifiers
for each group of desired flags to be printed.

So, you leave %pGp as is and then add another letter to add more details, so
user will choose what and in which order they want.

For example, let's assume %pGp == %pGpf and P is a new specifier for what you
are initially adding here:

  %pGpfP => referenced|uptodate|lru|active|private,Node 0,Zone 2
  %pGpPf => Node 0,Zone 2,referenced|uptodate|lru|active|private

and so on.

-- 
With Best Regards,
Andy Shevchenko


