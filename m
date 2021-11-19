Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EFD457324
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 17:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbhKSQjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 11:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbhKSQjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 11:39:02 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437F4C061748
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:36:00 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id m24so8518454pls.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mUA1Ik1IrEtjZziXrTIENZOvTLv8BEae3qCpSE+YCyM=;
        b=HrLUCriF+D8Cvoif6PoPXuZ01iT7CVMXAmIoIU345nrBpdU8RCDZ+XDjy4aMpyqWxX
         1mwslROiPVbi4rQFrNiFLaQRmGBi3X/LId8fpbBu1EBXodx74x0ejyq7NGD7dF6bmaCd
         XHh44079HyOoO48w9cAB4WkzNpBCpXyILFZkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mUA1Ik1IrEtjZziXrTIENZOvTLv8BEae3qCpSE+YCyM=;
        b=xhwlop7gDM5K1Z831LWSKzjF80hmAC0FVKkhD3uJEj6kN98mcV9jWuAd0oSvlIOH3L
         /IadSSI3yfP5RS6WobIXi+FNHd+xx2C2C8hZH6GjM/JR93ODazbvZTV8sGGpv2VjIprF
         LZ5lihq8EutpM9kotiNNyOYCImEQ/2ZTiwY8eS7GVCU93qo9LQaan+KWNRnl0PC9jpqs
         SKJmFI5ryMr8Ot2Ig3rqRp+NCBKKGpTYAFkFAbFGqEqNFAnvf319tQlK6NHcB9C3GjdO
         JoUkVV6l9+pF3ctkJYJkNN9iNIVdFlGr8clSUYVhcOy/+nxQVhBu11IdTU/++wpYg93f
         H0Ug==
X-Gm-Message-State: AOAM532tE9xzKNjOpOZlumLShIxGUH5yxhB7dMBzZnPHDavD9AltJJDS
        VdnpsIc8l2aIv5RDcazKo6SiTw==
X-Google-Smtp-Source: ABdhPJwVGtrRIcvhQKROwLYzVQy0XXGjw4lU4UVPO7uYFvU2N/IYecAtrr5pfHvRHECUwfWCqLA7aQ==
X-Received: by 2002:a17:90a:e00c:: with SMTP id u12mr1072545pjy.139.1637339759754;
        Fri, 19 Nov 2021 08:35:59 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w37sm184115pgk.87.2021.11.19.08.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 08:35:59 -0800 (PST)
Date:   Fri, 19 Nov 2021 08:35:58 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Kyle Huey <me@kylehuey.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Robert O'Callahan <rocallahan@gmail.com>
Subject: Re: [REGRESSION] 5.16rc1: SA_IMMUTABLE breaks debuggers
Message-ID: <202111190829.C0B365D4@keescook>
References: <CAP045AqjHRL=bcZeQ-O+-Yh4nS93VEW7Mu-eE2GROjhKOa-VxA@mail.gmail.com>
 <87k0h6334w.fsf@email.froward.int.ebiederm.org>
 <202111171341.41053845C3@keescook>
 <CAHk-=wgkOGmkTu18hJQaJ4mk8hGZc16=gzGMgGGOd=uwpXsdyw@mail.gmail.com>
 <CAP045ApYXxhiAfmn=fQM7_hD58T-yx724ctWFHO4UAWCD+QapQ@mail.gmail.com>
 <CAHk-=wiCRbSvUi_TnQkokLeM==_+Tow0GsQXnV3UYwhsxirPwg@mail.gmail.com>
 <CAP045AoqssLTKOqse1t1DG1HgK9h+goG8C3sqgOyOV3Wwq+LDA@mail.gmail.com>
 <202111171728.D85A4E2571@keescook>
 <875ysp1m39.fsf@email.froward.int.ebiederm.org>
 <CAP045Aq06LV_jbXVc85bYU62h5EoVQ=rD9pDn+nGaUJ+iWe62w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP045Aq06LV_jbXVc85bYU62h5EoVQ=rD9pDn+nGaUJ+iWe62w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 08:07:36AM -0800, Kyle Huey wrote:
> On Thu, Nov 18, 2021 at 8:12 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > Kyle thank you for your explanation of what breaks.  For future kernels
> > I do need to do some work in this area and I will copy on the patches
> > going forward.  In particular I strongly suspect that changing the
> > sigaction and blocked state of the signal for these synchronous signals
> > is the wrong thing to do, especially if the process is not killed.  I
> > want to find another solution that does not break things but that also
> > does not change the program state behind the programs back so things
> > work differently under the debugger.
> 
> The heads up in the future is appreciated, thanks.

Yeah, I wonder if we could add you as a Reviewer in the MAINTAINERS file
for ptrace/signal stuff? Then anyone using scripts/get_maintainers.pl
would have a CC to you added.

Also, are there more instructions about running the rr tests? When the
execve refactoring was happening, I tried it[1], but the results were
unclear (there seemed to be a lot of warnings and it made me think I'd
done something wrong on my end).

-Kees

[1] https://github.com/rr-debugger/rr/wiki/Building-And-Installing#tests

-- 
Kees Cook
