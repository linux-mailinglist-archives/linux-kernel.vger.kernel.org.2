Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5D240B5A8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 19:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhINRLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 13:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhINRLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 13:11:07 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B406AC061574;
        Tue, 14 Sep 2021 10:09:49 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id u1so12640519vsq.10;
        Tue, 14 Sep 2021 10:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BmjYRi68aN56XU0y56jNmFUmGH6RU4xfmzH+VRZkmP8=;
        b=WvQ9+x6vxQQ+jhcAP5aiM9UUy4wS/+0cv6xeYDS7ufnUKsz4hCBnFWDmhD1S9TlrMU
         15I+yXU4SaoAXgM5tE07/F7pJiZU6m5xLA0daV3F12m7Z4bMRCq/wCHKq1b63eTYw854
         IfhtsR4mlFwMil8XUAvNphsYt3XqAnG1Wq2QMqXFZc5j+oTn6Ww/UXeJd+VJ0L/llS6E
         dIHJmwyPnM/aWIk1uRTqLi5AICTQzTZIl0lulZVXv310h6vZOFdSB+zsb9B0J5GRN8tW
         8kk6FcBfTbpRpGKjoEIAWncTwrRs2+waDBETLl4OuPSKW+1L5QqSuNWHhpwdGPxR5xMn
         6Z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BmjYRi68aN56XU0y56jNmFUmGH6RU4xfmzH+VRZkmP8=;
        b=CA+4dLK1nF16YfsXOTxKZfgFCCHzm6cNrvlRTApyWt/FS4bvWfXg/rKsn4jN2nwx1V
         HitagpSb9OqelC8jlqmehu64r5tOrpK6BjuRk3JJQHRSL86ToN6xVdjF/XSuW8NIz6F6
         faEkv63AVuIwQrb2sVpyNE26uBSHqAFlvfQuvm023mNRcOpvm+zlAixkSw0ODflnDfDG
         ChoMa9cIkRyj1InIIzzSh4h8h5mXVocEx0OJ03d+CjWO0Y18087BjlnNCPGgigl3cK1q
         ciAR0PRaRUiohHnRF13WF4lNlmD6AgL1dqZhvPL2b/cjqggWbbqhJBIaUrGwCEGE/kk9
         s1+A==
X-Gm-Message-State: AOAM532mzKJgvQgnP0wgzz0wYGpU3KnZFbE8llngEmyeucWFjX+E2LYH
        FeCBSpV/QVevIZNfPSbV0CatDb9/vi5yp6Fp4Fq16hmA
X-Google-Smtp-Source: ABdhPJzTqzpkX0hLcieltriovP1u8Zem4alXiXe22whECWTd4+BN1Q5gN3Zr7krVAOKfE1FPBchFDYt9vsD8p2sJ4Eg=
X-Received: by 2002:a05:6102:34cd:: with SMTP id a13mr261137vst.56.1631639388823;
 Tue, 14 Sep 2021 10:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210910190322.27058-1-romain.perier@gmail.com>
 <20210910190322.27058-5-romain.perier@gmail.com> <CAFr9PXnLZC1zfs4e1GqZU4UU3knU-BwREe0-abrWNq7akrTntw@mail.gmail.com>
 <CAK8P3a24NTmkyh01OEzDQ8=oTWpUnDtwWQgUUxUbW2wxsgAFeA@mail.gmail.com>
 <CAFr9PXkipBnVDBOpdYhUD4bYNaL8qybPhGJi7YwSHaCNrPz6rw@mail.gmail.com> <CAK8P3a1=GTcgbqkwnzsFtBtFZTtf4Lop7U5hsCAid-fCgs07yQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1=GTcgbqkwnzsFtBtFZTtf4Lop7U5hsCAid-fCgs07yQ@mail.gmail.com>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Tue, 14 Sep 2021 19:09:37 +0200
Message-ID: <CABgxDoJLOERb4CFABz0XNZ9MFR1F66Nyw9NknaEMHKSRze6VHA@mail.gmail.com>
Subject: Re: [PATCH 4/4] MAINTAINERS: Add myself as MStar/Sigmastar Armv7 SoC maintainers
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Palmer <daniel@0x0f.com>, Rob Herring <robh+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you very much and sorry for the wrong inclusion of
soc@kernel.org, it's noted for the next time.

Regards,
Romain

Le mar. 14 sept. 2021 =C3=A0 17:26, Arnd Bergmann <arnd@arndb.de> a =C3=A9c=
rit :
>
> On Tue, Sep 14, 2021 at 5:03 PM Daniel Palmer <daniel@0x0f.com> wrote:
> > On Tue, 14 Sept 2021 at 22:54, Arnd Bergmann <arnd@arndb.de> wrote:
>
> > > FWIW, I'd suggest merging the MAINTAINERS file change as a
> > > bugfix for 5.15, it's generally better to do these as early as possib=
le
> > > to make sure any patches reach all the right people.
> >
> > That makes sense.
> > Would it be possible for you to merge that single commit for me?
>
> Done, merged into arm/fixes.
>
> > Seems like that would be easier than me creating a fixes branch for a
> > single commit, sending you a PR, finding out I still don't actually
> > know how to do PR properly.. :)
> > If it's a hassle I'll do the PR though.
>
> If you only have one or two patches, sending that patch to soc@kernel.org
> is usually the easiest way anyway, unless there is a reason to keep the
> branch description separate from the patch description in the git log.
>
>       Arnd
