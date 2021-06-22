Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783843AFF71
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 10:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhFVIoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 04:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhFVIoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 04:44:13 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D825C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 01:41:57 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m3so12232077wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 01:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XA1+Rp5LATzXW9X3kNyiTeCwcY/WbQj5ki86deqlRUU=;
        b=sye6DyVz9MMCkgM9C3JDj8Y0rVLYcm0XFgOqxYtiFqjc0BWAP68Nw1Ylqdc9NUyYee
         sZXg1PYVnjy5I+wWdRUXEpdzFjOxlwZgj2WyykKs7elysMO6C+3JUpwfiTCIQLrB9Eet
         FjEnoZjoTbDeVAQr90p8EgEn6M80nF8C5dk/xrqA4fpnO76UQfMNRN2PGpqSX0tqdloG
         obFLjnP/UYZJ4ot5zDO1/PX6gCNCH+lA0eqkXpGwo/6v+yprO4aMEGGwwgRy668Heclh
         xxFLKLBe5xUKAzE9xKZtuGjwjQUASGc5TFa5s+jqI/7ikvjmxVl8yJOromKXOhXe6mSF
         ruBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XA1+Rp5LATzXW9X3kNyiTeCwcY/WbQj5ki86deqlRUU=;
        b=BSqGi4BA6Mqn/99WGnQgfG6RaWYPkP8iv6Gkz+mqjJC143cHKqpwgeXEjR5c1D7dqw
         eEeNvvrxOdXiq0P+jqgPTDYf/COjcdmWe2MWAvx2df/uWd7THTGFQXCManf2Hs3nUk2E
         vSTF+t8KDTLRBYhiebSKk6s/wdBX4rEFpfqzx2WgfVcAnou11uNCzmCFIESyLQDNj3xe
         BgGEc+WyaiYigzT+KH6lkYlRch2Kg97A6Ko0yheF9Ei5yclRd/oBuKu/LXSVoYBRuVyM
         9FAb8CYhuDNLPU44+zyFO4XfclnTPnHE1Fw087E8xQaMgSbcpzeocJpKCadzYsmKF7d0
         tiNg==
X-Gm-Message-State: AOAM533+zD5H9kPmq9bePhtIk2rIBM1+W+AyntkEf28Sum0hPVzbIirV
        Tmlxzgo4pnzDOhhHNfuNLOa+wPTNJl/+26ZmphtNWQ==
X-Google-Smtp-Source: ABdhPJxyCBE2yf8JDZ6qOcKTBwdJou1Exjeh1KfsRwQRi8kJtfXDva4rXzVv5tE/owN4PIcSyHguZ6uWW6Xf0QPDVs0=
X-Received: by 2002:a1c:7219:: with SMTP id n25mr3008537wmc.3.1624351315897;
 Tue, 22 Jun 2021 01:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210616103649.2662395-1-jens.wiklander@linaro.org>
 <20210616103649.2662395-4-jens.wiklander@linaro.org> <20210616160557.GB3472903@robh.at.kernel.org>
In-Reply-To: <20210616160557.GB3472903@robh.at.kernel.org>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 22 Jun 2021 10:41:45 +0200
Message-ID: <CAHUa44ELTefa32oa3Zq+gFG+G1hfjMyMY9sf_fDPFmphf9-APw@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] dt-bindings: arm: optee: add interrupt property
To:     Rob Herring <robh@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jerome Forissier <jerome@forissier.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 6:06 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jun 16, 2021 at 12:36:45PM +0200, Jens Wiklander wrote:
> > Adds an optional interrupt property to the optee binding.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  .../devicetree/bindings/arm/firmware/linaro,optee-tz.yaml | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > index c931b030057f..3efbe11b637d 100644
> > --- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > +++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > @@ -24,6 +24,9 @@ properties:
> >              for the reference implementation maintained by Linaro.
> >            const: linaro,optee-tz
> >
> > +  interrupts:
> > +    maxItems: 1
> > +
> >    method:
> >      description: The method of calling the OP-TEE Trusted OS.
> >      $ref: /schemas/types.yaml#/definitions/string-array
> > @@ -37,6 +40,10 @@ properties:
> >            in drivers/tee/optee/optee_smc.h
> >          const: hvc
> >
> > +required:
> > +  - compatible
> > +  - method
> > +
>
> This should go in the first patch.

OK, that will be covered when I rebase the next patch set on what's
now be78329717e4 ("dt-bindings: arm: firmware: Convert linaro,optee-tz
to json schema") in linux-next.

Thanks,
Jens

>
> >  additionalProperties: false
> >
> >  examples:
> > @@ -45,5 +52,6 @@ examples:
> >        optee {
> >          compatible = "linaro,optee-tz";
> >          method = "smc";
> > +        interrupts = <0 187 4>;
> >        };
> >      };
> > --
> > 2.31.1
