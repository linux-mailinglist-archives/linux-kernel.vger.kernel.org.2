Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BAA3329E3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhCIPL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:11:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:36814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231920AbhCIPLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:11:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6358464D90;
        Tue,  9 Mar 2021 15:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615302705;
        bh=bQ7R0KgAevaht1DIc/P0+9IJtAAWdN476QMRBmZwqaY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F0tB8vFrfIwDQ+b/UgZmcDbMT3A8ti5wFxXBlFEsZhAhhvO4kmmJPDNxiUpmM90xZ
         dsTV/SzKoyKUq1M5yAx5tO83e+pPXBJMCbLILxLLQKxLkyjUel0UYBkEvFzn/Sup6m
         FBe6bkuxwFn+F1j5QB6RBEge3ySCD6nImrp6L9qkqhmQZA3GEZpf3k3CrmjbkrAqv9
         GHIhA3dqUsc2w0NOwft35Ernz1AatFIc1Ls9W4qx6/5LoWz4ugKBI+ytCUPpqfPOB8
         JRQNBSXjDvuytMVNxHLWDbJvwXvMZpNLrasHljXT3aK7HjJbBjuAhN+3M8gkmWegtd
         0C3jhiSgYqUZQ==
Received: by mail-ed1-f44.google.com with SMTP id v13so20796092edw.9;
        Tue, 09 Mar 2021 07:11:45 -0800 (PST)
X-Gm-Message-State: AOAM531J8DXSpsmOUaIbGL9yts+LnvoNuMPTP+ywap1e8OokonpRvOSR
        NxlBYIn6XJ9LC/rlPukb8hTDJcqrxBgEK79HYw==
X-Google-Smtp-Source: ABdhPJwx62SctgK+We8Ag14Qp+OBBXRQmMMi6+TK3C2JW8RKhdSeyrCCtwe3rh8IiQMYEZw3Jid3jxb8TMz/9lVhl8k=
X-Received: by 2002:a05:6402:c88:: with SMTP id cm8mr4680424edb.62.1615302703886;
 Tue, 09 Mar 2021 07:11:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1615198094.git.matti.vaittinen@fi.rohmeurope.com>
 <790da5fe60eb3bcd190830770866147bbb5f8143.1615198094.git.matti.vaittinen@fi.rohmeurope.com>
 <20210308173938.GA2679675@robh.at.kernel.org> <06c8e7339ebc3e1802aa1e9c213de9392671a8a5.camel@fi.rohmeurope.com>
In-Reply-To: <06c8e7339ebc3e1802aa1e9c213de9392671a8a5.camel@fi.rohmeurope.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 9 Mar 2021 08:11:31 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKbZzXBMPH_aus7=xZWn-EY0BBVnVbu0W_EO_US7vbJNA@mail.gmail.com>
Message-ID: <CAL_JsqKbZzXBMPH_aus7=xZWn-EY0BBVnVbu0W_EO_US7vbJNA@mail.gmail.com>
Subject: Re: [PATCH v3 05/15] dt_bindings: mfd: Add ROHM BD71815 PMIC
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org,
        linux-power <linux-power@fi.rohmeurope.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 5:51 AM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:
>
> Hello Rob,
>
> On Mon, 2021-03-08 at 10:39 -0700, Rob Herring wrote:
> > On Mon, 08 Mar 2021 12:40:50 +0200, Matti Vaittinen wrote:
> > > Document DT bindings for ROHM BD71815.
> > >
> > > BD71815 is a single-chip power management IC mainly for battery-
> > > powered
> > > portable devices. The IC integrates 5 bucks, 7 LDOs, a boost driver
> > > for
> > > LED, a battery charger with a Coulomb counter, a real-time clock, a
> > > 32kHz
> > > clock and two general-purpose outputs although only one is
> > > documented by
> > > the data-sheet.
> > >
> > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../bindings/mfd/rohm,bd71815-pmic.yaml       | 201
> > > ++++++++++++++++++
> > >  1 file changed, 201 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml
> > >
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
>
> I am sorry to bother but I've spent a while trying to reproduce this.
> For some reason I can't trigger the error from
>
> 'make dt_binding_check' or
> 'make dt_binding_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/mfd/rohm,bd71815-
> pmic.yaml'
>
> even after I ran
>
> 'pip3 install dtschema --upgrade --user'.
>
> I should also have yamllint installed.
>
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > Unknown file referenced: [Errno 2] No such file or directory:
> > '/usr/local/lib/python3.8/dist-
> > packages/dtschema/schemas/regulator/rohm,bd71815-regulator.yaml'
>
> This bothers me slightly. The patch 04/15 should bring-in the
> rohm,bd71815-regulator.yaml. Does this error indicate that file is
> missing or is my $ref somehow invalid?

Then it's simply a false positive. I usually check these and try to
only send the email if the dependency is not in the series so the
dependency is clear. It's a balance of replying quickly and my time
reviewing the errors.

> *** opinion follows - not sure if it just me but... ***
>
> I know I should probably keep my mouth shut but... I am more and more
> thinking that the yaml bindings are yet another 'excessive unit-test'
> type solution. Tooling which should "force doing things correctly" is
> eventually hindering development and causing the end result being sub-
> optimal.

It's about validating DTS files actually do what the bindings say.
It's pretty clear that the free form text bindings left a lot of
things ambiguous.

How would you propose we can check every property in a DTS file has a
definition (minimally of it's type)? Freeform text can simply never do
that.

> I mean that creating binding docs takes way too much time from someone
> like me who is "yaml-illiterate". And when I eventually get yaml done -
> the end result is far less descriptive for human eyes than the "good
> old" free-text format would've been. I know one can add comments - but
> I don't see much of them in the binding docs...

Because people do the minimum? The only comments/description I object
to are duplicating generic descriptions of common properties.

There's certainly lots of things we could do. There are tools which
generate pretty docs out of json-schema. Not sure how useful they
would be OOTB. But I simply don't have the bandwidth to look into
them. I can barely keep up with reviews...

Rob
