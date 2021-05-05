Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC975373DB9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 16:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbhEEOfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 10:35:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:40976 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229763AbhEEOfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 10:35:42 -0400
IronPort-SDR: gBM/ZxI60QbQQWNLOPKQjJryURnBABog0/hPRwzaP0KXbJISIt9yq2K326wXtBDsPrs1eoR+kC
 T7aiVzwKWyYg==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="283648490"
X-IronPort-AV: E=Sophos;i="5.82,275,1613462400"; 
   d="scan'208";a="283648490"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 07:34:44 -0700
IronPort-SDR: DrKoOWa5eJeqAiNbrQBDhagwD7L0gMC68nrfbJKLatMj5DI+/j4uq9ePLhp2EllddUoVIycVHu
 7WJnpOjDgHiQ==
X-IronPort-AV: E=Sophos;i="5.82,275,1613462400"; 
   d="scan'208";a="433848058"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 07:34:43 -0700
Date:   Wed, 5 May 2021 07:34:42 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH] sched: Work around undefined behavior in sched class
 checking
Message-ID: <20210505143442.GR4032392@tassilo.jf.intel.com>
References: <20210505033945.1282851-1-ak@linux.intel.com>
 <YJI/OwoflyY2IXvf@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJI/OwoflyY2IXvf@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Use RELOC_HIDE to make this work. This hides the symbols from gcc,
> > so the optimizer won't make these assumption. I also split
> > the BUG_ONs in multiple.
> 
> Urgh, that insanity again :/ Can't we pretty please get a GCC flag to
> disable that?

Even if that was done (I could totally see the gcc people pushing back on this;
why should they add special flags just for Linux developers not understanding
ISO-C?) you would still need the fix for already shipping compilers.

-Andi

