Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5783808FC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 13:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhENL4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:56:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231394AbhENL4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:56:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 735DD61458;
        Fri, 14 May 2021 11:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620993299;
        bh=NG4DrwRVQ5xszL8MoYeQgVwQUIgkAYcP6HM8rAN+ujY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R03cKXTOhfGnEErqTh4U5ZlIgS19j2yBjE0tgdTdbMSS2ArKUFnaVN24uGZ66k8un
         W+moaKDuXrDwipRRlI2xg/hCePEzKNR6BriqXSUv15gQClszugUYKzcx/ZsJ9szMzA
         S8EAG/5se8s6HefQdiu5XDTtKfKg8Y4TM7F839I8=
Date:   Fri, 14 May 2021 13:54:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     Bixuan Cui <cuibixuan@huawei.com>, linux-kernel@vger.kernel.org,
        hsweeten@visionengravers.com, grandmaster@al2klimov.de
Subject: Re: [PATCH -next v2] staging: =?utf-8?Q?co?=
 =?utf-8?Q?medi=3A_Remove_unused_variable_=E2=80=98min=5Ffull=5Fscale?=
 =?utf-8?B?4oCZ?= and function 'get_min_full_scales'
Message-ID: <YJ5lEJNaiKfYjFPV@kroah.com>
References: <20210514085214.53941-1-cuibixuan@huawei.com>
 <YJ4sLVlncZoQkNJm@kroah.com>
 <25e0e925-cc90-3e88-a3bd-15b70cb7b4ec@mev.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25e0e925-cc90-3e88-a3bd-15b70cb7b4ec@mev.co.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 12:16:11PM +0100, Ian Abbott wrote:
> On 14/05/2021 08:52, Greg KH wrote:
> > On Fri, May 14, 2021 at 04:52:14PM +0800, Bixuan Cui wrote:
> > > The variable ‘min_full_scale’ and function 'get_min_full_scales' are
> > > not used, So delete them.
> > > 
> > > Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> > > ---
> > > Changes from v2:
> > > * Delete function 'get_min_full_scales'
> > > 
> > >   drivers/comedi/drivers/jr3_pci.c | 15 ---------------
> > >   1 file changed, 15 deletions(-)
> > > 
> > > diff --git a/drivers/comedi/drivers/jr3_pci.c b/drivers/comedi/drivers/jr3_pci.c
> > > index 7a02c4fa3cda..f963080dd61f 100644
> > > --- a/drivers/comedi/drivers/jr3_pci.c
> > > +++ b/drivers/comedi/drivers/jr3_pci.c
> > > @@ -186,19 +186,6 @@ static void set_full_scales(struct jr3_sensor __iomem *sensor,
> > >   	set_s16(&sensor->command_word0, 0x0a00);
> > >   }
> > > -static struct six_axis_t get_min_full_scales(struct jr3_sensor __iomem *sensor)
> > > -{
> > > -	struct six_axis_t result;
> > > -
> > > -	result.fx = get_s16(&sensor->min_full_scale.fx);
> > > -	result.fy = get_s16(&sensor->min_full_scale.fy);
> > > -	result.fz = get_s16(&sensor->min_full_scale.fz);
> > > -	result.mx = get_s16(&sensor->min_full_scale.mx);
> > > -	result.my = get_s16(&sensor->min_full_scale.my);
> > > -	result.mz = get_s16(&sensor->min_full_scale.mz);
> > > -	return result;
> > 
> > Are you _SURE_ that this is ok to do?  You are reading from the
> > hardware, and that is sometimes required depending on the
> > internal-to-the-device state machine.
> > 
> > Have you tested to verify that not doing these reads does not break
> > something?
> > 
> > This is a constant theme in these "remove variables that are not being
> > used" patches, please be aware that how hardware works is very specific
> > and when you mess with how it is accessed, that has the chance of
> > causing problems.
> 
> I don't think removing this would do any harm.  The `get_s16` function is
> just a simple wrapper around `readl` that converts the type of the returned
> value to `s16`.  The registers for minimum full scale and maximum full scale
> are just informational, and there is nothing in the manual[1] about reading
> registers in a particular order.  The driver used to print these values to
> the kernel log, but that code was removed in commit a1d16659538a ("staging:
> comedi: jr3_pci: remove noisy printk").
> 
> [1] 5907E - Legacy PCI Receiver Manual
> <https://www.jr3.com/component/phocadownload/category/6-product-manuals?download=36:5907e-legacy-pci-receiver-manual>
> 

Ok, can I get a "reviewed-by:" then?

thanks,

greg k-h
