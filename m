Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05373E94EB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 17:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbhHKPqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 11:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbhHKPql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 11:46:41 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8C9C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 08:46:17 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso10262950pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 08:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xmjBHqykW03zNN1TupmXJKniB5jvJ6VdXHDLlgAgYnc=;
        b=e+nLPWrC/ohcEjdh99keoPB3lXKgmf/mvvRzCnWY7XOA0eOYaZvgjB0MH+rTO80tT+
         WPPzhHZcQKFC+wPUTTN93EHNXICO7uNlNFPCbZAXrcgsDIXE3IaI8SD4n8MqoAZffArj
         xzEtDvm3ZWIvqSigWIb9OXg2mI3zzvwSFhXCz3irXq3Rv/FtxhRE5OCWua/hdB/AbqI8
         6hERMHaTCkQxgS4dcITdAfuS6OO/1MHDjRZ8vyPoF13u9AGZTJqyKmJN2QlTylZG/6uS
         k3SMypExAJBvSAT0Q9pIH8C5CtqhsTxUWnEpPi+Jj+159A+1TlF9G67FvzUFtnEdPcM/
         dYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xmjBHqykW03zNN1TupmXJKniB5jvJ6VdXHDLlgAgYnc=;
        b=ja/u5PekvuVEeH+jJmhXg71PW2/f57Dx6RKduCmGS7yR4r8eTw8z1Vx4I1ZUJWWCoD
         ++fZDB0RveNQvi0wVBFoz0qD1RQ57bFKsPIZEag98YIehZ8Q/RhA78Q2GrNzNCkR/4tl
         LgKXWFIH4TW6whTNaRMDD5l7xawE9B50n0M874XL6MC9OKRBye3XeRaGL+ww5JXAWEgT
         FMvKsB9Ff2A73JeRMJ5IqOXfowyKny0oJ6KIyGjjpy8xKO59p9eAMHz6JXEFqkdymrFq
         lSMP1SHLnrCE0PGljpw1Pz5ZEQRETwQaovulLF3zwpQgSTEept1tu9w+PHmi93/AdBHO
         oIAw==
X-Gm-Message-State: AOAM533fXW5qUDWXstQmQZdA+LVbB2IIk0/JiQKlqkJLwgD7mK6V9nJ7
        9MmeAqrMeQCm6kxkks3F1eSbYg==
X-Google-Smtp-Source: ABdhPJyWCPc/VWWwcrdTNk0o8v2RJpnPmyBqQ48zWL1iBvPFGWtShWtsQB/zlKRhXWldiXQXSulM/Q==
X-Received: by 2002:a63:5659:: with SMTP id g25mr356067pgm.354.1628696777272;
        Wed, 11 Aug 2021 08:46:17 -0700 (PDT)
Received: from sspatil2.c.googlers.com (190.40.105.34.bc.googleusercontent.com. [34.105.40.190])
        by smtp.gmail.com with ESMTPSA id a35sm32239904pgm.66.2021.08.11.08.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 08:46:16 -0700 (PDT)
Subject: Re: [pipe] 3a34b13a88: hackbench.throughput -12.6% regression
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
References: <20210802024945.GA8372@xsang-OptiPlex-9020>
 <CAHk-=whr-zgf41B0BPsWnL-WWqhdk71rKffhV0fzdCuem3=SCQ@mail.gmail.com>
From:   Sandeep Patil <sspatil@android.com>
Message-ID: <f3c614bd-a8a4-55f8-98c5-bfa3065e24b1@android.com>
Date:   Wed, 11 Aug 2021 15:46:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whr-zgf41B0BPsWnL-WWqhdk71rKffhV0fzdCuem3=SCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/21 5:06 PM, Linus Torvalds wrote:
> On Sun, Aug 1, 2021 at 7:31 PM kernel test robot <oliver.sang@intel.com> wrote:
>>
>> FYI, we noticed a -12.6% regression of hackbench.throughput due to commit:
> 
> I had already forgotten how sensitive hackbench is to pipe wakeups.
> 
> I think it's all good for stable, and we can live with this -
> particularly since I'm not sure how much hackbench really matters.
> 
> But it might be one of those things where it is a good idea to make
> the crazy epoll case explicitly special.
> 
> Sandeep, does something like the attached patch (written to be on top
> of the existing one) work for you?
> 
> It's not a great patch - I'd like to catch _just_ the broken EPOLLET
> case, but this patch triggers on any select/poll usage - but it might
> be a good idea to do it this way simply because it now separates out
> the "ok, now we need to do stupid things" logic, so that we *could*
> make that "stupid things" test tighter some day.
> 
> And I think it's actually better to make sure that the unnecessary
> extra wakeup be the _last_ one a write() system call does, not the
> first one. So this may be the way to go for that reason too.

So the patch works for Android apps that I could test like
the last one did.

Also, the way that library was using pipes, I think first/last write
doesn't matter since the kernel will only see one small write afaict.
So, if this change helps with performance, it LGTM.

I can make sure its picked up for Android if you decide to merge in
your tree and report if something breaks happens again (I don't expect
anything)

> 
> This all probably doesn't matter one whit, but hey, I love how the
> kernel test robot gives us heads-up about performance anomalies, so I
> try to take them seriously when they aren't totally strange (which
> happens sometimes: some of the benchmarks end up having subtle cache
> placement effects)
> 

Thanks for sending this and sorry for the delay again.

- ssp


