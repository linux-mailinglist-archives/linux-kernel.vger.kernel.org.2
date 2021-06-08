Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D089439F180
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 10:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhFHI6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:58:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhFHI6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:58:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 314A061153;
        Tue,  8 Jun 2021 08:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623142570;
        bh=ews02L1jG1jjqGhNiQBHVN06tOoeL+zxI87hCEUyTkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nNfCk3uPL/u3KJrFtRoAGgFuNVs9IeZf6yMzuChgn0OzADTn+sFtyGdKGiogPvJ0l
         4OaqjsubDE3q0EmA2eXEIOiljTEksdm31Ltf3rleRITNeV9a1f6z98jZ1pumXm9NXy
         hpYgt0+3Pxbx8bJfKEPJYyZfpuZjfSJnAO/EIjPE=
Date:   Tue, 8 Jun 2021 10:56:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthias Kaehlcke <mka@chromium.org>
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
Message-ID: <YL8wqCQZvim7iB02@kroah.com>
References: <20210604144027.v11.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <202106050751.uNo0uAEm-lkp@intel.com>
 <YL5cvT4NvMLIuH+C@google.com>
 <YL5kL38o8JLDp8LK@kroah.com>
 <YL5mP4lGoiHNjAYN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL5mP4lGoiHNjAYN@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 11:32:31AM -0700, Matthias Kaehlcke wrote:
> On Mon, Jun 07, 2021 at 08:23:43PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Jun 07, 2021 at 10:51:57AM -0700, Matthias Kaehlcke wrote:
> > > On Sat, Jun 05, 2021 at 07:18:38AM +0800, kernel test robot wrote:
> > > > Hi Matthias,
> > > > 
> > > > I love your patch! Perhaps something to improve:
> > > > 
> > > > [auto build test WARNING on next-20210604]
> > > > [also build test WARNING on v5.13-rc4]
> > > > [cannot apply to usb/usb-testing robh/for-next char-misc/char-misc-testing driver-core/driver-core-testing linus/master v5.13-rc4 v5.13-rc3 v5.13-rc2]
> > > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > > And when submitting patch, we suggest to use '--base' as documented in
> > > > https://git-scm.com/docs/git-format-patch]
> > > > 
> > > > url:    https://github.com/0day-ci/linux/commits/Matthias-Kaehlcke/USB-misc-Add-onboard_usb_hub-driver/20210605-054213
> > > > base:    ccc252d2e818f6a479441119ad453c3ce7c7c461
> > > > config: arc-allyesconfig (attached as .config)
> > > > compiler: arceb-elf-gcc (GCC) 9.3.0
> > > > reproduce (this is a W=1 build):
> > > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > > >         chmod +x ~/bin/make.cross
> > > >         # https://github.com/0day-ci/linux/commit/7107f99a12058b7147342c6f763d026102bd6606
> > > >         git remote add linux-review https://github.com/0day-ci/linux
> > > >         git fetch --no-tags linux-review Matthias-Kaehlcke/USB-misc-Add-onboard_usb_hub-driver/20210605-054213
> > > >         git checkout 7107f99a12058b7147342c6f763d026102bd6606
> > > >         # save the attached .config to linux build tree
> > > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arc 
> > > > 
> > > > If you fix the issue, kindly add following tag as appropriate
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > 
> > > > All warnings (new ones prefixed by >>):
> > > > 
> > > > >> drivers/usb/misc/onboard_usb_hub.c:400:6: warning: no previous prototype for 'onboard_hub_create_pdevs' [-Wmissing-prototypes]
> > > >      400 | void onboard_hub_create_pdevs(struct usb_device *parent_hub, struct list_head *pdev_list)
> > > >          |      ^~~~~~~~~~~~~~~~~~~~~~~~
> > > > >> drivers/usb/misc/onboard_usb_hub.c:458:6: warning: no previous prototype for 'onboard_hub_destroy_pdevs' [-Wmissing-prototypes]
> > > >      458 | void onboard_hub_destroy_pdevs(struct list_head *pdev_list)
> > > >          |      ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > 
> > > Oh, I wasn't aware that prototypes are required for public functions.
> > 
> > How else can they be called?
> 
> Well, there are prototypes in include/linux/usb/onboard_hub.h, however this
> header isn't included (anymore) by the driver itself to avoid conflicts
> when COMPILE_TEST=y (see https://lkml.org/lkml/2021/5/25/975).

Then that needs to be resolved please.

thanks,

greg k-h
