Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0FC3115EE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 23:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbhBEWps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 17:45:48 -0500
Received: from mga01.intel.com ([192.55.52.88]:9160 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229562AbhBEOwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:52:11 -0500
IronPort-SDR: gqNaeb1Bo2cqaaN72sb2k6Fi1tA6p9QQDOq10UJ4d5z0sZePMeVZPFHpJqgu1yOHL2vxe9HEr9
 bZDtpQzcvbRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="200458140"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="200458140"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 08:01:32 -0800
IronPort-SDR: XM0B3MmmoWzhRiAeh0KlBcUrZDjGoqkkDfHi61Otf6dih0ahbZZXPqcTwXdkH+DME12WkBAR21
 aHWaSFFWEt/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="508578982"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 05 Feb 2021 08:01:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id D6D3B184; Fri,  5 Feb 2021 18:01:27 +0200 (EET)
Date:   Fri, 5 Feb 2021 19:01:27 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/9] Linear Address Masking enabling
Message-ID: <20210205160127.ylcdd6bbve6q2bbk@black.fi.intel.com>
References: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
 <YB1o8RZnaaf7xXAQ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YB1o8RZnaaf7xXAQ@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 04:49:05PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 05, 2021 at 06:16:20PM +0300, Kirill A. Shutemov wrote:
> > The feature competes for bits with 5-level paging: LAM_U48 makes it
> > impossible to map anything about 47-bits. The patchset made these
> > capability mutually exclusive: whatever used first wins. LAM_U57 can be
> > combined with mappings above 47-bits.
> 
> And I suppose we still can't switch between 4 and 5 level at runtime,
> using a CR3 bit?

No. And I can't imagine how would it work with 5-level on kernel side.

-- 
 Kirill A. Shutemov
