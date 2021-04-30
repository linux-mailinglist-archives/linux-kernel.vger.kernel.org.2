Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096A336F771
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 10:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhD3I6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 04:58:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59668 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhD3I6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 04:58:10 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619773041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7TvOyBzXvgra4jDnrI42WzEmRAmKfAJx8nWVdE6lSe4=;
        b=q+waqDS2CYqSTglpaX38I4CX7hFJQxj9fE46I6TcpgbFvbwIPOf3zcXAZwMT1EieU2zxo2
        IZGcS7Db5QPjX4oaf8idaK3HjmZ3Jq11EWrOZvGJr26mw059wUL2QqZlfvshgcrsI392i0
        rP58sHQIwyLygIuAmyG59QlQcOYE5U/t9GgYBMbXPvTPb4Nhi+9J3q2WpiCckrDXJhTN8r
        zNFw8l6vglYMkElecMwbGyFlAs2kLzkzkau0PdUvOoBjSLIXLiftS1ttW8L+sC4MeeBxoQ
        vuTD81V28X3a6rIlM83ChAzD+sxGGfVfXu1VmgBEnRo1bhq9ILDs/y1/MiqHCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619773041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7TvOyBzXvgra4jDnrI42WzEmRAmKfAJx8nWVdE6lSe4=;
        b=rgvoH4K40TJ8wA0jIbKHl0zQ6XyJIrCtwMfGroc/BtwyatB078YkRXT5S/Pki7fE3cbcsc
        Y/O/EWoh0PmMVzAw==
To:     Feng Tang <feng.tang@intel.com>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [signal]  4bad58ebc8:  will-it-scale.per_thread_ops -3.3% regression
In-Reply-To: <20210430081359.GB79529@shbuild999.sh.intel.com>
References: <20210420030837.GB31773@xsang-OptiPlex-9020> <20210430081359.GB79529@shbuild999.sh.intel.com>
Date:   Fri, 30 Apr 2021 10:57:20 +0200
Message-ID: <874kfof8un.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feng,

On Fri, Apr 30 2021 at 16:13, Feng Tang wrote:
> On Tue, Apr 20, 2021 at 11:08:37AM +0800, kernel test robot wrote:
>> commit: 
>>   69995ebbb9 ("signal: Hand SIGQUEUE_PREALLOC flag to __sigqueue_alloc()")
>>   4bad58ebc8 ("signal: Allow tasks to cache one sigqueue struct")
>> 
>> 69995ebbb9d37173 4bad58ebc8bc4f20d89cff95417 
>> ---------------- --------------------------- 
>>          %stddev     %change         %stddev
>>              \          |                \  
>>  1.273e+09            -3.3%  1.231e+09        will-it-scale.192.threads
>>    6630224            -3.3%    6409738        will-it-scale.per_thread_ops
>>  1.273e+09            -3.3%  1.231e+09        will-it-scale.workload
>
> We've double checked this, and it seems to be another case of
> the code alignment change caused regression change, just like
> the other case we debugged " [genirq]  cbe16f35be:
> will-it-scale.per_thread_ops -5.2% regression" 
>
> https://lore.kernel.org/lkml/20210428050758.GB52098@shbuild999.sh.intel.com/
>
> With the same debug patch of forcing function address 64 bytes
> aligned, then commit 4bad58ebc8 will bring no change on this case. 
>
> commit 09c60546f04f "./Makefile: add debug option to enable function
> aligned on 32 bytes" only forced 32 bytes align, with thinking 64B
> align will occupy more code space, and affect iTLB more. Maybe we
> should just extend it to 64B align, as it is for debug only anyway. 

thanks for the heads up!

But why is this restricted to debug mode?

The fact that adding a few bytes of text causes regressions in unrelated
code is not restricted to debug or am I missing something here?

Thanks,

        tglx
