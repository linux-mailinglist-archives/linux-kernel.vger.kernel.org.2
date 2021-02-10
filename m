Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E283163DC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 11:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhBJKbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 05:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhBJKTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 05:19:34 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9626AC06178A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 02:18:54 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id v3so1117486qtw.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 02:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=baxcKrCgkoScFUDNAwKsa84jVZFHv1nVp34webfNPW4=;
        b=FMzLIjunyqiHNiUcPvkqjDQKBNtMZFSJVGEPJfUVMDqvrc/fzg9Nb4FG7kVjduLgXB
         EP3sCzCQRAKuTEHztB6GWafxqQAYW53oatc5Vs+ENMIsF/z63khBAKiPab/05HGlBsm4
         qNGb3KtRaLxNLMtTdC/WtCNJaK9NMwUP5bBLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=baxcKrCgkoScFUDNAwKsa84jVZFHv1nVp34webfNPW4=;
        b=ahGfSIyhk2ePmRkv7TOYsF0WLeqIOQNndrV2uLha2qkCVBtvMCF58KUn4mqP0mmQWZ
         JWcU1DOS3qWYX+vlnBC4nPAj0DFlwvAIe0VjyTfgFF32YtgRXZ9kn6Smi4y6QaWRGpvQ
         iv7EV4YCjrAvNTpZsbaKq3+X9dh/u4p3GU/kCO6CNhYbeJQYdaOcmogJ/Yjyz2hLeDyL
         xEcLrPGNc0lklfXAR63UxSerRo0b//4nZciv2TkxqG2ova7lo2Ynmzmlv+2BWwAon3tu
         DKotevTgurHJeJt3lpIUpTSZ1bebj93GwKJcwsgx4RkpDRASYhekvznSTaM38brhJd0U
         rL4w==
X-Gm-Message-State: AOAM532AA5At+249iP8poXnIZd2wutOSu0BddnBx13ogDJWONXjywKO5
        Xmpa2zlTWJT9ZbGLm5lm+bIDMUexyFxoCEeMJXo=
X-Google-Smtp-Source: ABdhPJx8EwJMSfm1WnKBn8E5s6t3mQThpXYQTyVN5sLS/BAw6cQj9PKEjrp9ONWSXAMxw7s+zOrssnSpZXkZO5vOhFM=
X-Received: by 2002:ac8:5156:: with SMTP id h22mr2122208qtn.176.1612952333710;
 Wed, 10 Feb 2021 02:18:53 -0800 (PST)
MIME-Version: 1.0
References: <20201208091748.1920-1-wangzhiqiang.bj@bytedance.com>
 <HK0PR06MB33807C054FCE9E355346E204F2D00@HK0PR06MB3380.apcprd06.prod.outlook.com>
 <CAK8P3a2WPvWokkqJB-yhfQH1ofofGNvibqPjUXPme+F2LCHjxw@mail.gmail.com>
 <HK0PR06MB3380A1F79CDE49FACC1A3E71F2A60@HK0PR06MB3380.apcprd06.prod.outlook.com>
 <CAK8P3a1g8szrHnhOxjwFkwYt+P5ukawZRr7jbwtJLVyFVHS21g@mail.gmail.com>
In-Reply-To: <CAK8P3a1g8szrHnhOxjwFkwYt+P5ukawZRr7jbwtJLVyFVHS21g@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 10 Feb 2021 10:18:40 +0000
Message-ID: <CACPK8XdzLOQKe_v2BK=iTFonrw2V2NgYYqwiWky-PPzxs11iAg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] misc: Add clock control logic into Aspeed LPC
 SNOOP driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ryan Chen <ryan_chen@aspeedtech.com>,
        John Wang <wangzhiqiang.bj@bytedance.com>,
        "xuxiaohan@bytedance.com" <xuxiaohan@bytedance.com>,
        "yulei.sh@bytedance.com" <yulei.sh@bytedance.com>,
        Robert Lippert <rlippert@google.com>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Jae Hyun Yoo <jae.hyun.yoo@intel.com>,
        Patrick Venture <venture@google.com>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        Joel Stanley <joel@linux.ibm.com>,
        Andrew Jeffery <andrewrj@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Feb 2021 at 01:43, Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Sat, Jan 16, 2021 at 2:03 AM Ryan Chen <ryan_chen@aspeedtech.com> wrote:
> > >
> > > Sorry it did not make it into the merge window. The patch is still in patchwork.
> > > I could just pick it up directly for v5.12, or wait for a combined pull request
> > > with other work.
> >
> > Hello Arnd,
> > Thanks your update.
> >
> > >Joel, please let me know what you prefer.
> > >
> > Hello Joel,
> > Could you help check on this patch?
> > https://patchwork.ozlabs.org/project/linux-aspeed/patch/20200928070108.14040-2-ryan_chen@aspeedtech.com/

Sure, I'll respond to that thread separately.

> Hi Joel,
>
> I see there has been no new pull request for mach-aspeed in
> v5.12. If you have any material at all, please send it as soon
> as you can so I can pick it up this time.

There are some patches that I have queued up. As you can see I have
been a bit behind this cycle.

I'll get a pull request to you today. Thanks for the reminder.

Cheers,

Joel

>
> As a reminder, the patch here has still not been merged, as I
> never heard back from you.
>
>        Arnd
