Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D954453FB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 14:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhKDNjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 09:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhKDNjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 09:39:01 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB83C061203
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 06:36:23 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d3so8648878wrh.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 06:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tx/2C+t7VpEwCOvH7sOHu7Q1i56sP9nBdHDwvw2KuU0=;
        b=AIefXI8QkD1pMYpz+9ixV4beAj5Gz/aQCd5UevbTonBjIOFj9XObVB0/Fn1QZALyAL
         J687q6oIQvrxGBP0GNLfVUGjl0DRtLP1GG4CY/DcVhpCJzmE1F4ofBTYKM1yXd08Dn4o
         0yTmgnXMvINIOwYudNLxRQNrFGWdpZXIWm0pU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tx/2C+t7VpEwCOvH7sOHu7Q1i56sP9nBdHDwvw2KuU0=;
        b=S4vuBu4/l0x/J4ZBsC0skC08Xpe6WWlISpjL9cqSoBXf+6i7zaMWLV5FWAwgCu7sip
         zaLQW9RwnYLuyNgsL/uSxGk1cHhJmH2MjQdSTt85y0GEUlDpzGLUVjYLQ5IQUE3MZ2my
         Eh+nKEy11Ps7IAgtMaLlxoyHGe0fnwA8mOR1nEkSC8IecHKIrA4DAWi4NUskcvq/hwcS
         lVGQbPywUY+CIeZJEBfjPPG/qO1zVdluRSn5ZlZ1v5rie7veFmMoP4N+sIF55GaSWIIg
         FRMw10OZf5fa5bKZ6T1ACeBjeCsmvT6F+WqhvO5qlANJ/A73r7Y3A3pC/LrGVjaFNRO8
         hLgQ==
X-Gm-Message-State: AOAM533h1sc7Xoxdk0uwpuodSblxHtgPpkK+Y9ICtuYHRMLfkSdmY4kC
        BcBVDcwr5OnxnETYcbef8Mh6f2Wvl733TqujxEX2pA==
X-Google-Smtp-Source: ABdhPJy5jblvNQtdFBm739j5npNWs4ldml60zPSTdTQr1KxFWIm0AWtKwv4+Ouij135un3jAYZUsXVb4N+KWaYwJGeo=
X-Received: by 2002:adf:f990:: with SMTP id f16mr57641954wrr.128.1636032982277;
 Thu, 04 Nov 2021 06:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211103184939.45263-1-jim2101024@gmail.com> <20211103184939.45263-5-jim2101024@gmail.com>
 <20211103233026.trzas3cwrb26mqb3@pali>
In-Reply-To: <20211103233026.trzas3cwrb26mqb3@pali>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Thu, 4 Nov 2021 09:36:11 -0400
Message-ID: <CA+-6iNxdx=Yf3msfp1g_2-4sQVjJDWcB3bbHhjC=LMxiXs+Uvw@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] PCI: pci_alloc_child_bus() return NULL if
 ->add_bus() returns -ENOLINK
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 7:30 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Wednesday 03 November 2021 14:49:34 Jim Quinlan wrote:
> > Currently, if the call to the pci_ops add_bus() method returns an error=
, a
> > WARNING and dev_err() occurs.  We keep this behavior for all errors exc=
ept
> > -ENOLINK; for -ENOLINK we want to skip the WARNING and immediately retu=
rn
> > NULL.  The argument for this case is that one does not want to continue
> > enumerating if pcie-link has not been established.  The real reason is =
that
> > without doing this the pcie-brcmstb.c driver panics when the dev/id is
> > read, as this controller panics on such accesses rather than returning
> > 0xffffffff.
>
> I think that this is something which should be fixed in the driver, not
> in the pci core code. Check in driver code that you can touch HW and if
> not return fabricated value 0xffffffff.
Yes --  I don't have control of the config-space data but I do have control
of the address, and I can hijack the address so that it points to an access=
ible
register that holds 0xffffffff.

>
> > It appears that there are only a few uses of the pci_ops add_bus() meth=
od
> > in the kernel and none of them currently return -ENOLINK so it should b=
e
> > safe to do this.
> >
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > ---
> >  drivers/pci/probe.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index d9fc02a71baa..fdc3f42634b7 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1122,6 +1122,9 @@ static struct pci_bus *pci_alloc_child_bus(struct=
 pci_bus *parent,
> >
> >       if (child->ops->add_bus) {
> >               ret =3D child->ops->add_bus(child);
> > +             /* Don't return the child if w/o pcie link-up */
> > +             if (ret =3D=3D -ENOLINK)
>
> In my opinion ENOLINK is not the correct errno code for signaling
> "no link-up" error. IIRC ENOLINK was defined for file/inode links. For
> network connections there is ENETDOWN errno code which is more similar
> to "no link-up" than inode link.
>
> Anyway, I still do not think if it is a good idea to have this check in
> core pci code.
This commit is no longer needed per your suggestion of having the host-brid=
ge
driver force a return of 0xffffffff.

Thanks,
Jim

>
> (This is just my opinion... wait for Bjorn with maintainer's hat what
> will say that is the best way to handle above issue)
>
> > +                     return NULL;
> >               if (WARN_ON(ret < 0))
> >                       dev_err(&child->dev, "failed to add bus: %d\n", r=
et);
> >       }
> > --
> > 2.17.1
> >
