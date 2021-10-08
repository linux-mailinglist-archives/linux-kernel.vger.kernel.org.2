Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E88426F08
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 18:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhJHQeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 12:34:46 -0400
Received: from foss.arm.com ([217.140.110.172]:34696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230216AbhJHQeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 12:34:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 208381063;
        Fri,  8 Oct 2021 09:32:49 -0700 (PDT)
Received: from bogus (unknown [10.57.21.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAC583F66F;
        Fri,  8 Oct 2021 09:32:46 -0700 (PDT)
Date:   Fri, 8 Oct 2021 17:32:00 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        sughosh.ganu@linaro.org
Subject: Re: [PATCH v6 5/5] optee: add FF-A support
Message-ID: <20211008163200.wgls7gijpsk556kl@bogus>
References: <20211006070902.2531311-1-jens.wiklander@linaro.org>
 <20211006070902.2531311-6-jens.wiklander@linaro.org>
 <20211008132732.hbmkd3hftdydtrsc@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008132732.hbmkd3hftdydtrsc@bogus>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 02:27:32PM +0100, Sudeep Holla wrote:
> On Wed, Oct 06, 2021 at 09:09:02AM +0200, Jens Wiklander wrote:
> > Adds support for using FF-A [1] as transport to the OP-TEE driver.
> >
> > Introduces struct optee_msg_param_fmem which carries all information
> > needed when OP-TEE is calling FFA_MEM_RETRIEVE_REQ to get the shared
> > memory reference mapped by the hypervisor in S-EL2. Register usage is
> > also updated to include the information needed.
> >
> > The FF-A part of this driver is enabled if CONFIG_ARM_FFA_TRANSPORT is
> > enabled.
> >
> 
> I am not sure if I missed this with earlier version but I see the below
> warning the second time I insert the optee module. I am sure I tested it
> with previous version when I was fixing issues with FF-A as a module.
> 
> Not sure if I am missing something in my steps.
>

OK, more info, indeed I didn't observe this issue 2 weeks back with optee
at commit 57e642f12085 ("core: enable system PTA upon user TA support").
The UUID(d96a5b40-c3e5-21e3-8794-1002a5d5c61b) wasn't enumerated with above
commit. Today I am testing the latest commit 2de2880065f3 ("core: update
reference link to PrimeCell Cache Controller").

Though it looks like an issue with the driver, the latest optee changes
triggered the driver to hit this issue in my setup. Hope this helps.
IIUC we are not undoing optee_register_device executed via
optee_enumerate_devices in the exit path.

--
Regards,
Sudeep
