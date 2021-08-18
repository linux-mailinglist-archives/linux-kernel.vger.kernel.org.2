Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9117F3F067C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 16:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbhHROWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 10:22:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239573AbhHROV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:21:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59003610C7;
        Wed, 18 Aug 2021 14:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629296451;
        bh=3VS49PGFx4ovf7scM6iEYT6DejL6yh/QZoZo2qPj/q8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QJ73Eui4czENjaz6g7tVNraMOzz+ewMq2xoRXjlcV5PicbPKNO3nq3+g2ebGjcm/O
         yMQAylbBGQG8TS7yePMvPNWtqZI4IH9OYEccnPDIjejhobznoEVLtOpw1FZIOebruh
         ZAe7Cxrzy3h/VuTil2W8I9NXUcQrczN6zhlg52/SUx0reJO4bRxuU56Xj+W0ECPNhb
         An/horOkpo2q9zpfUjt4VWb6QfHqjjIyAHI3VRTAMPdZW1p4ShdKT1fukO3LtTVxwm
         fmmhdGTm3dPCHYg6/5+HRWdSRBeDLyAuGDrnzSZ5SZJiFKCvtLDGZfJXrdpmd6+b+X
         ja4ItdpTNzQpQ==
Received: by mail-ej1-f48.google.com with SMTP id z20so5404816ejf.5;
        Wed, 18 Aug 2021 07:20:51 -0700 (PDT)
X-Gm-Message-State: AOAM530lK8VMSK60nl2zDZzYW4gSnoS5ftP6sppTz9bancQl43eO3OWJ
        qpGi/KWkgkNZBb66PMyJJ38c0/Yu5rzRcb/kiA==
X-Google-Smtp-Source: ABdhPJxNH/3NPVuu5JiFruQ2uSA2icEz290Z3VRMLhmiLOVcWxKi46n4hLgcFPmUOoiY1+Arx9MBFmAPSQHUvawgGpU=
X-Received: by 2002:a17:906:fa92:: with SMTP id lt18mr10107051ejb.359.1629296448282;
 Wed, 18 Aug 2021 07:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <1627635002-24521-1-git-send-email-chunfeng.yun@mediatek.com>
 <1627635002-24521-3-git-send-email-chunfeng.yun@mediatek.com>
 <YQ2e6AGFi7beqp6Q@robh.at.kernel.org> <cd1662f5f47fe7539d2c01bd280ad8b9d9d25b3e.camel@mediatek.com>
In-Reply-To: <cd1662f5f47fe7539d2c01bd280ad8b9d9d25b3e.camel@mediatek.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 18 Aug 2021 09:20:37 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKjjPqArmhoXuYrk+1C-vXFSKNA_gxtOfLFsGTGBq20aQ@mail.gmail.com>
Message-ID: <CAL_JsqKjjPqArmhoXuYrk+1C-vXFSKNA_gxtOfLFsGTGBq20aQ@mail.gmail.com>
Subject: Re: [PATCH 03/11] dt-bindings: usb: mtk-xhci: add compatible for mt8195
To:     =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
Cc:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        =?UTF-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 3:02 AM Chunfeng Yun (=E4=BA=91=E6=98=A5=E5=B3=B0)
<Chunfeng.Yun@mediatek.com> wrote:
>
> On Fri, 2021-08-06 at 14:43 -0600, Rob Herring wrote:
> > On Fri, Jul 30, 2021 at 04:49:54PM +0800, Chunfeng Yun wrote:
> > > There are 4 USB controllers on MT8195, the controllers (IP1~IP3,
> > > exclude IP0) have a wrong default SOF/ITP interval which is
> > > calculated from the frame counter clock 24Mhz by default, but
> > > in fact, the frame counter clock is 48Mhz, so we should set
> > > the accurate interval according to 48Mhz. Here add a new compatible
> > > for MT8195, it's also supported in driver. But the first controller
> > > (IP0) has no such issue, we prefer to use generic compatible,
> > > e.g. mt8192's compatible.
> >
> > That only works until you find some 8195 bug common to all
> > instances.
> It's also OK for IP0 to use mt8195's compatible, these setting value is
> the same as IP0's default value, use mt8192's may avoid these dummy
> setting.

I still don't understand. By use mt8192's compatible, that means you
have for IP0:

compatible =3D "mediatek,mt8192-xhci", "mediatek,mtk-xhci";

And for the rest:
compatible =3D "mediatek,mt8195-xhci", "mediatek,mtk-xhci";

If there's a 8195 quirk you need to work around, then you can't on
IP0. You need to be able to address quirks in the future without
changing the DTB. That is why we require SoC specific compatibles even
when IP blocks are 'the same'.

Rob
