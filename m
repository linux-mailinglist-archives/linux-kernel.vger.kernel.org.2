Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3EC426143
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 02:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241739AbhJHA1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 20:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbhJHA1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 20:27:13 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE731C061570;
        Thu,  7 Oct 2021 17:25:18 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id n8so30126553lfk.6;
        Thu, 07 Oct 2021 17:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JAxiMV4e9IES0WCDs6Kf/JEV24J6hZNfBu2CFV/CZ38=;
        b=H2EWLDQbJMkvJFlEtT/t+4WfNlZc7NvJHo8UPbbJ1Vgbxqw1zgW/utCv8dE+C4j49v
         eRaUM/uUDYAAtqTT9zZ6cO/QOPY6Q9op105OnCcvkka1Ud/ImZRuHbaLnqaZ5di4DqOI
         J3B4z71Zr5KxukkUSg7Gzh5ouX1G6QAQzEB9vG3G57VvisVPVIRn4B9OQlStCvioIHES
         i69id2Xo6RpVEjTBgXc7ELWI2NXT0PUDIZC9AtB4nahgKjQeWMUwfU6+V9LDBr1hbS2j
         ZgEVTRSg41W4bNF9q4mPv4ux6C1EdgifKc2Oo1jh/oLVdiC9pOlp2bgveFA5atsHDKtj
         +kOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JAxiMV4e9IES0WCDs6Kf/JEV24J6hZNfBu2CFV/CZ38=;
        b=3PhQ+Xen6SlRIFO4sSoEgoLWtirIh/gHv9YaTeeeXhuYKLjsJiyzlEdMwRhpiU0NHS
         xNraWm4kjWeDDRQke8wj6uFqoQrOKvVm+gMrbmjOMAbzCEXOJ/IDkIkJDHy9YwlEqM+s
         uN45JqqJPvfnBUN4IVmN6jCxqOwBDRy7GpAKrabTCYtNj50ePBZelrxrc9mZJchIHx1K
         pCOXjTFGpm+cYxpq0ZbMuctdqlFK05hy3ApUUerriSoiktOl9GAxkA5z2hd6P+lhvTR7
         JhU6BbJzEg5CApsylGMQbdmDF8UQGupeKrUBJEam6inB3WNDhEg6UZAWEO+FCPGc34qe
         ckVA==
X-Gm-Message-State: AOAM533fGlWua6VzIEJfgSUXK3pDecxxjBIAFhN7f29wj+AaVQbjLP+f
        ICzchHeIz9cC/9Qr6aLRkNWuSUd5n5A14EucBSE=
X-Google-Smtp-Source: ABdhPJw/svHxQv1lF1Ihe6ehtlvQgm5Y7g4LCz8pevcaSeUqmDAJlLh+5VmaHLXuE1rESNw8nmRkAdd6U4+igSErhSQ=
X-Received: by 2002:a05:651c:1610:: with SMTP id f16mr63513ljq.415.1633652716880;
 Thu, 07 Oct 2021 17:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <1633396615-14043-1-git-send-email-u0084500@gmail.com>
 <YVw7vbpu4TS+7Su8@sirena.org.uk> <CADiBU39dvKS_a5FDgw9yMVFe8Uycn6bfjGwBWq+7MN_DdxkL1g@mail.gmail.com>
 <YVxFMaPhZdAFniMa@sirena.org.uk> <CADiBU3_TuHKiVG-r1TG-8WK_tW2GXi4VuqkidPwTyebOgE60OA@mail.gmail.com>
 <CADiBU3-4F-FdJxaa4Qp4xmUD3vsA=6u5_ojwDSr8zrDuW8JbXg@mail.gmail.com>
 <CADiBU38zCZk_P-q8BtbPfdeSacUF7LOvQYUFgvidbWZwcLY=wA@mail.gmail.com> <YV76ByQWKvKNOvF0@sirena.org.uk>
In-Reply-To: <YV76ByQWKvKNOvF0@sirena.org.uk>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Fri, 8 Oct 2021 08:25:05 +0800
Message-ID: <CADiBU3_2me9xxBxCy5oT6KxiC2J+TrsY-EzyXXcJ_F2mtm+oJQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: rt9120: Add initial bindings
To:     Mark Brown <broonie@kernel.org>
Cc:     oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, lkml <linux-kernel@vger.kernel.org>,
        cy_huang <cy_huang@richtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, allen lin <allen_lin@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> =E6=96=BC 2021=E5=B9=B410=E6=9C=887=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=889:45=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, Oct 07, 2021 at 10:44:49AM +0800, ChiYuan Huang wrote:
> > ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=886=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:47=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > > ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=88=
5=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:39=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > > > Mark Brown <broonie@kernel.org> =E6=96=BC 2021=E5=B9=B410=E6=9C=885=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:29=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> > > > > > > I would expect this to be done through the regulator bindings=
, they
> > > > > > > would allow the driver to query the supply voltage.
>
> > > > > Please don't take things off-list unless there is a really strong=
 reason
> > > > > to do so.  Sending things to the list ensures that everyone gets =
a
> > > > > chance to read and comment on things.
>
> > > After contacting our HW RD, to support DVDD 1.8V not just SW config,
> > > also HW connections.
> > > To get only DVDD supply voltage is not enough to meet the HW design.
> > > The property seems indeed and need to be used by user's HW connection=
.
>
> > > Can this property to be kept?
>
> > After thinking, This property name may be improper.
> > I think this change depends on HW external circuit for lowv application=
.
> > Currently, I'm modifying the V3 change, this property name also affect
> > the property parsing code change.
> > May I directly change the name to 'richtek,dvdd-lowv-application' and
> > submit the patch v3?
>
> I still don't understand why you wouldn't describe this through the
> regulator bindings, those exist to describe the physical supplies ont he
> board and their constraints.

Not to oppose your comment, from the initial idea, I'm just thinking
'how' to make the user easy to use.
But if this way  is more flexible, I'll change it to check the
regulator voltage.

This will be put in patch v3.
Thanks.
