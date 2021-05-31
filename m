Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553B6396569
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 18:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbhEaQex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 12:34:53 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:37308 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232633AbhEaOsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 10:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=XAT0o2UkIEm8i9ELaLVy9P23UNLzmSAUypWuOFFHxrw=; b=e39GbPDk5a6QfggflL2syvWB4o
        aSwOStt6VWu6esHekyvSumVz2c4EWjJOJKHlbCzGGTZ9TmfzvQdaQ4rokYS9jveFQxFHOvAVBK5di
        OgM5Y15U1g/CMDV/Mpi/SyZMbNJIEhwyKAWVht5lFOTvgi+uc92c4QDmkqXVm3k2bP8U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1lnjBM-0079dk-72; Mon, 31 May 2021 16:46:20 +0200
Date:   Mon, 31 May 2021 16:46:20 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rich Felker <dalias@libc.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko]
 undefined!
Message-ID: <YLT2vB0GwC1sJesL@lunn.ch>
References: <202105300736.7wVLvXHr-lkp@intel.com>
 <a0edf640-ec05-524e-9125-44decba27bbb@infradead.org>
 <d4c47108-f4d2-4850-14fd-b4c4bd0e0591@infradead.org>
 <CAMuHMdW1xZ-vJe2eOehNSKCP3T=-eq7ji4MBo3D6oGJyPNXGDw@mail.gmail.com>
 <0717b3a5-d838-e1ed-a4ac-80cf14f3a6aa@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0717b3a5-d838-e1ed-a4ac-80cf14f3a6aa@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > No, we should just fix the driver instead.
> > 
> > +               /* Wait 1000 clocks so we don't saturate the RSL bus
> > +                * doing reads.
> > +                */
> > +               __delay(1000);
> > 
> > As this is used only on Cavium Octeon and Thunder SoCs, running
> > at 400-600 MHz resp. 1800-2000 Mhz, what about replacing the __delay()
> > call by a call to udelay(1) or udelay(2)?
> 
> Yeah, I was planning to look into that change this week,
> but it would probably be better for David to do it.

If you look at the bigger picture, using linux/iopoll.h would be a
better solution.

       Andrew
