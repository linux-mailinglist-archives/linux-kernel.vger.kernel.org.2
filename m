Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD014289A8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 11:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbhJKJbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 05:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbhJKJbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 05:31:35 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F76C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 02:29:35 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r18so54083327wrg.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 02:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nJAJrgcCnMwOWbld2/+PFc9x5oKHhJRsTAShtPZJYhk=;
        b=Tx4OphigJi7if4czSFCSshxe+XOMyciSRoNjVPM+181pQgbUt8lzfEkviwNQKYYJSe
         DwVMHZq85IgWIPRcbEEi6jMDrlbTzERJpB5iqwFkodVcP2Hadu9LqLTm6bOFih5WVFZu
         5Bz3br3XolEYSBhgX/hX6JhNG3w1R5XFKgxnpRs+ajha3r/IVEalKQBOPddpLGI0KyPu
         tlDTd42yKJPbEu1+pOsBlwVVR8fGaQlwdjFYeAR4MLrZMWFR+GzNxC+PkorJX0fb/9PR
         7ZYCoWHTN5F6y/DQiw88pCTPPll/J8Nhw2is9mHfIiqoyB6Ha9LKGexkVGc5HPkHiQ6y
         E9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nJAJrgcCnMwOWbld2/+PFc9x5oKHhJRsTAShtPZJYhk=;
        b=fccCYPx3vFlbqkjsj1kU8ww0PcvRcnE6ydvPm4edg5YKC7iOdF/VhfUzpOLYUbskVA
         ceCBDe4Hk6gV/4ZEIz5AS3UaXsP/4G4UOJvTF9ojNa+JbH4cSFCjF8jCRyICi84cWl1q
         N/WApHlFhRNCzeYPxPqVyqFaefrlzSwsIANc9WtsNzV+vWwbau3y19YNeV7KKR7qeKs8
         TDmBXqoAKZrNxuR+7Gjy4fpk89GfOVHHlL9087JCQIW/qRQuhK6i8DgdmvxfWHcCiX1E
         cOI56THhF9snLq4w/hyErcQwoZ/e/tp4tGqWJr7vXdesC+KitWaUpGkYlpa2mp8ElpyY
         jnQQ==
X-Gm-Message-State: AOAM531FNhOIXmqx8axcimhbqeZcMLFDHTZu5emvKMYwOwwVFk/oJ4Dr
        7fivlMY54pwn4lAGbTE390Whaj3xoU7G60Ia4oaIPg==
X-Google-Smtp-Source: ABdhPJySoqj19zEuftkJBquxPQzua5ENfp9F1QfvDtvGFdHNbvon3hQb3lBY8NEoBzNrIF/p67IZm2hEl3QP/0kQm1Q=
X-Received: by 2002:a5d:59aa:: with SMTP id p10mr506626wrr.45.1633944574219;
 Mon, 11 Oct 2021 02:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211006070902.2531311-1-jens.wiklander@linaro.org>
 <20211006070902.2531311-6-jens.wiklander@linaro.org> <20211008132732.hbmkd3hftdydtrsc@bogus>
 <20211008163200.wgls7gijpsk556kl@bogus> <94277064-eff7-cd63-b5cb-d6b53e408e81@forissier.org>
In-Reply-To: <94277064-eff7-cd63-b5cb-d6b53e408e81@forissier.org>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 11 Oct 2021 11:29:23 +0200
Message-ID: <CAHUa44GccfP3M3uFPQfH_nUZSOTi_wGV0UhL=iHK8uVL2xWvnA@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] optee: add FF-A support
To:     Jerome Forissier <jerome@forissier.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Sughosh Ganu <sughosh.ganu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 9:21 PM Jerome Forissier <jerome@forissier.org> wrote:
>
> Hi Sudeep,
>
> On 10/8/21 6:32 PM, Sudeep Holla wrote:
> > On Fri, Oct 08, 2021 at 02:27:32PM +0100, Sudeep Holla wrote:
> >> On Wed, Oct 06, 2021 at 09:09:02AM +0200, Jens Wiklander wrote:
> >>> Adds support for using FF-A [1] as transport to the OP-TEE driver.
> >>>
> >>> Introduces struct optee_msg_param_fmem which carries all information
> >>> needed when OP-TEE is calling FFA_MEM_RETRIEVE_REQ to get the shared
> >>> memory reference mapped by the hypervisor in S-EL2. Register usage is
> >>> also updated to include the information needed.
> >>>
> >>> The FF-A part of this driver is enabled if CONFIG_ARM_FFA_TRANSPORT is
> >>> enabled.
> >>>
> >>
> >> I am not sure if I missed this with earlier version but I see the below
> >> warning the second time I insert the optee module. I am sure I tested it
> >> with previous version when I was fixing issues with FF-A as a module.
> >>
> >> Not sure if I am missing something in my steps.
> >>
> >
> > OK, more info, indeed I didn't observe this issue 2 weeks back with optee
> > at commit 57e642f12085 ("core: enable system PTA upon user TA support").
> > The UUID(d96a5b40-c3e5-21e3-8794-1002a5d5c61b) wasn't enumerated with above
> > commit. Today I am testing the latest commit 2de2880065f3 ("core: update
> > reference link to PrimeCell Cache Controller").
> >
> > Though it looks like an issue with the driver, the latest optee changes
> > triggered the driver to hit this issue in my setup. Hope this helps.
>
> Totally makes sense. The optee_os commit triggering this is almost
> certainly 811c42d40cd0 ("plat-vexpress: enable CFG_ENABLE_EMBEDDED_TESTS
> by default"). With this commit, the "invoke tests" PTA gets included by
> default in the TEE binary. This PTA has the TA_FLAG_DEVICE_ENUM flag so
> it is enumerated by the Linux driver. AFAICT the vexpress platform has
> no other PTA with that flag, so as you said the OP-TEE commit is simply
>  exposing a bug in the Linux driver.
>
> > IIUC we are not undoing optee_register_device executed via
> > optee_enumerate_devices in the exit path.
>
> That doesn't sound good indeed ;)

Thanks for the analysis, I'll look into this.

Cheers,
Jens
