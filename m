Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A5331EAF6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 15:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbhBRO1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 09:27:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:48256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232880AbhBRMa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:30:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3235561606;
        Thu, 18 Feb 2021 12:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613650902;
        bh=CUww4FNDgNjjJjf/yyPWIgKqj1HTk3NtzRSjQFCapKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FlDoOSuUHovzDqBvRiOlwNR3SfkvOcyrC3EaJSt3ZzMrWcPT2LEEvJVpPgVjp5BhZ
         VctfId5+8Ul5ysBiHakMwI3SbY1ZGucHPJMF5++Xmj+CsHkS88odCKL2qTHveFSqlC
         S01jS5sZ8l4Dg04aSNXiyqK16ZOkKfmnhiigiuyU=
Date:   Thu, 18 Feb 2021 13:21:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shile Zhang <shile.zhang@linux.alibaba.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc/pvpanic: Export module FDT device table
Message-ID: <YC5b1G7RmsZFeSBq@kroah.com>
References: <20210218094024.69354-1-shile.zhang@linux.alibaba.com>
 <YC46tZLAesfSNg40@kroah.com>
 <9dc35ee1-cf67-e434-c641-d2822ad0f6a7@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dc35ee1-cf67-e434-c641-d2822ad0f6a7@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 06:51:08PM +0800, Shile Zhang wrote:
> 
> 
> On 2021/2/18 18:00, Greg Kroah-Hartman wrote:
> > On Thu, Feb 18, 2021 at 05:40:24PM +0800, Shile Zhang wrote:
> > > Export the module FDT device table to ensure the FDT compatible strings
> > > are listed in the module alias. This help the pvpanic driver can be
> > > loaded on boot automatically not only the ACPI device, but also the FDT
> > > device.
> > > 
> > > Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
> > > ---
> > >   drivers/misc/pvpanic.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
> > > index 41cab297d66e..2356d621967e 100644
> > > --- a/drivers/misc/pvpanic.c
> > > +++ b/drivers/misc/pvpanic.c
> > > @@ -92,6 +92,7 @@ static const struct of_device_id pvpanic_mmio_match[] = {
> > >   	{ .compatible = "qemu,pvpanic-mmio", },
> > >   	{}
> > >   };
> > > +MODULE_DEVICE_TABLE(of, pvpanic_mmio_match);
> > 
> > What caused this to not work properly?  I.e. should there be a "Fixes:"
> > tag in the commit changelog as well?
> 
> Sorry, I think it should be:
> 
> Fixes: 46f934c9a12fc ("misc/pvpanic: add support to get pvpanic device info
> FDT")
> 
> Shall I sent v2 with this update?

Yes please.
