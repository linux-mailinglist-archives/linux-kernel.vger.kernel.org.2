Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89C8348ECC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 12:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhCYLQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 07:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhCYLQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 07:16:19 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF8FC06174A;
        Thu, 25 Mar 2021 04:16:18 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id d12so1697121oiw.12;
        Thu, 25 Mar 2021 04:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jfWJVHugH6F84viKhqW87rxxN4z2FKXxSY/2oOWo2Kk=;
        b=E29WFlPSSobswq8JFYDlcuoHZ3Y7BajYJkh6/5TbxD3ihkkpdLO1dVL28xMenpmx3q
         sIGOd+9dT+L44l2oWYD9oFgK01exlorM7VEPoN1ExNU/bFvc0YS0SNH11ZaiKmbilAR7
         PRfd2L7ONg0CcJnOjB9a3J1d9aeVAXrLXDYYbwZqifJ+WOkx+EaM1qhd20sUEgcJVdtx
         n2wKy1Oj6JGoxZWQYGC/UIcyKTpE7Vo81JmkJ2TaunfsbYMrMiog67jO33tCifyRmGrw
         A72L5RuRGiMwGiXlEh+nQ7Jcl835vr+okAlQ1T0BOEODXfqKOnYgZBX+rrkt95LXlT/M
         EbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jfWJVHugH6F84viKhqW87rxxN4z2FKXxSY/2oOWo2Kk=;
        b=SogYHDjsVVkKidbsgX/AJscpF3m0K0TVvQtehz9ybPKmMm2WIzldRDxaTshuH8gw4a
         2WnWUwnazzdy2J6POeQ3MYHlvDmu14JFr0+Pt+QAJzJJKD/M3qyzyTGkXJBc9VXn6GYI
         pS2t82xYUuqf28cTyJ/eunv1ZJz7IjWx5s99kf0O0LJfeCUOM2d8nlMbzVTd5jqXd19P
         MahIkR/J9IwWu1bT/tDeflWZ7zEH32x4qItqUl9+35faERTtacWWMCTmG3NzSr6Au2Jw
         blCuxw1B1bCEAPHmZTa1fTrx/2NCYKOs7oguEG841IGwX6ESEP+KQGfAHpFpdsLsTp2U
         r65A==
X-Gm-Message-State: AOAM531NTf7DLsvjXsuxXU1z8EkBPay8Lg3fhE3m51ZU3Hae/8hThwiG
        nwAJ60pF08DpZ+nBcAT/ohyUhUsCAEpHBDwrA8ByCtHB3CBstA==
X-Google-Smtp-Source: ABdhPJxi4yVbyEUatzUa0OEH/exBaiWoMEKvQLjeMIbN6tbjfAh2isPYniJhcQq3idILJbjb/1Coqgzhm8zfvtjnj7A=
X-Received: by 2002:a05:6808:14cf:: with SMTP id f15mr5676164oiw.39.1616670977915;
 Thu, 25 Mar 2021 04:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210324071609.7531-1-zhangqing@rock-chips.com>
 <40a7fad3-17bb-9275-ed4a-2e3d526d05a1@collabora.com> <f1323618-7990-9bb7-a8c2-a7321a4034f8@collabora.com>
 <2066097.irdbgypaU6@diego> <6da85755-276d-1f4d-cfa8-2d0e4d836c6b@rock-chips.com>
In-Reply-To: <6da85755-276d-1f4d-cfa8-2d0e4d836c6b@rock-chips.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 25 Mar 2021 12:16:06 +0100
Message-ID: <CAFqH_51J=jHzp9Nh5ZGRdpgk9305qUHia+cFcvM1p4+nv-O=tg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: power: rockchip: Convert to json-schema
To:     "elaine.zhang" <zhangqing@rock-chips.com>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, cl@rock-chips.com,
        huangtao@rock-chips.com, kever.yang@rock-chips.com,
        tony.xie@rock-chips.com, finley.xiao@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elaine,

