Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267B43AE55B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhFUI5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:57:08 -0400
Received: from foss.arm.com ([217.140.110.172]:58774 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230272AbhFUI5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:57:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A31371FB;
        Mon, 21 Jun 2021 01:54:53 -0700 (PDT)
Received: from bogus (unknown [10.57.36.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A9C13F718;
        Mon, 21 Jun 2021 01:54:50 -0700 (PDT)
Date:   Mon, 21 Jun 2021 09:54:31 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Peter Hilber <peter.hilber@opensynergy.com>,
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
        Cristian Marussi <cristian.marussi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH v3 01/12] firmware: arm_scmi, smccc, mailbox: Make
 shmem based transports optional
Message-ID: <20210621085431.whk5z3gohk3pb6j7@bogus>
References: <20210511002040.802226-1-peter.hilber@opensynergy.com>
 <20210511002040.802226-2-peter.hilber@opensynergy.com>
 <CABb+yY2q8Vw90=qEiNSOUZ39ZmX0ECShTvSidLoYCuZ-xGy-Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY2q8Vw90=qEiNSOUZ39ZmX0ECShTvSidLoYCuZ-xGy-Mg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2021 at 11:09:21PM -0500, Jassi Brar wrote:
> On Mon, May 10, 2021 at 7:22 PM Peter Hilber
> <peter.hilber@opensynergy.com> wrote:
> 
> .....
> 
> > --- a/drivers/mailbox/Kconfig
> > +++ b/drivers/mailbox/Kconfig
> > @@ -1,6 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  menuconfig MAILBOX
> >         bool "Mailbox Hardware Support"
> > +       select ARM_SCMI_HAVE_SHMEM
> >         help
> >           Mailbox is a framework to control hardware communication between
> >           on-chip processors through queued messages and interrupt driven
> >
> Isn't this too generic?
> Not all platforms, with a mailbox controller, use SCMI as the protocol.
>

Yikes! I agree Jassi, this looks super hack.

-- 
Regards,
Sudeep
