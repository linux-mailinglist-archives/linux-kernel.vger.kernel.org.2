Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F8A3CBE71
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 23:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbhGPV0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 17:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbhGPV0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 17:26:44 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C141C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 14:23:48 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id u14so5831799vsc.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 14:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=exlmnJXiaTJauhA+4vQfrj8cChgj2fjYs+wG+RJzlOQ=;
        b=PZMirsg+Wv7zn2IF4OI8mEOCXwDZpf0/STJYZT9OeZVCoxn32jPSwuNP7JY9zaOedz
         6+En2pXffn4xI8hdXJTDyaZJ0qRpoN8oUh0/aYtvPSTlS0ljqyo4UWJseHX7k2kSpS58
         A1vX6pFWxOZI10wytONsKpneL2hzVTU95rVnjfUdEO5UwcdbG1S7iUmi7dUCIFs7LP3v
         qLss0AXbY6brXMZu17o16SCofYCgmxoHt98F3C+KTvsIQp4rjWSXg2sYcH8y4vIs20B1
         upzGyMVYv4pdM5zS/MyIILAfoxXxtiJ0Vplb+OMxmwpkpuaBFM3y84BvnBh7gSRcoKra
         UsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=exlmnJXiaTJauhA+4vQfrj8cChgj2fjYs+wG+RJzlOQ=;
        b=d4BAlWdge2W8iupHdqdz2rdiQ1q8WsNUsnk96tL5ki8NmC/HRoeXjxDGXXsbd7YQIn
         XXOEHK6Mgiuv+1UJRMY4HKJaeFBHNBn1xq+x5MS2NaOIvWkcSsmzOOTi33cTrEgTZE0K
         vNtf284P7hnlYyAiWToir25X/CAuY7iG/jUQ+xr/KbHNaUvo0ZN8rK64/veaVHZiZ1UV
         Ue+5P548vhFLxex3D70d6g2QxI4LfeB6P5yVaaJqe+QnlhSv+ZVSfngAfBUjKsfUGO0n
         5ScJ3Uma6x1m5sChEmW3TQTewEONYx7/Vd7Rfdq1Jm448QNXecila+n+c1cOa082d3Pe
         hiQQ==
X-Gm-Message-State: AOAM533Rsacs+3kiZZXlgjiQ4rfsGnSvlDSjDeEi71GvdMAbJu/Uugww
        iOlPQNiHdvM33PBtVd9f1CGlkYQo3d71oObw5/1k
X-Google-Smtp-Source: ABdhPJyFJUjeQ2Rj6BUxU30JYEklw9PY84ubr6QK2gM3jJ/YcsPNZk09CHDFvghlYh8J7J73FY80A2H5x/LDWyIciiQ=
X-Received: by 2002:a05:6102:30a3:: with SMTP id y3mr14840293vsd.33.1626470627770;
 Fri, 16 Jul 2021 14:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210715100236.228531-1-iwamatsu@nigauri.org> <f78e471c-8f08-4ef6-667b-1c8484baf60a@redhat.com>
In-Reply-To: <f78e471c-8f08-4ef6-667b-1c8484baf60a@redhat.com>
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date:   Sat, 17 Jul 2021 06:23:21 +0900
Message-ID: <CABMQnVJiDPCWQZ6roetZcc74yXZ5hu9+7NzhF5z11ehyCnAa+g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: fpga: convert Xilinx Zynq MPSoC bindings to YAML
To:     Tom Rix <trix@redhat.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>, mdf@kernel.org,
        devicetree@vger.kernel.org,
        linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your review.

2021=E5=B9=B47=E6=9C=8815=E6=97=A5(=E6=9C=A8) 22:18 Tom Rix <trix@redhat.co=
m>:
>
>
> On 7/15/21 3:02 AM, Nobuhiro Iwamatsu wrote:
> > Convert FPGA Manager for Xilinx Zynq MPSoC bindings documentation to
> > YAML.
> >
> > Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> > ---
> >   .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   | 25 -------------
> >   .../bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml  | 36 ++++++++++++++++++=
+
> >   2 files changed, 36 insertions(+), 25 deletions(-)
> >   delete mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp=
-pcap-fpga.txt
> >   create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp=
-pcap-fpga.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fp=
ga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> > deleted file mode 100644
> > index 3052bf619dd547..00000000000000
> > --- a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> > +++ /dev/null
> > @@ -1,25 +0,0 @@
> > -Devicetree bindings for Zynq Ultrascale MPSoC FPGA Manager.
> > -The ZynqMP SoC uses the PCAP (Processor configuration Port) to configu=
re the
> > -Programmable Logic (PL). The configuration uses  the firmware interfac=
e.
> > -
> > -Required properties:
> > -- compatible: should contain "xlnx,zynqmp-pcap-fpga"
> > -
> > -Example for full FPGA configuration:
> > -
> > -     fpga-region0 {
> > -             compatible =3D "fpga-region";
> > -             fpga-mgr =3D <&zynqmp_pcap>;
> > -             #address-cells =3D <0x1>;
> > -             #size-cells =3D <0x1>;
> > -     };
> > -
> > -     firmware {
> > -             zynqmp_firmware: zynqmp-firmware {
> > -                     compatible =3D "xlnx,zynqmp-firmware";
> > -                     method =3D "smc";
> > -                     zynqmp_pcap: pcap {
> > -                             compatible =3D "xlnx,zynqmp-pcap-fpga";
> > -                     };
> > -             };
> > -     };
> > diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fp=
ga.yaml b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml
> > new file mode 100644
> > index 00000000000000..565b835b7fbac0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml
> > @@ -0,0 +1,36 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/fpga/xlnx,zynqmp-pcap-fpga.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Xilinx Zynq Ultrascale MPSoC FPGA Manager Device Tree Bindings
> > +
> > +maintainers:
> > +  - Michal Simek <michal.simek@xilinx.com>
> Needs a change to MAINTAINERS ?

My bad. I will change to correct maintainer.
> > +
> > +description: |
> > +  Device Tree Bindings for Zynq Ultrascale MPSoC FPGA Manager.
> > +  The ZynqMP SoC uses the PCAP (Processor configuration Port) to
>
> Configuration

I will update v2.

Best regards,
  Nobuhiro


--=20
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
