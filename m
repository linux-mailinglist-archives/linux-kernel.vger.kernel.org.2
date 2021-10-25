Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6364391EF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 11:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhJYJHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 05:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhJYJHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 05:07:33 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3780CC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 02:05:11 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so14024522ott.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 02:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NPeu1poYOZvBuPcB8mqHzEfH4COGHEACiTWNCQVfl9w=;
        b=KqQIbYxy73SZL1DGOQqQzSk2lqdc8dqLRIPlx0jEoOKP81cf0OeAQLI9plzVbeQ0HA
         K2E1JOtzeVL5A9qKdsyFJJ7Fl3Xmal0CZ9vdM3jQmjOy8UQt0yT1hFk+uIk/+8T7r1iu
         fBe4xFufWSF7hmTI7DROYob9lRBiZwaw9XWvNYEDm2BZ4/Dy1UWaSiJ3ev8asG2JT6OV
         IaIdGJ7q5swoac1+F6b4i7XQhaC0NxIIiR4SHV1r5xJ9xfplE3O7mDpbsCfjezVb6BsH
         PVt81Rm/XPa+oed+cAGZU7JTlE2hO5DcS8vShZlFLrCpY3c+6ZuxX3kLYOfEW89UsTKd
         aCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NPeu1poYOZvBuPcB8mqHzEfH4COGHEACiTWNCQVfl9w=;
        b=5w+/1SSj9U5uueWHBOpdRkzaWFsYbGZAyefSehoM7drPrv3C7tY3TmMI1Q/Di/nukO
         O+Ql7nigDBAnZQv6G+SfmyjM9gR5YixsFGMenfp5cYo9yc029CbDt4s4WxMpQtU9Xdhc
         50KSiHY9NNo5ofy6+V5THgY96Mq3qUX2tJxV4NG2eSA/HimVhP7XUmQnDJg1+QAZ1P5p
         RGqghD+eUW1RtHlnr+KJ0/CEGuJ13rpiALPBZn+xFkvuMQHDFUMLVUTwuOonzGgstzDc
         4H7lVuxz+58G9LFZ94Am3WC4wt7H5VDq+m1TDVQlBiaHkTWtDRKJ9Geonu6vmsdVWbP4
         +gwg==
X-Gm-Message-State: AOAM533HjqLWXAsfujBx55gMbTmAUbp+6uTbHd1uAvmAgVmRV0IpK+yo
        zRKZG/t47NPA7/gSpzkrmKj1QoIGlQAR1YiXzqaSLA==
X-Google-Smtp-Source: ABdhPJxamKYAFZoNCTkBSpzygAJ04U8L9iWnulLsJcuDqg2jccuCGWR54kLMiqkaIUsmOaNbdkG+qo7JoQZK6oy+KAE=
X-Received: by 2002:a9d:6483:: with SMTP id g3mr12458785otl.105.1635152710562;
 Mon, 25 Oct 2021 02:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200924063042.41545-1-jhp@endlessos.org> <YXXNsdVTo8pVfs4/@think.localdomain>
In-Reply-To: <YXXNsdVTo8pVfs4/@think.localdomain>
From:   Jian-Hong Pan <jhp@endlessos.org>
Date:   Mon, 25 Oct 2021 17:04:20 +0800
Message-ID: <CAPpJ_ed1pBmCWPFMPj8vNkfPAqUtugvUJC14e2pcDuDJUastzQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: disable USB type-c DisplayPort
To:     Siva Mahadevan <me@svmhdvn.name>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Soeren Moch <smoch@web.de>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Johan Jonker <jbx6244@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Siva Mahadevan <me@svmhdvn.name> =E6=96=BC 2021=E5=B9=B410=E6=9C=8825=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=885:17=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Jian-Hong Pan wrote:
> > The cdn-dp sub driver probes the device failed on PINEBOOK Pro.
> >
> > kernel: cdn-dp fec00000.dp: [drm:cdn_dp_probe [rockchipdrm]] *ERROR* mi=
ssing extcon or phy
> > kernel: cdn-dp: probe of fec00000.dp failed with error -22
> >
> > Then, the device halts all of the DRM related device jobs. For example,
> > the operations: vop_component_ops, vop_component_ops and
> > rockchip_dp_component_ops cannot be bound to corresponding devices. So,
> > Xorg cannot find the correct DRM device.
> >
> > The USB type-C DisplayPort does not work for now. So, disable the
> > DisplayPort node until the type-C phy work has been done.
> >
> > Link: https://patchwork.kernel.org/patch/11794141/#23639877
> > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arc=
h/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> > index 06d48338c836..d624c595c533 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> > @@ -380,7 +380,7 @@ mains_charger: dc-charger {
> >  };
> >
> >  &cdn_dp {
> > -     status =3D "okay";
> > +     status =3D "disabled";
> >  };
> >
> >  &cpu_b0 {
> > --
> > 2.28.0
>
> I saw a similar patch posted at https://lkml.org/lkml/2021/7/15/752. I
> was wondering if one of these patches will be submitted to mainline, or
> what the status on this patch is. I can confirm that this does solve
> the issue on my Pinebook Pro. Will this go forward?

Notice that commit ("arm64: dts: rockchip: Disable CDN DP on Pinebook
Pro") [1] is already in linux-next.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?h=3Dnext-20211022&id=3D2513fa5c25d42f55ca5f0f0ab247af7c9fbfa3b1

Jian-Hong Pan
