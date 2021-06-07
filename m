Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26DA39E6B6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 20:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhFGSfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 14:35:25 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:40649 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhFGSfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 14:35:24 -0400
Received: by mail-pg1-f180.google.com with SMTP id j12so14491146pgh.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 11:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+e6j0DkhXs3c5ZQ2veNO7IXOw8xfMmU+JwFBGETHbB4=;
        b=esS2wXIpTMmyEb3BcLL2uwFPK4JYIbUbezpQ27/MnSETF/F3Gop/j2gmnXPCAuC/uf
         fT4y+JvbR7iro7flaDlpjc+EVcGkOK7qNbU743WYVTUcXtriGZYuWI4NzJg0ebkdcUrN
         Mj+9aJSqhRSVt6et3akwqFQx8WIjDRQ/DpjoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+e6j0DkhXs3c5ZQ2veNO7IXOw8xfMmU+JwFBGETHbB4=;
        b=rJxyS/15WQenNgmvhPRqLGE2RTI1rSS1Eve9JgWARckSJQ3P21hlzEgzRUME4ZxRsp
         XZsYYhmApjDS78nkh9tsFaMRIvuVmf2ekYA890UgNrjUjEUl/s79dPYdSgGSPJoj2oC7
         BD9SGdbtAcedyaIxx9c3JNRsAgPe8/symYJojo/Qx5EUXIGykxgKAF1p7kPU4H0H31sn
         jzRrIml8TptWbwCW9uZpeuYAIwKlax9Jcd/B+tawA6kS5+99V66dy1S34cGugGLEocJ3
         BC+XYRST4WqH5VbTzoy+WFgDtcRqjQFlr409c0znY25DhsGBplELqo7WBWBvoj3g2hCO
         MEkw==
X-Gm-Message-State: AOAM532AL+Su59H8QzEa+kUpQOvJH034Rm4ThObcuhk9Kfsa2B6mg0Yz
        C4tCjorSpeLV3TXdkar2cmssaQ==
X-Google-Smtp-Source: ABdhPJzi3DYzJwI/BVZMs7JCqw91yLvsX1cRd0demFVjrZqacogwt7V3Qh18aO2T3hK84psz9cWdNA==
X-Received: by 2002:a63:e316:: with SMTP id f22mr18654277pgh.100.1623090752641;
        Mon, 07 Jun 2021 11:32:32 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:312d:da15:9317:e223])
        by smtp.gmail.com with UTF8SMTPSA id l3sm9504603pgb.77.2021.06.07.11.32.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 11:32:32 -0700 (PDT)
Date:   Mon, 7 Jun 2021 11:32:31 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel test robot <lkp@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        kbuild-all@lists.01.org, Michal Simek <monstr@monstr.eu>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        linux-usb@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 2/5] USB: misc: Add onboard_usb_hub driver
Message-ID: <YL5mP4lGoiHNjAYN@google.com>
References: <20210604144027.v11.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <202106050751.uNo0uAEm-lkp@intel.com>
 <YL5cvT4NvMLIuH+C@google.com>
 <YL5kL38o8JLDp8LK@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YL5kL38o8JLDp8LK@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 08:23:43PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jun 07, 2021 at 10:51:57AM -0700, Matthias Kaehlcke wrote:
> > On Sat, Jun 05, 2021 at 07:18:38AM +0800, kernel test robot wrote:
> > > Hi Matthias,
> > > 
> > > I love your patch! Perhaps something to improve:
> > > 
> > > [auto build test WARNING on next-20210604]
> > > [also build test WARNING on v5.13-rc4]
> > > [cannot apply to usb/usb-testing robh/for-next char-misc/char-misc-testing driver-core/driver-core-testing linus/master v5.13-rc4 v5.13-rc3 v5.13-rc2]
> > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > And when submitting patch, we suggest to use '--base' as documented in
> > > https://git-scm.com/docs/git-format-patch]
> > > 
> > > url:    https://github.com/0day-ci/linux/commits/Matthias-Kaehlcke/USB-misc-Add-onboard_usb_hub-driver/20210605-054213
> > > base:    ccc252d2e818f6a479441119ad453c3ce7c7c461
> > > config: arc-allyesconfig (attached as .config)
> > > compiler: arceb-elf-gcc (GCC) 9.3.0
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://github.com/0day-ci/linux/commit/7107f99a12058b7147342c6f763d026102bd6606
> > >         git remote add linux-review https://github.com/0day-ci/linux
> > >         git fetch --no-tags linux-review Matthias-Kaehlcke/USB-misc-Add-onboard_usb_hub-driver/20210605-054213
> > >         git checkout 7107f99a12058b7147342c6f763d026102bd6606
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arc 
> > > 
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > All warnings (new ones prefixed by >>):
> > > 
> > > >> drivers/usb/misc/onboard_usb_hub.c:400:6: warning: no previous prototype for 'onboard_hub_create_pdevs' [-Wmissing-prototypes]
> > >      400 | void onboard_hub_create_pdevs(struct usb_device *parent_hub, struct list_head *pdev_list)
> > >          |      ^~~~~~~~~~~~~~~~~~~~~~~~
> > > >> drivers/usb/misc/onboard_usb_hub.c:458:6: warning: no previous prototype for 'onboard_hub_destroy_pdevs' [-Wmissing-prototypes]
> > >      458 | void onboard_hub_destroy_pdevs(struct list_head *pdev_list)
> > >          |      ^~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Oh, I wasn't aware that prototypes are required for public functions.
> 
> How else can they be called?

Well, there are prototypes in include/linux/usb/onboard_hub.h, however this
header isn't included (anymore) by the driver itself to avoid conflicts
when COMPILE_TEST=y (see https://lkml.org/lkml/2021/5/25/975).

