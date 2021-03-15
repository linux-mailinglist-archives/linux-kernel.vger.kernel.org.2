Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC24833C400
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 18:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbhCORUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 13:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbhCORUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:20:11 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6B4C06174A;
        Mon, 15 Mar 2021 10:20:11 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id w11so8447286iol.13;
        Mon, 15 Mar 2021 10:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=xFtEHSj/3JJ9WJjd/AY+kzYWQRP/x6OzCgX6GLQN9pE=;
        b=varF+Xc7I1jiWPNdI/a1mt5wK9UASoUiMGBKOBM0YkSc0ITiVZeIs3QtUv8w76YaMJ
         oGz4U2eSn8JgcGk/4Z5vBHAedDCFxZAeUYmZ1GpHwqHDBjSpw6CWVmpunv4VUZpc2+dS
         h9ESPv6Lqr/smgJj8ZapKjQcHJKfmdTGCeMFHx/6tYueqUAaVhaLwawnYyIod9LMMBy/
         flWFsWomHrWBELEc+uLrJJulEHjanJ35JpLm01ctOE6s+qDkJn1yDD1djiPQiXzGuN75
         G0ElaQiuVXGlz6sVQVlobylkx994xLc+/+UPEjF6dRiFvNcliYW9gA64l4dGlFDlX/ny
         +bSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=xFtEHSj/3JJ9WJjd/AY+kzYWQRP/x6OzCgX6GLQN9pE=;
        b=dxWKaP7jKmOq3JAEZ5H5jvEbEyD34lCZeI+mH/8WmyIVxLH3DMkD2JFaGPJLTf3dda
         0W/6dhyXk0NVCvPucjc0y/MWj2Z3BiEONVGDNidU9EN9zIyB8UqvGB0s5UY73+1XJDEu
         5spenPz0WenvNWCBtSWc6+lZbGN54mqKJ4v45pWx9ffoIpiWIist0Fy5/6kkaUOdsLnN
         nXObZ+hcl/vaHpUVg+hCHGtaNO+Jnr/azAnMCwOMbOW8LtB+l2TjmOfmbtnxEjR8kkYA
         /Wx0lLFdaQsKPS8OtZXL0iJ2gefaPKQLhaA4a59rgIb/pUVQqlsrAygBh4Ti+gF/r5LD
         dTGw==
X-Gm-Message-State: AOAM531y+GgMzlfgTapKtS8wTPUeF3ZYaZTRwr8m9qR2VJXT/Qs/zm3j
        nD9sAQSNwEv9bYoaF0C3EJG7Bjv/iWYBPcVII0w=
X-Google-Smtp-Source: ABdhPJzXzL86uydQrDLaeOiipIrpIXWQrnHVjwnXO0U3T5Yyp0Qe8rxyoS428+RBkplx14QX57LRwfcIqxWIZMDOvzE=
X-Received: by 2002:a02:7822:: with SMTP id p34mr10492460jac.65.1615828810877;
 Mon, 15 Mar 2021 10:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUWSCS6vAQOXoG6nsW+Dbnogivzf+rmegCTMjz5hjE5cKQ@mail.gmail.com>
 <20210313084923.GA16144@zn.tnic> <CA+icZUVEkA6+5d3NGy7_G8eiaPvJkO_JCAX=XQwT1qpiGkLMWw@mail.gmail.com>
 <20210313121541.GC16144@zn.tnic> <CA+icZUXrJHHDNOC+DAcr9iw4MXn5cBDj-JrDkxeumk978Gtdcg@mail.gmail.com>
 <20210313124919.GD16144@zn.tnic> <CA+icZUWXuknBMdxTQXjJH2JiOgZbWcbk1U=dk6Zp2FgygU5Nyg@mail.gmail.com>
 <20210313132927.GF16144@zn.tnic> <CA+icZUWTSo2vkQO_tRggDFvvF_Q6AdzhvhQvmAsNxKnpGXHi0Q@mail.gmail.com>
 <CA+icZUXLyFqq0y_GnKca8MS4wO2kcj4K-D1kBHLa8u_pnLZ7eQ@mail.gmail.com> <20210315171516.GG20497@zn.tnic>
In-Reply-To: <20210315171516.GG20497@zn.tnic>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 15 Mar 2021 18:19:34 +0100
Message-ID: <CA+icZUVOf4T65H2t_q-h_eAN24WOEN-cc8eNubT3GojJrGJ0vA@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86: Remove ideal_nops[]
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        rostedt@goodmis.org, hpa@zytor.com, torvalds@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        jpoimboe@redhat.com, alexei.starovoitov@gmail.com,
        mhiramat@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 6:15 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Mar 15, 2021 at 06:04:41PM +0100, Sedat Dilek wrote:
> > Here some fresh numbers:
>
> Lemme paste my previous reply which still holds true here:
>
> "There's a reason I have -s for silent in the build - printing output
> during the build creates a *lot* of variance. And you have excessive
> printing with V=1 and KBUILD_VERBOSE=1.
>

I have this for diagnostic reasons.
Yes, I can drop V=1 and KBUILD_VERBOSE=1.
This is a good idea for a fast build.

> Also, you need to repeat those workloads a couple of times - one is not
> enough. That's why I have --repeat 5 in there.
>
> Also, you need --pre=/root/bin/pre-build-kernel.sh where that script is:
>
> ---
> #!/bin/bash
> echo $0
>
> make -s clean
> echo 3 > /proc/sys/vm/drop_caches
> ---
>
> so that you can avoid pagecache influence."
>

With my next build I try to apply this.

- Sedat -
