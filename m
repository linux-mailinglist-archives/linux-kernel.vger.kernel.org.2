Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C8941797F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 19:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343836AbhIXRPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 13:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343767AbhIXRO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 13:14:59 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13151C061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 10:13:22 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id m3so43310950lfu.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 10:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9HO1ShFyKTyu7+kkITpSnYVObom9GeBnJLEEdXJMAPc=;
        b=BzaXwFs2mAqfL90plsQdr0Opk5Ife/Nn0Nz/x570+v5yPCDrVDsVn3yIXX2m6fGFJ5
         3UHuPOwWMBwkQrP8LZdovcVHqGqDCRFJcpAmjap4a9wSD2kRLMnMH/cebAVCCusbNRSC
         2dyTKY0tJBui7ClS/YdPqErVxUfg5uw0jroWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9HO1ShFyKTyu7+kkITpSnYVObom9GeBnJLEEdXJMAPc=;
        b=bUDPfb6QBmi9M0uEICDyac7PkdsTPYsen2hBPU/l7TdVhR1/IcR52O4029mSUNKqcb
         PzebsegXkkpLqoMjDzpeM7bx++LMRs96Oga0ZeOCHLmkKIp8kyl6mm+80gZyU55UkLAJ
         9dyLynY7upXckwec65u/tdS/njgsI1m62b83E2JaJTVkiYMWsbV6P65ZMHnyHZM8BiRI
         2stpXGyku39Ect0L4CrHT2qa2Tn9zUbK5qhQoCfOj0tA5slQj5ifH6+luPD627XliKvE
         QZB1Q029LsLnIBS+U4rYPJ4Wu1hSa/vCeo2e5OjU3O9ULU6SqZbZpEQuDehHpyxV/ySK
         it0g==
X-Gm-Message-State: AOAM530DpBHJn4kn9hfxZzNtn6bQbI6udNUC8xr06KP0o8S7vjAG02Vj
        qgyiqQIeFy97lJtmZ83pjDMfMctRS3aET39i
X-Google-Smtp-Source: ABdhPJxIJHqCv/3R8VSTQLPPSHAoJ/6GcZyRd1UvxJRaHa8cCM5v7OAgyi+ZQ1DNY19ipVR2I98r7Q==
X-Received: by 2002:ac2:547a:: with SMTP id e26mr11020578lfn.582.1632503599966;
        Fri, 24 Sep 2021 10:13:19 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id b21sm804465lff.158.2021.09.24.10.13.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 10:13:19 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id y28so42618436lfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 10:13:19 -0700 (PDT)
X-Received: by 2002:a19:ef01:: with SMTP id n1mr10818829lfh.150.1632503598816;
 Fri, 24 Sep 2021 10:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <89481e37-6723-6dd5-3549-85d1aa9fccbe@paragon-software.com>
In-Reply-To: <89481e37-6723-6dd5-3549-85d1aa9fccbe@paragon-software.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Sep 2021 10:13:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgaM64246C-Jz3a4eZtvez6-O83YGHT7j2CP3QCZifD=A@mail.gmail.com>
Message-ID: <CAHk-=wgaM64246C-Jz3a4eZtvez6-O83YGHT7j2CP3QCZifD=A@mail.gmail.com>
Subject: Re: Question about ntfs3 git pull request
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 9:47 AM Konstantin Komarov
<almaz.alexandrovich@paragon-software.com> wrote:
>
>
> Right now my github repo still based on 5.14-rc7.
> Do I need to update it with git merge up to 5.15-rcX?

Oh, keep your previous base, and just send me a pull request with your
changes and no merge.

In fact, the best workflow is generally to avoid merging from me as
much as humanly possible, but then if you notice that we're all in
sync, and you have nothing pending in your tree, you can basically
fast-forward and start any new development at some new point.

But even then, it's a good idea to make that new point be something
well-defined - like a full release, or at least an rc release (usually
avoiding rc1 is good, since rc1 can be a bit experimental).

But I have no problems pulling from a git tree that is based on older
kernels. I much prefer than to having  people rebase their work overly
aggressively, or having people do lots of merges of my tree.

At some point, if you end up being multiple releases behind, it ends
up being inconvenient for both of us just because some infrastructure
has changed, so _occasionally_ syncing up is just a good idea.

In my experience, people tend to do it too much, rather than too
little. Don't worry too much about it.

               Linus
