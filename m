Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84DF3337AE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 09:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbhCJIoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 03:44:30 -0500
Received: from mail-vs1-f54.google.com ([209.85.217.54]:34266 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbhCJIn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 03:43:57 -0500
Received: by mail-vs1-f54.google.com with SMTP id m18so8341912vsa.1;
        Wed, 10 Mar 2021 00:43:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YPUEK0LT27EUaM0kP8V6EnWzkWmYVmHulltUbBErJa4=;
        b=hhSudM/gerKRZxYxQ/O/zzf7fcAlxzLEhauzC0NGa7agVA3LHmulFQMsF0mPXWYOHk
         6CVz9IBklALGTpP8CYHCltjIcuAujjBPQ3kfQSb49BMHdFi6H2E+t18FPs/x6oGujlvw
         ifslAWUQWjeDc862+wYWpY4aniZZ046aqddrKNbSJcDVlHs4jopdHpwlLzlD5aq2QrqS
         jB8d0cHqsuP6rON2wTRVxXFP0mREn7Tc8Y/5dS/eTAwL9Uk8FwApNq7e2zbWaWtllEWC
         JEaCP0zmYNd6KCWCS2sqLabYdgy/2IIS5WzkfkinJHV9frI/iJdvS0Z6GVRAqEjmHoxJ
         mSsA==
X-Gm-Message-State: AOAM533agH3L9vbpbur7xiffgFh6pLGSx0GBD8AS5oOR15+shjbC/I+L
        ZirhIlt4HHb2/C1i2Odipftte3bPgTCjIRxRWzY4wERzkN0=
X-Google-Smtp-Source: ABdhPJyHLp6EkBycxStPS2VJaKsOjrCm388ciPMWhHyHuOIeXFLLi2yGoUtOcvHYaJ/sm+g8EJheaUUBrPGh9QvYV5s=
X-Received: by 2002:a67:fe90:: with SMTP id b16mr1066469vsr.40.1615365833430;
 Wed, 10 Mar 2021 00:43:53 -0800 (PST)
MIME-Version: 1.0
References: <20210309112148.2309116-1-geert+renesas@glider.be> <CAL_JsqJzfoSubkKQ+aGYGbuH2=vLG2Sf_nQShxJ8DLirALff5g@mail.gmail.com>
In-Reply-To: <CAL_JsqJzfoSubkKQ+aGYGbuH2=vLG2Sf_nQShxJ8DLirALff5g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 10 Mar 2021 09:43:42 +0100
Message-ID: <CAMuHMdWqo7WVsiNk2xyTM=cqi883v0_-jh1Ry9R7yLBaoOYxoA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] dt-bindings: Consider DT_SCHEMA_FILES when finding
 all json-schema
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Mar 9, 2021 at 6:42 PM Rob Herring <robh+dt@kernel.org> wrote:
> On Tue, Mar 9, 2021 at 4:21 AM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > Setting DT_SCHEMA_FILES allows the user to restrict the
> > "dt_binding_check" make target to a specified set of DT binding files.
> > However, yamllint is still run on all available files, which can take
> > quite some time.
> >
> > Fix this by changing "find_cmd" to only return the specified files.
> > Note that this also affects the "cmd_chk_bindings" and "cmd_mk_schema"
> > rules.
> >
> > This reduces the execution time of
> >
> >     make dt_binding_check DT_SCHEMA_FILES=/path/to/json/schema/file
> >
> > from ca. 22 to less than 2 seconds on an i7-8700K.
>
> We could use xargs sharding like 'chk_bindings' does. That goes from
> 18s to 5s for me (i7-7700HQ). Good enough? Not sure why I didn't other
> than thinking 20sec was fast enough.

Sounds better, but yamllint (on all files) would still take 80% of the
time for a single binding check, assuming a reasonably fast multi-core
machine.  My main objection is that while working on a new binding, and
using DT_SCHEMA_FILES, I don't want to waste time on checking other
bindings, and being bothered with warnings about them.

> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Should this be restricted to cmd_yamllint?
> > I'm not sure which users of find_cmd do and do not need all files.
>
> cmd_chk_bindings always does. cmd_mk_schema needs both. So I think
> this doesn't work for all cases.

Thanks, will respin to restrict to yamllint.

> > --- a/Documentation/devicetree/bindings/Makefile
> > +++ b/Documentation/devicetree/bindings/Makefile
> > @@ -22,10 +22,18 @@ $(obj)/%.example.dts: $(src)/%.yaml check_dtschema_version FORCE
> >  # Use full schemas when checking %.example.dts
> >  DT_TMP_SCHEMA := $(obj)/processed-schema-examples.json
> >
> > +ifeq ($(DT_SCHEMA_FILES),)
> > +
> >  find_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
> >                 -name 'processed-schema*' ! \
> >                 -name '*.example.dt.yaml' \)
> >
> > +else
> > +
> > +find_cmd = echo $(addprefix $(srctree)/, $(DT_SCHEMA_FILES))
> > +
> > +endif
> > +
> >  quiet_cmd_yamllint = LINT    $(src)
> >        cmd_yamllint = ($(find_cmd) | \
> >                       xargs $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)/.yamllint) || true

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
