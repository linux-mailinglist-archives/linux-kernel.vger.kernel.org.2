Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C390743CF91
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 19:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243226AbhJ0RVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 13:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243204AbhJ0RVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:21:07 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709DBC061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 10:18:41 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so2579200pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 10:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W7BJytzyK4CwYDI6+SDcsLZ1wWZAGv23zroJhXSjOSU=;
        b=mp6cJETM6WIYLZ9Jr6hTeL2KCe3b117SwaBq60POOQzZ3d/RPKwvxaWrx/3czWe7yh
         hc/dIM8O1y+Hqpfi5OL7v1bTuEAayySwdsudH6i34CEiG/e3t1e22CQeuQ1BnbfLf5n5
         DoGLUzLj0c9r4Q0JdhlEBo1MtFJMwFvxfXV8emLSzb72zBfAAVkJtIsuvPN9LzoC+jB1
         nRsoAH1YqVTTquovmaI9Uu0zb6Foh/9I67dW8u59Jg2orlwTJDkgb1N1C/1TJIMSCan+
         7ZllFGnrNVGecp9S6Pz1VRls3ZCoKtKhYIyswKQFq9qTlxPNNJqv+SZP8GvgBbrKlHpd
         XwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W7BJytzyK4CwYDI6+SDcsLZ1wWZAGv23zroJhXSjOSU=;
        b=YZlh9zNXEI9Iwlvxt0Cdq9B/swH7fEOpkltE4C9gni1bTH3cZvxEpszC/UKC2QdK8g
         2y/NCrOHyH013C8jHxzNaAc3nC61QBSFr55ScLHUOHL23oTv0xuMjNVQOOrQl2iXYxK3
         3PMlbvngCb77CjhjcAonq9wDXsgoLXCTPnGgSqjhsqHw8fqQJ9WvjYK3Lgbn8S1HQax1
         UqDyUxvSkcbV0KvM84gXzBNYpgWuTjtugdVc+cHqn6BChmItGmrI+m5uM7yrS7WYwlfb
         h5IiynLCoj32WnighI2WTLUyqdESYsbQfdjM14GGdI6S44GITnJs6oFHMbjaKJE9BZO8
         84dA==
X-Gm-Message-State: AOAM533F5JjySlxwxU9hiVx6bZWlG0Vyr8gkNtUhEDqmARoNVp3vRCGh
        +SSoy8XarV2W6SRNYzzyC0rH4aHgWl8fH26Dp8M=
X-Google-Smtp-Source: ABdhPJzWMGpiW/luaoaSu0FNjIrAv/GzjSYGVkcCrcrdzVTxHTVxchhf4IpwYa5q+GWqqOauKtbdtRwlF3ohtQMNdlg=
X-Received: by 2002:a17:90b:1c8f:: with SMTP id oo15mr7289753pjb.87.1635355121014;
 Wed, 27 Oct 2021 10:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
 <20211015204713.2855996-2-goldstein.w.n@gmail.com> <YXky/qrRSvvhI3JN@zn.tnic>
 <CAFUsyfJGxpLz14pZ-_nC-3651WaeZeb6p1yteCP2J4=aTKRsrA@mail.gmail.com> <YXmFLTEzxdc6soxS@zn.tnic>
In-Reply-To: <YXmFLTEzxdc6soxS@zn.tnic>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Wed, 27 Oct 2021 12:18:30 -0500
Message-ID: <CAFUsyf+Xu20PBGBnmdVB3w8L7rD-9xG9Mz18mTFZ5G35Lbp6Jw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/xstate: Make AVX512 status tracking more accurate
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, X86 ML <x86@kernel.org>,
        hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 11:58 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Oct 27, 2021 at 11:28:07AM -0500, Noah Goldstein wrote:
> > Got it. Thanks.
>
> Did ya?
>
> :-)

Oof :/


Fixed.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
