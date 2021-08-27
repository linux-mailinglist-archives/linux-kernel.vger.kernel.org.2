Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93723F9677
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 10:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244699AbhH0Iv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 04:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244510AbhH0Ivy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 04:51:54 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE2DC061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 01:51:06 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id e7so5453850pgk.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 01:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bMaGJWE8JkQX/jS5e7a5O9JgNZI63aOrwjsOxzEo8ow=;
        b=kfRgosVpAgkbFtmxvx5mIrTWyROl9DKQnEUrAdczCwLt23l09iwTGspZc8GAR//xV/
         pFEWCWM9imjmBwNC1IpkrF2V+TVpvc8tc/zgbCJqUNi81Ik1FXyPiyMdj+xhDqOCpOxR
         f02BgS1HudAFJEwV5o6HsWhs/8fqdwXOJIU3lHLAnU2kQhWoYEv7FWhbUVyJGhT9U3QQ
         OIMrc1oPuOuTxQ5rndITyW1uKv/HUQdYntpZu6v34IxpAl939lHpjAd2DKow2y+8EhHD
         awvLIf/RiWMogqUwWxAy2RhJf1DBgfp7r9wRcoDuMoTizSAkMsEFCPrer2smbOF4Gz12
         bVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bMaGJWE8JkQX/jS5e7a5O9JgNZI63aOrwjsOxzEo8ow=;
        b=gAPv97k3PoZ4oxcn2geZ/+ZRXK/KD72CEU+4D6Nj1nloI6sMFNSmYhaBam+eEmlCx5
         4ZgPnOOz+f0q/J7u4n1dUq3+k1i6iNEbvGEeW1DfCj/RHG+DeSR/lCj6cTnCOgPM5ix2
         GGToUAW9bTACTNSinvqjq8bJh0wmHGuXgqwhfx6kKAunHV43WrfGYGpsVOW4HiPHLQjA
         pAzEWK32QK/A3C+bpG8Bps8i0af/6kCN8NpEEm74P+xkccdEhEmvWb0S+MrYdzxfkovY
         qXd/XAoxt5ShIszQv+ldyUkLP/jcIFvS+UnXXxY2J2d/KbZx6tm6tzj8etYmD4NKMcsc
         3Otg==
X-Gm-Message-State: AOAM532+qWYF6+lnDCCPZIMM9gOKSjg8HN2xrIkvuPlWB2Ym+XnsMS+G
        VNIsvQYdshuFrVw3eOgPF8G4bZ6dIMU/YHOI98k=
X-Google-Smtp-Source: ABdhPJw5NKcMK3oZBjTPdjOkUv3xTFGZT484vMm/gL/jELTGtORYEcBU+V+B0jknMkrbUqwklGo9SHsc0R0Ne5oLltw=
X-Received: by 2002:aa7:93ae:0:b0:3e1:46ca:20d3 with SMTP id
 x14-20020aa793ae000000b003e146ca20d3mr7894454pff.24.1630054265619; Fri, 27
 Aug 2021 01:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAPGkw+x+B1731SL=afoSKiWwH-n-FA5YJ+WOwYdv8iyFhWk1zA@mail.gmail.com>
 <3634721.RBzQ2xsved@localhost.localdomain> <1742120.GgyQvu0Ciu@localhost.localdomain>
In-Reply-To: <1742120.GgyQvu0Ciu@localhost.localdomain>
From:   Krish Jain <krishjain02939@gmail.com>
Date:   Fri, 27 Aug 2021 10:50:52 +0200
Message-ID: <CAPGkw+yJ=V0OwFE+uqCeWWS8JbJD=YBE3+Uk-OKpmHRnvSTh+A@mail.gmail.com>
Subject: Re: [PATCH] Declare the file_operations struct as const
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, yes, this is my first time programming at this low level. And yes,
I read both docs now. Furthermore the issue is that my current
hardware can't handle building the kernel, it barely managed to
survive the first build after 2 hours so I don't know how I can. If I
change it to static const would it fix the issue and build
successfully?  If not what would be the error message, then I can
debug. Thanks

On Fri, Aug 27, 2021 at 9:48 AM Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> On Friday, August 27, 2021 8:49:30 AM CEST Fabio M. De Francesco wrote:
> > On Friday, August 27, 2021 3:59:28 AM CEST Krish Jain wrote:
> > >  From: Krish Jain <krishjain02939@gmail.com>
> > >
> > > Declare the file_operations struct as const as done elsewhere in the
> > > kernel, as there are no modifications to its fields.
> > >
> > > Signed-off-by: Krish Jain <krishjain02939@gmail.com>
> > > ---
> > > []
> > Are you sure that it works? I wouldn't be.
> > You didn't build this file. Please build your changes before submitting patches.
> >
> > Furthermore, please always rebase to the current version of the staging tree.
> >
> > Finally, please use the class modifier "static" as the first keyword of a declaration/definition
> > as it is done everywhere in the kernel (see "grep -rn "static const" drivers/staging/" and
> > then switch to "const static" and read the output).
>
> Please don't misunderstand me: as far as I can see this is your first patch and
> (I'm pretty sure I can speak for everyone else about this) you are very welcome
> to staging and to kernel hacking :)
>
> However, before posting further works, you'd better read at least the following
> documents:
>
> https://www.kernel.org/doc/html/latest/process/4.Coding.html
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>
> And please don't forget to always CC linux-kernel@vger.kernel.org.
>
> Have a nice time with kernel hacking.
>
> Thanks,
>
> Fabio
>
>