Missatge de elaine.zhang <zhangqing@rock-chips.com> del dia dj., 25 de
mar=C3=A7 2021 a les 7:43:
>
> Hi,Heiko:
>
> =E5=9C=A8 2021/3/24 =E4=B8=8B=E5=8D=889:31, Heiko St=C3=BCbner =E5=86=99=
=E9=81=93:
> > Am Mittwoch, 24. M=C3=A4rz 2021, 11:32:42 CET schrieb Enric Balletbo i =
Serra:
> >> On 24/3/21 11:25, Enric Balletbo i Serra wrote:
> >>> Hi Elaine,
> >>>
> >>> On 24/3/21 11:18, elaine.zhang wrote:
> >>>> Hi,  Enric
> >>>>
> >>>> =E5=9C=A8 2021/3/24 =E4=B8=8B=E5=8D=885:56, Enric Balletbo i Serra =
=E5=86=99=E9=81=93:
> >>>>> Hi Elaine,
> >>>>>
> >>>>> This is not the exact version I sent, and you reintroduced a "probl=
em" that were
> >>>>> already solved/discussed on previous versions. See below:
> >>>>>
> >>>>> On 24/3/21 8:16, Elaine Zhang wrote:
> >>>>>> Convert the soc/rockchip/power_domain.txt binding document to
> >>>>>> json-schema and move to the power bindings directory.
> >>>>>>
> >>>>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.co=
m>
> >>>>> If you do significant is a good practice shortly describe them with=
in [] here.
> >>>>>
> >>>>>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> >>>>> Note that my last version already had the
> >>>>>
> >>>>> Reviewed-by: Rob Herring <robh@kernel.org>
> >>>>>
> >>>>> Which should be fine for merging (with probably only minor changes)=
 and you
> >>>>> could maintain if you don't do significant changes, but that's not =
the case, as
> >>>>> I said, you are reintroducing one problem. Please review the commen=
ts already
> >>>>> received on this patchset or similar patchsets to avoid this.
> >>>>>
> >>>>>> ---
> >>>>>>    .../power/rockchip,power-controller.yaml      | 284 +++++++++++=
+++++++
> >>>>>>    .../bindings/soc/rockchip/power_domain.txt    | 136 ---------
> >>>>>>    2 files changed, 284 insertions(+), 136 deletions(-)
> >>>>>>    create mode 100644
> >>>>>> Documentation/devicetree/bindings/power/rockchip,power-controller.=
yaml
> >>>>>>    delete mode 100644
> >>>>>> Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
> >>>>>>
> >>>>>> diff --git
> >>>>>> a/Documentation/devicetree/bindings/power/rockchip,power-controlle=
r.yaml
> >>>>>> b/Documentation/devicetree/bindings/power/rockchip,power-controlle=
r.yaml
> >>>>>> new file mode 100644
> >>>>>> index 000000000000..a220322c5139
> >>>>>> --- /dev/null
> >>>>>> +++ b/Documentation/devicetree/bindings/power/rockchip,power-contr=
oller.yaml
> >>>>>> @@ -0,0 +1,284 @@
> >>>>>> +# SPDX-License-Identifier: GPL-2.0-only
> >>>>>> +%YAML 1.2
> >>>>>> +---
> >>>>>> +$id: http://devicetree.org/schemas/power/rockchip,power-controlle=
r.yaml#
> >>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>>>> +
> >>>>>> +title: Rockchip Power Domains
> >>>>>> +
> >>>>>> +maintainers:
> >>>>>> +  - Elaine Zhang <zhangqing@rock-chips.com>
> >>>>>> +  - Rob Herring <robh+dt@kernel.org>
> >>>>> Up to Rob, but I don't think Rob would like to be the maintainer. I=
 think you
