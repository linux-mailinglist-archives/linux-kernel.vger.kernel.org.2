Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1487355ADD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 19:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbhDFR6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 13:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbhDFR63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 13:58:29 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5155DC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 10:58:18 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id n4so7076686ili.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 10:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vGkQibEhIMdD/p8ZIvDkxPOyyzWAR6ElrjD/hXxlZ+o=;
        b=pwdcqtcQFLyaOUfrHtEFFwBrCsuNVSW0ieW/zjYyIO9wwYBCcLDmcRMoHi3L9Ml8gy
         ieV8caoK32xe2eFZpQRBihOKHKGREk6/9Bbgfl4lLevVQx44IaKplPquArQBONPzI6PC
         jVfarE6LPmYu0+RaTod/zz9pDa9QI+6Tr23RCLWNsH9YvvXCGSe450uPgLQo2HiNP+QY
         kEeQdq5pyPp3RjdHdKersgHHDhwtwO8Af5r9B4zlFzRYRrHTEBMwQiyTM2QnuK31s4X8
         RAnsMexNXGckLopIEYjKuk5NBqShLGWu+M7Aw+hh5Tw8KzmFsvkcnMzbibk4GKoOWg+5
         hKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vGkQibEhIMdD/p8ZIvDkxPOyyzWAR6ElrjD/hXxlZ+o=;
        b=IOjq7VUwwt54zHwHRU/bsFTTCNzu/TY5cnkElOw6oDW4vmVqPmebLECTh4rGwVsWW/
         /O4kDB0gcEg89L24bzYs/YszY1Zi8SaRRvg33adhskzEG2qSqrIUHhVBn4NnCfIQiPra
         90IPOX8F1y9fwWmrcfmYB6yPm+c+vrTON02/uI9zJ1qHa+4m+96RbFralqZx+1XgnROR
         45uzr3vIQ6cWpt3rMcwqmrdG8hc0Zdk8YWk9tQ2cN+ba3XN9iBeyxjiuvWz0DGMyViLs
         nMxfPBzfWaCwhJNsa5Rv+Uz6blHYBd5EGbMB51Aavpvo+V/ydAD2hwvo62ZPaARh6Jnc
         eThQ==
X-Gm-Message-State: AOAM531sZgVIlWkaC16K+ahCNiW/gjRK79Xj2jBmO41zD2cQ/IgNYdjW
        HQeYrv7vQHq4AMFzAoW02EptM/59CEv4OfLhlGiNnA==
X-Google-Smtp-Source: ABdhPJycK7EacZ6QGGyp+/k0L/DeJEDPQRgAo3sYB0F8iOgth4YzomZToeNqcXEFJ+iqVdf4//lb4Ni5JFtSIjdFgnE=
X-Received: by 2002:a05:6e02:1b0e:: with SMTP id i14mr24439552ilv.58.1617731897753;
 Tue, 06 Apr 2021 10:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210405191757.283122-1-mathieu.poirier@linaro.org> <87o8erq0u2.wl-maz@kernel.org>
In-Reply-To: <87o8erq0u2.wl-maz@kernel.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 6 Apr 2021 11:58:07 -0600
Message-ID: <CANLsYkwijvqGv-EdSSC-F727LczXS0gjBbY-YwJ-0OZkKGTZsg@mail.gmail.com>
Subject: Re: [GIT PULL] coresight: Add support for ETE and TRBE
To:     Marc Zyngier <maz@kernel.org>
Cc:     "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Apr 2021 at 02:22, Marc Zyngier <maz@kernel.org> wrote:
>
> Hi Mathieu,
>
> On Mon, 05 Apr 2021 20:17:57 +0100,
> Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> >
> > The following changes since commit a354a64d91eec3e0f8ef0eed575b480fd75b999c:
> >
> >   KVM: arm64: Disable guest access to trace filter controls (2021-03-24 17:26:38 +0000)
> >
> > are available in the Git repository at:
> >
> >   git@gitolite.kernel.org:pub/scm/linux/kernel/git/coresight/linux.git next-ETE-TRBE
> >
> > for you to fetch changes up to 7885b4e43231048654c5a80c0a18844ce3185e64:
> >
> >   dts: bindings: Document device tree bindings for Arm TRBE (2021-04-05 11:38:04 -0600)
> >
> > ----------------------------------------------------------------
> > Hi Marc,
> >
> > As previously agreed, here are the changes to support CoreSight
> > ETE and TRBE components submitted here[1].
> >
> > I draw your attention to these:
> >
> > [PATCH v6 05/20] kvm: arm64: Handle access to TRFCR_EL1
> > [PATCH v6 06/20] kvm: arm64: Move SPE availability check to VCPU load
> > [PATCH v6 07/20] arm64: kvm: Enable access to TRBE support for host
> >
> > They are KVM specific and will need an SoB tag.
>
> There seem to be a disconnect here, because it works the other way
> around.
>
> If I pull this, I obviously cannot add anything to the patches that
> are merged (changing stuff would result in changing the commit IDs,
> which is exactly the opposite of what we are trying to achieve).
>
> This isn't a problem, as the act of pulling the branch means that I am
> happy with that, and the git merge makes it traceable.
>
> However, some of the patches (the KVM ones) do not carry your own SoB,
> which is a problem (if you are picking stuff off the list, you need to
> add your own SoB). So for the couple of KVM patches, please add my
>

I wasn't clear on how to handle the KVM patches and as such decided to
proceed conservatively...

>         Acked-by: Marc Zyngier <maz@kernel.org>
>
> together with your SoB, resend the PR and I'll gladly merge it.
>

And I didn't want to SoB those patches because I am not in a position
to cast judgement on them, but with your Ack it changes everything.

> And if you can make sure the subject lines are formatted as:
>
>         "KVM: arm64: Super Duper feature enablement"

No problem.

>
> that'd be absolutely awesome (but that's just me being annoying...).
>

I'll do a respin of this in a couple hours.

> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
