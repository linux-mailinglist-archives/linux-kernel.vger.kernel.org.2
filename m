Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73031325F80
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 09:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhBZIyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 03:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhBZIy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 03:54:28 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8B2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 00:53:47 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id w11so7771246wrr.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 00:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7kNEmrMUnoRO3jTYiSsoULEzq/+mwZ/afdSXWdymP48=;
        b=tAlcyLRXVkY+yIqpFQ3R3Y5HkxH6+QALeswaRb1bDca5i33FVKfdIHrQTxPq3myZqG
         BVxiEeXozhM7ONvkyzC/j+n1doiN2U94iG7AAX6vejluri/HNv5FGT2QxRQ/intiKyEZ
         ulcS0+AnNdOT8X1oX7rP3mHIcXXwCoe3n2q4GvbGAw+yGJybvPYEqJ2tfIg6DJOMHWCD
         Chmn6raavsakWK/afMhft765MroKboZf1Fz6Nm/5z6x+EJRb2VJ5ldD3wSf0FtVSYXCN
         mwpmIesKoW42UahpeHVtfCvq6KfT3dagb5iQfECwUjPF64Y7+gLjosKnJ/ZiA91cpvru
         LhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7kNEmrMUnoRO3jTYiSsoULEzq/+mwZ/afdSXWdymP48=;
        b=JzZ4WwqJMUl4/gcnMF+99Gn+GVsJmZMwbOOUGGGRvH/uoIAuXx8arX2RnN9/APgkG5
         w7DELgzQPXXa4u8HxUabLnyzJXnLBn25Khayv6GX3TWsvq7m8PM4A2IvltDxoqExm/zA
         h0xlu7TstUDOchV1Ow7kaWfojOrGmPYcAUwWEnBETuxen6dR/zlfAQHBJvsrJ1VwwDQh
         j3KZZ7xiNNnyk2ml5QoMWe/14IoucV3DkGkuFt/KJNRF1d4pA+kVJGrT+qdzjRKf+v/6
         I4wpOdBl1mxQOy1N2Bvf/n7IFCmFkoX5pzVJ9jttDYXTqAG0nhlVgT5hS/9qfBkVMXj4
         IZYw==
X-Gm-Message-State: AOAM532j2mjeFQeFKCfM6jJ99o7mwOf4o1HNCq5r10aRIZtBLcPdW5KC
        PWDL4MDyNA7JTzlBzTmPxFeg6Q5e/u7RO/yZnHU=
X-Google-Smtp-Source: ABdhPJyPB9pHDA3cux0fkSStbgJSLMHmFjWlwBhDYI4jG2WuPBWqV7hlzmOlRQdWCRI90pIDl/VB8gR8RAXsWWfRIJQ=
X-Received: by 2002:adf:d1cb:: with SMTP id b11mr2091283wrd.118.1614329626375;
 Fri, 26 Feb 2021 00:53:46 -0800 (PST)
MIME-Version: 1.0
References: <20210222075205.19834-1-dwaipayanray1@gmail.com>
 <bcee822d1934772f47702ee257bc735c8f467088.camel@perches.com>
 <CABJPP5AARO3h2mt-piPWuOD3kY_XzNfW-s2mi=btfOayVPURHg@mail.gmail.com> <87mtvrc0gz.fsf@meer.lwn.net>
In-Reply-To: <87mtvrc0gz.fsf@meer.lwn.net>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Fri, 26 Feb 2021 14:23:46 +0530
Message-ID: <CABJPP5CjbKCCtnafg6BP6CXTwCVMtGw15jk=jFvWLjij2kp_jA@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] checkpatch: add verbose mode
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Joe Perches <joe@perches.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 2:46 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Dwaipayan Ray <dwaipayanray1@gmail.com> writes:
>
> > On Thu, Feb 25, 2021 at 11:03 PM Joe Perches <joe@perches.com> wrote:
> >> I don't have any real objection to this patch set, but as this
> >> might be added to the Documentation tree and in .rst format,
> >> perhaps Jonathan Corbet and/or Mauro Carvalho Chehab might have
> >> some opinion.
> >>
> >> Also I do not want to be a maintainer of this .rst file and
> >> likely neither Jon nor Mauro would either.  Perhaps you?
> >>
> >
> > I could take it up if everybody is okay with it!
> >
> >> Ideally, the patch order would be reversed so the .rst file
> >> is added first, then checkpatch updated to use it.
> >>
> >
> > Sure, if Jonathan or Mauro has no objections to it, I will be happy
> > to resend it so that it can be picked up properly.
>
> So I haven't been copied on this for a while.  Looking in the archives,
> I see that you have a manual table of contents at the top of the
> document; you could take that out and let Sphinx generate it (and keep
> it current!) for you.
>

Sure that sounds nice.
I will modify the series and send the v8 in so that you can pick it up
from there. That shall include the MAINTAINERS patch sent by Lukas
as well.

> Either way, though, if you want to merge this via some other path, it's
> OK by me:
>
> Acked-by: Jonathan Corbet <corbet@lwn.net>
>
Thanks for the ack!

Regards,
Dwaipayan.

> Thanks,
>
> jon
