Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A062345FC6E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 04:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351891AbhK0DsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 22:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351773AbhK0DqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 22:46:03 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9C2C0613ED
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 18:41:52 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id j14so22027750uan.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 18:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JUTz9r6cQOlxlu3tXjp2/meDLVET9zcm7JMPcTh5e3U=;
        b=Pbdm6ltCM1oaPOHRTxqZgUS7IiEdjyGgQUIenVmcD1RgQ0NlBefHLjn/McStBDqAG4
         D5pmhyb6/6+D72FoeskkxXZr1QOETa6fKkayyX3973wqHu2mOEPWIpxT33rq7va1bLEY
         okzn4J83p/jnvp+SDd57XtydcS8K2fEYA03js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JUTz9r6cQOlxlu3tXjp2/meDLVET9zcm7JMPcTh5e3U=;
        b=aFPU6teL8U21rSpswFtWwjKni4RxGXkGQyukj60v2c3Wyt5S7N6O8EEehEGDZSaV8F
         gjozKvzKzCbnZ+ZkzmC9HtYz9iAM45m5m+aRlan8feCRif9mXFBoBsY1spxxWrVJFUrH
         R2RxvrX+i2uBPKXwFnzICiHVxTlj6TWi/9D2je0S1V82ai0tJyXu/YKwb6lWweztQ13i
         aC46q7BgCHEc0zq1EuH45Oby2mCU20xppHbfoIchEfEF/FplJn8E6d3vYcJOPd7+Fw+h
         Yb41kw/PAXf8+oh0lShJbn317rI01m5HjwOseIN23FWrZoWN4rG7QAagrAmg1MvE1o0Z
         yWJw==
X-Gm-Message-State: AOAM533j6fnxBrLToSCbs7pL8c3fO4esXXq8jE29gecXx696F6z9i+Q2
        9nfJiLFB+OXdJc6C/dCNVWw/PgPPdJAReAtL53qhBQ==
X-Google-Smtp-Source: ABdhPJzxUa4J19bW94AhJDUynNSXZxtuE3PwmI+nAZKwsrj/TRWk00H6VBcbXFg0E0rCUpdyxilLjWZFf9AHCwgSBDk=
X-Received: by 2002:ab0:14a7:: with SMTP id d36mr38072285uae.96.1637980911133;
 Fri, 26 Nov 2021 18:41:51 -0800 (PST)
MIME-Version: 1.0
References: <20211120000356.1850639-1-sjg@chromium.org> <CAPnjgZ0JpmK+8VpYCfwaZC=GUBSWLvdVzxcugT5S=884n6qbpA@mail.gmail.com>
In-Reply-To: <CAPnjgZ0JpmK+8VpYCfwaZC=GUBSWLvdVzxcugT5S=884n6qbpA@mail.gmail.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Fri, 26 Nov 2021 19:41:39 -0700
Message-ID: <CAPnjgZ3E=c6ObCKHjs+SGkCStYsSPBu5sSTXnjcN7BB_rTd7Cw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: u-boot: Add a few more options bindings
To:     Devicetree Discuss <devicetree@vger.kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     Tom Rini <trini@konsulko.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Rob Herring <robh@kernel.org>,
        lk <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ others

Are there no comments on this?

- Simon

On Fri, 19 Nov 2021 at 17:13, Simon Glass <sjg@chromium.org> wrote:
>
> +Rob Herring oops
>
>
> On Fri, 19 Nov 2021 at 17:04, Simon Glass <sjg@chromium.org> wrote:
> >
> > This adds three new options with varying degree of interest / precedent.
> >
> > This being sent to the mailing list since it might attract more review.
> > A PR will be sent when this has had some review. That is why the file
> > path is set up for https://github.com/devicetree-org/dt-schema rather
> > than the Linux kernel.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  schemas/options/u-boot.yaml | 51 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >
> > diff --git a/schemas/options/u-boot.yaml b/schemas/options/u-boot.yaml
> > index 71dfda7..b8bdec1 100644
> > --- a/schemas/options/u-boot.yaml
> > +++ b/schemas/options/u-boot.yaml
> > @@ -71,6 +71,37 @@ properties:
> >        2: use simplified command line (e.g. avoid hush)
> >        3... reserved
> >
> > +  load-environment:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 1
> > +    maximum: 1
> > +    description: |
> > +      This allows control over whether U-Boot loads its environment after
> > +      relocation. This normally happens automatically, but can pose a security
> > +      risk, so disabling it in certain situations is useful.
> > +
> > +      Note: This could be a boolean. It is defined as an integer since that
> > +      allows changing the value without resizing the devicetree. I'm not sure
> > +      how ugly that is, but IMO the fact that 'false' boolean values are
> > +      represented by being missing is a bit of a pain. One must either add or
> > +      delete the property.
> > +
> > +      Values:
> > +
> > +      0: don't load the environment
> > +      1: do load the environment
> > +
> > +  no-apm-final:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: |
> > +      For devices running on coreboot, this tells U-Boot not to lock down the
> > +      Intel Management Engine (ME) registers. This allows U-Boot to access the
> > +      hardware more fully for platforms that need it.
> > +
> > +      Absence of this property indicates that the ME registers should be locked
> > +      down as part of U-Boot's start-up sequence and before the command line is
> > +      available.
> > +
> >    silent-console:
> >      $ref: /schemas/types.yaml#/definitions/uint32
> >      default: 0
> > @@ -88,6 +119,23 @@ properties:
> >          enabled)
> >        2: console output is suppressed and not recorded
> >
> > +  spl-payload-offset:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 0
> > +    description: |
> > +      If present (and SPL is controlled by the devicetree), this allows the
> > +      offset of the SPL payload (typically U-Boot) to be specified. The offset
> > +      is in bytes from the start of the media (typically SPI flash).
> > +
> > +      Note: This is quite widely used in U-Boot, but since v2018.01 it is
> > +      possible to use Binman instead, to provide this offset (and various
> > +      others) to SPL, or even to U-Boot proper. So far I have not tried sending
> > +      the Binman bindings upstream, but perhaps that should be done instead.
> > +
> > +      See here for details:
> > +
> > +      https://u-boot.readthedocs.io/en/latest/develop/package/binman.html#image-description-format
> > +
> >  required:
> >    - compatible
> >
> > @@ -101,6 +149,9 @@ examples:
> >          bootcmd = "vboot go auto";
> >          bootdelay-sec = <(-1)>;
> >          bootsecure = <1>;
> > +        load-environment = <0>;
> > +        no-apm-final;
> >          silent-console = <1>;
> > +        spl-payload-offset = <0x40000>;   /* 256K */
> >        };
> >      };
> > --
> > 2.34.0.rc2.393.gf8c9666880-goog
> >
