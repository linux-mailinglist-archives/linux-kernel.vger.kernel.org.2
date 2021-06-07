Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAF339E6AD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 20:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhFGSaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 14:30:08 -0400
Received: from foss.arm.com ([217.140.110.172]:39934 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230253AbhFGSaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 14:30:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBA6912FC;
        Mon,  7 Jun 2021 11:28:15 -0700 (PDT)
Received: from bogus (unknown [10.57.73.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E3F83F73D;
        Mon,  7 Jun 2021 11:28:13 -0700 (PDT)
Date:   Mon, 7 Jun 2021 19:27:54 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [RFC PATCH 01/10] firmware: arm_scmi: Reset properly xfer SCMI
 status
Message-ID: <20210607182754.3wsmhc2t5mh36ycm@bogus>
References: <20210606221232.33768-1-cristian.marussi@arm.com>
 <20210606221232.33768-2-cristian.marussi@arm.com>
 <20210607173809.et6fzayvubsosvso@bogus>
 <20210607180137.GB40811@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210607180137.GB40811@e120937-lin>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 07:01:37PM +0100, Cristian Marussi wrote:
> On Mon, Jun 07, 2021 at 06:38:09PM +0100, Sudeep Holla wrote:
> > On Sun, Jun 06, 2021 at 11:12:23PM +0100, Cristian Marussi wrote:
> > > When an SCMI command transfer fails due to some protocol issue an SCMI
> > > error code is reported inside the SCMI message payload itself and it is
> > > then retrieved and transcribed by the specific transport layer into the
> > > xfer.hdr.status field by transport specific .fetch_response().
> > >
> > > The core SCMI transport layer never explicitly reset xfer.hdr.status,
> > > so when an xfer is reused, if a transport misbehaved in handling such
> > > status field, we risk to see an invalid ghost error code.
> > >
> > > Reset xfer.hdr.status to SCMI_SUCCESS right before each transfer is
> > > started.
> > >
> >
> > Any particular reason why it can't be part of xfer_get_init which has other
> > initialisations ? If none, please move it there.
> >
>
> Well it was there initially then I moved it here.
>
> The reason is mostly the same as the reason for the other patch in this
> series that adds a reinit_completion() in this same point: the core does
> not forbid to reuse an xfer multiple times, once obtained with xfer_get()
> or xfer_get_init(), and indeed some protocols do such a thing: they
> implements such do_xfer looping and bails out on error.
>

Makes sense. But it is okay to retain xfer->transfer_id for every transfer
in such a loop ?

> In the way that it is implemented now in protocols poses no problem
> indeed because the do_xfer loop bails out on error and the xfer is put,
> but as soon as some protocol is implemented that violates this common
> practice and it just keeps on reuse an xfer after an error fo other
> do_xfers() this breaks...so it seemed more defensive to just reinit the
> completion and the status before each send.

Fair enough. But they use it to send same message I guess, may be if it
gave error or something ? I would like to really know such a sequence
instead of assisting that 😉. 

--
Regards,
Sudeep
