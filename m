Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF1F3F2717
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 08:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbhHTGzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 02:55:15 -0400
Received: from egress-ip4b.ess.de.barracuda.com ([18.185.115.208]:51226 "EHLO
        egress-ip4b.ess.de.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231998AbhHTGzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 02:55:13 -0400
X-Greylist: delayed 1677 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Aug 2021 02:55:13 EDT
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70]) by mx-outbound16-7.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 20 Aug 2021 06:54:32 +0000
Received: by mail-wm1-f70.google.com with SMTP id o8-20020a05600c378800b002e72385f8e7so316708wmr.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 23:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hcuPJzI48ACDUsy7FQfltiq6GrliZ7PQzihG218WNKY=;
        b=ehFoCCvzT0rbZ7ht4RKXR47svEKDf/oQh5OE/A1Bgp19SIELkIxdcqp+igW66HWyLr
         qjxlLZTrmk74xo2GaD5NmJtfvlj7NZH7DvyN+U5uw7g1GZCEiDU8i4nuim/bo5xu3bTP
         yR2jO8K88rRnOc7XOAgAyt2Pg96/AJFPtYVig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hcuPJzI48ACDUsy7FQfltiq6GrliZ7PQzihG218WNKY=;
        b=rSZmNoLMxExhegAqVmuGIl2rcksgvWu1H3uequ/kYYtUpFK5j41Jq1lR/OSaEpKiHn
         NEWLTDSTehCqWrQInS7UsXzIJjdKWwFFgvH5CQJ41WYNH1hRhWM83I/z05JzF/TthksN
         7JmdLMdxveEPU0io+Y9UY5id/AlADzvND2eoYxxf/KUilKns8KxfjDsvbskrJ8u1ez8H
         FDktLYedeyYMNcPHU2/yDduhTM0GR6kMTjfuy6YK8/ddPr34oGMHe+OPB1dxcUgTbNLQ
         Tl3lqZA/bI87cpQPu8jxt5163BDT7SXV4A/BsZl7DZqDA/Mua48CltRvJSZjGtlMhAIe
         DRWw==
X-Gm-Message-State: AOAM531cKct4AqFTVFmmIclGEvIHJK0+iAcbQVlgwbP5DJJP1fpsRdyk
        egucWDgye8M3vbVUL+avyC1C/5WWPVyLvbvaz0qyn29oGDSmVM3vdKIZPGUyrFHwEbfVyU/fMly
        Z3lpdQaPC4Dk9+zjr0KO90bc0kOMxAeytZNoHiQ8D1I4Z5MM5b/D4DGWjgA/F5th9/zIT/tvtoE
        61
X-Received: by 2002:a7b:cb02:: with SMTP id u2mr2081806wmj.103.1629440793572;
        Thu, 19 Aug 2021 23:26:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUpTVpY5loxCylXUXl3QzaPyMvv2z8srnQpPVyv3dpCPkhvSqbLiBl6xuULNB+8ghw1qIJ+8C6IiVC6SPpXn0=
X-Received: by 2002:a7b:cb02:: with SMTP id u2mr2081780wmj.103.1629440793277;
 Thu, 19 Aug 2021 23:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210818074030.1877-1-sinthu.raja@ti.com> <20210818130535.siv7jpjjzfwonwdt@unsteady>
In-Reply-To: <20210818130535.siv7jpjjzfwonwdt@unsteady>
From:   Sinthu Raja M <sinthu.raja@mistralsolutions.com>
Date:   Fri, 20 Aug 2021 11:56:21 +0530
Message-ID: <CAEd-yTQgWLZUKPJQvByWfo3w=gNFLz=F6q6_oF_0WC7cRpZ6dw@mail.gmail.com>
Subject: Re: [PATCH V1] dt-bindings: remoteproc: k3-dsp: Update example to
 remove board specific
To:     Nishanth Menon <nm@ti.com>
Cc:     "Nagalla, Hari" <hnagalla@ti.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Rob Herring <robh+dt@kernel.org>, Suman Anna <s-anna@ti.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>,
        Sinthu Raja <sinthu.raja@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-BESS-ID: 1629442471-304103-19346-15804-1
