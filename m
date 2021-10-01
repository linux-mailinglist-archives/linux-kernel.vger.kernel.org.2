Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA6241F227
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 18:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355011AbhJAQbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 12:31:38 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:43854 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbhJAQbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 12:31:37 -0400
Received: by mail-qt1-f177.google.com with SMTP id a13so9479345qtw.10;
        Fri, 01 Oct 2021 09:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ITh0BGr5DcDj7xCp1Z0IhOFPgiSIbzrRXYfEGa/wJE=;
        b=rqIG8jG4N6b8Wcl8k0rgAsJDDa/HOFsQ7pDmbW/TTsmx9wI+HY4COPFrrd+huq0rCP
         1NKTxX3lNQNt1WaLwU6uRfy9if2IRwqGSuVy5zkw66GmI30vAkZ99/WJS1FJHYuBClfB
         o7Fxt0ixqvG7qWV/M6gc6q0hXU7ugNktTdPE8O32wMZDsqYjb5P51RA6aNsXW925WnjX
         n1uALyaJ9NSMxeNBZaez2OzgjrwahZpWjdm3mQetO5r8WoKK5gg57QxoaJDRpK2bUV11
         y44vscoLcj+1EhqU8FR/YUH+zwEr/O8oOgRezxwiIBcN402/8TIJQXTFt+ZYJFfE/6cd
         76JA==
X-Gm-Message-State: AOAM5312Tcf6S7RvDU3oXuZn9KuhiqzTn8hZv3Mt0vEm+jsHsHFHisRx
        qBoY2ucP5hxNq8mASXA/e9wX1WraETY=
X-Google-Smtp-Source: ABdhPJz8zfCynKu++s7WY7ADfXWnXlsUNuCsvYiU30H3MXSS8dxd+I+rOk248/+cy2Ei9KTfzBl96A==
X-Received: by 2002:ac8:1e85:: with SMTP id c5mr4814437qtm.154.1633105792206;
        Fri, 01 Oct 2021 09:29:52 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id h68sm3373905qkf.126.2021.10.01.09.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 09:29:51 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id x9so9555221qtv.0;
        Fri, 01 Oct 2021 09:29:51 -0700 (PDT)
X-Received: by 2002:ac8:74c7:: with SMTP id j7mr6215018qtr.118.1633105791433;
 Fri, 01 Oct 2021 09:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211001000924.15421-1-leoyang.li@nxp.com> <20211001000924.15421-2-leoyang.li@nxp.com>
 <1633094217.843390.3666440.nullmailer@robh.at.kernel.org>
In-Reply-To: <1633094217.843390.3666440.nullmailer@robh.at.kernel.org>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 1 Oct 2021 11:29:39 -0500
X-Gmail-Original-Message-ID: <CADRPPNQBR63pS60nmfUQx02GbBoWEbgroU5Zw-iY62TodmB91Q@mail.gmail.com>
Message-ID: <CADRPPNQBR63pS60nmfUQx02GbBoWEbgroU5Zw-iY62TodmB91Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: memory: fsl: convert ifc binding to yaml schema
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 1, 2021 at 8:18 AM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, 30 Sep 2021 19:09:20 -0500, Li Yang wrote:
> > Convert the txt binding to yaml format and add description.  Drop the
> > "simple-bus" compatible string from the example and not allowed by the
> > binding any more.  This will help to enforce the correct probe order
> > between parent device and child devices, but will require the ifc driver
> > to probe the child devices to work properly.
> >
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > ---
> > updates from previous submission:
> > - Drop "simple-bus" from binding and only "fsl,ifc" as compatible
> > - Fix one identiation problem of "reg"
> > - Add type restriction to "little-endian" property
> >
> >  .../bindings/memory-controllers/fsl/ifc.txt   |  82 -----------
> >  .../bindings/memory-controllers/fsl/ifc.yaml  | 137 ++++++++++++++++++
> >  2 files changed, 137 insertions(+), 82 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
> >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/ifc.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/memory-controllers/fsl/ifc.example.dt.yaml:0:0: /example-0/soc/ifc@ffe1e000/flash@1,0: failed to match any schema with compatible: ['fsl,ifc-nand']
> Documentation/devicetree/bindings/memory-controllers/fsl/ifc.example.dt.yaml:0:0: /example-0/soc/ifc@ffe1e000/cpld@3,0: failed to match any schema with compatible: ['fsl,p1010rdb-cpld']

These are defined in other bindings, but unfortunately they are not
converted to yaml format yet.

>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/patch/1535102
>
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.
>
