Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AD5374CCE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 03:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhEFBVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 21:21:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:60385 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhEFBU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 21:20:59 -0400
IronPort-SDR: QjW6wl/2ZL2Er58FzjlPo/Y6Qtrx6pxZFh0zsiAbC08CwWQt1C5AuQFrIYSPho2dLiNPzglHgv
 N9kt/xSZ8k3g==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="283779782"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="283779782"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 18:20:00 -0700
IronPort-SDR: l4kFtJD3/ikRP0/cineXO5j1mZl2xsfXzeJs4D/vCyix2IgZxFrH2mZSWYn89ZSJx0uB2Ck57g
 e9u96KeNP8CQ==
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="434095098"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 18:19:55 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jens Axboe <axboe@kernel.dk>, Jian Cai <jiancai@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        He Ying <heying24@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] [v2] smp: fix smp_call_function_single_async prototype
References: <20210505211300.3174456-1-arnd@kernel.org>
Date:   Thu, 06 May 2021 09:19:53 +0800
In-Reply-To: <20210505211300.3174456-1-arnd@kernel.org> (Arnd Bergmann's
        message of "Wed, 5 May 2021 23:12:42 +0200")
Message-ID: <87czu4slom.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> As of commit 966a967116e6 ("smp: Avoid using two cache lines for struct
> call_single_data"), the smp code prefers 32-byte aligned call_single_data
> objects for performance reasons, but the block layer includes an instance
> of this structure in the main 'struct request' that is more senstive
> to size than to performance here, see 4ccafe032005 ("block: unalign
> call_single_data in struct request").
>
> The result is a violation of the calling conventions that clang correctly
> points out:
>
> block/blk-mq.c:630:39: warning: passing 8-byte aligned argument to 32-byte aligned parameter 2 of 'smp_call_function_single_async' may result in an unaligned pointer access [-Walign-mismatch]
>                 smp_call_function_single_async(cpu, &rq->csd);

Can this be silenced by

		smp_call_function_single_async(cpu, (call_single_data_t *)&rq->csd);

Best Regards,
Huang, Ying

[snip]
