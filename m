Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192E1444A84
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 22:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhKCV41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 17:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbhKCV4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 17:56:21 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AA7C061203
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 14:53:44 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d3so5644297wrh.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 14:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D7FSrtNrX5nOFnwygS5xpyL/5wYBkJfbm++yYupLlqo=;
        b=BOnSOl6YXnuSil9Gt1blmrWYKaP4cFrvlgfMaylmUIXlRY1YXa4xesmT9UQguUTb/6
         qKzdmnPAMJktxgWyrIpHWagD6SAb8VIRF6UKohjYn+HjjDgNPy30KAOMIkTMeOaMLsSA
         G1T2j7JWpytiQMstMlQ/Og41MeZRXcoV5nXaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D7FSrtNrX5nOFnwygS5xpyL/5wYBkJfbm++yYupLlqo=;
        b=i/p/Wfyy1NuQCFJeP44G9UCsI3iUpMR7ZbIcKuFIQSs4xag3QjQtlUYp0qcbNHpFBV
         V3Pee3UR1ydAYPoPDq1CZCsuBdW98Q4m/kxt9UDzQrSq/NthTB9gxdXsO193WfxD9Txk
         KOHZWyeV/EhZcUpJl7/Nf2cgASwvdr5mkTGRj9lG91NMo0WBELqqMdbMG5KMHoh/3lyv
         m0yay396Jjv/d6PGBGARazCzVVNV4wxXaaQkLatX5ZpZgNFv+cPVwxCr81UZxfICeD2n
         Z8MVRfog0VTq1Ee2VeXLXWAaBY7BWCZBZb9GuQXLsjqhrEVb7SuSX0m1yd68RbiVS5rK
         NFpg==
X-Gm-Message-State: AOAM530Qy9/2Q2slm8q7UXx0OvMDzFqRVBoJ+JDm3s74QF4ziAdqASQC
        tGcmJ76Oa3rnWr2VnuoUdx4K/cwUep8Ii81QTraF+A==
X-Google-Smtp-Source: ABdhPJy0sTuL7PHeTb2+ERKpgRvzQcvSzbrxX79HbSBGj+++Szj2w7dWetm+oKLaSe4IhQdSf37ppgqKLgegphecNFQ=
X-Received: by 2002:adf:ba87:: with SMTP id p7mr59062923wrg.282.1635976423448;
 Wed, 03 Nov 2021 14:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211103184939.45263-1-jim2101024@gmail.com> <20211103184939.45263-6-jim2101024@gmail.com>
 <YYLm3z0MAgBK24z5@sirena.org.uk> <CA+-6iNzkg4R8Kt=Q=sgdB++HHStRSHRUOUTvAfjZr31-FUrzNA@mail.gmail.com>
 <CA+-6iNziZv0UycoaoFhscmp39Z2Y2bHrWUpFW4f9MBK-uM24qA@mail.gmail.com> <YYMEkjlbFdeIjror@sirena.org.uk>
In-Reply-To: <YYMEkjlbFdeIjror@sirena.org.uk>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Wed, 3 Nov 2021 17:53:32 -0400
Message-ID: <CA+-6iNwshLwTaHuh+BezmqjGi7wRnFUqa2HvKestecOy06qj8g@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] PCI: brcmstb: Add control of subdevice voltage regulators
To:     Mark Brown <broonie@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 5:52 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Nov 03, 2021 at 04:34:34PM -0400, Jim Quinlan wrote:
> > On Wed, Nov 3, 2021 at 4:25 PM Jim Quinlan <james.quinlan@broadcom.com> wrote:
>
> > > I did it to squelch the "supply xxxxx not found, using dummy
> > > regulator" output.  I'll change it.
>
> > Now I remember: if I know there are no vpciexxx-supplly props in the
> > DT, I can skip executing all of the buik regulator calls entirely, as
> > well as walking the PCI bus as in brcm_regulators_off().
>
> > Do you consider this a valid reason?
>
> No, the whole point in the core code providing dummy supplies is that it
> removes the complexity introduced by client drivers trying to guess if
> there's supplies available or not.  If they do that then we end up with
> a bunch of code duplication and issues if there's any changes or
> extensions to the generic bindings.
Ok, will change it.
Thanks, Jim
