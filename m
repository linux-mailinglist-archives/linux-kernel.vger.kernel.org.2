Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3A23A941A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhFPHgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhFPHgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:36:39 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0E8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 00:34:33 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q5so1482092wrm.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 00:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DkOyAc/bX03Ji647TARVlGet/gKH2IOLf7LbuAqbisM=;
        b=qChz5fhqUDfjnLDvqzi5XBuBjS/YpqGv52c5EDCSZUyUKBmckNmzxhBCgGZfu/ywnG
         xjGGlfmbYpVUwHDcsUi9cx2/ycQeOpnPR2oxzqsb5O+GIv9OQPAK9U/THRXX0QGPzUmn
         5PtWtI8i7nwiij7U3ef1cvW+85/WV64Mr0G7tiGz8LRaxbPgLtjStCIt6FjbG5M7GdBU
         uD8DEBAqhZiSmI22kl8Z7BHs5eoClErpyIa+oQkopS5ezeu31Wx1j5ZhPkJpH6CZi6Kw
         gamYMqgtCxRykk/RF6YbF94x0EsbHR+usC+AIeXFhUb8RZFdRMbiRkUjSFh6WHxM16kg
         Wh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DkOyAc/bX03Ji647TARVlGet/gKH2IOLf7LbuAqbisM=;
        b=n3NB3yrNP+8tiEzmCj6L8y2bmGOlthTuonURD16quVGzMeUkYx1FYprhzCmYKdDT7T
         /95Nv+/RKJ2tItxlBMHrqq0+ioFJOXME/0fnJN21GzY/Cplr9aRFCh92WqgpCdVI3c83
         1sySD8TfI2GCATBSFl/DUjXKVi/rzLUk27688kH2Rz1Wki9wVqzEOm8w52ae+XsxB2Xn
         LfE+M56LwDBDJJ7OwOg5n/lOAMxGliXhv6IdiL/siks4Jraz4gusjHuzP5YDYTE7Et/u
         yKF6RtFSmTyfZrE8Fpxpjy+RmEcYzuJ3S+Jj/paAp5YCbuR0wjIZs4sYzvtBmgmJpuqk
         0xFg==
X-Gm-Message-State: AOAM533M/Jd6BwjB4TCjZb4KI/E4UagO64E2QOF3+1DhlfFqCUNG/EWK
        He5K6NkAHftwL6A/W4neVnWsiU4Xn1N9N9V+UFrezQ==
X-Google-Smtp-Source: ABdhPJwpxMKlpG/gqkLzaOULtd1zak/UVf75vq18LqdWZh2wnaeGAvWveZNSB1V/CXs08H2Oz9EutGPHVzoXCW3nVww=
X-Received: by 2002:a05:6000:1889:: with SMTP id a9mr3682588wri.288.1623828871959;
 Wed, 16 Jun 2021 00:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210611124642.72910-1-zhengqi.arch@bytedance.com> <06292162-5a44-6f91-140d-e1211c006ad0@kernel.org>
In-Reply-To: <06292162-5a44-6f91-140d-e1211c006ad0@kernel.org>
From:   =?UTF-8?B?6YOR55Cm?= <zhengqi.arch@bytedance.com>
Date:   Wed, 16 Jun 2021 15:34:21 +0800
Message-ID: <CAOgjDMgcKZAGP0-QW9uzCM28eKdZvA49KoDQ=RnAnJL=7_zL5g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] x86: fix get_wchan() not support the ORC unwinder
To:     Andy Lutomirski <luto@kernel.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 12:21 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On 6/11/21 5:46 AM, Qi Zheng wrote:
> > Currently, the kernel CONFIG_UNWINDER_ORC option is enabled by
> > default on x86, but the implementation of get_wchan() is still
> > based on the frame pointer unwinder, so the /proc/<pid>/wchan
> > always return 0 regardless of whether the task <pid> is running.
> >
> > We reimplement the get_wchan() by calling stack_trace_save_tsk(),
> > which is adapted to the ORC and frame pointer unwinders.
>
> How much slower does this make ps?

I used the bpftrace tool to test the running time of get_wchan() in the two
cases of the ORC and frame pointer unwinders, the test script and
the result are as follows:

the test script:
bpftrace -e 'kprobe:get_wchan { @start[tid] = nsecs; } kretprobe: get_wchan
/@start[tid]/ { @ns[comm] = hist(nsecs - @start[tid]); delete(@start[tid]); }'

the result:
1) ORC unwinder ( before applying this patch )

@ns[ps]:
[512, 1K)     4609   |@@@@@@@@@@@@ |
[1K, 2K)      18599  |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[2K, 4K)      1848    |@@@@@ |
[4K, 8K)       307     | |
[8K, 16K)     74       | |
[16K, 32K)   12       | |

73% of the cases are in the [1K, 2K) range.
Notice: In this case, the get_wchan() always returns the wrong value of 0.

2) ORC unwinder ( after applying this patch )

@ns[ps]:
[512, 1K)    536      |@ |
[1K, 2K)     19945   |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[2K, 4K)     5604     |@@@@@@@@@@@@@@ |
[4K, 8K)     246       | |
[8K, 16K)   154       | |
[16K, 32K) 18         | |

75% of the cases are in the [1K, 2K) range.

3) frame point unwinder ( before applying this patch )

@ns[ps]:
[512, 1K)    245      | |
[1K, 2K)     16577   |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[2K, 4K)     2788     |@@@@@@@@ |
[4K, 8K)     190       | |
[8K, 16K)   74         | |
[16K, 32K) 9           | |

83% of the cases are in the [1K, 2K) range.

4) frame point unwinder ( after applying this patch )

@ns[ps]:
[512, 1K)    85        | |
[1K, 2K)     12023  |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[2K, 4K)     7418    |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ |
[4K, 8K)     232      |@ |
[8K, 16K)   104      | |
[16K, 32K) 18        | |

60% of the cases are in the [1K, 2K) range.

In summary, the running time of get_wchan() has increased after applying this
patch. But the get_wchan() is not the hotspot function, and this is a bug in the
default ORC option, so I think these increased runtimes are acceptable.

In addition, this issue has existed for nearly 4 years and no one has
fixed it, if
nobody cares about the return value of the get_wchan(), maybe we can return
0 or remove this function directly. What do you think?

Best regards,
Qi Zheng

>
> --Andy
