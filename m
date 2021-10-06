Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C696424985
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 00:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239554AbhJFWRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 18:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbhJFWR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 18:17:28 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DC4C061755
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 15:15:36 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id u32so8772967ybd.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 15:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bLkXPKgwDs6RrD6sIhWAu6J/jje6v2DWvJSDi3dyacU=;
        b=omp5WUi2srkkJtu6Y11KpKx5rkaN7WkK46/dR0H6c1VEUCNDbqbXAKQJVdOs/iL5Fu
         FYaHTvcZ44x69udRZvVB9D5td2Qzu2Hp5Q8wPjoGTGYJWobyFvt/uBcRtCXkD8sl29Hb
         T06DOOgOCzjlVfLDgZkcOjbIggQgnGVi2ARfsVLp36Hvq15lkeRTAzHhe2YcSGufFk1Y
         QkFE6WbhnCGfH0pGWUrg2KfICYhLMlcHnkzMyZ1q59/+LAWTr/SCPYJPOrMxsCfd/ieY
         3iejfymWIfZyPmkG8m2kWLyMUpacRGDn4RocpW3T0w9uvFPhq61jI65GS01BvkeE7u/H
         Gd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bLkXPKgwDs6RrD6sIhWAu6J/jje6v2DWvJSDi3dyacU=;
        b=EUkuXit9U/aH9icYaEDMukm0q+4QDpZC7/+VWT4c4WFcdSmlvXg8d6PFHjEe0rdCJj
         pNYODqDsaxMIv6FzWQqQ1XeYiX4T+lNk4x1cENsudroQhu/s5UurRh9gfJpsKyYB/ouv
         AJbcEi7CqA+5QJKr1umsNVqdti+zAOr0FOgDRRsA6AuVSuhGmOz7vm0aBLZXB9GRlfZP
         eJdxNVeKjI1zxwc7kZq74RW+0sOCS55bAZFwScuw9L17FpwVDGWXMX0EtFICdRMhVwrt
         hqSWBGY5cnc7UJ/ZBoWosKiYp2OIxnmMIGOMPLg0YGjzJFa/jweBmLIS9wyc9/vQwbxh
         EXlQ==
X-Gm-Message-State: AOAM531mOxbHrAu30GBQsbJTgvHlLdSKm612tGsmLGunwYf0ncud+MsY
        vkxWwxv50d0G2MULKjWA/A9gU5oVRKaY26+HtlNNHg==
X-Google-Smtp-Source: ABdhPJysw5eB0GRIFouNT/cd+prCfUToi3eegnqBYBd3kLXJmVy7fuTCNUtkIx8MrmqGYV0EXHtXjqXKPCZasHrBj8A=
X-Received: by 2002:a25:2b07:: with SMTP id r7mr700635ybr.296.1633558534897;
 Wed, 06 Oct 2021 15:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <m3lf39nfsq.fsf@t19.piap.pl> <CAGETcx_N7XYkzFPSuQdvWKk1o+Pzzg4HnzChE_4c_Bg_oOK3eA@mail.gmail.com>
 <CAOMZO5DwcXUe5j97n4Q_RF9WRo2DYoToe7FLNbpDJhn_BxuH0w@mail.gmail.com> <m38rz6oinj.fsf@t19.piap.pl>
In-Reply-To: <m38rz6oinj.fsf@t19.piap.pl>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 6 Oct 2021 15:14:59 -0700
Message-ID: <CAGETcx8qsJQNkEHYgqihqHuFu8sgC5DDsnG9yQ=_e_hiC43z-w@mail.gmail.com>
Subject: Re: v5.15-rcX regression: video devices on i.MX6 are not created
To:     =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 5, 2021 at 9:56 PM Krzysztof Ha=C5=82asa <khalasa@piap.pl> wrot=
e:
>
> Hi Fabio, Saravana,
>
> Fabio Estevam <festevam@gmail.com> writes:
>
> >> > FYI the patch: 6b2117ad65f1bca9ece6d4b1ee784b42701a2d86
> >> >
> >> > of: property: fw_devlink: Add support for "resets" and "pwms"
> >> >
> >> > Allows better tracking of dependencies between devices.
> >> >
> >> >  drivers/of/property.c | 4 ++++
> >> >
> >> > breaks v4l2 video devices on an i.MX6 CPU. The /dev/video* nodes are=
 not
> >> > created, and the drivers (async subdevicess) are "waiting":
> >
> > Phillip has sent a fix for this issue:
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2021-October/6878=
68.html
>
> This patch makes the /dev/video* devices to show up on my i.MX6-based
> system again, so I consider the problem fixed. Thanks.

Ah, I helped Phillip come up with that fix. I didn't realize this was
the same issue. Glad that I have one less issue to debug :)

-Saravana
