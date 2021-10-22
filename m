Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B1D437E96
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 21:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhJVT1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 15:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbhJVT1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:27:20 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA191C061766
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 12:25:02 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d13so1829852wrf.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 12:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RUp2XLqq8Lwi/bCtW75kgwYY33nabu26v+zSnuqstFo=;
        b=H78BuiGGtS652wLIuHe5+8En2woNN+Zx3w5mN1mw6MZuDHZI2AZVfeG2SVm1RLTzfY
         gbvClSs1QexiFf64RI18qjMk88x0e8HWu6lzTL6tdUUqu/qXPu4RRo4MwgUCI5ABDuCd
         Zg05VhGgagMRpRVH5U+hZII1ifD2CgO3NuI48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RUp2XLqq8Lwi/bCtW75kgwYY33nabu26v+zSnuqstFo=;
        b=wttf+lRDFpmqHRc9+cdUkososZOlPUwr3/RviHlsPTmpKra5S/GO8nrTM170QeVtXS
         ww8r/nwlU+UlKumjJypCH264yH1RQEG9RcFkrKULaA/fZsBA4zEZicD9Ma6Wp2DDzCTL
         bG+k2wdeRTvaA+fOCPfDWESvpIHADBH66G8qZWVIMYT0hoaQo7KxG1Oxwka1/QHgYnO2
         RbkcIesNUkI7RD7fvFqqxOdq3u9Ao/5S23zDKbfAy8rUKs3CVOy6AObV4U3OXcBuBntF
         ZnHcx3HYn5pCM4DfAuEtq1fFfCbeYxhmwwJrXCsinOcfblvFAv25XLQ8I8O5sQmWe6ms
         trkQ==
X-Gm-Message-State: AOAM532iYhuVFwXsmmyLpV39L//VPNuAOGwgFnzmz9ul01XgTRdMJteo
        PbIHRVetkdktQNyTK7AG+raw+xAdcnaN7DR0KxdXEw==
X-Google-Smtp-Source: ABdhPJyMDc6EZKx2boNeX0DtFA+guxiLLagh2B2rcpBWIQ8n27Nr50828eKBi9y39j6/fsELyTRrOGfZJB/2CW0Qav8=
X-Received: by 2002:a05:6000:1283:: with SMTP id f3mr2224362wrx.128.1634930701241;
 Fri, 22 Oct 2021 12:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211022140714.28767-1-jim2101024@gmail.com> <20211022140714.28767-2-jim2101024@gmail.com>
 <YXLPZ4CsQMjHPpJS@sirena.org.uk>
In-Reply-To: <YXLPZ4CsQMjHPpJS@sirena.org.uk>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Fri, 22 Oct 2021 15:24:50 -0400
Message-ID: <CA+-6iNz3PMsYDds_uoh_xNoPop-tLn1O9U9wnTmTx+pZyN5ZFA@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] dt-bindings: PCI: Add bindings for Brcmstb EP
 voltage regulators
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 10:49 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Oct 22, 2021 at 10:06:54AM -0400, Jim Quinlan wrote:
>
> > The use of a regulator property in the pcie EP subnode such as
> > "vpcie12v-supply" depends on a pending pullreq to the pci-bus.yaml
> > file at
> >
> > https://github.com/devicetree-org/dt-schema/pull/54
>
> This contains updates to add the generic PCIe supply rails, not the
> brcm-ep-a and brcm-ep-b supplies (which as I said on the other patch
> look like they ought to be renamed).  That's fine since they're
> obviously not generic PCIe things but this means that those bindings
> need to be added to the device specific bindings here.  Currently
> there's only an update to the examples.

Just to be clear, and assuming that the brcm-ep-[ab] supply names are
green-lighted by you and Rob, are you saying
I have to update the github site or our YAML file?  If the latter, it
seems odd to be describing
an EP-device property in the YAML for an RC driver since the github
site already describes the EP-device.

Jim
