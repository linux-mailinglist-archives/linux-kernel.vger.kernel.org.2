Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97DC1458DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 12:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239422AbhKVL4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 06:56:01 -0500
Received: from foss.arm.com ([217.140.110.172]:40450 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230425AbhKVL4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 06:56:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B96D6D;
        Mon, 22 Nov 2021 03:52:54 -0800 (PST)
Received: from bogus (unknown [10.57.46.248])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC9913F73B;
        Mon, 22 Nov 2021 03:52:52 -0800 (PST)
Date:   Mon, 22 Nov 2021 11:52:50 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steven Price <steven.price@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] firmware: smccc: Fix check for ARCH_SOC_ID not
 implemented
Message-ID: <20211122115250.zlk4az3idtqhlm3z@bogus>
References: <1637365141-16823-1-git-send-email-mikelley@microsoft.com>
 <20211122083503.umkqv2t75osypsbx@bogus>
 <CAK8P3a2c_Cw1p_3GpnwJ9ycRjAEDyLSsRMuK12w0TYNYQ2xh7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2c_Cw1p_3GpnwJ9ycRjAEDyLSsRMuK12w0TYNYQ2xh7Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 11:56:16AM +0100, Arnd Bergmann wrote:
> On Mon, Nov 22, 2021 at 9:35 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > On Fri, Nov 19, 2021 at 03:39:01PM -0800, Michael Kelley wrote:
> > > The ARCH_FEATURES function ID is a 32-bit SMC call, which returns
> > > a 32-bit result per the SMCCC spec.  Current code is doing a 64-bit
> > > comparison against -1 (SMCCC_RET_NOT_SUPPORTED) to detect that the
> > > feature is unimplemented.  That check doesn't work in a Hyper-V VM,
> > > where the upper 32-bits are zero as allowed by the spec.
> > >
> > > Cast the result as an 'int' so the comparison works. The change also
> > > makes the code consistent with other similar checks in this file.
> > >
> > > Fixes: 821b67fa4639 ("firmware: smccc: Add ARCH_SOC_ID support")
> >
> > Good catch.
> >
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> > Can you please re-post with my review tag keeping arm@kernel.org and
> > soc@kernel.org ? I don't have any other fixes at the moment, we can
> > ask SoC maintainers to fix this up directly.
>
> In general, I think the easiest way would be for you to forward the
> patch with your Signed-off-by, when you don't have other material
> for a pull request.
>

Thanks for the tip, I will follow that in future.

> I've applied this patch from the list now.
>

Thanks for that.

--
Regards,
Sudeep
