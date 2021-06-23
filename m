Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CB73B1A62
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhFWMmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:42:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231135AbhFWMm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:42:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4099B61075;
        Wed, 23 Jun 2021 12:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624452009;
        bh=E2jJiWLflk4zOTprOIP3xybsAuLmX2jkH2ltmG50uzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BRDfzh8xW2f5/Fl3+oLqp/FpUbyRw1f2/BGc++p3YYTOF1kRjN3JfPIHdW6sBUoaw
         F0q3pstRI6JC0z7h1+1BSfywq+7IcoGglYoGO36678+2oYCTEo9g0pRRNK2nuQGEjq
         +H+p2wPZ/9uzvwGVLTStz2cXLnPZIyAzUO/hY8jE=
Date:   Wed, 23 Jun 2021 14:40:07 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Cc:     David Laight <David.Laight@aculab.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "philipp.deppenwiese@immu.ne" <philipp.deppenwiese@immu.ne>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via
 sysfs
Message-ID: <YNMrpzZgH4KECykk@kroah.com>
References: <20210622142334.14883-1-hans-gert.dahmen@immu.ne>
 <5ee9e467bfbf49d29cb54679d2dce1c3@AcuMS.aculab.com>
 <d61176a0-67cf-268f-8c31-8de8739753c3@immu.ne>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d61176a0-67cf-268f-8c31-8de8739753c3@immu.ne>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 02:17:54PM +0200, Hans-Gert Dahmen wrote:
> Hi,
> 
> these are some good points.
> 
> On 23.06.21 00:18, David Laight wrote:
> > Are you saying that my 15 year old 64bit Athlon cpu and bios
> > have this large SPI flash
> 
> No. The reads will wrap, i.e. if your flash is 2MB then it would be repeated
> 8 times in the 16MB window.
> 
> > and the required hardware to
> > convert bus cycles to serial spi reads?
> 
> Yes. The window is part of the DMI interface and the south bridge or PCH
> converts the bus cycles to SPI reads. It is because this region contains the
> reset vector address of your CPU and the very first instruction it executes
> after a reset when the internal setup is done will actually be loaded from
> the serial SPI bus. It is AFAIK part of AMD's original 64-bit specification.
> 
> However, after reading your mail I understand that I should have looked up
> the exact explanations in the respective specs. So to definitively answer
> your question I need to know which south bridge there is in your 15 year old
> system and have a look into its datasheet. Do you know which one it is by
> any chance?

The point is that you will never be able to do this for all devices.
You should ONLY be allowed to have this module bind to the hardware that
you KNOW it will work with.

So please work off of a DMI table, or some such hardware description,
instead of just blindly enabling it for all systems.

thanks,

greg k-h
