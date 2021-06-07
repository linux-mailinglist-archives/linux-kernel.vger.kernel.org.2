Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FF339D2C3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 03:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhFGB6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 21:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhFGB6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 21:58:33 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10778C061766;
        Sun,  6 Jun 2021 18:56:28 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id o8so19961580ljp.0;
        Sun, 06 Jun 2021 18:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xTTxITwBYMnhyrfbOb8zkex9qFX68doqwSOyVmroo3w=;
        b=HvpLmIbIR3mNdpiJ/dBhtaD548am5lcLerCi4eyrVPUMgTYRBUM23HGmPvbHEeIEhy
         FmHE8kx0iLRqYoJkT4ZB7KnvQNlwo4Q+mY/mo0aRL3Njzt4/+oHTTlQ9Du4qxi7XNeRA
         U14LJ8iznSxJVCV5d9wtug4e/LIRS81E7I5mEaZNn0ix8JOAnAgsQJOIW4oTZdic0mfg
         aJ2NuRCm9DlAix8K4KPMrenSw4TUIDTWqPMrGnkV6N5zLJEhXzrwLcQ8CXDmFo5sv1d4
         QviAURu4pjq8BT2HU6Td3xSwMzbLG4biavU2K+u0OgGbGD3baqB1CHNSkpOjMPZETkZ7
         /b4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xTTxITwBYMnhyrfbOb8zkex9qFX68doqwSOyVmroo3w=;
        b=uDlS77bRLeo1UP7bXm8nSvBq9ghXaHgWFr/W70kJJ9b6u3LRlN0nrh72RbpySSI+Yh
         qP/YZTHWJgJLJZU8biqNqrEvAB25d/3dzX2ecKdlNjLiurb2lRPl+K9hgXpk5H0xlETP
         PI6OjNL0aLUIPmEcIBTdPFgvwdJCxClCJjMniDgHnRgYS+PvXEuvrgyOMbIPL8CMUjSP
         j9VY9U2eQ8avdTCbHewv0J0l9DTpoNkzDrV4q4194yKB+dOPzML1ff87TE25I7Rwy0c8
         g45N3eAeL3l+PesPWcxwdHRNHPUUNlSXJe5cFlxAZwkiRJouuPusGogyVaFppzZ7jDvN
         bqzg==
X-Gm-Message-State: AOAM531y/J2MsIl5ivjsJfbjaKwrQxm1tar9c0mbBe+5H5SoKIbrloi+
        mQmNFT2EM3+ydg1Hern16pB5cfVqzAgiVbYJP2+1k6vPvDT9pw==
X-Google-Smtp-Source: ABdhPJxMNqgqU3iSazC38FdKKv1nycz+Yq/I0pOQEHDj3t4xY+cZKUDSmEf6D+sA5ZTJ6TiQNs1xqdGSZdkTLd078AQ=
X-Received: by 2002:a05:651c:556:: with SMTP id q22mr13289307ljp.491.1623030985198;
 Sun, 06 Jun 2021 18:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210601085145.3273-1-g199209@gmail.com> <87eedhilr9.fsf@meer.lwn.net>
In-Reply-To: <87eedhilr9.fsf@meer.lwn.net>
From:   =?UTF-8?B?6auY5piO6aOe?= <g199209@gmail.com>
Date:   Mon, 7 Jun 2021 09:56:14 +0800
Message-ID: <CAJkD-m3AONmZW0Ec30rDJThA48Z6TX7kBoqrZU-KPTFO+Ysmbg@mail.gmail.com>
Subject: Re: [PATCH] docs: block: fix stat.rst document error
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks! This is my first patch, I'll try to write the changelog in
kernel style in the future.

Regards,
Gao Mingfei

Jonathan Corbet <corbet@lwn.net> =E4=BA=8E2021=E5=B9=B46=E6=9C=885=E6=97=A5=
=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=881:26=E5=86=99=E9=81=93=EF=BC=9A
>
> Gao Mingfei <g199209@gmail.com> writes:
>
> > There are 17 decimal vaules, not 11.
> >
> > Previous committers forgot to change this number when adding
> > new fields.
> >
> > Signed-off-by: Gao Mingfei <g199209@gmail.com>
> > ---
> >  Documentation/block/stat.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/block/stat.rst b/Documentation/block/stat.rs=
t
> > index 77311335c08b..a1cd9db2058f 100644
> > --- a/Documentation/block/stat.rst
> > +++ b/Documentation/block/stat.rst
> > @@ -18,7 +18,7 @@ A.
> >     each, it would be impossible to guarantee that a set of readings
> >     represent a single point in time.
> >
> > -The stat file consists of a single line of text containing 11 decimal
> > +The stat file consists of a single line of text containing 17 decimal
> >  values separated by whitespace.  The fields are summarized in the
> >  following table, and described in more detail below.
>
> I've applied this.  I rewrote the changelog, though, to better fit
> kernel style:
>
>         Update the description of the device stat files to include the
>         proper number of fields.
>
> Thanks,
>
> jon
