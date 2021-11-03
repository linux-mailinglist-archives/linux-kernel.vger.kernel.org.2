Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949B2444908
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 20:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhKCThm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 15:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhKCThk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 15:37:40 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DE3C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 12:35:03 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id s24so5613398lji.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 12:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n9W4p+e3FH13k+KxnPIh2RI8UTA5IO2e2jpCzQxdx0A=;
        b=eiyfzbYMFqirulY9rvWU7fsfoRUFXGSyEstBw14iMFoIy7KSRFRIta/HFInm1amwID
         cgmAFIXZSS+HJMKrAPq9Ck8YWIREjD435tabu6Yy4rUbcEWyTlNPNS4DYqQIyu1587KY
         xg8i8IBgEqe4OUakIFzPsMUJb8wLGD6BO1sS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n9W4p+e3FH13k+KxnPIh2RI8UTA5IO2e2jpCzQxdx0A=;
        b=6Bw4RAa2S0ZBMPMNqU5kqe9aIYjCF4EDfMwIutep82/CnWTc05ykILqP+PRDnuS4qR
         kMAweBHLKfVAwWaR0Y21khdQ+mvZPWqs5eKee01BbtoE//jMjwRE9kRjvg1la8JXxU/t
         sUyzMaLh6lRmyseVN//SZKTl2Jlov78+TurYlh89Exl4ZOOSsq/HUoM7XjPFYSrtwoZJ
         iZJXKaxL3SDUyovqTAxjvvRWBRVrSJbBgbrcqLdBh8usErI1tu9BtZi241lgGpxFoZmi
         n8ZVfwXyN9O9ylE46WBxnaIa7rRsB+EoPJt7JKfnxvZRTKxPsrVxGW7v0Nos1jIF3Gp4
         fI4Q==
X-Gm-Message-State: AOAM53384LjEpLcM5CgKKBStVPtS6LUs8BUVLEzNPPYjIOF8XvD/CsJg
        yIi0yBlqBFveWQgGgbTDhP2ZdWcWMny+B9bz
X-Google-Smtp-Source: ABdhPJxpIEvQWxkILCkuwd2UFfb8xnF4cpv+nMuUd1bagKUKI7+Qf4r7pWhcU5mg8R5psiZr/c1TRg==
X-Received: by 2002:a2e:a7d0:: with SMTP id x16mr23958531ljp.119.1635968101836;
        Wed, 03 Nov 2021 12:35:01 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id f20sm221091lfs.122.2021.11.03.12.35.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 12:35:01 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id bq11so7288090lfb.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 12:35:00 -0700 (PDT)
X-Received: by 2002:ac2:544a:: with SMTP id d10mr28557820lfn.141.1635968100697;
 Wed, 03 Nov 2021 12:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <878ry512iv.fsf@disp2133>
In-Reply-To: <878ry512iv.fsf@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Nov 2021 12:34:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wivLcb3ELGSf=fM0u=PxP5m1=jRrVXDOr0+QJZRZggaHg@mail.gmail.com>
Message-ID: <CAHk-=wivLcb3ELGSf=fM0u=PxP5m1=jRrVXDOr0+QJZRZggaHg@mail.gmail.com>
Subject: Re: [GIT PULL] per signal_struct coredumps
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 12:07 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Please pull the per_signal_struct_coredumps-for-v5.16 branch

I've pulled it, but I'm not convinced about that odd extra merge
commit that contains the commentary.

That's what signed tags are for, and they have that explanation that
then makes it into the merge - plus they have the crypto signature to
show it all comes from you.

So that would have been the much better model than a fake extra merge.

But at least that extra merge did have explanations, so at least it
doesn't trigger me on _that_ level.

               Linus
