Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DFD31EAB8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 15:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhBROCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 09:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbhBRMIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:08:22 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00EFC061574;
        Thu, 18 Feb 2021 04:07:24 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 80so1648149oty.2;
        Thu, 18 Feb 2021 04:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UAF+AYB5tpUpq4+oyyh6f/zszxtQc2PJSl9KiMzzdLg=;
        b=nEORJ1zq5KEJsx/O+mUTUsGzEV58pXDCdz1GlwQUXjqtzU5Wb6ahDmbRFpnNxX3Ep1
         RuikxdpjNAM72y8iMky12EesUVKvF9XPaM6TsEvwJMiOqSsCeVbDvAYYo/fFfrrcTAJW
         nGEF2VVjrJ86uD/RO1f4dqqAtxYLfRzFIRA4pAfaYf5LUTJnyxL4n+yEqUq6FvBUrRok
         +WsrnCnf4aWFzfkNKsYmM6jdcmoWzLKq3RpnbSqrijGS8oNR8o4irvXSw7Q1dv6EaVBC
         bS/a1GJnsWAieHNkO+Z4d7nJl/Sih6Rk7GkR9JroLHF0XAb2D+0fiVQiWJqfna5bzfgF
         8epg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UAF+AYB5tpUpq4+oyyh6f/zszxtQc2PJSl9KiMzzdLg=;
        b=J6WQkoZHt1WlQLyXowZFwOMsAfjuF2TYrm6zqWDvBXUsSwI1zUIfE+jFURHUMpag0k
         /NeT+drdMbvNaHiDFTGp+Z3+0fSPfXWLDO8Fcv4UtdClA85lPAl5hMfUFoDLrLzU0C8s
         3/0CC1rSw9qgsQ8Hxio2sgSN77i/napoyGQv+NlJr7JsWgHwM5stqBDcWixNZqvKwo5k
         KmkyhGwY5nSJo+HoPd7dpGZLm/rI8B4Qsj4jzw+MTVSo+27SWsIeOmURw0mReFEcwCND
         VWnFc1nbwvGx2sFQzjcmFGW+U+ccuYQA8ZKrea949WwdBWBEpf6fqnMy/k/2zbOB3yVJ
         3fKQ==
X-Gm-Message-State: AOAM531kZJkqK3XxdcM0SpXJ6dKp3eiVXsILYBAhrPx1MMcr0Sw0PVNj
        Co72eqVy92Gy27GMGXCj/YZJD71hDnq9z9LPy+A=
X-Google-Smtp-Source: ABdhPJz5rL4/7PZwcbf5yGJPgwmcBEWoqsceFCttMg03TwgGMRqsXPc8r/vT9J0fTR7KBMJfbwI4SyTD54AeKCGVPmE=
X-Received: by 2002:a9d:7f86:: with SMTP id t6mr2664690otp.362.1613650044026;
 Thu, 18 Feb 2021 04:07:24 -0800 (PST)
MIME-Version: 1.0
References: <1605782884-19741-1-git-send-email-weiyi.lu@mediatek.com>
 <CAFqH_522NuGY9c-_XWhHxoa3QkrdoM92qTOLxgM8PpOU=-ttbw@mail.gmail.com>
 <1605791419.19819.4.camel@mtksdaap41> <CAFqH_51m5Pg9ny4HWt1iwf8wtsGSdShpDCVaGwac=v9BBDj2vg@mail.gmail.com>
 <1f25cc3f-324a-0020-7bf2-e5a915291522@gmail.com> <1606734983.24689.1.camel@mtksdaap41>
 <1613644263.10586.8.camel@mtksdaap41>
In-Reply-To: <1613644263.10586.8.camel@mtksdaap41>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 18 Feb 2021 13:07:12 +0100
Message-ID: <CAFqH_51m7zXQ1G-KxhKxH0dPXrgfi=2JgmnncON_XqthpF9U0g@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: mediatek: Add mt8192 power domains controller
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Weiyi,

