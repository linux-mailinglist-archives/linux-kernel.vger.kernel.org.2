Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85255454CEF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 19:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbhKQSVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 13:21:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:53854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhKQSVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 13:21:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D4F261BC1;
        Wed, 17 Nov 2021 18:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637173099;
        bh=WKWLmnSx48KQMhYe8gUkuZfag0aPvWLgOhzHXAyhWUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L21L6Zk5kTpjph3hIFSnqWtMe2depzkRJq0dU6FwlxCq5of6Q5RyTPZDVm+zjSkkm
         /gnQfWAkoJzQ6hRQyN/E5efIdEjcsjL7PwMkOwnsEtjqDF9UmWMyUvzLEB1Uu1OflQ
         JfA45NGRD7FGNVCb68Xn1sqEFmP0bk3Qmz3zjBP0=
Date:   Wed, 17 Nov 2021 19:18:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com, ardb@kernel.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [RFC PATCH 1/5] firmware: Create firmware upload framework
Message-ID: <YZVHaeuYL8QD/7db@kroah.com>
References: <20211111011345.25049-1-russell.h.weight@intel.com>
 <20211111011345.25049-2-russell.h.weight@intel.com>
 <YZUceupQe67KYJyf@kroah.com>
 <c521bc07-0f10-e89e-a59c-b6e07fc35089@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c521bc07-0f10-e89e-a59c-b6e07fc35089@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 10:00:54AM -0800, Russ Weight wrote:
> 
> 
> On 11/17/21 7:15 AM, Greg KH wrote:
> > On Wed, Nov 10, 2021 at 05:13:41PM -0800, Russ Weight wrote:
> >> The Firmware Upload class driver provides a common API for uploading
> >> firmware files to devices.
> > That is exactly what the existing firmware api in the kernel is supposed
> > to be accomplishing.
> >
> > If it is not doing what you need it to do, then you need to document the
> > heck out of why it is not, and why you need a different api for this.  I
> > do not see that here in this changelog at all :(
> This is part of the documentation included later in this patch. I can add
> this to the changelog.
> 
> +Some devices load firmware from on-board FLASH when the card initializes.
> +These cards do not require the request_firmware framework to load the
> +firmware when the card boots, but they to require a utility to allow
> +users to update the FLASH contents.

There's no requirement that request_firmware only be done at boot time,
why not use it at any point in time?

> When you say "existing firmware api", I'm thinking request_firmware, which
> requires that driver names be specified in the kernel config and wants to
> load firmware automatically during device initialization.

It can be used at any time, why do you think it's restricted to init
time?

And I do not understand your issue with driver names.

> Other support under driver/firmware is specific to certain vendors, devices.
> 
> If I add this information to the changelog, is that sufficient?

Nope!

