Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D93B315C68
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbhBJBiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:38:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:55012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234388AbhBIX2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 18:28:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DFA564E3F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 23:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612913249;
        bh=3vU0Uy3HSkxGGNDAunWUhBn2Lv70jpf5UWvjN+nChAE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UYgVK3imMkUdJR47b4zXfpcL3Wt0HXa/W++x7hCggRMb+o2eoIJfenAtuBcBsxjkP
         TK6EUsRAbTq/HDfLB66mEAE6IP4RT4C9EDkjGQGIVgUBIwkEUdzaBh3HadjIn8LvGp
         9DOWU/5qM3oMneZYr16z0y8jyAR9nMmVAWB03VcSajNcSqjnUrnKKeP40eddKso8pz
         5UTWnXaDOnNNNUtcmdJ5s5KPUrMK2O7FS7332vaUKpJV2xxcYzzBMSMf6JwKISTAe9
         N3ba3L+lukmKeRJ5aT218Mx0tww7bJqcFfEAZwQaDW9on3y8jC/dJ1wZVznf0yus4a
         rqxbPI4hGXujw==
Received: by mail-ot1-f53.google.com with SMTP id y11so155597otq.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 15:27:29 -0800 (PST)
X-Gm-Message-State: AOAM531rJyX/xBEW7Ps/Ctdnsbpfi/Cl+yDW9O6hBlO35jjbMdouMClT
        5WzbCm5m6I/KG6gniE5FaqThKyTkqzXRPCxQ3rs=
X-Google-Smtp-Source: ABdhPJwjgBTaSG9EOqxnTvcLwfqEElK3d/DzjLqI0xBj4lU6eEGJ52F5b0KPivFKoiRhdtMvl9c1LkFhNkmzSkqFtdA=
X-Received: by 2002:a9d:3403:: with SMTP id v3mr39086otb.305.1612913248471;
 Tue, 09 Feb 2021 15:27:28 -0800 (PST)
MIME-Version: 1.0
References: <20201208091748.1920-1-wangzhiqiang.bj@bytedance.com>
 <HK0PR06MB33807C054FCE9E355346E204F2D00@HK0PR06MB3380.apcprd06.prod.outlook.com>
 <CAK8P3a2WPvWokkqJB-yhfQH1ofofGNvibqPjUXPme+F2LCHjxw@mail.gmail.com> <HK0PR06MB3380A1F79CDE49FACC1A3E71F2A60@HK0PR06MB3380.apcprd06.prod.outlook.com>
In-Reply-To: <HK0PR06MB3380A1F79CDE49FACC1A3E71F2A60@HK0PR06MB3380.apcprd06.prod.outlook.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 10 Feb 2021 00:27:12 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1g8szrHnhOxjwFkwYt+P5ukawZRr7jbwtJLVyFVHS21g@mail.gmail.com>
Message-ID: <CAK8P3a1g8szrHnhOxjwFkwYt+P5ukawZRr7jbwtJLVyFVHS21g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] misc: Add clock control logic into Aspeed LPC
 SNOOP driver
To:     Ryan Chen <ryan_chen@aspeedtech.com>
Cc:     John Wang <wangzhiqiang.bj@bytedance.com>,
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

On Sat, Jan 16, 2021 at 2:03 AM Ryan Chen <ryan_chen@aspeedtech.com> wrote:
> >
> > Sorry it did not make it into the merge window. The patch is still in patchwork.
> > I could just pick it up directly for v5.12, or wait for a combined pull request
> > with other work.
>
> Hello Arnd,
> Thanks your update.
>
> >Joel, please let me know what you prefer.
> >
> Hello Joel,
> Could you help check on this patch?
> https://patchwork.ozlabs.org/project/linux-aspeed/patch/20200928070108.14040-2-ryan_chen@aspeedtech.com/

Hi Joel,

I see there has been no new pull request for mach-aspeed in
v5.12. If you have any material at all, please send it as soon
as you can so I can pick it up this time.

As a reminder, the patch here has still not been merged, as I
never heard back from you.

       Arnd
