Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8EF30EB92
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 05:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhBDEd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 23:33:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:47222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229609AbhBDEdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 23:33:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4F5064E0A;
        Thu,  4 Feb 2021 04:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612413165;
        bh=Ue3Xs9wUJgj8n2DPAwzxQPz9+XDAeJ1+dP20Be2cMmc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kcPYaqRHlCzbhoaLfnC7CyocyIw09KlkNAanE/fLzAfRxSR0rdNVXPpmrzhfL+HAH
         /k+KNAQxTN4mCmAXhxX6BlRb2mn0JTPuUMlfhQW82iIDeK4HTU1EkrVSMW4qt1ONOg
         w1sfUAYnTRgnL739k/25VCaW9hpYX/rKquYyqEopm6sPLli8t51AzdTNH9wjfaXbrY
         efujbLozFRDsJfe13TnRxdZj4L9KKMonANdINkEq6QHBtqNyamPANdU6pAEcs1UZDJ
         M12hYgkvbx9iUq1/FCs/ysUqKU9ABIhpQJMeS41kuVXP7YspLOqb8ljp273CkXZ8UB
         UDoPNwM5vxiZQ==
Received: by mail-lj1-f176.google.com with SMTP id f2so1770967ljp.11;
        Wed, 03 Feb 2021 20:32:44 -0800 (PST)
X-Gm-Message-State: AOAM530DatMhVw0/d+bMLYPMAwZzSJwa/97lNuL6FYsOqWYXA7RgIUtW
        2cpJcMChOTj+DKttz08Hgb4cwn3XAS426ojhTH4=
X-Google-Smtp-Source: ABdhPJwEAuRxQ4vVpWDAsPEZhML2MX4H3MeAubmQ6/1kmFd2jhVHIwzOpEC2bQi2+maalynHoa+xpMePe7ea04vw+gE=
X-Received: by 2002:a2e:921a:: with SMTP id k26mr2096814ljg.238.1612413163027;
 Wed, 03 Feb 2021 20:32:43 -0800 (PST)
MIME-Version: 1.0
References: <20210203134834.2367593-1-guoren@kernel.org> <652791212cbf9c05a9d83b6da5a83520@kernel.org>
In-Reply-To: <652791212cbf9c05a9d83b6da5a83520@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 4 Feb 2021 12:32:31 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTmBUjrTVmQ+CqGtYtBkLO6C5WguWsT7+rFLOp4n=9diA@mail.gmail.com>
Message-ID: <CAJF2gTTmBUjrTVmQ+CqGtYtBkLO6C5WguWsT7+rFLOp4n=9diA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers/irqchip: Fixup csky,mpintc compile error with CPU_CK610
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Marc,

On Wed, Feb 3, 2021 at 11:44 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2021-02-03 13:48, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The irq-csky-mpintc.c only could support CPU_CK860 and it will
> > compile error with CPU_CK610.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > ---
> >  drivers/irqchip/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index b147f22a78f4..9be2dd5c6380 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -433,7 +433,7 @@ config QCOM_PDC
> >
> >  config CSKY_MPINTC
> >       bool "C-SKY Multi Processor Interrupt Controller"
> > -     depends on CSKY
> > +     depends on CSKY && CPU_CK860
> >       help
> >         Say yes here to enable C-SKY SMP interrupt controller driver used
> >         for C-SKY SMP system.
>
> I'm not convinced this is the right fix.
>
> You already select CSKY_MPINTC only when CPU_CK860 is selected,
> so preventing the user from selecting it should simply be a matter
> of dropping the string after bool.
Yes, you are right. I will change it into arch/csky.


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
