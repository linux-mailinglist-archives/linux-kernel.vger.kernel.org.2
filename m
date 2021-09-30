Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FBE41D1C9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 05:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347860AbhI3DOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 23:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346735AbhI3DOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 23:14:48 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3DDC06161C;
        Wed, 29 Sep 2021 20:13:06 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so5527603otq.7;
        Wed, 29 Sep 2021 20:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fF22d/2C+sJktNyAT2q4zyofKn0DGrffVdGHAaWKWOg=;
        b=Apv01V9LNBTGzVnm3+Ksvb9fv6yjUNPC+f2u6aOwfptJvMSncgdrCooZi6u6eV0lTf
         +ifQjcG9e/fduX2+wWjoA6b1BrXdUDtMYW8+/ge/OTBH1aTt2vj//c8BouNJcW/mvwCa
         kd9I0+YLr3zQYaVzzCoevoTu7g9LTDWwu+2xgfDht5e18z180Z98J3RFNtmfhLhaclPA
         enL+yu0SvgJKMaJ/mJkqUsiIaKmOjfvFmTmeUuAryS6yZyEWcLI/rpjieun4IAVc6j1N
         VhYD1kESbL+ggoQ+d6aV2BaSZg3K8RlpZ9Fgp4mha/9ZIxufyqvt7D91XZ0g/5B5u0oR
         cMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fF22d/2C+sJktNyAT2q4zyofKn0DGrffVdGHAaWKWOg=;
        b=Zpoz+71I6V3JMD43MO1K3oTVmb9gRa6MNB8/GPtc238U0MUyUYI7+4dUj3eYTAcQ3I
         9E96uB1pJbxZ4l8ZH2PN7Awanf+v8EkqgOj9eTcaPX4oROmNrlViB5k+EiMaWS/DW4Og
         SzkzqnTDpkcydaCpyIUZEtTzVPCjeZ8WJ0tS4gnCVE/uiOF9WhhezoLFnekxN2IetDE2
         XEfh8Q0Ap6hhD4+GIYzSw0us5SET7Kad1wdnRokGAJcv/Scf8/Oz/rp0G0QlUJ6MNC0L
         dS6nG315yc4Xv/F7okllLVzkXYFnPZBBm43R56P95sxkhsBKTWI3UfiVWhhbC4nryvZR
         1kqw==
X-Gm-Message-State: AOAM531ihbCFp0if06bCL8XwWLIVHuPAqAeqhf8XuNMuLCsQb15EFx5M
        QJsbEol+VYsWcHIvVNAkcQLLyEo8rIIeuMwrusk=
X-Google-Smtp-Source: ABdhPJyM3c4rPIni04HMYo5pPMALpqwsbN4dTXba7vJ9bNG/hFkmUtVs5i/uUY7vQA/2GFeqEl7pLib08GgSehn49RM=
X-Received: by 2002:a05:6830:9c9:: with SMTP id y9mr3094542ott.6.1632971584913;
 Wed, 29 Sep 2021 20:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210928073609.198975-1-zhang.lyra@gmail.com> <20210928113057.GJ4199@sirena.org.uk>
 <CAAfSe-vM8iG1OtQeVR1CxQtpvA8kqSs3pJ78RQQOL7GcWcTwSw@mail.gmail.com> <20210929122912.GO4199@sirena.org.uk>
In-Reply-To: <20210929122912.GO4199@sirena.org.uk>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 30 Sep 2021 11:12:28 +0800
Message-ID: <CAAfSe-tJMvYyvtOArsAW9Y980y_qzUgHoaQsyqnO6W47f9jMNA@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: Add Unisoc's SC2730 regulator driver
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Lee Jones

On Wed, 29 Sept 2021 at 20:30, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Sep 29, 2021 at 04:20:37PM +0800, Chunyan Zhang wrote:
> > On Tue, 28 Sept 2021 at 19:31, Mark Brown <broonie@kernel.org> wrote:
>
> > > Since this is a part of a MFD I'd not expect it to have a compatible
> > > string?
>
> > Since we switched to use devm_of_platform_populate() [1] to register
> > MFD subdevices, compatible is required, IIUC.
>
> I'm not sure that's a good fit for these regulators, we don't gain any
> extra information from the compatible here.

Humm... regulators cannot be probed without compatible for this case,
except we have a list of mfd_cells which include compatible and driver
name in sc27xx_spi (mfd) driver.

On different platforms, sc27xx_spi consists of different sub-devices
with different compatible string, to avoid adding mfd_cells to
sc27xx_spi driver each time we add a new platform support, we changed
to use devm_of_platform_populate() which can automatically register
sun-devices listed in devicetree.

The above is my understand, please correct me if I'm missing something
@Lee Jones

Thanks,
Chunyan

[1] https://lkml.org/lkml/2020/6/19/207
