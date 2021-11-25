Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8600D45E1CE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 21:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357188AbhKYUsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 15:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbhKYUqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 15:46:16 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF46C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 12:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=7qlcS+ge7hsZOtjwKm94/eIrDorkzsfp9oGAwvwAovg=;
        t=1637872985; x=1639082585; b=eqDnE3qAf6sR5V6g82F6O91Mpbr/KJvdEpIUkX/q3bS9aCX
        CK1lqXYsXpb7VmCmbzCsqpCT1otWv1gc4OOJ0d2xAF70AVljFuGTE0IEHiNKIJfi2Pew0P/Q3aafk
        qN3lkvuVZKapTjLHdcbz4iAx36d9HI1+85fQObk43h5aZXHdjtHrDEPpPMmxxT3WhIIVWCWdF0vVA
        PqYSUwXbkoxu2wmfOvuE4c1e+pQFn0ks9JPZjvl/wdjGiPTlboCN7YH9nxtMcdisAmVz3cCYmaM8g
        FyHNqXUtHHAEdNNsLaKL9RqYP1Q1UkXcCwAD1Ls10fGMG8nSWoh+NyDZxl+UnT+g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mqLa2-002tB9-N1;
        Thu, 25 Nov 2021 21:42:55 +0100
Message-ID: <d4e9d61034eb6dd3afccc3d30e995ff89701e3b4.camel@sipsolutions.net>
Subject: Re: [gcov] 1391efa952: BUG:KASAN:slab-out-of-bounds_in_gcov_info_add
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Hackmann <ghackmann@android.com>,
        Tri Vo <trong@android.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     "Sang, Oliver" <oliver.sang@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>
Date:   Thu, 25 Nov 2021 21:42:47 +0100
In-Reply-To: <CAHk-=wj7OZQcHPdcTz1cAXN1fdRJ4kqqeQHqOTP8CChHHS=bjQ@mail.gmail.com>
References: <20211125142622.GD3109@xsang-OptiPlex-9020>
         <a5274ba1922d5eaf9568886191e0a05bdfc55506.camel@sipsolutions.net>
         <CAHk-=wj7OZQcHPdcTz1cAXN1fdRJ4kqqeQHqOTP8CChHHS=bjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-11-25 at 09:48 -0800, Linus Torvalds wrote:
> 
> The report isn't wonderful (the KASAN report is garbled, and the "code
> disassembly" is not from the actual KASAN report, it's from the return
> to user space code), but it blames a 8-byte read at
> 
>     gcov_info_add (kernel/gcov/clang.c:328)
> 
> which in that kernel version (1391efa952e8) is that
> 
>         for (i = 0; i < sfn_ptr->num_counters; i++)
> ->              dfn_ptr->counters[i] += sfn_ptr->counters[i];
> 
> and so it looks like that 'sfn_ptr->counters[i]' access is the problem case.
> 

Not sure. Note the +=, so it has to read both sides first. Would KASAN
report the follow-up write as well?

The loop is going to sfn_ptr->num_counters, so that seems less likely to
get confused, unless clang has a bug, which is where the original
counters and num_counters comes from, afaict?

I mean, we seem to always consistently allocate counters from
num_counters for these things, but here we use sfn_ptr and dfn_ptr, and
the loop checks only dfn_ptr. Just being suspicious I guess, but I
really don't know anything about this. All I know that vmalloc made this
really slow on ARCH=um and so I converted all of this ... :)

johannes
