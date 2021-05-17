Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0C8383CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 20:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbhEQSrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 14:47:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:1909 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235486AbhEQSro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 14:47:44 -0400
IronPort-SDR: l36sVhyjRggpiuaY6dIvURWi9zPLehtd0wWlj7h/eZfBF8Mw0mGuXsARxMd8MUbDSI5WbM1XWg
 CRncXS1CJQ5A==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="286068099"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="286068099"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 11:46:27 -0700
IronPort-SDR: ow5fnO3Rv0w3EMf4yV9xevk+7ZgBecb5WfB0gY9Dnc5yPENpB5PjeMKhn8xKJXoSDQeGxba0xQ
 HGMP9f3S9vZw==
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="630118842"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 11:46:27 -0700
Date:   Mon, 17 May 2021 18:46:21 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH 0/4] x86/bus_lock: Set rate limit for bus lock
Message-ID: <YKK5/fgD4w+TVinx@otcwcpicx3.sc.intel.com>
References: <20210419214958.4035512-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419214958.4035512-1-fenghua.yu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dear X86 maintainers,

On Mon, Apr 19, 2021 at 09:49:54PM +0000, Fenghua Yu wrote:
> Bus lock warn and fatal handling is in tip. This series sets system
> wide bus lock rate limit to throttle malicious code.
> 
> This series is applied on top of tip master branch.
> 
> Change Log:
> -Set system wide rate limit instead of per-user rate limit (Thomas).
> -Thomas suggested to split the previous bus lock into warn and fatal
> patch set and this rate limit patch set:
> https://lore.kernel.org/lkml/871rca6dbp.fsf@nanos.tec.linutronix.de/

Any comment on this series?

The series can be applied to 5.13-rc cleanly without any change.

Thanks.

-Fenghua
