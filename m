Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280E43828D6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbhEQJyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhEQJyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:54:19 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7BFC061573;
        Mon, 17 May 2021 02:53:02 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id v5so6396024ljg.12;
        Mon, 17 May 2021 02:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ngU07/Nz5uBaGKSNQDKxKqJRj7ed23twEteeceYcPE0=;
        b=kzsE5o55kTlANbGYoIAaMo6gz3+pJ8pWPgcfyFQ5twZZEpcSLTTAdGQ3xXjZ6soUKu
         W4q89rLrsjkUb8rgpSvYZbIf/PrvJtRcn4mUJGVDkKKBEApvmDh9D4/az1H1Trh8ch5q
         TGG7ypBl+Vr8MT0NdwRQnpjmchGWB2IrgfoP//7fgogV5dkUTDrdJtFbeUO6FbFkh2oH
         06sk0X4MNBgILAs2RGblxKrde3R1TJgV6VRufgQ27lrf9DLP5qjKxvZNvjuvdqg0YaqM
         PRgG2oKxdum9s4b4gGlcpE8jxOTHPAwN9X4PZ+YzxNVfuBhsrcGjS6mCUfO9epuLYmca
         PG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ngU07/Nz5uBaGKSNQDKxKqJRj7ed23twEteeceYcPE0=;
        b=SWkOimIipT67yiWM41C2tRH+75Uxx6pQOtopLkA9WyMBrM2fcoFF3VhkYlRteLDTHH
         mcRz83GHcqVS2SYo6X1BG99squKlZimoov7kpFefmxKQSW7DiTIu8F9M0leAJagSYmZA
         KzrB/PGF0NEYKcnr7seGiX4wd9ROkXV05OdByjHvaY04aSZ5AlCkUy5zxgX/OIURkJWp
         STxj5D0OK2x+C08MQfGxrp/BOxng6M1qIi3MTSKkWahzdfvRmZPmleFEf5c4D9DdDYE3
         q1vz7Ds/y8F0JCFj+JFHNBwC8oLe6WlKq1fQLUFwDLNViwDkTPFTJbhHi/+BgRpBtXp1
         YQcA==
X-Gm-Message-State: AOAM533PpA6xEQ6n+ulhtLjALIfUuPXzuHM+zfkneASd9TRzx0cbnTpb
        YXnrfRXvwXlSJkkQPRAwl50xFK8vELxTKcYz92PrB4jJG0J3IyQXSr0=
X-Google-Smtp-Source: ABdhPJxacRlBrpdQvL2FKypzz7N/PoKwJjW0iAWZZji59hz8CQ78tlF69OrjNztXNreHnvt+7Idh/NpHti6xPDktDdg=
X-Received: by 2002:a2e:9211:: with SMTP id k17mr49792574ljg.284.1621245181177;
 Mon, 17 May 2021 02:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <1621243800-27702-1-git-send-email-yangtiezhu@loongson.cn> <CAKXUXMyVSf_HsjKhD2FeZzyz6pbA7JN=KkWrvdRswkba60OXww@mail.gmail.com>
In-Reply-To: <CAKXUXMyVSf_HsjKhD2FeZzyz6pbA7JN=KkWrvdRswkba60OXww@mail.gmail.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Mon, 17 May 2021 15:22:50 +0530
Message-ID: <CABJPP5C9URoCVsGwQxref9Z9V0SvgpNfCY5Aib_HGG6M8LmdRQ@mail.gmail.com>
Subject: Re: [PATCH v3] Documentation: checkpatch: add description if no
 filenames are given
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 3:13 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> On Mon, May 17, 2021 at 11:30 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >
> > After commit 45107ff6d526 ("checkpatch: if no filenames then read stdin"),
> > if no filenames are given, it will read patch from stdin rather than exit
> > directly. This means the script waits for input indefinitely, which
> > confuses new checkpatch users at first.
> >
> > Add some basic documentation on this behaviour of checkpatch to lower
> > the confusion.
> >
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> >
> > v3: Update the commit message, thank you Lukas.
> >
>
> Thanks.
>
> Acked-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>
> Dwaipayan, can you acknowledge this as well?
>

Yes it looks good to me too. Thanks for the patch Tiezhu.

Acked-by: Dwaipayan Ray <dwaipayanray1@gmail.com>

> Jonathan, I assume you will pick this up in your doc tree once
> Dwaipayan ack is there, right?
>
> Lukas
>
> >  Documentation/dev-tools/checkpatch.rst | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> > index 51fed1b..3eb9ead 100644
> > --- a/Documentation/dev-tools/checkpatch.rst
> > +++ b/Documentation/dev-tools/checkpatch.rst
> > @@ -22,6 +22,8 @@ Usage::
> >
> >    ./scripts/checkpatch.pl [OPTION]... [FILE]...
> >
> > +When FILE is -, or absent, checkpatch reads from standard input.
> > +
> >  Available options:
> >
> >   - -q,  --quiet
> > --
> > 2.1.0
> >
