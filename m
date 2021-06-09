Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17EC3A1DCB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 21:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhFITig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 15:38:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhFITif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 15:38:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3AE76139A;
        Wed,  9 Jun 2021 19:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623267400;
        bh=X5BBnmOIxZn8P1yRC4oksYkdkEDawoP4AuyY71hEDd4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WXGx5uuAJOpUBhJlE/ivrDiVSqhgqT+IwVW1K8dsBY9BegGDZz+SZGy3BD5+BGSYq
         vJstnn71bT0oVWdNBiiS9bXKuRGHYzhG4z4MLL3BoGiXXAtdLueBa3THeuP7XR8Enr
         Dk+r5+ykHjNyEvIigxkGg+zdu0owAlA5E+lJ7UQVsxxbIjo7M7U7iUTLW940dtxSsb
         MbOsTc9BSNm5GeIwN1kMZW8N1YEcoKHSou85jeNja1AKprPW2vV5UsXSCne77l/NF7
         YZ3ysr4NldFp66MIv8PJpjfenALcaX4SmkLvrDW2s74GQsetbqfoT9LQmqDzc6mGFz
         vPUVjo+R7W6Ow==
Received: by mail-ed1-f44.google.com with SMTP id dj8so29872488edb.6;
        Wed, 09 Jun 2021 12:36:40 -0700 (PDT)
X-Gm-Message-State: AOAM531m2hyFb2Q4BHUbJUc4WheLD8fBy6DIXvBHnY/EW4BsRp/7T3CA
        oaaP9m8Ucv3FlsbhfhoyRzqV7AQpCFbNvmztFg==
X-Google-Smtp-Source: ABdhPJzgNI2+5vEERakKrzf95MkI2PUaocE5cKoGnU8i9q8tWEHPlwI5flHI9jk/IHPLd/GIYm3Kvs8mL1aNefrwNnA=
X-Received: by 2002:a05:6402:31eb:: with SMTP id dy11mr976983edb.165.1623267399325;
 Wed, 09 Jun 2021 12:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210609080112.1753221-1-miquel.raynal@bootlin.com>
 <20210609080112.1753221-18-miquel.raynal@bootlin.com> <1623255403.668043.3763305.nullmailer@robh.at.kernel.org>
In-Reply-To: <1623255403.668043.3763305.nullmailer@robh.at.kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 9 Jun 2021 14:36:28 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJT6Wks=ChNis06fhYqpKfxoApr6g1u9cAZLOnHevLnQw@mail.gmail.com>
Message-ID: <CAL_JsqJT6Wks=ChNis06fhYqpKfxoApr6g1u9cAZLOnHevLnQw@mail.gmail.com>
Subject: Re: [PATCH v22 17/18] dt-bindings: mtd: pl353-nand: Describe this
 hardware controller
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Amit Kumar Mahapatra <akumarma@xilinx.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Helmut Grohne <helmut.grohne@intenta.de>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>,
        Richard Weinberger <richard@nod.at>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Srinivas Goud <sgoud@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michal Simek <monstr@monstr.eu>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 9, 2021 at 11:16 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, 09 Jun 2021 10:01:11 +0200, Miquel Raynal wrote:
> > Add a yaml description of this NAND controller which is described as a
> > subnode of the SMC bus.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  .../bindings/mtd/arm,pl353-nand-r2p1.yaml     | 57 +++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.example.dt.yaml:0:0: /example-0/memory-controller@e000e000: failed to match any schema with compatible: ['arm,pl353-smc-r2p1', 'arm,primecell']

Ignore these errors.

Rob