> >>>>> can only include yourself and Heiko.
> >>>>>
> >>>>>
> >>>>>> +  - Heiko Stuebner <heiko@sntech.de>
> >>>>>> +
> >>>>>> +description: |
> >>>>>> +  Rockchip processors include support for multiple power domains =
which can be
> >>>>>> +  powered up/down by software based on different application scen=
arios to
> >>>>>> save power.
> >>>>>> +
> >>>>>> +  Power domains contained within power-controller node are generi=
c power domain
> >>>>>> +  providers documented in
> >>>>>> Documentation/devicetree/bindings/power/power-domain.yaml.
> >>>>>> +
> >>>>>> +  IP cores belonging to a power domain should contain a "power-do=
mains"
> >>>>>> +  property that is a phandle for the power domain node representi=
ng the domain.
> >>>>>> +
> >>>>>> +properties:
> >>>>>> +  $nodename:
> >>>>>> +    const: power-controller
> >>>>>> +
> >>>>>> +  compatible:
> >>>>>> +    enum:
> >>>>>> +      - rockchip,px30-power-controller
> >>>>>> +      - rockchip,rk3036-power-controller
> >>>>>> +      - rockchip,rk3066-power-controller
> >>>>>> +      - rockchip,rk3128-power-controller
> >>>>>> +      - rockchip,rk3188-power-controller
> >>>>>> +      - rockchip,rk3228-power-controller
> >>>>>> +      - rockchip,rk3288-power-controller
> >>>>>> +      - rockchip,rk3328-power-controller
> >>>>>> +      - rockchip,rk3366-power-controller
> >>>>>> +      - rockchip,rk3368-power-controller
> >>>>>> +      - rockchip,rk3399-power-controller
> >>>>>> +
> >>>>>> +  "#power-domain-cells":
> >>>>>> +    const: 1
> >>>>>> +
> >>>>>> +  "#address-cells":
> >>>>>> +    const: 1
> >>>>>> +
> >>>>>> +  "#size-cells":
> >>>>>> +    const: 0
> >>>>>> +
> >>>>>> +patternProperties:
> >>>>>> +  "^pd_[0-9a-z_]{2,10}@[0-9a-f]+$":
> >>>>>> +    type: object
> >>>>>> +    description: |
> >>>>>> +      Represents the power domains within the power controller no=
de as
> >>>>>> documented
> >>>>>> +      in Documentation/devicetree/bindings/power/power-domain.yam=
l.
> >>>>>> +
> >>>>> The node names must be generic, as this is power-domain must be in =
the form:
> >>>>>
> >>>>> +patternProperties:
> >>>>> +  "^power-domain@[0-9a-f]+$":
> >>>> In this way, dtbs_check cannot be passed, and all the usage methods =
in dts of
> >>>> Rockchip need to be corrected, which I think is a bigger change.
> >>> Well, the problem is in the Rockchip dtbs, so needs to be fixed there=
. The
> >>> bindings must describe hardware in a generic way, not describe the ac=
tual dtbs
> >>> to not report errors.
> >>>
> >> FWIW I remember I did something regarding this but never sent to upstr=
eam, feel
> >> free to pick if you find useful.
> >>
> >> *
> >> https://gitlab.collabora.com/eballetbo/linux/-/commit/12499f223e3d3360=
2449b9102404fe573fb804f5
> >> *
> >> https://gitlab.collabora.com/eballetbo/linux/-/commit/12499f223e3d3360=
2449b9102404fe573fb804f5
> >> *
> >> https://gitlab.collabora.com/eballetbo/linux/-/commit/492bf2213c341152=
a1c2423242c5634b9e53ff27
> > looks good that way. I did look at the power-domain driver and
> > we're (of course) not doing anything with the name in front of the @ :-=
) .
> >
> > So I'd be happy to get these.
> >
> > Heiko
>
> I still don't want to modify this,  I think the PD summary will become
> less intuitive.
>

This is because in the pm_domainss driver you have:

    pd->genpd.name =3D node->name;

You can use the full_name or add a meaningful name to the driver if
you want. We solved this on Mediatek with the following patches [1]

Again, IMO this is a driver problem, not a binding problem. The
bindings shouldn't know about debugfs entry names.

