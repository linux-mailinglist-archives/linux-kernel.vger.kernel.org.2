Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69EB3A6A54
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbhFNPar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbhFNP3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:29:30 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA74C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:27:15 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id i13so47067722edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3gxmspcFXVYNdg43UgbRcnO/nztmp2eLs2CqpNuQDGU=;
        b=i4fb1dHHUacw0281OjEv+VIUAcW95gLdmwOF7w0UUK0UX74r26tUalCAiUUpMFYl62
         IU6j1zbLGmSS6pJoDpwlR72yTw1HrVqqOGV8IzCB5+O+7z+dwCYQGAXtdxMB6Mwyto/b
         hjdz4rwem+kfP/1mzGJoySiK2vk5Va+uV2IdnMe80pQX4IqSFxgHpZRF9/L9j3zEVzHW
         La9ebLgD6diM3keeqh6Ot5z4I72XMuWGk41DX5dbuASn8rwJodIs37+FPx8TeiokcxVk
         EFeJxesgoHRcHSrdqugZa0gaJkK1B1uJyX2PunBAGMt91gEZZVZGjA+fYg3fN/m8yCzU
         0miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3gxmspcFXVYNdg43UgbRcnO/nztmp2eLs2CqpNuQDGU=;
        b=HYpnZ/Hm/WQ+bUywZAnu2sUtNwzI0KN2PmXpJ0/8difTO+qRtgcjakxupms50qbQNA
         PLNySoW1ePGBYtstDWuLgRDHzt4vlPkYcOJCAU3ackJjgCAprXIqIOApO4lWlDSFuizW
         34AsJ4AjUOiEPUzJ10Xk6M9LikQg7FVAS9OWszb5nAw4StxmSZcvO19tWzWbwsg4AtoV
         Jb9nwB9QNTrpNBywQRDwBys8OpyRl3Hsg+1QwCyIerA0pVqaQ98ROhkmKDQ5Wri0+eA3
         uU37G2xMYLlzDutkc96FOQ/vXF3Ht3YZEhuCMfKMWOSAGJucdwJSdb0it4siXoG7YTb0
         ySow==
X-Gm-Message-State: AOAM532wrIwuSbx6wiQXouZW13yylsBOezgPV2WwwxFRVov8J38NhJTS
        8bXbwmnvujYlH/eD95ixNb4AcgEv8q6Mt9JYD/w=
X-Google-Smtp-Source: ABdhPJwVxdtsF6hl0TLkjQz3LU/GAabMcnEYsuAraHw7Dp6Kn1av63GeXeed+oOA0hkexGpOP2/hjvp5RajlDDpCzm4=
X-Received: by 2002:a50:cc0b:: with SMTP id m11mr17546019edi.297.1623684434279;
 Mon, 14 Jun 2021 08:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210613122858.1433252-1-fbihjmeric@gmail.com>
 <YMX7SRSPgvMA/Pw1@kroah.com> <CAKgboZ8QUQpiinL0xCxUmcp6nEVU20jXkDXbrK_QisUMiLEo1A@mail.gmail.com>
 <YMdkN9cft6KHcFn3@zeniv-ca.linux.org.uk>
In-Reply-To: <YMdkN9cft6KHcFn3@zeniv-ca.linux.org.uk>
From:   Jhih Ming Huang <fbihjmeric@gmail.com>
Date:   Mon, 14 Jun 2021 23:27:03 +0800
Message-ID: <CAKgboZ9P2afm7-eOE3COrKVDkFZ_g288KfJAyQiwzC6fN75VmA@mail.gmail.com>
Subject: Re: [PATCH v2] rtw_security: fix cast to restricted __le32
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, maqianga@uniontech.com,
        marcocesati@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 10:14 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Jun 14, 2021 at 12:40:27AM +0800, Jhih Ming Huang wrote:
> > On Sun, Jun 13, 2021 at 8:34 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Sun, Jun 13, 2021 at 08:28:58PM +0800, Jhih-Ming Huang wrote:
> > > > This patch fixes the sparse warning of fix cast to restricted __le32.
> > > >
> > > > Last month, there was a change for replacing private CRC-32 routines with
> > > > in-kernel ones.
> > > > In that patch, we replaced getcrc32 with crc32_le in calling le32_to_cpu.
> > > > le32_to_cpu accepts __le32 type as arg, but crc32_le returns unsigned int.
> > > > That how it introduced the sparse warning.
> > >
> > > As crc32_le returns a u32 which is in native-endian format, how can you
> > > cast it to le32?  Why do you cast it to le32?  Isn't that going to be
> > > incorrect for big endian systems?
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Thanks for the fast reply.
> > Yes, you are right. I did not notice that le32_to_cpu already handles
> > both of the cases.
> >
> > So it seems the warning from sparse is false positives, am I right?
>
> In a sense that on all architectures we would be ever likely to support
> le32_to_cpu and cpu_to_le32 do the same bit-shuffling - yes.  In a sense
> of having those used correctly it's not a false positive, though - it's
> much easier to follow "this variable always hold native-endian, this -
> little-endian" and watch for conversions done correctly than to count
> the byteswaps and try to prove that it's either even for all execution
> histories or odd for all execution histories.
>
> IOW, there's a good reason for keeping separate cpu_to_le32 and le32_to_cpu
> and not mixing them with each other - it's easier to prove correctness that
> way *and* easier to look for endianness bugs.

Thanks for your explanation.

To clarify, even though it might be false positives in some senses,
following "hold the variable native-endian and check the conversion
done correctly"
is much easier than the other way. And it's exactly the current implementation.

So it's better to keep the current implementation and ignore the
warnings, right?

Thanks. Regards

--jmhuang
