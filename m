Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23914367554
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 00:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240158AbhDUWth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 18:49:37 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:40677 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbhDUWtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 18:49:35 -0400
Received: by mail-ot1-f43.google.com with SMTP id g4-20020a9d6b040000b029029debbbb3ecso7430023otp.7;
        Wed, 21 Apr 2021 15:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b8Uw+a2UAbxkwp1aO1rJYNcMyKZnxLKvwSwNt6PYJSE=;
        b=N8h4206Sst2K5heimT4kzTEy9i++rui0TUekxvto1mgPsrtggsLETJk0dxzD8JuUtl
         aL5i1JpCN2AV1wQC20U/7qMiaDhOxhZX7eQXCZoUysVGjmZNaoDOoW/XhV54VXwISqaF
         O4dEw4FXjmAYALs+8ot90o0KM1hIUf5Lp5VPm8DyvwAvqrT/ADJHxyoTFVW9SkFVACOX
         IzrFPtIFGLPZFCohNiJf/ybRW8RQsXIrpg7GMWbieSRjL98oeI/muas47++sNW397t2d
         L4sHDNrcFDBkzXBg5WUXsRWD+PjxXg0IQLSJGpRIoHo1g8opbsSAAOuBTAkcsXETInFh
         vtCQ==
X-Gm-Message-State: AOAM530IWfQF1czwbsQwIvkBnTL9zK+KOEVTHrRSwv+3LkDHMuknyF/N
        rMbf5vZJDjPPpl8cMiXzHw==
X-Google-Smtp-Source: ABdhPJydA7axca9NNFsNQNCielil8CXHW/dy/iWwaXIj1TmJVtIEGy6l1iqoQYu8BayepipRfkYzfg==
X-Received: by 2002:a9d:c24:: with SMTP id 33mr334796otr.289.1619045341736;
        Wed, 21 Apr 2021 15:49:01 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 88sm197996otx.2.2021.04.21.15.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 15:49:00 -0700 (PDT)
Received: (nullmailer pid 1756902 invoked by uid 1000);
        Wed, 21 Apr 2021 22:48:59 -0000
Date:   Wed, 21 Apr 2021 17:48:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Nishanth Menon <nm@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: arm: firmware: Convert linaro,optee-tz to
 json schema
Message-ID: <20210421224859.GA1750844@robh.at.kernel.org>
References: <20210416222518.15801-1-nm@ti.com>
 <CAHUa44GZenrwVWRZW6BKB8cktfXvktJ4OCF0AgPKanYGV01m5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHUa44GZenrwVWRZW6BKB8cktfXvktJ4OCF0AgPKanYGV01m5g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 10:32:37AM +0200, Jens Wiklander wrote:
> On Sat, Apr 17, 2021 at 12:25 AM Nishanth Menon <nm@ti.com> wrote:
> >
> > Convert linaro,optee-tz to json schema format for better documentation
> > and error checks.
> >
> > NOTE:
> > 1. This change does introduce a stricter naming convention for
> >    optee nodes.
> > 2. We do have false positive checkpatch warning with this patch:
> >    "DT binding docs and includes should be a separate patch"
> >
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> >  .../bindings/arm/firmware/linaro,optee-tz.txt | 31 ----------
> >  .../arm/firmware/linaro,optee-tz.yaml         | 62 +++++++++++++++++++
> >  2 files changed, 62 insertions(+), 31 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
> > deleted file mode 100644
> > index d38834c67dff..000000000000
> > --- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
> > +++ /dev/null
> > @@ -1,31 +0,0 @@
> > -OP-TEE Device Tree Bindings
> > -
> > -OP-TEE is a piece of software using hardware features to provide a Trusted
> > -Execution Environment. The security can be provided with ARM TrustZone, but
> > -also by virtualization or a separate chip.
> > -
> > -We're using "linaro" as the first part of the compatible property for
> > -the reference implementation maintained by Linaro.
> > -
> > -* OP-TEE based on ARM TrustZone required properties:
> > -
> > -- compatible     : should contain "linaro,optee-tz"
> > -
> > -- method         : The method of calling the OP-TEE Trusted OS. Permitted
> > -                   values are:
> > -
> > -                   "smc" : SMC #0, with the register assignments specified
> > -                          in drivers/tee/optee/optee_smc.h
> > -
> > -                   "hvc" : HVC #0, with the register assignments specified
> > -                          in drivers/tee/optee/optee_smc.h
> > -
> > -
> > -
> > -Example:
> > -       firmware {
> > -               optee {
> > -                       compatible = "linaro,optee-tz";
> > -                       method = "smc";
> > -               };
> > -       };
> > diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > new file mode 100644
> > index 000000000000..6513b5ac8b2c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > @@ -0,0 +1,62 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/firmware/linaro,optee-tz.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> 
> Are these links supposed to work?

Could possibly some day, but no. Just convention for json-schema.

Rob
