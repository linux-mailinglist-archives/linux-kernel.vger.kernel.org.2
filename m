Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5AA3F9F44
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 20:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhH0S4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 14:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhH0S4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 14:56:06 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E97C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 11:55:16 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id c8so3751354lfi.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 11:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ax0CJMOgduVv/32QoycAH/mRiDBK5uv/nN9bGI40mt0=;
        b=ATzC+t5cG8jHopW4/4rBc18jUIdRGHc2DyDwD+M0flGO1eSHqwkN+VqRgYYo5kH008
         sXhzBKF3s+HVqDfl18jri4XuhVxJceqAXYXhfk7q+EEqTwQ9G7dVnUm8g3KLCqETP2k4
         4PX3gAQl0ZiEM3CD9NnGCXeayGqcCSvVCj6VA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ax0CJMOgduVv/32QoycAH/mRiDBK5uv/nN9bGI40mt0=;
        b=F59114Z/GBRWFQU5hvmpU8a3tB6WyfXwI0/yK7Xw233oodS8ydHYjWGSHDmZi6yc+P
         Zvs+yrn8+qeqGVlzMuVoRC9kwX/bsJV8MJy1rKtoAGM1ML1lWDo4+Vdq4LjV3Px2hmgD
         qO2Ae0/PmZZzLo83SchQy5lCOz0PzCFU8gXZWEnFjSkqLs8geaDNqDA384J8XC/NlECb
         8lYux70VWoJNf2weiywQSIbMeJZqLZOKPQ9orTuOUR/FMmOOm/k7/YHpMbVyamwyjXlD
         3X/xxXRY1O4yBfwvxpOa76xa5I5Axj8dCycmlZk+GATIAgzpwKp6gFlChqxo+cDuTnHc
         kLIw==
X-Gm-Message-State: AOAM5332fXTMWxLaDIwYxc2vsdsoWmA04Cxu6NnMiMIPI0vRcFfNdkVb
        HyRI/hZR27iqt9G9k8F8vbkpkPHQZu/rZI3t
X-Google-Smtp-Source: ABdhPJxFeJk4iLZmNxnSnfs/aTUngqL2y3D4wXVIKJPmVk3uM8WGoRlujud3vY+5tE0DbcNbGbol9Q==
X-Received: by 2002:a05:6512:12c8:: with SMTP id p8mr4110252lfg.208.1630090514738;
        Fri, 27 Aug 2021 11:55:14 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id z5sm767114ljc.123.2021.08.27.11.55.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 11:55:14 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id f2so13154003ljn.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 11:55:13 -0700 (PDT)
X-Received: by 2002:a2e:84c7:: with SMTP id q7mr8831182ljh.61.1630090513752;
 Fri, 27 Aug 2021 11:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <YRrdvKEu2JQxLI5n@zeniv-ca.linux.org.uk> <877dgkvsog.fsf@disp2133> <YSXRL4Gt4SVLa+Hl@zeniv-ca.linux.org.uk>
In-Reply-To: <YSXRL4Gt4SVLa+Hl@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Aug 2021 11:54:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnUy1UHTt6dpgCdBgz4tu1JCVmrN8ouJ==fpDkT+kwpw@mail.gmail.com>
Message-ID: <CAHk-=whnUy1UHTt6dpgCdBgz4tu1JCVmrN8ouJ==fpDkT+kwpw@mail.gmail.com>
Subject: Re: [PATCH][RFC] fix PTRACE_KILL
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Sorry, this got missed by other stuff in my inbox ]

On Tue, Aug 24, 2021 at 10:12 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> The change I'd proposed makes PTRACE_KILL deliver SIGKILL regardless of
> the target state; yours is arguably what we should've done from the very
> beginning (what we used to have prior to 0.99pl14 and what all other
> Unices had been doing all along), but it's a visible change wrt error
> returns and I don't see any sane way to paper over that part.
>
> Linus, what would you prefer?  I've no strong preferences here...

Honestly, I have no huge preferences either, simply because this has
clearly been broken so long that people who care have worked around
the breakage already, or it just didn't matter enough.

Your patch looks fine to me, although looking at it I get the feeling
that we might as well do it inside "ptrace_check_attach()", and that
we should have just passed that function the request (instead of that
odd "ignore_state" argument).

ptrace_check_attach() already gets that tasklist_lock that the code
requires, and could easily do the PTRACE_KILL checking. So I think
that might be an additional cleanup.

But your patch is targeted and doesn't look wrong to me either.

I don't think Eric's patch works, because if I read that one right, it
would actually do that "wait_task_inactive()" which is very much
against the whole point of PTRACE_KILL.  We want to kill the target
asap, and regardless of where it is stuck.

              Linus
