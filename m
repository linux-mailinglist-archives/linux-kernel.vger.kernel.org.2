Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F36031D40F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 03:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhBQCwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 21:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhBQCvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 21:51:53 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46B3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 18:51:13 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id q77so271809iod.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 18:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mKEi1sJYnLakZCgrLfrV2khoVOUj2RlU6jI3qP53jFw=;
        b=LmCLQw9JEInyfq+j1Ckjhhcnt/PrdwS148aC+nfMxhjLs+alVeMb6CRSCrG47PlMP4
         LNceal2gZ633OIfcpmnVWMqe7UcZvJhr3ia5L7mlJFn9ViO10rai5swUpvEaZhqy+JTI
         Bo8CHqESkmNH6RofNQz/pwgqXDoE7k+DasjQzr8bHA45lsgthu7qtgTQdaAFeaqZLaTY
         Z4nQynes2El7E/1vCx8gPSBr6M0G63m0j13rFMJwHFs04dCiAd/wQSGSv7ggN7ggK7Lp
         3uhHxJP/BdfQPCEtDOLThyXWKs/cJq/CgdGycaUPidufFKxwb2OQIlSQBq1YDfRr15pW
         MCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mKEi1sJYnLakZCgrLfrV2khoVOUj2RlU6jI3qP53jFw=;
        b=DoVgHBlhAhB9JrhzLtXA42uo7Js+GMKXg0pX4ZWDKL+rhojAzRWwO/s5biN6y4MOfm
         qXUYMJbn8AQCs54qOu02bVTBsXzNbVKK5nZ3NBEh7UN+zHiTxdbKyBEy8Ma7ACJTN3FM
         C5hex1KBzN7F4ZiiT7fFtqu8dqbFK5cmYun44/8SqqlDyJpmmP0sQgsMKBAfthRlHQHV
         Rxanhnq94nNrkcWo34Xnb8dmYa3oAhklfPyW67LJxLl1Ph+XsLy+riGlz+D4tHnvPna9
         HproUVNiqnTjDSaROwFUe9+VR/7R9SPv277j2y3dMnGdQ9cgMD+OtACw457xlAKvhw30
         w42g==
X-Gm-Message-State: AOAM530YV8/5GYCVLIc983c//+vDD9tCskWUS9+MfnNX0JhLpXSZ3VvU
        /r4CUGCkdSo3XcYZOWNivGqr89TlIzuufHDWmiA=
X-Google-Smtp-Source: ABdhPJy7d0HuMHvtRKtYi3cnsYuP0/uzSvdausvX5f/WhKE6ROvtouCT+EFn1Vd1QGcUKSPdu+37RQF/EmfZpYTxyp0=
X-Received: by 2002:a6b:6f04:: with SMTP id k4mr316022ioc.2.1613530273152;
 Tue, 16 Feb 2021 18:51:13 -0800 (PST)
MIME-Version: 1.0
References: <CAKpeocV5osRZL2W+rXJVOQS0vcTCBXNp4aWMsVs9TqjhpBuEBA@mail.gmail.com>
 <875d20889c9528190cd661202030b6fccc25d120.camel@nvidia.com>
In-Reply-To: <875d20889c9528190cd661202030b6fccc25d120.camel@nvidia.com>
From:   James Spader <jamesspader.linux@gmail.com>
Date:   Wed, 17 Feb 2021 08:21:01 +0530
Message-ID: <CAKpeocU=yHJnLR0y1x7meW_C8ExBuTU=Cy4TWaWO+kcyo+c5Zg@mail.gmail.com>
Subject: Re: mlx5 HW crypto offload support
To:     Saeed Mahameed <saeedm@nvidia.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Raed Salem <raeds@nvidia.com>, Huy Nguyen <huyn@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saeed

Thank you so much for the response!! It helped me a lot.

The guide is very helpful. It is detailed and well written.



Thank you
Best regards
- James


On Wed, Feb 17, 2021 at 3:26 AM Saeed Mahameed <saeedm@nvidia.com> wrote:
>
> On Mon, 2021-02-15 at 23:17 +0530, James Spader wrote:
> > Hi All,
> >
> > Does HW crypto offload support for mlx5 work under virtualized
> > environment?
> > For e.g with PF (Physical Function) driver and VF(Virtual Function)
> > driver.
> >
> > If yes, then how does the information that is required to create
> > security association get passed to the PF driver?
> >
> > For example in rx full offload the FDB table needs to match the spi.
> > As the spi is created by the VF driver, how does its value get
> > communicated to PF driver...
> >
>
> Hi James,
>
> please find this guide [1] for a step by step configuration, i hope it
> will answer your questions.
>
> the solution is only in OFED package right now, Huy and Raed "CCed" are
> working on the upstream submission.
>
> The link below discusses the configuration for Bluefield smart device,
> but the concept should be the same for Native SRIOV.
>
> [1]
> https://community.mellanox.com/s/article/ConnectX-6DX-Bluefield-2-IPsec-HW-Full-Offload-Configuration-Guide
>