Thanks,
  Enric

[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=3D4385=
23

> Now:
>
> domain                          status          slaves
>      /device                                             runtime status
> ----------------------------------------------------------------------
> pd_pipe                         on
>      /devices/platform/3c0800000.pcie unsupported
>      /devices/platform/fc800000.sata                     active
>      /devices/platform/usbdrd/fcc00000.dwc3              active
>      /devices/platform/usbhost/fd000000.dwc3             active
> pd_rkvenc                       off-0
>      /devices/platform/fdf40f00.iommu                    suspended
>      /devices/platform/fdf40000.rkvenc                   suspended
> pd_rkvdec                       off-0
>      /devices/platform/fdf80800.iommu                    suspended
>      /devices/platform/fdf80200.rkvdec                   suspended
> pd_vpu                          off-0
>      /devices/platform/fdea0800.iommu                    suspended
>      /devices/platform/fdea0400.vdpu                     suspended
> pd_rga                          off-0
>      /devices/platform/fded0480.iommu                    suspended
>      /devices/platform/fdee0800.iommu                    suspended
>      /devices/platform/fdef0800.iommu                    suspended
>      /devices/platform/fdee0000.vepu                     suspended
>      /devices/platform/fdef0000.iep                      suspended
>      /devices/platform/fded0000.jpegd                    suspended
>      /devices/platform/fdeb0000.rk_rga                   suspended
> pd_vo                           on
>      /devices/platform/fe850000.mipi-dphy                suspended
>      /devices/platform/fe040000.vop                      active
>      /devices/platform/fe0c0000.edp                      suspended
>      /devices/platform/fe0a0000.hdmi                     active
>      /devices/platform/fe060000.dsi                      active
> pd_vi                           off-0
>      /devices/platform/fdff1a00.iommu                    suspended
>      /devices/platform/fdff0000.rkisp                    suspended
> pd_gpu                          on
>      /devices/platform/fde60000.gpu                      active
> pd_npu                          off-0
>
> If modify to power-domain@:
>
> domain                          status          slaves
>      /device                                             runtime status
> ----------------------------------------------------------------------
> power-domain                    on
>      /devices/platform/3c0800000.pcie unsupported
>      /devices/platform/fc800000.sata                     active
>      /devices/platform/usbdrd/fcc00000.dwc3              active
>      /devices/platform/usbhost/fd000000.dwc3             active
> power-domain                    off-0
>      /devices/platform/fdf40f00.iommu                    suspended
>      /devices/platform/fdf40000.rkvenc                   suspended
> power-domain                    off-0
>      /devices/platform/fdf80800.iommu                    suspended
>      /devices/platform/fdf80200.rkvdec                   suspended
> power-domain                    off-0
>      /devices/platform/fdea0800.iommu                    suspended
>      /devices/platform/fdea0400.vdpu                     suspended
> power-domain                    off-0
>      /devices/platform/fded0480.iommu                    suspended
>      /devices/platform/fdee0800.iommu                    suspended
>      /devices/platform/fdef0800.iommu                    suspended
>      /devices/platform/fdee0000.vepu                     suspended
>      /devices/platform/fdef0000.iep                      suspended
>      /devices/platform/fded0000.jpegd                    suspended
>      /devices/platform/fdeb0000.rk_rga                   suspended
> power-domain                    on
>      /devices/platform/fe850000.mipi-dphy                suspended
>      /devices/platform/fe040000.vop                      active
>      /devices/platform/fe0c0000.edp                      suspended
>      /devices/platform/fe0a0000.hdmi                     active
>      /devices/platform/fe060000.dsi                      active
> power-domain                    off-0
>      /devices/platform/fdff1a00.iommu                    suspended
>      /devices/platform/fdff0000.rkisp                    suspended
> power-domain                    on
>      /devices/platform/fde60000.gpu                      active
> power-domain                    off-0
> console:/ #
>
> I think the now one is more intuitive, so I don't want to fix it.
>
> >
> >
> >
> >
>
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
