Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E182C4217E0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 21:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbhJDTrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 15:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbhJDTrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 15:47:13 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A91C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 12:45:23 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id p4so17670996qki.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 12:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oeZjcZzXMoL0V9g3Q64+vql9WcnWxsXlK52mwWaJhAI=;
        b=JFIQe7l1WOh/9f77lKowAsRMazPl14m5gObWqMGWb/fNbbHukHVuzzTILW3tjlSr73
         loxU7b2k1/m5j++1LEtQVPSOn0CRkSJNQBPthrahUAWvdZZFeWZpII8hOJzW3Tvg18Jn
         Dv3TRbKedV1Sp+ofGyCKtvoGfvMHffgWYyyqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oeZjcZzXMoL0V9g3Q64+vql9WcnWxsXlK52mwWaJhAI=;
        b=wviWRxoBAH60ko0uDFlOR/jmPFW3Ni4yyRwcgffE9j8PjCY+2XwJVuiNMAgyELuyHG
         o1xCbklh6l/c/bfyMzGzpx7RPmGjUAIOKyzw00/8eD35lHbt20KAvgHaGg+jsvusUuNK
         O7v6RqXrQAJzBPnLs/wu4Oges3/r9M0vl386mE/rxjY/LwXkBJNPNbvDUP66CudGBLz+
         4ZVTmMXwEpxvmxFx+Gso/qqRBi/zv/3Iq5WaXLfyAoQIBzfYsSv9i2mmTWbNm891kAdy
         cL6rD0dWWMp1wkWrvdoqXw8ObAhK4WtK1MGTZBbwH/DewnU8Uy2vVfCoQn1aL7n+EokJ
         re/A==
X-Gm-Message-State: AOAM532z9CMbR1YF0iO0sckp20phg32yEkvfWn7ahQZoWVq4RYIpo8Hk
        zg4LyTMLkHYHjdkZqLuYsk2cdg==
X-Google-Smtp-Source: ABdhPJw3BqsoDioflv3VHzrSlvWfK0qgMt0I2PmlXczJ5kbk0fWuIukBBlfG8BlvvvKTMH1YtQ4VRw==
X-Received: by 2002:a37:9cd4:: with SMTP id f203mr11842285qke.73.1633376723030;
        Mon, 04 Oct 2021 12:45:23 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id o5sm6996381qkl.50.2021.10.04.12.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 12:45:22 -0700 (PDT)
Date:   Mon, 4 Oct 2021 15:45:21 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] kallsyms: strip LTO suffixes from static functions
Message-ID: <20211004194521.e2syd25qzrgn5mzg@meerkat.local>
References: <202110020501.RKX4zca7-lkp@intel.com>
 <20211004162936.21961-1-ndesaulniers@google.com>
 <163337043811.3396838.458236649388694225.b4-ty@chromium.org>
 <CAKwvOdm5bBUE0df8jbXq+bSCf9U0AM3Wm4NsZeHu=Nuhi0yd-A@mail.gmail.com>
 <20211004183806.5weyuk554ppe5olb@meerkat.local>
 <CAKwvOdkzviryHByOZj1K6r6HVKcC+4Tc43jXn4Eqk9EXGVpucg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdkzviryHByOZj1K6r6HVKcC+4Tc43jXn4Eqk9EXGVpucg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 11:41:29AM -0700, Nick Desaulniers wrote:
> On Mon, Oct 4, 2021 at 11:38 AM Konstantin Ryabitsev
> <konstantin@linuxfoundation.org> wrote:
> >
> > On Mon, Oct 04, 2021 at 11:32:43AM -0700, Nick Desaulniers wrote:
> > > $ git format-patch HEAD~
> > > 0001-ARM-mm-proc-macros-ensure-_tlb_fns-are-4B-aligned.patch
> > > $ git send-email --suppress-cc=body --to keescook@chromium.org
> > > 0001-ARM-mm-proc-macros-ensure-_tlb_fns-are-4B-aligned.patch
> > > patatt: E: -: Not a valid RFC2822 message
> > > fatal: 0001-ARM-mm-proc-macros-ensure-_tlb_fns-are-4B-aligned.patch:
> > > rejected by sendemail-validate hook
> > > fatal: command 'git hook run sendemail-validate -- <patch>' died with
> > > exit code 1
> > > warning: no patches were sent
> >
> > Woah. What git version is this?
> 
> $ git --version
> git version 2.33.0.800.g4c38ced690-goog
> 
> Looks like some corporate version...anything else I can to do to help
> debug? (Moving explicit CC's to BCC).

So, this line:

> fatal: command 'git hook run sendemail-validate -- <patch>' died with exit code 1

Suggests to me that your git version is patched to carry the
new-and-not-yet-accepted "git hook" changes. It seems that it both opens a
stdin and passes the file as the parameter. When we find a stdin, we always
grab that instead of the passed parameter, but that's only a problem with this
change to git.

I'll add a fix that will always disregard stdin when we're running with
--hook.

-K
