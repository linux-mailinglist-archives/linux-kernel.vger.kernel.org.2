Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BFB3A698D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbhFNPGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbhFNPGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:06:32 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E30CC061574;
        Mon, 14 Jun 2021 08:04:15 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id r14so20505536ljd.10;
        Mon, 14 Jun 2021 08:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=amLIRuKnX8etVBSiINMJCmDXT6ZlQpwL3htcwT0iYfw=;
        b=HqNjQ+tMbZJq5JAwtGeHbUE3rr52qEq/eM/9wyt39c/Oi45aL+/qQ2BV6XglFCeAOc
         41sv5B+PJ0ZvQqdOdZP4byrqsI61Po7CIz47VUnyMyU8f9aaun2VfrB6Zj4hb2UHkOkH
         +NwNTv0CqYoPnkVLpgXYaZxxdY511dBFMGhgqg/+nuKquX3QOn0tkiFqBVi+nij+5OxU
         lCgmvm62M1hfH8K5PmifI8NxKoM9qPEZDPfNJEpRS2TNwCteVvE5klB4WTKVf3nzI8Y2
         B3rgFvtNw6PAlN4lGELO6SMEFwfaITgmfDaNMd2zFwAuEtVOPLVJBEpWklxyL4LTxZzM
         BKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=amLIRuKnX8etVBSiINMJCmDXT6ZlQpwL3htcwT0iYfw=;
        b=mETNk4H5RC9htRIxfCK/RX5ckr6jY8n0EqgBg4jszzQKj7O4kzlKzJg9H6Gp+rQ222
         k201r403sf8j2nZfwBKoknHliFWbaWu7YHrf3+ghLRJ9snihvpY3gbeazHD2WjlSpUNg
         R0teNpH1OfzpqlCL6ghU8Hk871fKvpLtfIid3INrnRw9pgDL94Ss+c3VzkUh9VP2EZS8
         HbxIbaoicxsWTR1kCwM3kAecO+d7UtNwpfZJrhppOPnXD5546K1xN59PHJaM83ksesy7
         7heCE8tuBupdiywDCWgkTWv8R9KR1IMbRIi7oA9XC/xzidB7ZND6gLagPNl7Eup5jSEc
         zPxg==
X-Gm-Message-State: AOAM530tnZgR9pXGTRk+MlA0h87BRC5heTnaysoIP7FCzZZ1Xn5G7Av0
        Rl4AkLZuCnIGQzrEHjq9urW4luEDlRWw7GR3pOg=
X-Google-Smtp-Source: ABdhPJxHddSXn7MQEp2UzCg15YgRi/rclsfAe5DXKS289hueqMrow1G88LUOOdzToY/PLKHRHzJnJCnx8KUSm8YacgE=
X-Received: by 2002:a2e:2f03:: with SMTP id v3mr13547128ljv.168.1623683053157;
 Mon, 14 Jun 2021 08:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <1622616875-22740-1-git-send-email-u0084500@gmail.com> <20210611201643.GA1583875@robh.at.kernel.org>
In-Reply-To: <20210611201643.GA1583875@robh.at.kernel.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Mon, 14 Jun 2021 23:04:01 +0800
Message-ID: <CADiBU39Prz99ZLtkYdcM9XDQsd0nKKeiEGjW3wq=u75JGjwX=g@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: mt6360: Add optional mediatek.power-off-sequence
 in bindings document
To:     Rob Herring <robh@kernel.org>
Cc:     lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>,
        matthias.bgg@gmail.com, gene_chen@richtek.com,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, cy_huang <cy_huang@richtek.com>,
        gene.chen.richtek@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rob:

Rob Herring <robh@kernel.org> =E6=96=BC 2021=E5=B9=B46=E6=9C=8812=E6=97=A5 =
=E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=884:16=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Jun 02, 2021 at 02:54:34PM +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add optional mediatek.power-off-sequence in bindings document.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> > Hi,
> >
> > Originally, we think it must write in platform dependent code like as b=
ootloader.
> > But after the evaluation, it must write only when system normal HALT or=
 POWER_OFF.
> > For the other cases, just follow HW immediate off by default.
>
> Wouldn't this be handled by PSCI implementation?
No, the current application default on powers buck1/buck2/ldo7/ldo6
are for Dram power.
It's not the soc core power. It seems not appropriate  to implement
like as PSCI.
MT6360 play the role for the subpmic in the SOC application reference desig=
n.
>
> > ---
> >  .../devicetree/bindings/regulator/mt6360-regulator.yaml       | 11 +++=
++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/regulator/mt6360-regulat=
or.yaml b/Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml
> > index a462d99..eaf36e2 100644
> > --- a/Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml
> > +++ b/Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml
> > @@ -24,6 +24,16 @@ properties:
> >    LDO_VIN3-supply:
> >      description: Input supply phandle(s) for LDO6/7
> >
> > +  mediatek,power-off-sequence:
> > +    description: |
> > +      Power off sequence time selection for BUCK1/BUCK2/LDO7/LDO6, res=
petively.
> > +      Cause these regulators are all default-on power. Each value from=
 0 to 63,
> > +      and step is 1. Each step means 2 millisecond delay.
> > +      Therefore, the power off sequence delay time range is from 0ms t=
o 126ms.
> > +    $ref: "/schemas/types.yaml#/definitions/uint8-array"
> > +    minItems: 4
> > +    maxItems: 4
>
> So this is the delay between BUCK1 and BUCK2, then BUCK2 to LDO7, etcc?
No. you may misunderstand. there's an external 'Enable' pin that's
connected to the main pmic.
The starting point of delay time are all from  the external 'Enable' H to L=
.
Not one-by-one delay time,
> If we wanted to express this in DT, we'd made this generic which would
> need to be more flexible. A poweroff delay in each regulator (similar to
> the existing power on delay) would be sufficient for what you need I
> think.
Power on sequence already defined by the part number, It's not decided by S=
W.
So for the flexibility, I implement it in DT.

Duel to there're many part number MT6360 P/UP/LP, etc.
The difference are the power on sequence.

Do you have any suggestion about this situation?

PS: Due to DRAM power usage , sometimes it also need to customized by
the DRAM that customer choosed.
It may differ from external DRAM part choosen following by JEDEC spec.
>
> Rob
