Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8563AE57E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 11:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhFUJDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 05:03:47 -0400
Received: from foss.arm.com ([217.140.110.172]:58858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhFUJDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 05:03:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B521E1FB;
        Mon, 21 Jun 2021 02:01:31 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A6D13F718;
        Mon, 21 Jun 2021 02:01:29 -0700 (PDT)
Date:   Mon, 21 Jun 2021 10:01:26 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Peter Hilber <peter.hilber@opensynergy.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Igor Skalkin <igor.skalkin@opensynergy.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        souvik.chakravarty@arm.com, alex.bennee@linaro.org,
        jean-philippe@linaro.org, mikhail.golubev@opensynergy.com,
        anton.yakovlev@opensynergy.com,
        Vasyl Vavrychuk <Vasyl.Vavrychuk@opensynergy.com>,
        Andriy Tryshnivskyy <Andriy.Tryshnivskyy@opensynergy.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH v3 01/12] firmware: arm_scmi, smccc, mailbox: Make
 shmem based transports optional
Message-ID: <20210621090126.GA50227@e120937-lin>
References: <20210511002040.802226-1-peter.hilber@opensynergy.com>
 <20210511002040.802226-2-peter.hilber@opensynergy.com>
 <CABb+yY2q8Vw90=qEiNSOUZ39ZmX0ECShTvSidLoYCuZ-xGy-Mg@mail.gmail.com>
 <20210621085431.whk5z3gohk3pb6j7@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621085431.whk5z3gohk3pb6j7@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 21, 2021 at 09:54:31AM +0100, Sudeep Holla wrote:
> On Sun, Jun 20, 2021 at 11:09:21PM -0500, Jassi Brar wrote:
> > On Mon, May 10, 2021 at 7:22 PM Peter Hilber
> > <peter.hilber@opensynergy.com> wrote:
> > 
> > .....
> > 
> > > --- a/drivers/mailbox/Kconfig
> > > +++ b/drivers/mailbox/Kconfig
> > > @@ -1,6 +1,7 @@
> > >  # SPDX-License-Identifier: GPL-2.0-only
> > >  menuconfig MAILBOX
> > >         bool "Mailbox Hardware Support"
> > > +       select ARM_SCMI_HAVE_SHMEM
> > >         help
> > >           Mailbox is a framework to control hardware communication between
> > >           on-chip processors through queued messages and interrupt driven
> > >
> > Isn't this too generic?
> > Not all platforms, with a mailbox controller, use SCMI as the protocol.
> >
> 
> Yikes! I agree Jassi, this looks super hack.
> 

Yes indeed, I have still to rework this part of the series.

(@Jassi: I'm reworking this series starting from the work done by Peter up to
V3, since it needed some core SCMI transport rework to ease implememtation of
virtio-scmi transport)

Thanks,
Cristian

> -- 
> Regards,
> Sudeep
