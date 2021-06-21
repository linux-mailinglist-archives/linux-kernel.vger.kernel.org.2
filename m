Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42713AF819
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 23:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhFUV4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 17:56:03 -0400
Received: from mga03.intel.com ([134.134.136.65]:54165 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230263AbhFUV4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 17:56:01 -0400
IronPort-SDR: jzaJHtAeTe+kaGeo7Jzl5o4zqAAHrXzwajs+wZjy8ppAUQPkyX8lgAmeM6UOfMSQYLkXoTbu5R
 1ZLPZlj818Ig==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="206979733"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="206979733"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 14:53:46 -0700
IronPort-SDR: 9JkbAif2JeIyDUqy/2ZLO+refLXJf8h7ahP9j11N0Jn1J2BUVQjqmNQsUOyH8RbkBWrnwkd0lQ
 az63/pUT1kJg==
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="454029184"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 14:53:45 -0700
Date:   Mon, 21 Jun 2021 21:53:39 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [patch V3 00/66] x86/fpu: Spring cleaning and PKRU sanitizing
Message-ID: <YNEKYysw6/fUgZrL@otcwcpicx3.sc.intel.com>
References: <20210618141823.161158090@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618141823.161158090@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, X86 maintainers,

On Fri, Jun 18, 2021 at 04:18:23PM +0200, Thomas Gleixner wrote:
> The main parts of this series are:
> 
>   - Yet more bug fixes
...
> and is also available via git:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/fpu
...
> Changes vs. V2:
...

After reverting the disabling PASID patch, resolving one PKRU conflict, and
porting the latest internal IDXD patches to this series, I can run stress
PASID context switch tests on this series (and v2 as well). I don't see any
issue for PASID context switch.

Also thank you very much for moving the PASID feature forward.

-Fenghua
