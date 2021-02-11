Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C40319602
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 23:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhBKWr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 17:47:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:44656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229903AbhBKWru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 17:47:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5DD864E4B;
        Thu, 11 Feb 2021 22:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613083630;
        bh=ksI7x+CFHJSMWyftjpURxC87NwW7uxJrVV7hwvTi/WU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JAc42ynMvOjdRi8uxYEX3CMxlMCEw+e5PRVj+/w+GfiJcwT1Tjnjk9rnpvrEMldeX
         snqOgJ6MWXw3+L4DCihgsBE5TZuYBQx9eVLIzBzBhTXE3oy+tinhI2rv/xUe+mXklL
         AdgKvd6ugsfooOQEUZkh7phiG1UynUotYXKaCenSQEbrgnB3rA3F/vP12o1nCzIOmp
         F2gO4dFoVEzwnf39kH9UJLxT8AgFNhRGBv9h391lXDFW7AXPpFBWLnoHoTldx5cbSF
         mi2zgOlZOxlMUIIyVQxq/VRKoCZHyiKr8ZUeqJTetPzTFigyGE0BTbpA1efwpVT6UZ
         vNJtAa7j1QsRQ==
Received: by mail-ej1-f50.google.com with SMTP id sa23so12616597ejb.0;
        Thu, 11 Feb 2021 14:47:09 -0800 (PST)
X-Gm-Message-State: AOAM532N6ShNxQ2+x2Ch8OMY2+2XxBPM0gyT6MwgE+JyTXxokiDtvKDb
        HL/svyG1CCTYyEKIRHSy9f9WtSbj7EpE+EH5cw==
X-Google-Smtp-Source: ABdhPJx8frNq1hOIUUTp4W0tz6HdiEqWhVCjFLmewCa0h36/gkIU+r+6ht8N+8b/IGr+JJVYwzALpuc0/hY1xnX0mo8=
X-Received: by 2002:a17:906:af41:: with SMTP id ly1mr10307309ejb.525.1613083628399;
 Thu, 11 Feb 2021 14:47:08 -0800 (PST)
MIME-Version: 1.0
References: <20210210171040.684659-1-mka@chromium.org> <20210210091015.v5.3.I7a3a7d9d2126c34079b1cab87aa0b2ec3030f9b7@changeid>
 <20210210210645.xapaua7djdsvr3ca@kozik-lap> <YCRcIuCxB8nYi7/e@google.com>
 <161307087919.1254594.11784819060723374369@swboyd.mtv.corp.google.com>
 <YCWVU7YCE+WzRx9v@google.com> <161307633188.1254594.14761449293146776857@swboyd.mtv.corp.google.com>
In-Reply-To: <161307633188.1254594.14761449293146776857@swboyd.mtv.corp.google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 11 Feb 2021 16:46:56 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJR5DUiDJ-fkrGbM0M2Lm5S4xQH2dhV9oi9UMhBuiVVrA@mail.gmail.com>
Message-ID: <CAL_JsqJR5DUiDJ-fkrGbM0M2Lm5S4xQH2dhV9oi9UMhBuiVVrA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] usb: host: xhci-plat: Create platform device for
 onboard hubs in probe()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Bastien Nocera <hadess@hadess.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 2:45 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Matthias Kaehlcke (2021-02-11 12:36:35)
> > Hi Stephen,
> >
> > On Thu, Feb 11, 2021 at 11:14:39AM -0800, Stephen Boyd wrote:
> > >
> > > Is it possible to use the graph binding to connect the USB controller=
 on
> > > the SoC to the port on the hub? Then the hub would be a standalone no=
de
> > > at the root of DT connected to the USB controller (or phy) and xhci c=
ode
> > > could probe the firmware to see if there's a graph connection downstr=
eam
> > > that is a powered hub like this. I didn't see this idea mentioned in =
the
> > > previous discussions, but maybe I missed it.
> >
> > Thanks for bringing this up. I'm not sure I completely understand your
> > suggestion, but in general it seems a direction that could be worth
> > exploring.
>
> Cool.
>
> >
> > I think something like the following should work even without requiring
> > cooperation from the XHCI code:
> >
> > onboard-usb-hub {
> >     compatible =3D =E2=80=9Crealtek,rts5411=E2=80=9D, =E2=80=9Conboard_=
usb_hub=E2=80=9D;
> >     #address-cells =3D <1>;
> >     #size-cells =3D <0>;
> >
> >     vdd-supply =3D <&pp3300_hub>;
> >
> >     port@0 {
> >         reg =3D <0>;
> >
> >         rts5411_3_0: endpoint {
> >             // should not be needed
> >             remote-endpoint =3D <&usb_1_dwc3_port1>;
> >         };
> >     };
> >
> >     port@1 {
> >         reg =3D <1>;
> >
> >         rts5411_2_0: endpoint {
> >             // should not be needed
> >             remote-endpoint =3D <&usb_1_dwc3_port2>;
> >         };
> >     };
> > };
> >
> > &usb_1_dwc3 {
> >     dr_mode =3D "host";
> >     #address-cells =3D <1>;
> >     #size-cells =3D <0>;
> >
> >     port@1 {
> >         reg =3D <1>;
> >
> >         usb_1_dwc3_port1: endpoint {
> >             remote-endpoint =3D <&rts5411_3_0>;
> >         };
> >     };
> >
> >     port@2 {
> >         reg =3D <2>;
> >
> >         usb_1_dwc3_port2: endpoint {
> >             remote-endpoint =3D <&rts5411_2_0>;
> >         };
> >     };
> > };
> >
> > That looks like an actual description of the hardware, without multiple=
 DT
> > nodes for the hub.
> >
> > The USB part of the onboard_hub driver could determine the platform dev=
ice
> > from the remote endpoint and register the USB device with it.
>
> Yeah you got it, this is what I'm suggesting. I'd like to go even
> further and also describe the ports on "the other side" or "downstream
> facing side" of the USB hub that go to things like type-c ports or
> type-a ports. This would allow us to describe the USB topology and how
> it is physically connected to ports on the device that humans see. But
> that's mostly a job for the type-c subsystem, so it's a parallel
> discussion that's only related because of the graph binding.

I'd like to see a complete case that includes connectors. I really
need someone to worry about USB bindings with a view on the big
picture. The piecemeal additions don't result in the best design.

Rob
