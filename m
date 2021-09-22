Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD7E4152E2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 23:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238099AbhIVVfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 17:35:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:4408 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237770AbhIVVe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 17:34:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="246150220"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="246150220"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 14:33:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="454881380"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 22 Sep 2021 14:33:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 3E2A2FF; Thu, 23 Sep 2021 00:33:26 +0300 (EEST)
Date:   Thu, 23 Sep 2021 00:33:26 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "Zhang, Xiang1" <xiang1.zhang@intel.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Marco Elver <elver@google.com>,
        Taras Madan <tarasmadan@google.com>
Subject: Re: [RFC 0/9] Linear Address Masking enabling
Message-ID: <20210922213326.d4n57ml5vehmyaad@black.fi.intel.com>
References: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
 <CACT4Y+bh1yaGLs5H3YTM6YLLtyWELvjWR7HcEk0pd9Nod9u4ZQ@mail.gmail.com>
 <20210207141104.ikxbdxhoisgqaoio@box>
 <CACT4Y+YwUgksZBj4YpChqL8iac2us7mOkbVDLsib3Y+MVb31cw@mail.gmail.com>
 <CAMe9rOog08O8xmhhXuJ6aTO+ctv8D2yw1_vu8XjQWwsfw707Mg@mail.gmail.com>
 <MWHPR11MB00787E70E2E0316E5124741DD3A29@MWHPR11MB0078.namprd11.prod.outlook.com>
 <CACT4Y+anEXw18nT47gxBTA7BEh3GUhqm6qb+PUdVPf6E4Fs6cg@mail.gmail.com>
 <CACT4Y+ZGFdmKYZvA4kvw3iTYLJWmnNp=GeL=0Dz2xyC0EpSuCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZGFdmKYZvA4kvw3iTYLJWmnNp=GeL=0Dz2xyC0EpSuCw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 10:03:32PM +0200, Dmitry Vyukov wrote:
> > 6. The kernel patches (this email thread) depend on the CET patches
> > (for the interface part only). And the CET patches is this, right?
> > https://lore.kernel.org/linux-doc/?q=x86%2Fcet%2Fshstk

CET is two part patchset: shstk and ibt. Look for x86/cet/ibt.

At this point we plan to use CET interface, but it's not settled until it
actually lands upstream.


-- 
 Kirill A. Shutemov
