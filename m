Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69B33C6F33
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 13:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbhGMLPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 07:15:41 -0400
Received: from foss.arm.com ([217.140.110.172]:41188 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235390AbhGMLPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:15:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 461F61FB;
        Tue, 13 Jul 2021 04:12:50 -0700 (PDT)
Received: from bogus (unknown [10.57.79.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C08BA3F7D8;
        Tue, 13 Jul 2021 04:12:45 -0700 (PDT)
Date:   Tue, 13 Jul 2021 12:11:43 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Etienne CARRIERE <etienne.carriere@st.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>, Marc Zyngier <maz@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jerome Forissier <jerome@forissier.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: Re: [PATCH v2 0/7] Asynchronous notifications from secure world
Message-ID: <20210713111143.g6ztdakegs6ck25s@bogus>
References: <PAXPR10MB4687E737261282B78600272DFD189@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR10MB4687E737261282B78600272DFD189@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2021 at 08:05:57AM +0000, Etienne CARRIERE wrote:
> Hello Sudeep and all,
> 
> On Wed, 7 Jul 2021 at 19:52, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > Hi Sumit,
> >
> > I was holding off you reply as I didn't have all the background on this.
> > Achin did mention that this is preparatory work for FFA notifications.
> > I did mention to him that this is more than that, it is custom extension
> > to address what FF-A notification is trying to in standard way.
> >
> > I share same opinion as Marc Z.
> >
> > On Wed, Jul 07, 2021 at 11:22:23AM +0530, Sumit Garg wrote:
> > > On Tue, 6 Jul 2021 at 18:16, Marc Zyngier <maz@kernel.org> wrote:
> >
> > [...]
> >
> > > >
> > > > I don't care about OP-TEE. If you are proposing a contract between S
> > > > and NS, it has to be TEE and OS independent. That's how the
> > > > architecture works.
> > > >
> > >
> > > Agree, here we are not proposing a common contract among the S and NS
> > > world that every TEE (based on Arm TrustZone) will use to communicate
> > > with REE (Linux in our case) but rather an OP-TEE specific
> > > notifications feature that is built on top of OP-TEE specific ABIs.
> > >
> > > And I can see your arguments coming from an FFA perspective but there
> > > are platforms like the ones based on Armv7 which don't support FFA
> > > ABI. Maybe Jens can elaborate how this feature will fit in when FFA
> > > comes into picture?
> > >
> >
> > I can understand that but won't those platforms add the support both in
> > the kernel(current series) and secure world to address notifications.
> > While you could argue that it is small extension to what is already present
> > but I prefer they support FF-A is they need such a support instead of adding
> > custom mechanisms. It is hard to maintain and each vendor will deviate
> > from this custom mechanism and soon we will have bunch of them to handle.
>
> There exist armv7-a platforms that expect OP-TEE notification support and
> will not move the FF-A, like the stm32mp15. This platform won't move to FF-A
> mainly due to the memory cost of the added SPM layer and the device physical
> constraints.

Fair enough on the use-case and the analysis for not being able to use FF-A.
As you may already know it doesn't simply this problem. This has been
discussed for years and FF-A was assumed to be the solution when FF-A
spec work started.

> We have a usecase for OP-TEE notification. We're working on the integration
> of an SCMI server in OP-TEE. SCMI notification is a feature needed is this
> scope and it requires OP-TEE async notification means as those proposed
> here.
>

I am aware of this use-case, I understand. But I can only share rants
which I know doesn't help much.

> This OP-TEE async notif also brings a lot of value in OP-TEE as it allows a
> OP-TEE secure thread (i.e. executing a trusted application service) to
> gently wait on a secure interrupt (as a slow bus transaction completion or
> many other usecase) with the CPU relaxed. This support is provided by the
> proposed series. I believe existing device should be able to leverage this
> OP-TEE feature without needing their OP-TEE to move to the new FF-A
> interface.
>

While I agree these are nice to have in OPTEE, the timing is just odd.

We are trying hard to push FF-A as standard solution to address all such
issues that couldn't be solved with OPTEE + DT, now we are back to address
the same in parallel to FF-A.

--
Regards,
Sudeep