Missatge de Weiyi Lu <weiyi.lu@mediatek.com> del dia dj., 18 de febr.
2021 a les 11:31:
>
> On Mon, 2020-11-30 at 19:16 +0800, Weiyi Lu wrote:
> > On Fri, 2020-11-27 at 13:42 +0100, Matthias Brugger wrote:
> > >
> > > On 19/11/2020 15:13, Enric Balletbo Serra wrote:
> > > > Hi Weiyi,
> > > >
> > > > Missatge de Weiyi Lu <weiyi.lu@mediatek.com> del dia dj., 19 de nov.
> > > > 2020 a les 14:10:
> > > >>
> > > >> On Thu, 2020-11-19 at 13:13 +0100, Enric Balletbo Serra wrote:
> > > >>> Hi Weiyi,
> > > >>>
> > > >>> Thank you for the patch
> > > >>>
> > > >>> Missatge de Weiyi Lu <weiyi.lu@mediatek.com> del dia dj., 19 de nov.
> > > >>> 2020 a les 11:48:
> > > >>>>
> > > >>>> Add power domains controller node for SoC mt8192
> > > >>>>
> > > >>>> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > > >>>> ---
> > > [...]
> > > >>>> +                       /* System Power Manager */
> > > >>>> +                       spm: power-controller {
> > > >>>> +                               compatible = "mediatek,mt8192-power-controller";
> > > >>>> +                               #address-cells = <1>;
> > > >>>> +                               #size-cells = <0>;
> > > >>>> +                               #power-domain-cells = <1>;
> > > >>>> +
> > > >>>> +                               /* power domain of the SoC */
> > > >>>> +                               audio@MT8192_POWER_DOMAIN_AUDIO {
> > > >>>
> > > >>> If you run the dt_bindings_check it should return some errors, as all
> > > >>> these node names should be 'power-domain@'. Which is a bit annoying
> > > >>> because then you will get a bunch of errors like this:
> > > >>>
> > > >>> [    1.969110] debugfs: Directory 'power-domain' with parent
> > > >>> 'pm_genpd' already present!
> > > >>> [    1.976997] debugfs: Directory 'power-domain' with parent
> > > >>> 'pm_genpd' already present!
> > > >>> [    1.984828] debugfs: Directory 'power-domain' with parent
> > > >>> 'pm_genpd' already present!
> > > >>> [    1.992657] debugfs: Directory 'power-domain' with parent
> > > >>> 'pm_genpd' already present!
> > > >>> [    2.000685] debugfs: Directory 'power-domain' with parent
> > > >>> 'pm_genpd' already present!
> > > >>> [    2.008566] debugfs: Directory 'power-domain' with parent
> > > >>> 'pm_genpd' already present!
> > > >>> [    2.016395] debugfs: Directory 'power-domain' with parent
> > > >>> 'pm_genpd' already present!
> > > >>> [    2.024221] debugfs: Directory 'power-domain' with parent
> > > >>> 'pm_genpd' already present!
> > > >>> [    2.032049] debugfs: Directory 'power-domain' with parent
> > > >>> 'pm_genpd' already present!
> > > >>> [    2.039874] debugfs: Directory 'power-domain' with parent
> > > >>> 'pm_genpd' already present!
> > > >>> [    2.047699] debugfs: Directory 'power-domain' with parent
> > > >>> 'pm_genpd' already present!
> > > >>> [    2.055524] debugfs: Directory 'power-domain' with parent
> > > >>> 'pm_genpd' already present!
> > > >>> [    2.063352] debugfs: Directory 'power-domain' with parent
> > > >>> 'pm_genpd' already present!
> > > >>> [    2.071176] debugfs: Directory 'power-domain' with parent
> > > >>> 'pm_genpd' already present!
> > > >>>
> > > >>> But that's another problem that should be handled in debugfs system.
> > > >>>
> > > >>
> > > >> Indeed...so I chose to use different name in dts to avoid problems in
> > > >> debugfs. It does violate the naming rules.
> > > >>
> > > >
> > > > But your binding will not pass (or trigger warnings) the dtb check
> > > > then. Rob was clear that names should be generic. Proper fix is fix
> > > > debugfs not the binding.
> > > >
> > >
> > > By the way, is anybody working on this debugfs issue?
> > >
> >
> > I think we can solve this problem by adding "name" to the struct
> > scpsys_domain_data and use this domain_data->name as the genpd.name.
> > This is very simple. But I want to know if you both like it?
> >
>
> Hi Enric and Matthias,
>
> May I have your opinions on how you might to fix this issue?
> I'll try to give another name to each power domain in the
> scpsys_domain_data and register power domain with this name like below
>
> struct scpsys_domain_data {
>         ...
> +       char *name;
>  };
>
>
> -       pd->genpd.name = node->name;
> +       pd->genpd.name = pd->data->name ?: node->name;
>
>
> Does it violate the naming rules to some extent? or it's acceptable?
>

I think it could be acceptable, I think doesn't violate any rule. My
doubt here is we should name in a generic way in the form
'power-domain@addr' getting the last part of the full node name to
avoid conflicts or if the name should be driver-specific. I think it
makes sense to be driver-specific as is more helpful for debugging
purposes. If we do driver-specific (with data->name) I'd fail if is
not supplied.

Thanks,
  Enric

> > > Regards,
> > > Matthias
> >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
>