X-BESS-VER: 2019.1_20210819.2207
X-BESS-Apparent-Source-IP: 209.85.128.70
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.234048 [from 
        cloudscan17-81.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND, BSF_SC0_SA085b
X-BESS-BRTS-Status: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With Regards

Sinthu Raja


On Wed, Aug 18, 2021 at 6:35 PM Nishanth Menon <nm@ti.com> wrote:
>
> On 13:10-20210818, Sinthu Raja wrote:
> > The example includes a board-specific compatible property, but developers
> > need to add the board name each time when a new board is added to the K3
> > J721E SoC list. This grows the compatible string-list. So, drop the
> > board-specific compatible string and add cbass_main as a parent node to
>
> What is cbass_main node?
>
> > avoid parent node and child node address-cells mismatch error.
> >
>
> I think you mean that since the existing example uses address cells and
> size for 64bit addresses and sizes, you are introducing a bus segment
> indicative of the same capability to reduce the churn in the binding.
> Correct? if so, rephrase accordingly.
>
> > Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
>
> Your From: and Signed-off-by email IDs do not match. You might want to
> re-read the contribution guidelines documentation in linux kernel.
>
> This should be also tagged with Fixes: since it is fixing a pre-existing
> binding that slipped through our review.

Hi Nishanth,
May I know to which commit I have to tag the Fixes. If you are
referring to the below review, then the patch is not merged and how
shall we add the Fixes tag for this patch.
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210607093314.23909-2-sinthu.raja@ti.com/


>
> NOTE: at least my test.. (I think rob's system will still complain)
> base: next-20210818
> b4 am -o  ~/tmp -3 -g -t -l -c -s --no-cover 20210818074030.1877-1-sinthu.raja@ti.com
>         https://pastebin.ubuntu.com/p/VxzzvzpY9N/
>
> I mean, both these can be caught with checkpatch and standard checks, so
> did you see that in your basic vett prior to posting?

It didn't catch in my basic patch verification. But the generated
patch does have the From header, but sometimes the From header is
getting truncated when submitting for review. Still working on that to
fix it. (using Gmail client to submitting the patch)

With Regards
Sinthu Raja
>
> > ---
> > Changes in V1:
> > Fixed alignment issue which caused the yaml parse error.
>
> Some 101 comments:
>
> A) when you post a new revision, post a url like previous versions in
>    diffstat - :
>    https://lore.kernel.org/linux-devicetree/20210817152005.21575-1-sinthu.raja@ti.com/
> B) When you are sending the very first patch, it is already V1 and
>    does'nt need to be explicitly stated. this update to your original
>    post is a V2, so, when you update this patch to address the review
>    comments, the next revision will be V3.
>
> >
> >  .../devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml     | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> > index 6070456a7b67..e44a9397b8db 100644
> > --- a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> > +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> > @@ -132,10 +132,8 @@ required:
> >  unevaluatedProperties: false
> >
> >  examples:
> > -  - |
> > -    / {
> > -        model = "Texas Instruments K3 J721E SoC";
> > -        compatible = "ti,j721e";
> > +  - |+
>
> minor detail: you are also doing one additional change -> you are now using
> the standard example template and adding the example node instead of a
> complete example node as well here. Personally, I do prefer this
> approach rather than the previous example.
>
> > +    cbass_main {
> >          #address-cells = <2>;
> >          #size-cells = <2>;
>
>
>
> Usually, when one sees problems like these, they tend to be
> symptomatic, and we need to look if there is a similar pattern of
> error else where in the codebase.
>
> Sigh, in this case, I see the same problem in:
> a) Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
> b) Documentation/devicetree/bindings/hwlock/ti,omap-hwspinlock.yaml
>
> Hari, Sinthu,
> Can we fix these in a series that belongs to each maintainer?
>
> >
> > --
> > 2.31.1
> >
>
> --
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
