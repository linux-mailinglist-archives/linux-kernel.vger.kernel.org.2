Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982B0349B1D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 21:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhCYUkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 16:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhCYUkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 16:40:11 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC33C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 13:40:11 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id k8so3210434iop.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 13:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jxjYVyzv0VtmRagBbn7C6REHsWZ6v6VeVCUpgEtMtPM=;
        b=A5TRe8F7xZOkW5UJYIYX4JMYMOCw5JF4Tva1AvGvdKbXp/2SuptkuI5qoau9ekKpMC
         pY22tcBlTXTXeU8KteJmKMJuIL1fnfQ4a+0rTj3ad8H3rvfMaUm26zRVho/uD8TWAJTT
         J/5egllh7nn/gy61+l0XhbcNzmpgAU19jHc7M4VWmoWEgLuj+k1Xn/rNR7K0wkKFjC7j
         94XhDvtciMEiAmpMe5j7w8psDCmvwHvLJ9Qw88BJg4AjoV+uhLl8gu5WsE7wmV/5NJgh
         IezcePq+ZV1FFYnlYBmrHS3Ty5fsSVj7h9eVtLT/iHPL2DrGFaR8C2uDjfFVO8g8qJL/
         Rm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jxjYVyzv0VtmRagBbn7C6REHsWZ6v6VeVCUpgEtMtPM=;
        b=FF/nnV2D1aH6oCT0ruFfV57yAN/x4dGZC028VgrZXfNvEL2dqg+4j2d/tKG5j9VpMu
         +JO5J9Ym2g0x8Usf//C+EdkcE6G7HwkPDQzDivg8JeoVhRZ1mlyRInd9QCYeR78kjhqD
         XaSW613LdhhtTPl7G1MPDsGIMWgbovzV+0yuO+IfGeNMg9X0TxKaaHOmhDfctTzMl+iY
         JoLomjhwIJ/EXHzDCOB6YaeyOPxSgxcndoC3JY/hwuWphzI+uGsmHlMpP1r62y9FBmkX
         Sd2Bzyurfpj4K/Wz97lRaSEM858lEVigyje2Y0IfEeu5xDB7xQISMUeTCm+iYrBiPRGp
         RCQg==
X-Gm-Message-State: AOAM533WczMmxRwHu+KfjOivZ53trn5Fob99IbsTND/IPQFpHVpFf7HL
        ttk9aefse6eT60HMnuMQeRv41D2d7AsIZQ==
X-Google-Smtp-Source: ABdhPJw26OPXsttfpqFcAPc3t3g3KrF8DIkFEO9xWkPI6UJ53qkOox3NCB/jnRNGS4c+YwJmd1LF+g==
X-Received: by 2002:a02:7419:: with SMTP id o25mr8954187jac.100.1616704811098;
        Thu, 25 Mar 2021 13:40:11 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v17sm3134802ios.46.2021.03.25.13.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 13:40:10 -0700 (PDT)
Subject: Re: [PATCH 0/2] Don't show PF_IO_WORKER in /proc/<pid>/task/
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     io-uring <io-uring@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Stefan Metzmacher <metze@samba.org>
References: <20210325164343.807498-1-axboe@kernel.dk>
 <m1ft0j3u5k.fsf@fess.ebiederm.org>
 <CAHk-=wjOXiEAjGLbn2mWRsxqpAYUPcwCj2x5WgEAh=gj+o0t4Q@mail.gmail.com>
 <CAHk-=wg1XpX=iAv=1HCUReMbEgeN5UogZ4_tbi+ehaHZG6d==g@mail.gmail.com>
 <CAHk-=wgUcVeaKhtBgJO3TfE69miJq-krtL8r_Wf_=LBTJw6WSg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ad21da2b-01ea-e77c-70b2-0401059e322b@kernel.dk>
Date:   Thu, 25 Mar 2021 14:40:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgUcVeaKhtBgJO3TfE69miJq-krtL8r_Wf_=LBTJw6WSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/21 2:12 PM, Linus Torvalds wrote:
> On Thu, Mar 25, 2021 at 12:42 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> On Thu, Mar 25, 2021 at 12:38 PM Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>> I don't know what the gdb logic is, but maybe there's some other
>>> option that makes gdb not react to them?
>>
>> .. maybe we could have a different name for them under the task/
>> subdirectory, for example (not  just the pid)? Although that probably
>> messes up 'ps' too..
> 
> Actually, maybe the right model is to simply make all the io threads
> take signals, and get rid of all the special cases.
> 
> Sure, the signals will never be delivered to user space, but if we
> 
>  - just made the thread loop do "get_signal()" when there are pending signals
> 
>  - allowed ptrace_attach on them
> 
> they'd look pretty much like regular threads that just never do the
> user-space part of signal handling.
> 
> The whole "signals are very special for IO threads" thing has caused
> so many problems, that maybe the solution is simply to _not_ make them
> special?

Just to wrap up the previous one, yes it broke all sorts of things to
make the 'tid' directory different. They just end up being hidden anyway
through that, for both ps and top.

Yes, I do think that maybe it's better to just embrace maybe just
embrace the signals, and have everything just work by default. It's
better than continually trying to make the threads special. I'll see
if there are some demons lurking down that path.

-- 
Jens Axboe

