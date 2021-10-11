Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1CE429714
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 20:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbhJKSsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 14:48:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229542AbhJKSry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 14:47:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9F3C60F4B;
        Mon, 11 Oct 2021 18:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633977953;
        bh=slrBS2iWicQssAAHo9cIRSDkDkmT0N370ZMWkDFUOsQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a3FaMMPktBn0HzynG2irWzI1bsJn12rKkxnyxjax+6QWFLz22lfK5vetI4ahogmUx
         +oOjpfcKp9+Rn8DUG2OwNUxilH0yKppt7iVG1wt32PFYOu+OjnT6JhjISMH6xsINFf
         Qcw3AMM/3mvntelqnrG+HBYeBS45PJQYCfwf3FWQhX+6cCICVncRnFc2MwcQPWYYnV
         aBxw+Ov6/z4xYTXThMeBpGtpgkPtBS6s+doE4UeGkCAj6NKLUylPmhvrM4ZbX17uyf
         YJ3KH4wkyxF2m5c+ENBQjoNoqg9wDiktrLIuLAErT7tOeli9rybKplQhG8BkEaXAyA
         bi99Ium9vndrg==
Received: by mail-ed1-f53.google.com with SMTP id g10so70644180edj.1;
        Mon, 11 Oct 2021 11:45:53 -0700 (PDT)
X-Gm-Message-State: AOAM5334FVJroNgubwg8JyjPlbpdLpO99BnZfHlxHCnidps6ETgoJm/s
        14hi/NVppRMhuUs+ZdxCmxeofhPK0tAtX8ZLmA==
X-Google-Smtp-Source: ABdhPJxq19qlUhYZ8K5Xe1nS5T+wdThmJizEU1SmWiWjKnTWFBiGfof2WeretTYcfFS+4z1Qg8oCjulLYvKdxTfKwRs=
X-Received: by 2002:a17:906:e089:: with SMTP id gh9mr27523694ejb.320.1633977952254;
 Mon, 11 Oct 2021 11:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211009104309.45117-1-david@ixit.cz> <1633894316.403809.3158663.nullmailer@robh.at.kernel.org>
 <W97S0R.8W2XT6A4XCW4@ixit.cz>
In-Reply-To: <W97S0R.8W2XT6A4XCW4@ixit.cz>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 11 Oct 2021 13:45:40 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJeHYA4Bpb-4FRojV0TWr9z8tbpCshG=t_an7eMnSiQYQ@mail.gmail.com>
Message-ID: <CAL_JsqJeHYA4Bpb-4FRojV0TWr9z8tbpCshG=t_an7eMnSiQYQ@mail.gmail.com>
Subject: Re: [PATCH] WIP: dt-bindings: arm: hwmon: gpio-fan: Convert txt
 bindings to yaml
To:     David Heidelberg <david@ixit.cz>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        ~okias/devicetree@lists.sr.ht, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2021 at 4:50 PM David Heidelberg <david@ixit.cz> wrote:
>
>
>
>
> On Sun, Oct 10 2021 at 14:31:56 -0500, Rob Herring <robh@kernel.org>
> wrote:
> > On Sat, 09 Oct 2021 12:43:09 +0200, David Heidelberg wrote:
> >>  Convert fan devices connected to GPIOs to the YAML syntax.
> >>
> >>  Signed-off-by: David Heidelberg <david@ixit.cz>
> >>  ---
> >>   .../devicetree/bindings/hwmon/gpio-fan.txt    | 41 -----------
> >>   .../devicetree/bindings/hwmon/gpio-fan.yaml   | 69
> >> +++++++++++++++++++
> >>   2 files changed, 69 insertions(+), 41 deletions(-)
> >>   delete mode 100644
> >> Documentation/devicetree/bindings/hwmon/gpio-fan.txt
> >>   create mode 100644
> >> Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
> >>
> >
> > Running 'make dtbs_check' with the schema in this patch gives the
> > following warnings. Consider if they are expected or the schema is
> > incorrect. These may not be new warnings.
> >
> > Note that it is not yet a requirement to have 0 warnings for
> > dtbs_check.
> > This will change in the future.
> >
> > Full log is available here: https://patchwork.ozlabs.org/patch/1538743
> >
> >
> > fan: 'gpio-fan,speed-map' is a required property
> >       arch/arm/boot/dts/kirkwood-nas2big.dt.yaml
> >       arch/arm/boot/dts/kirkwood-net2big.dt.yaml
> This sounds correct.
>
> >
> > gpio-fan: gpio-fan,speed-map: 'anyOf' conditional failed, one must be
> > fixed:
> >       arch/arm/boot/dts/gemini-dlink-dir-685.dt.yaml
> >       arch/arm/boot/dts/gemini-dlink-dns-313.dt.yaml
> >
> Look like two arrays instead one expected.
>
> > gpio_fan: gpio-fan,speed-map: 'anyOf' conditional failed, one must be
> > fixed:
> >       arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
> >       arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
> >       arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
> Look like two arrays instead one expected.
>
> >
> > gpio-fan: gpio-fan,speed-map: 'oneOf' conditional failed, one must be
> > fixed:
> >       arch/arm/boot/dts/gemini-dlink-dir-685.dt.yaml
> >       arch/arm/boot/dts/gemini-dlink-dns-313.dt.yaml
> >
> Look like three arrays instead one expected.
>
> > gpio_fan: gpio-fan,speed-map: 'oneOf' conditional failed, one must be
> > fixed:
> >       arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
> >       arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
> >       arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
> >
> Look like two arrays instead one expected.
>
> I can send patches to solve these warnings.

Certainly not required, but would be nice. I sent it more for whether
anything in the schema should change.

Rob
