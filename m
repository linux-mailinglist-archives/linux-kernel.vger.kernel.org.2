Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988E83335C3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 07:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhCJGT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 01:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhCJGTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 01:19:45 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE588C06174A;
        Tue,  9 Mar 2021 22:19:44 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id b5so14497463ilq.10;
        Tue, 09 Mar 2021 22:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5p/SXRe4HjTxgctJ5m48amd8gNDg6K092/5QjLT6b4c=;
        b=afTJ02CA0fyqSMV6hiFeYZ2votdnUzaUNActc9myS2kr7PuOKFpuyRsgQ2nGtNApqs
         L9Ml/Z7a0Q3KLYL7B5L7XzSDdEamBMaleMUOsUiWEj6kVzw8F8v4qV+DbL88tX/0dkKJ
         2YfjTMGrLcDWKJVhfUvmUd/YdbhcOaD5exougRrwepHaQVM/in1TDfEsNpvlm3zA/Yq9
         9SkrNVAUUQP++4zcG6YTmIh1r1r3iX3e1hjwWlME7L1fjUe0hCMQAA9RzGkm52PA4ZiS
         rin/UKxeK6XREnLXUjKiIptzYOtubAX3JHgLcZ/esMNcOi12MOz9PQ3ERZt3pkfy1lvO
         s9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5p/SXRe4HjTxgctJ5m48amd8gNDg6K092/5QjLT6b4c=;
        b=lQKKHUS6tAusa8Qi9qk+sEjn3ccBPBe4EGShJ2XUf9bMnB6pFK+VKaU6ZdIvdgbRuZ
         6tApXmytk4xr11U1qfe2bO2B1kXAoeOFeXk/RCJe4iLuiBstW10l9YUG1Iw4ExiH5d4Y
         ObFPNZb3r8G7DZMufAWM+FXY6Sy1LotUw6RnFqRT/Yqc6LFn2q5rfA6mls59G7eUT11l
         caip/y1Y9yRpMRdZAoa+0rYjtq/Ueuv2Z6I4cXQTIyahozI2nnHOwVmqEtXWGjLJ4Jeo
         HQrhVil9kJ70BF+x0xS07b5kd/ZWn+4iaWa2iYuRHBixOLuXrtWCnBpbU487GZJ8w+aB
         Zw6A==
X-Gm-Message-State: AOAM530JbqNsE924pU/N7nc80RKZn5gwOw6sUSMKCFXq/N68Hoh/Z+p3
        UezVIKH13HBhU66x6A4XYOggAxi5wQu5Qjazyiw=
X-Google-Smtp-Source: ABdhPJzekvuj7UiN+GP4cNsd4Jrk+KGKWCCq+ycOpS7ANtQi+AXKXRa3yuozVnszTI1wJnoZnnq+TdtB8Bbljlj7CH4=
X-Received: by 2002:a05:6e02:1aaa:: with SMTP id l10mr343415ilv.251.1615357184067;
 Tue, 09 Mar 2021 22:19:44 -0800 (PST)
MIME-Version: 1.0
References: <20210309125324.4456-1-yashsri421@gmail.com> <8959bf29-9ee1-6a1d-da18-f440232864f3@darmarit.de>
 <c673e76f-72db-bbee-39d6-f5428e765173@gmail.com>
In-Reply-To: <c673e76f-72db-bbee-39d6-f5428e765173@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 10 Mar 2021 07:19:41 +0100
Message-ID: <CAKXUXMwg7Vs5hm_X3ZHJj9309w5VYbnNeqXaajHBHS1oAKQydw@mail.gmail.com>
Subject: Re: [RFC] scripts: kernel-doc: avoid warnings due to initial
 commented lines in file
To:     Aditya <yashsri421@gmail.com>
Cc:     Markus Heiser <markus.heiser@darmarit.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 10:24 PM Aditya <yashsri421@gmail.com> wrote:
>
> On 9/3/21 7:00 pm, Markus Heiser wrote:
> >
> > Am 09.03.21 um 13:53 schrieb Aditya Srivastava:
> >> Starting commented lines in a file mostly contains comments describing
> >> license, copyright or general information about the file.
> >>
> >> E.g., in sound/pci/ctxfi/ctresource.c, initial comment lines describe
> >> its copyright and other related file informations.
> >
> > The opening comment mark /** is used for kernel-doc comments [1]
> >
> > [1]
> > https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#how-to-format-kernel-doc-comments
> >
>
> Hi Markus!
> That's true. But the content inside the comment does not follow
> kernel-doc format.
> For e.g., try running kernel-doc -none/man/rst on the above file in
> the example("sound/pci/ctxfi/ctresource.c").
> The starting 2-3 lines in files generally do not contain any
> struct/enum/function, etc. declaration.
>

Aditya, can you provide a diff of the warnings over the whole kernel tree?

At the moment, your patch just implements ignoring the initial
comment, which probably is good for experimentation.

Alternatively, we could simply have a dedicated warning and then
ignore it or even warn and then parse it as-if.

In the "long run", we would probably want to fix all current files in
the repository by just replacing '/**' by '/*' and have kernel-doc
warn about this suspicious pattern, when new files appear (maybe even
configurable, but that is another feature to enable or disable certain
kernel-doc checks and warnings). I would certainly assist and
contribute to such a clean-up task.

I think the first step is to look at the diff, and see how many cases
really appear in the tree... then check how many patches throughout
the whole tree are required and if they are generally accepted.


Lukas
