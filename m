Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63904429EB9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 09:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbhJLHhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 03:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbhJLHhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 03:37:33 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F065C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 00:35:31 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id p16so13323980lfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 00:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PZd2bSE5svn+P10RXeeRDeZcjuwXkvyXwASRR0cwTEo=;
        b=lbEBS2Qka1sOOn/BZKpejk6DRNN96eyCzwf94MrCX5lFnYJ12lYML6h9eCjYcJ2jAn
         0SYlkYOrrYy1Kd4GqyyhCeStdIsdMQbUE2kHevT/TTF943JwHbQbxuKuVr8BQ/bSMDWj
         i/uJmQfCVvwlIKcRyUGsTTa7gJDMwO2jkjwkrbKBJHIHj9KzGEoyXO2NqGDo1/fs6dKc
         Ix4UiQVqK0B4LgfCoRyL4AZv6ptu0ShBbUiKvGmAlTEoKAg8wAsAPT8JIdSCWIHlSzjV
         RltTNDSjRKWAQf95uxiN/eVXCtPxMmC1tSZIR0OpqiNIUDD/dhOmcXyBiLB17dRUFoBH
         cB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PZd2bSE5svn+P10RXeeRDeZcjuwXkvyXwASRR0cwTEo=;
        b=GGFbDmJncof6aH93mFy3GQ94+eLBv3eEy/8cd4XuzxF9k7BjbNtkbUeSnUb7vJWC7K
         LBhAMG1j7xLAeAKvE1vUhfkQLvku9LPUo6AE7TfSo7O4Je5nt/AIcLrq173OvIFGNfFj
         uW8ZwHF8O9xEPv2TM895hiquqFM71NWlDo5lDRFy0jd6KpPB/7IwHg0BrbwnFOCqwhXl
         nPxj0WMBqubsfox9iT/R0WeCSJo6i10cGROefmNpNehhhcvm1/7efEaureOZ7Bamqldq
         obOSDHnu9tVuQIE/e/6jeltTi0D6zjIhL2jvl98rxita1H33QNPLmHVFARjd9w5hIMej
         2+ag==
X-Gm-Message-State: AOAM5330dui56XXJuwNF9IZYktaZTUCZ44ENUtV0/mRX/KtYhut38Il+
        xlSdaipHblFfOop+Pf6Jo/Jzhd2SmU5F8BBfFJya/Q==
X-Google-Smtp-Source: ABdhPJxEPpU5KnEaY2DjvSjui2FAObZ8GF2kzfSut/0a/At4VjJEkYtTYHSKz952MvvNGGEhu5Hz8qVqLTOaig110l4=
X-Received: by 2002:a05:6512:3b94:: with SMTP id g20mr32953344lfv.119.1634024129910;
 Tue, 12 Oct 2021 00:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211006070902.2531311-1-jens.wiklander@linaro.org>
 <20211006070902.2531311-6-jens.wiklander@linaro.org> <20211008132732.hbmkd3hftdydtrsc@bogus>
 <20211008163200.wgls7gijpsk556kl@bogus> <94277064-eff7-cd63-b5cb-d6b53e408e81@forissier.org>
 <CAHUa44GccfP3M3uFPQfH_nUZSOTi_wGV0UhL=iHK8uVL2xWvnA@mail.gmail.com>
In-Reply-To: <CAHUa44GccfP3M3uFPQfH_nUZSOTi_wGV0UhL=iHK8uVL2xWvnA@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 12 Oct 2021 13:05:18 +0530
Message-ID: <CAFA6WYMR1F+zzi=kHpeQD5H_FgDapCt9gEJ1kYKa3a8oTWezdg@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] optee: add FF-A support
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Jerome Forissier <jerome@forissier.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Sughosh Ganu <sughosh.ganu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2021 at 14:59, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> On Fri, Oct 8, 2021 at 9:21 PM Jerome Forissier <jerome@forissier.org> wrote:
> >
> > Hi Sudeep,
> >
> > On 10/8/21 6:32 PM, Sudeep Holla wrote:
> > > On Fri, Oct 08, 2021 at 02:27:32PM +0100, Sudeep Holla wrote:
> > >> On Wed, Oct 06, 2021 at 09:09:02AM +0200, Jens Wiklander wrote:
> > >>> Adds support for using FF-A [1] as transport to the OP-TEE driver.
> > >>>
> > >>> Introduces struct optee_msg_param_fmem which carries all information
> > >>> needed when OP-TEE is calling FFA_MEM_RETRIEVE_REQ to get the shared
> > >>> memory reference mapped by the hypervisor in S-EL2. Register usage is
> > >>> also updated to include the information needed.
> > >>>
> > >>> The FF-A part of this driver is enabled if CONFIG_ARM_FFA_TRANSPORT is
> > >>> enabled.
> > >>>
> > >>
> > >> I am not sure if I missed this with earlier version but I see the below
> > >> warning the second time I insert the optee module. I am sure I tested it
> > >> with previous version when I was fixing issues with FF-A as a module.
> > >>
> > >> Not sure if I am missing something in my steps.
> > >>
> > >
> > > OK, more info, indeed I didn't observe this issue 2 weeks back with optee
> > > at commit 57e642f12085 ("core: enable system PTA upon user TA support").
> > > The UUID(d96a5b40-c3e5-21e3-8794-1002a5d5c61b) wasn't enumerated with above
> > > commit. Today I am testing the latest commit 2de2880065f3 ("core: update
> > > reference link to PrimeCell Cache Controller").
> > >
> > > Though it looks like an issue with the driver, the latest optee changes
> > > triggered the driver to hit this issue in my setup. Hope this helps.
> >
> > Totally makes sense. The optee_os commit triggering this is almost
> > certainly 811c42d40cd0 ("plat-vexpress: enable CFG_ENABLE_EMBEDDED_TESTS
> > by default"). With this commit, the "invoke tests" PTA gets included by
> > default in the TEE binary. This PTA has the TA_FLAG_DEVICE_ENUM flag so
> > it is enumerated by the Linux driver. AFAICT the vexpress platform has
> > no other PTA with that flag, so as you said the OP-TEE commit is simply
> >  exposing a bug in the Linux driver.
> >
> > > IIUC we are not undoing optee_register_device executed via
> > > optee_enumerate_devices in the exit path.
> >

Thanks Sudeep for spotting this issue. I have sent a corresponding fix
[1], give it a try and let me know if you observe any further issues.

[1] https://lkml.org/lkml/2021/10/12/136

-Sumit

> > That doesn't sound good indeed ;)
>
> Thanks for the analysis, I'll look into this.
>
> Cheers,
> Jens
